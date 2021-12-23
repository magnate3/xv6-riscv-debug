
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	04013103          	ld	sp,64(sp) # 8000a040 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	09c000ef          	jal	ra,800000b2 <start>

000000008000001a <junk>:
    8000001a:	a001                	j	8000001a <junk>

000000008000001c <setup_pmp>:

// assembly code in kernelvec.S for machine-mode timer interrupt.
extern void timervec();

void setup_pmp(void)
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
  // Set up a PMP to permit access to all of memory.
  // Ignore the illegal-instruction trap if PMPs aren't supported.
  unsigned long pmpc = PMP_NAPOT | PMP_R | PMP_W | PMP_X;
  asm volatile ("la t0, 1f\n\t"
    80000022:	47fd                	li	a5,31
    80000024:	577d                	li	a4,-1
    80000026:	00000297          	auipc	t0,0x0
    8000002a:	01628293          	addi	t0,t0,22 # 8000003c <setup_pmp+0x20>
    8000002e:	305292f3          	csrrw	t0,mtvec,t0
    80000032:	3b071073          	csrw	pmpaddr0,a4
    80000036:	3a079073          	csrw	pmpcfg0,a5
    8000003a:	0000                	unimp
    8000003c:	30529073          	csrw	mtvec,t0
                "csrw pmpaddr0, %1\n\t"
                "csrw pmpcfg0, %0\n\t"
                ".align 2\n\t"
                "1: csrw mtvec, t0"
                : : "r" (pmpc), "r" (-1UL) : "t0");
}
    80000040:	6422                	ld	s0,8(sp)
    80000042:	0141                	addi	sp,sp,16
    80000044:	8082                	ret

0000000080000046 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000046:	1141                	addi	sp,sp,-16
    80000048:	e422                	sd	s0,8(sp)
    8000004a:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    8000004c:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000050:	2781                	sext.w	a5,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000052:	0037969b          	slliw	a3,a5,0x3
    80000056:	02004737          	lui	a4,0x2004
    8000005a:	96ba                	add	a3,a3,a4
    8000005c:	0200c737          	lui	a4,0x200c
    80000060:	ff873603          	ld	a2,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80000064:	000f4737          	lui	a4,0xf4
    80000068:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    8000006c:	963a                	add	a2,a2,a4
    8000006e:	e290                	sd	a2,0(a3)

  // prepare information in scratch[] for timervec.
  // scratch[0..3] : space for timervec to save registers.
  // scratch[4] : address of CLINT MTIMECMP register.
  // scratch[5] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &mscratch0[32 * id];
    80000070:	0057979b          	slliw	a5,a5,0x5
    80000074:	078e                	slli	a5,a5,0x3
    80000076:	0000b617          	auipc	a2,0xb
    8000007a:	f8a60613          	addi	a2,a2,-118 # 8000b000 <mscratch0>
    8000007e:	97b2                	add	a5,a5,a2
  scratch[4] = CLINT_MTIMECMP(id);
    80000080:	f394                	sd	a3,32(a5)
  scratch[5] = interval;
    80000082:	f798                	sd	a4,40(a5)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000084:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000088:	00006797          	auipc	a5,0x6
    8000008c:	4d878793          	addi	a5,a5,1240 # 80006560 <timervec>
    80000090:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000098:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000009c:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800000a0:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800000a4:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800000a8:	30479073          	csrw	mie,a5
}
    800000ac:	6422                	ld	s0,8(sp)
    800000ae:	0141                	addi	sp,sp,16
    800000b0:	8082                	ret

00000000800000b2 <start>:
{
    800000b2:	1141                	addi	sp,sp,-16
    800000b4:	e406                	sd	ra,8(sp)
    800000b6:	e022                	sd	s0,0(sp)
    800000b8:	0800                	addi	s0,sp,16
  uartputs(" enter start \n");
    800000ba:	00008517          	auipc	a0,0x8
    800000be:	05e50513          	addi	a0,a0,94 # 80008118 <userret+0x88>
    800000c2:	00001097          	auipc	ra,0x1
    800000c6:	a22080e7          	jalr	-1502(ra) # 80000ae4 <uartputs>
  setup_pmp();
    800000ca:	00000097          	auipc	ra,0x0
    800000ce:	f52080e7          	jalr	-174(ra) # 8000001c <setup_pmp>
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800000d2:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800000d6:	7779                	lui	a4,0xffffe
    800000d8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd0753>
    800000dc:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000de:	6705                	lui	a4,0x1
    800000e0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000e4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000e6:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ea:	00001797          	auipc	a5,0x1
    800000ee:	37078793          	addi	a5,a5,880 # 8000145a <main>
    800000f2:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000f6:	4781                	li	a5,0
    800000f8:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000fc:	67c1                	lui	a5,0x10
    800000fe:	17fd                	addi	a5,a5,-1
    80000100:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80000104:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80000108:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    8000010c:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80000110:	10479073          	csrw	sie,a5
  timerinit();
    80000114:	00000097          	auipc	ra,0x0
    80000118:	f32080e7          	jalr	-206(ra) # 80000046 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    8000011c:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80000120:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    80000122:	823e                	mv	tp,a5
  asm volatile("mret");
    80000124:	30200073          	mret
}
    80000128:	60a2                	ld	ra,8(sp)
    8000012a:	6402                	ld	s0,0(sp)
    8000012c:	0141                	addi	sp,sp,16
    8000012e:	8082                	ret

0000000080000130 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(struct file *f, int user_dst, uint64 dst, int n)
{
    80000130:	7159                	addi	sp,sp,-112
    80000132:	f486                	sd	ra,104(sp)
    80000134:	f0a2                	sd	s0,96(sp)
    80000136:	eca6                	sd	s1,88(sp)
    80000138:	e8ca                	sd	s2,80(sp)
    8000013a:	e4ce                	sd	s3,72(sp)
    8000013c:	e0d2                	sd	s4,64(sp)
    8000013e:	fc56                	sd	s5,56(sp)
    80000140:	f85a                	sd	s6,48(sp)
    80000142:	f45e                	sd	s7,40(sp)
    80000144:	f062                	sd	s8,32(sp)
    80000146:	ec66                	sd	s9,24(sp)
    80000148:	e86a                	sd	s10,16(sp)
    8000014a:	1880                	addi	s0,sp,112
    8000014c:	84aa                	mv	s1,a0
    8000014e:	8bae                	mv	s7,a1
    80000150:	8ab2                	mv	s5,a2
    80000152:	8a36                	mv	s4,a3
  uint target;
  int c;
  char cbuf;

  target = n;
    80000154:	00068b1b          	sext.w	s6,a3
  struct cons_t* cons = &consoles[f->minor-1];
    80000158:	02651983          	lh	s3,38(a0)
    8000015c:	39fd                	addiw	s3,s3,-1
    8000015e:	00199d13          	slli	s10,s3,0x1
    80000162:	9d4e                	add	s10,s10,s3
    80000164:	0d1a                	slli	s10,s10,0x6
    80000166:	00013917          	auipc	s2,0x13
    8000016a:	69a90913          	addi	s2,s2,1690 # 80013800 <consoles>
    8000016e:	996a                	add	s2,s2,s10
  acquire(&console_number_lock);
    80000170:	00014517          	auipc	a0,0x14
    80000174:	8d050513          	addi	a0,a0,-1840 # 80013a40 <console_number_lock>
    80000178:	00001097          	auipc	ra,0x1
    8000017c:	bb8080e7          	jalr	-1096(ra) # 80000d30 <acquire>
  while(console_number != f->minor - 1){
    80000180:	02649783          	lh	a5,38(s1)
    80000184:	37fd                	addiw	a5,a5,-1
    80000186:	0002e717          	auipc	a4,0x2e
    8000018a:	ee270713          	addi	a4,a4,-286 # 8002e068 <console_number>
    8000018e:	4318                	lw	a4,0(a4)
    80000190:	02e78763          	beq	a5,a4,800001be <consoleread+0x8e>
    sleep(cons, &console_number_lock);
    80000194:	00014c97          	auipc	s9,0x14
    80000198:	8acc8c93          	addi	s9,s9,-1876 # 80013a40 <console_number_lock>
  while(console_number != f->minor - 1){
    8000019c:	0002ec17          	auipc	s8,0x2e
    800001a0:	eccc0c13          	addi	s8,s8,-308 # 8002e068 <console_number>
    sleep(cons, &console_number_lock);
    800001a4:	85e6                	mv	a1,s9
    800001a6:	854a                	mv	a0,s2
    800001a8:	00002097          	auipc	ra,0x2
    800001ac:	64c080e7          	jalr	1612(ra) # 800027f4 <sleep>
  while(console_number != f->minor - 1){
    800001b0:	02649783          	lh	a5,38(s1)
    800001b4:	37fd                	addiw	a5,a5,-1
    800001b6:	000c2703          	lw	a4,0(s8)
    800001ba:	fee795e3          	bne	a5,a4,800001a4 <consoleread+0x74>
  }
  release(&console_number_lock);
    800001be:	00014517          	auipc	a0,0x14
    800001c2:	88250513          	addi	a0,a0,-1918 # 80013a40 <console_number_lock>
    800001c6:	00001097          	auipc	ra,0x1
    800001ca:	db6080e7          	jalr	-586(ra) # 80000f7c <release>
  acquire(&cons->lock);
    800001ce:	854a                	mv	a0,s2
    800001d0:	00001097          	auipc	ra,0x1
    800001d4:	b60080e7          	jalr	-1184(ra) # 80000d30 <acquire>
  while(n > 0){
    800001d8:	09405c63          	blez	s4,80000270 <consoleread+0x140>
    while(cons->r == cons->w){
      if(myproc()->killed){
        release(&cons->lock);
        return -1;
      }
      sleep(&cons->r, &cons->lock);
    800001dc:	00013797          	auipc	a5,0x13
    800001e0:	6d478793          	addi	a5,a5,1748 # 800138b0 <consoles+0xb0>
    800001e4:	9d3e                	add	s10,s10,a5
    while(cons->r == cons->w){
    800001e6:	00199493          	slli	s1,s3,0x1
    800001ea:	94ce                	add	s1,s1,s3
    800001ec:	00649793          	slli	a5,s1,0x6
    800001f0:	00013497          	auipc	s1,0x13
    800001f4:	61048493          	addi	s1,s1,1552 # 80013800 <consoles>
    800001f8:	94be                	add	s1,s1,a5
    800001fa:	0b04a783          	lw	a5,176(s1)
    800001fe:	0b44a703          	lw	a4,180(s1)
    80000202:	02f71463          	bne	a4,a5,8000022a <consoleread+0xfa>
      if(myproc()->killed){
    80000206:	00002097          	auipc	ra,0x2
    8000020a:	df4080e7          	jalr	-524(ra) # 80001ffa <myproc>
    8000020e:	453c                	lw	a5,72(a0)
    80000210:	eba5                	bnez	a5,80000280 <consoleread+0x150>
      sleep(&cons->r, &cons->lock);
    80000212:	85ca                	mv	a1,s2
    80000214:	856a                	mv	a0,s10
    80000216:	00002097          	auipc	ra,0x2
    8000021a:	5de080e7          	jalr	1502(ra) # 800027f4 <sleep>
    while(cons->r == cons->w){
    8000021e:	0b04a783          	lw	a5,176(s1)
    80000222:	0b44a703          	lw	a4,180(s1)
    80000226:	fef700e3          	beq	a4,a5,80000206 <consoleread+0xd6>
    }

    c = cons->buf[cons->r++ % INPUT_BUF];
    8000022a:	0017871b          	addiw	a4,a5,1
    8000022e:	0ae4a823          	sw	a4,176(s1)
    80000232:	07f7f713          	andi	a4,a5,127
    80000236:	9726                	add	a4,a4,s1
    80000238:	03074703          	lbu	a4,48(a4)
    8000023c:	00070c1b          	sext.w	s8,a4

    if(c == C('D')){  // end-of-file
    80000240:	4691                	li	a3,4
    80000242:	06dc0363          	beq	s8,a3,800002a8 <consoleread+0x178>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000246:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000024a:	4685                	li	a3,1
    8000024c:	f9f40613          	addi	a2,s0,-97
    80000250:	85d6                	mv	a1,s5
    80000252:	855e                	mv	a0,s7
    80000254:	00003097          	auipc	ra,0x3
    80000258:	802080e7          	jalr	-2046(ra) # 80002a56 <either_copyout>
    8000025c:	57fd                	li	a5,-1
    8000025e:	00f50963          	beq	a0,a5,80000270 <consoleread+0x140>
      break;

    dst++;
    80000262:	0a85                	addi	s5,s5,1
    --n;
    80000264:	3a7d                	addiw	s4,s4,-1

    if(c == '\n'){
    80000266:	47a9                	li	a5,10
    80000268:	00fc0463          	beq	s8,a5,80000270 <consoleread+0x140>
  while(n > 0){
    8000026c:	f80a17e3          	bnez	s4,800001fa <consoleread+0xca>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons->lock);
    80000270:	854a                	mv	a0,s2
    80000272:	00001097          	auipc	ra,0x1
    80000276:	d0a080e7          	jalr	-758(ra) # 80000f7c <release>

  return target - n;
    8000027a:	414b053b          	subw	a0,s6,s4
    8000027e:	a039                	j	8000028c <consoleread+0x15c>
        release(&cons->lock);
    80000280:	854a                	mv	a0,s2
    80000282:	00001097          	auipc	ra,0x1
    80000286:	cfa080e7          	jalr	-774(ra) # 80000f7c <release>
        return -1;
    8000028a:	557d                	li	a0,-1
}
    8000028c:	70a6                	ld	ra,104(sp)
    8000028e:	7406                	ld	s0,96(sp)
    80000290:	64e6                	ld	s1,88(sp)
    80000292:	6946                	ld	s2,80(sp)
    80000294:	69a6                	ld	s3,72(sp)
    80000296:	6a06                	ld	s4,64(sp)
    80000298:	7ae2                	ld	s5,56(sp)
    8000029a:	7b42                	ld	s6,48(sp)
    8000029c:	7ba2                	ld	s7,40(sp)
    8000029e:	7c02                	ld	s8,32(sp)
    800002a0:	6ce2                	ld	s9,24(sp)
    800002a2:	6d42                	ld	s10,16(sp)
    800002a4:	6165                	addi	sp,sp,112
    800002a6:	8082                	ret
      if(n < target){
    800002a8:	000a071b          	sext.w	a4,s4
    800002ac:	fd6772e3          	bleu	s6,a4,80000270 <consoleread+0x140>
        cons->r--;
    800002b0:	00199713          	slli	a4,s3,0x1
    800002b4:	974e                	add	a4,a4,s3
    800002b6:	071a                	slli	a4,a4,0x6
    800002b8:	00013697          	auipc	a3,0x13
    800002bc:	54868693          	addi	a3,a3,1352 # 80013800 <consoles>
    800002c0:	9736                	add	a4,a4,a3
    800002c2:	0af72823          	sw	a5,176(a4)
    800002c6:	b76d                	j	80000270 <consoleread+0x140>

00000000800002c8 <consputc>:
  if(panicked){
    800002c8:	0002e797          	auipc	a5,0x2e
    800002cc:	da478793          	addi	a5,a5,-604 # 8002e06c <panicked>
    800002d0:	439c                	lw	a5,0(a5)
    800002d2:	2781                	sext.w	a5,a5
    800002d4:	c391                	beqz	a5,800002d8 <consputc+0x10>
    for(;;)
    800002d6:	a001                	j	800002d6 <consputc+0xe>
{
    800002d8:	1141                	addi	sp,sp,-16
    800002da:	e406                	sd	ra,8(sp)
    800002dc:	e022                	sd	s0,0(sp)
    800002de:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800002e0:	10000793          	li	a5,256
    800002e4:	00f50a63          	beq	a0,a5,800002f8 <consputc+0x30>
    uartputc(c);
    800002e8:	00000097          	auipc	ra,0x0
    800002ec:	7d2080e7          	jalr	2002(ra) # 80000aba <uartputc>
}
    800002f0:	60a2                	ld	ra,8(sp)
    800002f2:	6402                	ld	s0,0(sp)
    800002f4:	0141                	addi	sp,sp,16
    800002f6:	8082                	ret
    uartputc('\b'); uartputc(' '); uartputc('\b');
    800002f8:	4521                	li	a0,8
    800002fa:	00000097          	auipc	ra,0x0
    800002fe:	7c0080e7          	jalr	1984(ra) # 80000aba <uartputc>
    80000302:	02000513          	li	a0,32
    80000306:	00000097          	auipc	ra,0x0
    8000030a:	7b4080e7          	jalr	1972(ra) # 80000aba <uartputc>
    8000030e:	4521                	li	a0,8
    80000310:	00000097          	auipc	ra,0x0
    80000314:	7aa080e7          	jalr	1962(ra) # 80000aba <uartputc>
    80000318:	bfe1                	j	800002f0 <consputc+0x28>

000000008000031a <consolewrite>:
{
    8000031a:	711d                	addi	sp,sp,-96
    8000031c:	ec86                	sd	ra,88(sp)
    8000031e:	e8a2                	sd	s0,80(sp)
    80000320:	e4a6                	sd	s1,72(sp)
    80000322:	e0ca                	sd	s2,64(sp)
    80000324:	fc4e                	sd	s3,56(sp)
    80000326:	f852                	sd	s4,48(sp)
    80000328:	f456                	sd	s5,40(sp)
    8000032a:	f05a                	sd	s6,32(sp)
    8000032c:	ec5e                	sd	s7,24(sp)
    8000032e:	1080                	addi	s0,sp,96
    80000330:	89aa                	mv	s3,a0
    80000332:	8a2e                	mv	s4,a1
    80000334:	84b2                	mv	s1,a2
    80000336:	8ab6                	mv	s5,a3
  struct cons_t* cons = &consoles[f->minor-1];
    80000338:	02651783          	lh	a5,38(a0)
    8000033c:	37fd                	addiw	a5,a5,-1
    8000033e:	00179913          	slli	s2,a5,0x1
    80000342:	993e                	add	s2,s2,a5
    80000344:	00691793          	slli	a5,s2,0x6
    80000348:	00013917          	auipc	s2,0x13
    8000034c:	4b890913          	addi	s2,s2,1208 # 80013800 <consoles>
    80000350:	993e                	add	s2,s2,a5
  acquire(&console_number_lock);
    80000352:	00013517          	auipc	a0,0x13
    80000356:	6ee50513          	addi	a0,a0,1774 # 80013a40 <console_number_lock>
    8000035a:	00001097          	auipc	ra,0x1
    8000035e:	9d6080e7          	jalr	-1578(ra) # 80000d30 <acquire>
  while(console_number != f->minor - 1){
    80000362:	02699783          	lh	a5,38(s3)
    80000366:	37fd                	addiw	a5,a5,-1
    80000368:	0002e717          	auipc	a4,0x2e
    8000036c:	d0070713          	addi	a4,a4,-768 # 8002e068 <console_number>
    80000370:	4318                	lw	a4,0(a4)
    80000372:	02e78763          	beq	a5,a4,800003a0 <consolewrite+0x86>
    sleep(cons, &console_number_lock);
    80000376:	00013b97          	auipc	s7,0x13
    8000037a:	6cab8b93          	addi	s7,s7,1738 # 80013a40 <console_number_lock>
  while(console_number != f->minor - 1){
    8000037e:	0002eb17          	auipc	s6,0x2e
    80000382:	ceab0b13          	addi	s6,s6,-790 # 8002e068 <console_number>
    sleep(cons, &console_number_lock);
    80000386:	85de                	mv	a1,s7
    80000388:	854a                	mv	a0,s2
    8000038a:	00002097          	auipc	ra,0x2
    8000038e:	46a080e7          	jalr	1130(ra) # 800027f4 <sleep>
  while(console_number != f->minor - 1){
    80000392:	02699783          	lh	a5,38(s3)
    80000396:	37fd                	addiw	a5,a5,-1
    80000398:	000b2703          	lw	a4,0(s6)
    8000039c:	fee795e3          	bne	a5,a4,80000386 <consolewrite+0x6c>
  release(&console_number_lock);
    800003a0:	00013517          	auipc	a0,0x13
    800003a4:	6a050513          	addi	a0,a0,1696 # 80013a40 <console_number_lock>
    800003a8:	00001097          	auipc	ra,0x1
    800003ac:	bd4080e7          	jalr	-1068(ra) # 80000f7c <release>
  acquire(&cons->lock);
    800003b0:	854a                	mv	a0,s2
    800003b2:	00001097          	auipc	ra,0x1
    800003b6:	97e080e7          	jalr	-1666(ra) # 80000d30 <acquire>
  for(i = 0; i < n; i++){
    800003ba:	03505e63          	blez	s5,800003f6 <consolewrite+0xdc>
    800003be:	00148993          	addi	s3,s1,1
    800003c2:	fffa879b          	addiw	a5,s5,-1
    800003c6:	1782                	slli	a5,a5,0x20
    800003c8:	9381                	srli	a5,a5,0x20
    800003ca:	99be                	add	s3,s3,a5
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800003cc:	5b7d                	li	s6,-1
    800003ce:	4685                	li	a3,1
    800003d0:	8626                	mv	a2,s1
    800003d2:	85d2                	mv	a1,s4
    800003d4:	faf40513          	addi	a0,s0,-81
    800003d8:	00002097          	auipc	ra,0x2
    800003dc:	6d4080e7          	jalr	1748(ra) # 80002aac <either_copyin>
    800003e0:	01650b63          	beq	a0,s6,800003f6 <consolewrite+0xdc>
    consputc(c);
    800003e4:	faf44503          	lbu	a0,-81(s0)
    800003e8:	00000097          	auipc	ra,0x0
    800003ec:	ee0080e7          	jalr	-288(ra) # 800002c8 <consputc>
  for(i = 0; i < n; i++){
    800003f0:	0485                	addi	s1,s1,1
    800003f2:	fd349ee3          	bne	s1,s3,800003ce <consolewrite+0xb4>
  release(&cons->lock);
    800003f6:	854a                	mv	a0,s2
    800003f8:	00001097          	auipc	ra,0x1
    800003fc:	b84080e7          	jalr	-1148(ra) # 80000f7c <release>
}
    80000400:	8556                	mv	a0,s5
    80000402:	60e6                	ld	ra,88(sp)
    80000404:	6446                	ld	s0,80(sp)
    80000406:	64a6                	ld	s1,72(sp)
    80000408:	6906                	ld	s2,64(sp)
    8000040a:	79e2                	ld	s3,56(sp)
    8000040c:	7a42                	ld	s4,48(sp)
    8000040e:	7aa2                	ld	s5,40(sp)
    80000410:	7b02                	ld	s6,32(sp)
    80000412:	6be2                	ld	s7,24(sp)
    80000414:	6125                	addi	sp,sp,96
    80000416:	8082                	ret

0000000080000418 <consoleintr>:
// do erase/kill processing, append to cons->buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80000418:	7179                	addi	sp,sp,-48
    8000041a:	f406                	sd	ra,40(sp)
    8000041c:	f022                	sd	s0,32(sp)
    8000041e:	ec26                	sd	s1,24(sp)
    80000420:	e84a                	sd	s2,16(sp)
    80000422:	e44e                	sd	s3,8(sp)
    80000424:	e052                	sd	s4,0(sp)
    80000426:	1800                	addi	s0,sp,48
    80000428:	84aa                	mv	s1,a0
  acquire(&cons->lock);
    8000042a:	0002e797          	auipc	a5,0x2e
    8000042e:	c3678793          	addi	a5,a5,-970 # 8002e060 <cons>
    80000432:	6388                	ld	a0,0(a5)
    80000434:	00001097          	auipc	ra,0x1
    80000438:	8fc080e7          	jalr	-1796(ra) # 80000d30 <acquire>

  switch(c){
    8000043c:	47c5                	li	a5,17
    8000043e:	1af48c63          	beq	s1,a5,800005f6 <consoleintr+0x1de>
    80000442:	0a97d063          	ble	s1,a5,800004e2 <consoleintr+0xca>
    80000446:	47d5                	li	a5,21
    80000448:	10f48d63          	beq	s1,a5,80000562 <consoleintr+0x14a>
    8000044c:	07f00793          	li	a5,127
    80000450:	1af48d63          	beq	s1,a5,8000060a <consoleintr+0x1f2>
    80000454:	47cd                	li	a5,19
    80000456:	08f49f63          	bne	s1,a5,800004f4 <consoleintr+0xdc>
      consputc(BACKSPACE);
    }
    break;
  case C('S'): // switch consoles
  {
    acquire(&console_number_lock);
    8000045a:	00013997          	auipc	s3,0x13
    8000045e:	5e698993          	addi	s3,s3,1510 # 80013a40 <console_number_lock>
    80000462:	854e                	mv	a0,s3
    80000464:	00001097          	auipc	ra,0x1
    80000468:	8cc080e7          	jalr	-1844(ra) # 80000d30 <acquire>
    struct spinlock* old = &cons->lock;
    8000046c:	0002e917          	auipc	s2,0x2e
    80000470:	bf490913          	addi	s2,s2,-1036 # 8002e060 <cons>
    80000474:	00093a03          	ld	s4,0(s2)
    console_number = (console_number + 1) % NBCONSOLES;
    80000478:	0002e497          	auipc	s1,0x2e
    8000047c:	bf048493          	addi	s1,s1,-1040 # 8002e068 <console_number>
    80000480:	409c                	lw	a5,0(s1)
    80000482:	2785                	addiw	a5,a5,1
    80000484:	470d                	li	a4,3
    80000486:	02e7e7bb          	remw	a5,a5,a4
    8000048a:	0007871b          	sext.w	a4,a5
    8000048e:	c09c                	sw	a5,0(s1)
    cons = &consoles[console_number];
    80000490:	00171513          	slli	a0,a4,0x1
    80000494:	953a                	add	a0,a0,a4
    80000496:	051a                	slli	a0,a0,0x6
    80000498:	00013797          	auipc	a5,0x13
    8000049c:	36878793          	addi	a5,a5,872 # 80013800 <consoles>
    800004a0:	953e                	add	a0,a0,a5
    800004a2:	00a93023          	sd	a0,0(s2)
    acquire(&cons->lock);
    800004a6:	00001097          	auipc	ra,0x1
    800004aa:	88a080e7          	jalr	-1910(ra) # 80000d30 <acquire>
    release(old);
    800004ae:	8552                	mv	a0,s4
    800004b0:	00001097          	auipc	ra,0x1
    800004b4:	acc080e7          	jalr	-1332(ra) # 80000f7c <release>
    wakeup(cons);
    800004b8:	00093503          	ld	a0,0(s2)
    800004bc:	00002097          	auipc	ra,0x2
    800004c0:	4be080e7          	jalr	1214(ra) # 8000297a <wakeup>
    printf("Switched to console number %d\n", console_number);
    800004c4:	408c                	lw	a1,0(s1)
    800004c6:	00008517          	auipc	a0,0x8
    800004ca:	c6250513          	addi	a0,a0,-926 # 80008128 <userret+0x98>
    800004ce:	00000097          	auipc	ra,0x0
    800004d2:	510080e7          	jalr	1296(ra) # 800009de <printf>
    release(&console_number_lock);
    800004d6:	854e                	mv	a0,s3
    800004d8:	00001097          	auipc	ra,0x1
    800004dc:	aa4080e7          	jalr	-1372(ra) # 80000f7c <release>
    break;
    800004e0:	a8d5                	j	800005d4 <consoleintr+0x1bc>
  switch(c){
    800004e2:	47b1                	li	a5,12
    800004e4:	10f48e63          	beq	s1,a5,80000600 <consoleintr+0x1e8>
    800004e8:	47c1                	li	a5,16
    800004ea:	0ef48163          	beq	s1,a5,800005cc <consoleintr+0x1b4>
    800004ee:	47a1                	li	a5,8
    800004f0:	10f48d63          	beq	s1,a5,8000060a <consoleintr+0x1f2>
      cons->e--;
      consputc(BACKSPACE);
    }
    break;
  default:
    if(c != 0 && cons->e-cons->r < INPUT_BUF){
    800004f4:	c0e5                	beqz	s1,800005d4 <consoleintr+0x1bc>
    800004f6:	0002e797          	auipc	a5,0x2e
    800004fa:	b6a78793          	addi	a5,a5,-1174 # 8002e060 <cons>
    800004fe:	6398                	ld	a4,0(a5)
    80000500:	0b872783          	lw	a5,184(a4)
    80000504:	0b072703          	lw	a4,176(a4)
    80000508:	9f99                	subw	a5,a5,a4
    8000050a:	07f00713          	li	a4,127
    8000050e:	0cf76363          	bltu	a4,a5,800005d4 <consoleintr+0x1bc>
      c = (c == '\r') ? '\n' : c;
    80000512:	47b5                	li	a5,13
    80000514:	12f48063          	beq	s1,a5,80000634 <consoleintr+0x21c>

      // echo back to the user.
      consputc(c);
    80000518:	8526                	mv	a0,s1
    8000051a:	00000097          	auipc	ra,0x0
    8000051e:	dae080e7          	jalr	-594(ra) # 800002c8 <consputc>

      // store for consumption by consoleread().
      cons->buf[cons->e++ % INPUT_BUF] = c;
    80000522:	0002e797          	auipc	a5,0x2e
    80000526:	b3e78793          	addi	a5,a5,-1218 # 8002e060 <cons>
    8000052a:	6388                	ld	a0,0(a5)
    8000052c:	0b852783          	lw	a5,184(a0)
    80000530:	0017871b          	addiw	a4,a5,1
    80000534:	0007069b          	sext.w	a3,a4
    80000538:	0ae52c23          	sw	a4,184(a0)
    8000053c:	07f7f793          	andi	a5,a5,127
    80000540:	97aa                	add	a5,a5,a0
    80000542:	02978823          	sb	s1,48(a5)

      if(c == '\n' || c == C('D') || cons->e == cons->r+INPUT_BUF){
    80000546:	47a9                	li	a5,10
    80000548:	10f48e63          	beq	s1,a5,80000664 <consoleintr+0x24c>
    8000054c:	4791                	li	a5,4
    8000054e:	10f48b63          	beq	s1,a5,80000664 <consoleintr+0x24c>
    80000552:	0b052783          	lw	a5,176(a0)
    80000556:	0807879b          	addiw	a5,a5,128
    8000055a:	06f69d63          	bne	a3,a5,800005d4 <consoleintr+0x1bc>
      cons->buf[cons->e++ % INPUT_BUF] = c;
    8000055e:	86be                	mv	a3,a5
    80000560:	a211                	j	80000664 <consoleintr+0x24c>
    while(cons->e != cons->w &&
    80000562:	0002e797          	auipc	a5,0x2e
    80000566:	afe78793          	addi	a5,a5,-1282 # 8002e060 <cons>
    8000056a:	6398                	ld	a4,0(a5)
    8000056c:	0b872783          	lw	a5,184(a4)
    80000570:	0b472683          	lw	a3,180(a4)
    80000574:	06f68063          	beq	a3,a5,800005d4 <consoleintr+0x1bc>
          cons->buf[(cons->e-1) % INPUT_BUF] != '\n'){
    80000578:	37fd                	addiw	a5,a5,-1
    8000057a:	0007869b          	sext.w	a3,a5
    8000057e:	07f7f793          	andi	a5,a5,127
    80000582:	97ba                	add	a5,a5,a4
    while(cons->e != cons->w &&
    80000584:	0307c603          	lbu	a2,48(a5)
    80000588:	47a9                	li	a5,10
    8000058a:	0002e497          	auipc	s1,0x2e
    8000058e:	ad648493          	addi	s1,s1,-1322 # 8002e060 <cons>
    80000592:	4929                	li	s2,10
    80000594:	04f60063          	beq	a2,a5,800005d4 <consoleintr+0x1bc>
      cons->e--;
    80000598:	0ad72c23          	sw	a3,184(a4)
      consputc(BACKSPACE);
    8000059c:	10000513          	li	a0,256
    800005a0:	00000097          	auipc	ra,0x0
    800005a4:	d28080e7          	jalr	-728(ra) # 800002c8 <consputc>
    while(cons->e != cons->w &&
    800005a8:	6098                	ld	a4,0(s1)
    800005aa:	0b872783          	lw	a5,184(a4)
    800005ae:	0b472683          	lw	a3,180(a4)
    800005b2:	02f68163          	beq	a3,a5,800005d4 <consoleintr+0x1bc>
          cons->buf[(cons->e-1) % INPUT_BUF] != '\n'){
    800005b6:	37fd                	addiw	a5,a5,-1
    800005b8:	0007869b          	sext.w	a3,a5
    800005bc:	07f7f793          	andi	a5,a5,127
    800005c0:	97ba                	add	a5,a5,a4
    while(cons->e != cons->w &&
    800005c2:	0307c783          	lbu	a5,48(a5)
    800005c6:	fd2799e3          	bne	a5,s2,80000598 <consoleintr+0x180>
    800005ca:	a029                	j	800005d4 <consoleintr+0x1bc>
    procdump();
    800005cc:	00002097          	auipc	ra,0x2
    800005d0:	536080e7          	jalr	1334(ra) # 80002b02 <procdump>
      }
    }
    break;
  }
  
  release(&cons->lock);
    800005d4:	0002e797          	auipc	a5,0x2e
    800005d8:	a8c78793          	addi	a5,a5,-1396 # 8002e060 <cons>
    800005dc:	6388                	ld	a0,0(a5)
    800005de:	00001097          	auipc	ra,0x1
    800005e2:	99e080e7          	jalr	-1634(ra) # 80000f7c <release>
}
    800005e6:	70a2                	ld	ra,40(sp)
    800005e8:	7402                	ld	s0,32(sp)
    800005ea:	64e2                	ld	s1,24(sp)
    800005ec:	6942                	ld	s2,16(sp)
    800005ee:	69a2                	ld	s3,8(sp)
    800005f0:	6a02                	ld	s4,0(sp)
    800005f2:	6145                	addi	sp,sp,48
    800005f4:	8082                	ret
    priodump();
    800005f6:	00002097          	auipc	ra,0x2
    800005fa:	5c8080e7          	jalr	1480(ra) # 80002bbe <priodump>
    break;
    800005fe:	bfd9                	j	800005d4 <consoleintr+0x1bc>
    dump_locks();
    80000600:	00000097          	auipc	ra,0x0
    80000604:	61a080e7          	jalr	1562(ra) # 80000c1a <dump_locks>
    break;
    80000608:	b7f1                	j	800005d4 <consoleintr+0x1bc>
    if(cons->e != cons->w){
    8000060a:	0002e797          	auipc	a5,0x2e
    8000060e:	a5678793          	addi	a5,a5,-1450 # 8002e060 <cons>
    80000612:	639c                	ld	a5,0(a5)
    80000614:	0b87a703          	lw	a4,184(a5)
    80000618:	0b47a683          	lw	a3,180(a5)
    8000061c:	fae68ce3          	beq	a3,a4,800005d4 <consoleintr+0x1bc>
      cons->e--;
    80000620:	377d                	addiw	a4,a4,-1
    80000622:	0ae7ac23          	sw	a4,184(a5)
      consputc(BACKSPACE);
    80000626:	10000513          	li	a0,256
    8000062a:	00000097          	auipc	ra,0x0
    8000062e:	c9e080e7          	jalr	-866(ra) # 800002c8 <consputc>
    80000632:	b74d                	j	800005d4 <consoleintr+0x1bc>
      consputc(c);
    80000634:	4529                	li	a0,10
    80000636:	00000097          	auipc	ra,0x0
    8000063a:	c92080e7          	jalr	-878(ra) # 800002c8 <consputc>
      cons->buf[cons->e++ % INPUT_BUF] = c;
    8000063e:	0002e797          	auipc	a5,0x2e
    80000642:	a2278793          	addi	a5,a5,-1502 # 8002e060 <cons>
    80000646:	6388                	ld	a0,0(a5)
    80000648:	0b852783          	lw	a5,184(a0)
    8000064c:	0017871b          	addiw	a4,a5,1
    80000650:	0007069b          	sext.w	a3,a4
    80000654:	0ae52c23          	sw	a4,184(a0)
    80000658:	07f7f793          	andi	a5,a5,127
    8000065c:	97aa                	add	a5,a5,a0
    8000065e:	4729                	li	a4,10
    80000660:	02e78823          	sb	a4,48(a5)
        cons->w = cons->e;
    80000664:	0ad52a23          	sw	a3,180(a0)
        wakeup(&cons->r);
    80000668:	0b050513          	addi	a0,a0,176
    8000066c:	00002097          	auipc	ra,0x2
    80000670:	30e080e7          	jalr	782(ra) # 8000297a <wakeup>
    80000674:	b785                	j	800005d4 <consoleintr+0x1bc>

0000000080000676 <consoleinit>:

void
consoleinit(void)
{
    80000676:	1101                	addi	sp,sp,-32
    80000678:	ec06                	sd	ra,24(sp)
    8000067a:	e822                	sd	s0,16(sp)
    8000067c:	e426                	sd	s1,8(sp)
    8000067e:	1000                	addi	s0,sp,32
  initlock(&console_number_lock, "console_number_lock");
    80000680:	00013497          	auipc	s1,0x13
    80000684:	18048493          	addi	s1,s1,384 # 80013800 <consoles>
    80000688:	00008597          	auipc	a1,0x8
    8000068c:	ac058593          	addi	a1,a1,-1344 # 80008148 <userret+0xb8>
    80000690:	00013517          	auipc	a0,0x13
    80000694:	3b050513          	addi	a0,a0,944 # 80013a40 <console_number_lock>
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	52a080e7          	jalr	1322(ra) # 80000bc2 <initlock>
  console_number = 0;
    800006a0:	0002e797          	auipc	a5,0x2e
    800006a4:	9c07a423          	sw	zero,-1592(a5) # 8002e068 <console_number>
  cons = &consoles[console_number];
    800006a8:	0002e797          	auipc	a5,0x2e
    800006ac:	9a97bc23          	sd	s1,-1608(a5) # 8002e060 <cons>
  for(int i = 0; i < NBCONSOLES; i++){
    initlock(&consoles[i].lock, "cons");
    800006b0:	00008597          	auipc	a1,0x8
    800006b4:	ab058593          	addi	a1,a1,-1360 # 80008160 <userret+0xd0>
    800006b8:	8526                	mv	a0,s1
    800006ba:	00000097          	auipc	ra,0x0
    800006be:	508080e7          	jalr	1288(ra) # 80000bc2 <initlock>
    800006c2:	00008597          	auipc	a1,0x8
    800006c6:	a9e58593          	addi	a1,a1,-1378 # 80008160 <userret+0xd0>
    800006ca:	00013517          	auipc	a0,0x13
    800006ce:	1f650513          	addi	a0,a0,502 # 800138c0 <consoles+0xc0>
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	4f0080e7          	jalr	1264(ra) # 80000bc2 <initlock>
    800006da:	00008597          	auipc	a1,0x8
    800006de:	a8658593          	addi	a1,a1,-1402 # 80008160 <userret+0xd0>
    800006e2:	00013517          	auipc	a0,0x13
    800006e6:	29e50513          	addi	a0,a0,670 # 80013980 <consoles+0x180>
    800006ea:	00000097          	auipc	ra,0x0
    800006ee:	4d8080e7          	jalr	1240(ra) # 80000bc2 <initlock>
  }

  uartinit();
    800006f2:	00000097          	auipc	ra,0x0
    800006f6:	392080e7          	jalr	914(ra) # 80000a84 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    800006fa:	00026797          	auipc	a5,0x26
    800006fe:	49e78793          	addi	a5,a5,1182 # 80026b98 <devsw>
    80000702:	00000717          	auipc	a4,0x0
    80000706:	a2e70713          	addi	a4,a4,-1490 # 80000130 <consoleread>
    8000070a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000070c:	00000717          	auipc	a4,0x0
    80000710:	c0e70713          	addi	a4,a4,-1010 # 8000031a <consolewrite>
    80000714:	ef98                	sd	a4,24(a5)
}
    80000716:	60e2                	ld	ra,24(sp)
    80000718:	6442                	ld	s0,16(sp)
    8000071a:	64a2                	ld	s1,8(sp)
    8000071c:	6105                	addi	sp,sp,32
    8000071e:	8082                	ret

0000000080000720 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80000720:	7179                	addi	sp,sp,-48
    80000722:	f406                	sd	ra,40(sp)
    80000724:	f022                	sd	s0,32(sp)
    80000726:	ec26                	sd	s1,24(sp)
    80000728:	e84a                	sd	s2,16(sp)
    8000072a:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8000072c:	c219                	beqz	a2,80000732 <printint+0x12>
    8000072e:	00054d63          	bltz	a0,80000748 <printint+0x28>
    x = -xx;
  else
    x = xx;
    80000732:	2501                	sext.w	a0,a0
    80000734:	4881                	li	a7,0
    80000736:	fd040713          	addi	a4,s0,-48

  i = 0;
    8000073a:	4601                	li	a2,0
  do {
    buf[i++] = digits[x % base];
    8000073c:	2581                	sext.w	a1,a1
    8000073e:	00008817          	auipc	a6,0x8
    80000742:	7e280813          	addi	a6,a6,2018 # 80008f20 <digits>
    80000746:	a801                	j	80000756 <printint+0x36>
    x = -xx;
    80000748:	40a0053b          	negw	a0,a0
    8000074c:	2501                	sext.w	a0,a0
  if(sign && (sign = xx < 0))
    8000074e:	4885                	li	a7,1
    x = -xx;
    80000750:	b7dd                	j	80000736 <printint+0x16>
  } while((x /= base) != 0);
    80000752:	853e                	mv	a0,a5
    buf[i++] = digits[x % base];
    80000754:	8636                	mv	a2,a3
    80000756:	0016069b          	addiw	a3,a2,1
    8000075a:	02b577bb          	remuw	a5,a0,a1
    8000075e:	1782                	slli	a5,a5,0x20
    80000760:	9381                	srli	a5,a5,0x20
    80000762:	97c2                	add	a5,a5,a6
    80000764:	0007c783          	lbu	a5,0(a5)
    80000768:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    8000076c:	0705                	addi	a4,a4,1
    8000076e:	02b557bb          	divuw	a5,a0,a1
    80000772:	feb570e3          	bleu	a1,a0,80000752 <printint+0x32>

  if(sign)
    80000776:	00088b63          	beqz	a7,8000078c <printint+0x6c>
    buf[i++] = '-';
    8000077a:	fe040793          	addi	a5,s0,-32
    8000077e:	96be                	add	a3,a3,a5
    80000780:	02d00793          	li	a5,45
    80000784:	fef68823          	sb	a5,-16(a3)
    80000788:	0026069b          	addiw	a3,a2,2

  while(--i >= 0)
    8000078c:	02d05763          	blez	a3,800007ba <printint+0x9a>
    80000790:	fd040793          	addi	a5,s0,-48
    80000794:	00d784b3          	add	s1,a5,a3
    80000798:	fff78913          	addi	s2,a5,-1
    8000079c:	9936                	add	s2,s2,a3
    8000079e:	36fd                	addiw	a3,a3,-1
    800007a0:	1682                	slli	a3,a3,0x20
    800007a2:	9281                	srli	a3,a3,0x20
    800007a4:	40d90933          	sub	s2,s2,a3
    consputc(buf[i]);
    800007a8:	fff4c503          	lbu	a0,-1(s1)
    800007ac:	00000097          	auipc	ra,0x0
    800007b0:	b1c080e7          	jalr	-1252(ra) # 800002c8 <consputc>
  while(--i >= 0)
    800007b4:	14fd                	addi	s1,s1,-1
    800007b6:	ff2499e3          	bne	s1,s2,800007a8 <printint+0x88>
}
    800007ba:	70a2                	ld	ra,40(sp)
    800007bc:	7402                	ld	s0,32(sp)
    800007be:	64e2                	ld	s1,24(sp)
    800007c0:	6942                	ld	s2,16(sp)
    800007c2:	6145                	addi	sp,sp,48
    800007c4:	8082                	ret

00000000800007c6 <panic>:
  printf_locking(0, fmt, ap);
}

void
panic(char *s)
{
    800007c6:	1101                	addi	sp,sp,-32
    800007c8:	ec06                	sd	ra,24(sp)
    800007ca:	e822                	sd	s0,16(sp)
    800007cc:	e426                	sd	s1,8(sp)
    800007ce:	1000                	addi	s0,sp,32
    800007d0:	84aa                	mv	s1,a0
  pr.locking = 0;
    800007d2:	00013797          	auipc	a5,0x13
    800007d6:	2c07a723          	sw	zero,718(a5) # 80013aa0 <pr+0x30>
  printf("PANIC: ");
    800007da:	00008517          	auipc	a0,0x8
    800007de:	98e50513          	addi	a0,a0,-1650 # 80008168 <userret+0xd8>
    800007e2:	00000097          	auipc	ra,0x0
    800007e6:	1fc080e7          	jalr	508(ra) # 800009de <printf>
  printf(s);
    800007ea:	8526                	mv	a0,s1
    800007ec:	00000097          	auipc	ra,0x0
    800007f0:	1f2080e7          	jalr	498(ra) # 800009de <printf>
  printf("\n");
    800007f4:	00008517          	auipc	a0,0x8
    800007f8:	e7450513          	addi	a0,a0,-396 # 80008668 <userret+0x5d8>
    800007fc:	00000097          	auipc	ra,0x0
    80000800:	1e2080e7          	jalr	482(ra) # 800009de <printf>
  printf("HINT: restart xv6 using 'make qemu-gdb', type 'b panic' (to set breakpoint in panic) in the gdb window, followed by 'c' (continue), and when the kernel hits the breakpoint, type 'bt' to get a backtrace\n");
    80000804:	00008517          	auipc	a0,0x8
    80000808:	96c50513          	addi	a0,a0,-1684 # 80008170 <userret+0xe0>
    8000080c:	00000097          	auipc	ra,0x0
    80000810:	1d2080e7          	jalr	466(ra) # 800009de <printf>
  panicked = 1; // freeze other CPUs
    80000814:	4785                	li	a5,1
    80000816:	0002e717          	auipc	a4,0x2e
    8000081a:	84f72b23          	sw	a5,-1962(a4) # 8002e06c <panicked>
  for(;;)
    8000081e:	a001                	j	8000081e <panic+0x58>

0000000080000820 <printf_locking>:
{
    80000820:	7119                	addi	sp,sp,-128
    80000822:	fc86                	sd	ra,120(sp)
    80000824:	f8a2                	sd	s0,112(sp)
    80000826:	f4a6                	sd	s1,104(sp)
    80000828:	f0ca                	sd	s2,96(sp)
    8000082a:	ecce                	sd	s3,88(sp)
    8000082c:	e8d2                	sd	s4,80(sp)
    8000082e:	e4d6                	sd	s5,72(sp)
    80000830:	e0da                	sd	s6,64(sp)
    80000832:	fc5e                	sd	s7,56(sp)
    80000834:	f862                	sd	s8,48(sp)
    80000836:	f466                	sd	s9,40(sp)
    80000838:	f06a                	sd	s10,32(sp)
    8000083a:	ec6e                	sd	s11,24(sp)
    8000083c:	0100                	addi	s0,sp,128
    8000083e:	8daa                	mv	s11,a0
    80000840:	8aae                	mv	s5,a1
    80000842:	8932                	mv	s2,a2
  if(locking)
    80000844:	e515                	bnez	a0,80000870 <printf_locking+0x50>
  if (fmt == 0)
    80000846:	020a8e63          	beqz	s5,80000882 <printf_locking+0x62>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000084a:	000ac503          	lbu	a0,0(s5)
    8000084e:	4481                	li	s1,0
    80000850:	14050d63          	beqz	a0,800009aa <printf_locking+0x18a>
    if(c != '%'){
    80000854:	02500a13          	li	s4,37
    switch(c){
    80000858:	07000b13          	li	s6,112
  consputc('x');
    8000085c:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000085e:	00008b97          	auipc	s7,0x8
    80000862:	6c2b8b93          	addi	s7,s7,1730 # 80008f20 <digits>
    switch(c){
    80000866:	07300c93          	li	s9,115
    8000086a:	06400c13          	li	s8,100
    8000086e:	a82d                	j	800008a8 <printf_locking+0x88>
    acquire(&pr.lock);
    80000870:	00013517          	auipc	a0,0x13
    80000874:	20050513          	addi	a0,a0,512 # 80013a70 <pr>
    80000878:	00000097          	auipc	ra,0x0
    8000087c:	4b8080e7          	jalr	1208(ra) # 80000d30 <acquire>
    80000880:	b7d9                	j	80000846 <printf_locking+0x26>
    panic("null fmt");
    80000882:	00008517          	auipc	a0,0x8
    80000886:	9c650513          	addi	a0,a0,-1594 # 80008248 <userret+0x1b8>
    8000088a:	00000097          	auipc	ra,0x0
    8000088e:	f3c080e7          	jalr	-196(ra) # 800007c6 <panic>
      consputc(c);
    80000892:	00000097          	auipc	ra,0x0
    80000896:	a36080e7          	jalr	-1482(ra) # 800002c8 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000089a:	2485                	addiw	s1,s1,1
    8000089c:	009a87b3          	add	a5,s5,s1
    800008a0:	0007c503          	lbu	a0,0(a5)
    800008a4:	10050363          	beqz	a0,800009aa <printf_locking+0x18a>
    if(c != '%'){
    800008a8:	ff4515e3          	bne	a0,s4,80000892 <printf_locking+0x72>
    c = fmt[++i] & 0xff;
    800008ac:	2485                	addiw	s1,s1,1
    800008ae:	009a87b3          	add	a5,s5,s1
    800008b2:	0007c783          	lbu	a5,0(a5)
    800008b6:	0007899b          	sext.w	s3,a5
    if(c == 0)
    800008ba:	0e098863          	beqz	s3,800009aa <printf_locking+0x18a>
    switch(c){
    800008be:	05678663          	beq	a5,s6,8000090a <printf_locking+0xea>
    800008c2:	02fb7463          	bleu	a5,s6,800008ea <printf_locking+0xca>
    800008c6:	09978563          	beq	a5,s9,80000950 <printf_locking+0x130>
    800008ca:	07800713          	li	a4,120
    800008ce:	0ce79163          	bne	a5,a4,80000990 <printf_locking+0x170>
      printint(va_arg(ap, int), 16, 1);
    800008d2:	00890993          	addi	s3,s2,8
    800008d6:	4605                	li	a2,1
    800008d8:	85ea                	mv	a1,s10
    800008da:	00092503          	lw	a0,0(s2)
    800008de:	00000097          	auipc	ra,0x0
    800008e2:	e42080e7          	jalr	-446(ra) # 80000720 <printint>
    800008e6:	894e                	mv	s2,s3
      break;
    800008e8:	bf4d                	j	8000089a <printf_locking+0x7a>
    switch(c){
    800008ea:	09478d63          	beq	a5,s4,80000984 <printf_locking+0x164>
    800008ee:	0b879163          	bne	a5,s8,80000990 <printf_locking+0x170>
      printint(va_arg(ap, int), 10, 1);
    800008f2:	00890993          	addi	s3,s2,8
    800008f6:	4605                	li	a2,1
    800008f8:	45a9                	li	a1,10
    800008fa:	00092503          	lw	a0,0(s2)
    800008fe:	00000097          	auipc	ra,0x0
    80000902:	e22080e7          	jalr	-478(ra) # 80000720 <printint>
    80000906:	894e                	mv	s2,s3
      break;
    80000908:	bf49                	j	8000089a <printf_locking+0x7a>
      printptr(va_arg(ap, uint64));
    8000090a:	00890793          	addi	a5,s2,8
    8000090e:	f8f43423          	sd	a5,-120(s0)
    80000912:	00093983          	ld	s3,0(s2)
  consputc('0');
    80000916:	03000513          	li	a0,48
    8000091a:	00000097          	auipc	ra,0x0
    8000091e:	9ae080e7          	jalr	-1618(ra) # 800002c8 <consputc>
  consputc('x');
    80000922:	07800513          	li	a0,120
    80000926:	00000097          	auipc	ra,0x0
    8000092a:	9a2080e7          	jalr	-1630(ra) # 800002c8 <consputc>
    8000092e:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80000930:	03c9d793          	srli	a5,s3,0x3c
    80000934:	97de                	add	a5,a5,s7
    80000936:	0007c503          	lbu	a0,0(a5)
    8000093a:	00000097          	auipc	ra,0x0
    8000093e:	98e080e7          	jalr	-1650(ra) # 800002c8 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000942:	0992                	slli	s3,s3,0x4
    80000944:	397d                	addiw	s2,s2,-1
    80000946:	fe0915e3          	bnez	s2,80000930 <printf_locking+0x110>
      printptr(va_arg(ap, uint64));
    8000094a:	f8843903          	ld	s2,-120(s0)
    8000094e:	b7b1                	j	8000089a <printf_locking+0x7a>
      if((s = va_arg(ap, char*)) == 0)
    80000950:	00890993          	addi	s3,s2,8
    80000954:	00093903          	ld	s2,0(s2)
    80000958:	00090f63          	beqz	s2,80000976 <printf_locking+0x156>
      for(; *s; s++)
    8000095c:	00094503          	lbu	a0,0(s2)
    80000960:	c139                	beqz	a0,800009a6 <printf_locking+0x186>
        consputc(*s);
    80000962:	00000097          	auipc	ra,0x0
    80000966:	966080e7          	jalr	-1690(ra) # 800002c8 <consputc>
      for(; *s; s++)
    8000096a:	0905                	addi	s2,s2,1
    8000096c:	00094503          	lbu	a0,0(s2)
    80000970:	f96d                	bnez	a0,80000962 <printf_locking+0x142>
      if((s = va_arg(ap, char*)) == 0)
    80000972:	894e                	mv	s2,s3
    80000974:	b71d                	j	8000089a <printf_locking+0x7a>
        s = "(null)";
    80000976:	00008917          	auipc	s2,0x8
    8000097a:	8ca90913          	addi	s2,s2,-1846 # 80008240 <userret+0x1b0>
      for(; *s; s++)
    8000097e:	02800513          	li	a0,40
    80000982:	b7c5                	j	80000962 <printf_locking+0x142>
      consputc('%');
    80000984:	8552                	mv	a0,s4
    80000986:	00000097          	auipc	ra,0x0
    8000098a:	942080e7          	jalr	-1726(ra) # 800002c8 <consputc>
      break;
    8000098e:	b731                	j	8000089a <printf_locking+0x7a>
      consputc('%');
    80000990:	8552                	mv	a0,s4
    80000992:	00000097          	auipc	ra,0x0
    80000996:	936080e7          	jalr	-1738(ra) # 800002c8 <consputc>
      consputc(c);
    8000099a:	854e                	mv	a0,s3
    8000099c:	00000097          	auipc	ra,0x0
    800009a0:	92c080e7          	jalr	-1748(ra) # 800002c8 <consputc>
      break;
    800009a4:	bddd                	j	8000089a <printf_locking+0x7a>
      if((s = va_arg(ap, char*)) == 0)
    800009a6:	894e                	mv	s2,s3
    800009a8:	bdcd                	j	8000089a <printf_locking+0x7a>
  if(locking)
    800009aa:	020d9163          	bnez	s11,800009cc <printf_locking+0x1ac>
}
    800009ae:	70e6                	ld	ra,120(sp)
    800009b0:	7446                	ld	s0,112(sp)
    800009b2:	74a6                	ld	s1,104(sp)
    800009b4:	7906                	ld	s2,96(sp)
    800009b6:	69e6                	ld	s3,88(sp)
    800009b8:	6a46                	ld	s4,80(sp)
    800009ba:	6aa6                	ld	s5,72(sp)
    800009bc:	6b06                	ld	s6,64(sp)
    800009be:	7be2                	ld	s7,56(sp)
    800009c0:	7c42                	ld	s8,48(sp)
    800009c2:	7ca2                	ld	s9,40(sp)
    800009c4:	7d02                	ld	s10,32(sp)
    800009c6:	6de2                	ld	s11,24(sp)
    800009c8:	6109                	addi	sp,sp,128
    800009ca:	8082                	ret
    release(&pr.lock);
    800009cc:	00013517          	auipc	a0,0x13
    800009d0:	0a450513          	addi	a0,a0,164 # 80013a70 <pr>
    800009d4:	00000097          	auipc	ra,0x0
    800009d8:	5a8080e7          	jalr	1448(ra) # 80000f7c <release>
}
    800009dc:	bfc9                	j	800009ae <printf_locking+0x18e>

00000000800009de <printf>:
printf(char *fmt, ...){
    800009de:	711d                	addi	sp,sp,-96
    800009e0:	ec06                	sd	ra,24(sp)
    800009e2:	e822                	sd	s0,16(sp)
    800009e4:	1000                	addi	s0,sp,32
    800009e6:	e40c                	sd	a1,8(s0)
    800009e8:	e810                	sd	a2,16(s0)
    800009ea:	ec14                	sd	a3,24(s0)
    800009ec:	f018                	sd	a4,32(s0)
    800009ee:	f41c                	sd	a5,40(s0)
    800009f0:	03043823          	sd	a6,48(s0)
    800009f4:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    800009f8:	00840613          	addi	a2,s0,8
    800009fc:	fec43423          	sd	a2,-24(s0)
  printf_locking(pr.locking, fmt, ap);
    80000a00:	85aa                	mv	a1,a0
    80000a02:	00013797          	auipc	a5,0x13
    80000a06:	06e78793          	addi	a5,a5,110 # 80013a70 <pr>
    80000a0a:	5b88                	lw	a0,48(a5)
    80000a0c:	00000097          	auipc	ra,0x0
    80000a10:	e14080e7          	jalr	-492(ra) # 80000820 <printf_locking>
}
    80000a14:	60e2                	ld	ra,24(sp)
    80000a16:	6442                	ld	s0,16(sp)
    80000a18:	6125                	addi	sp,sp,96
    80000a1a:	8082                	ret

0000000080000a1c <printf_no_lock>:
printf_no_lock(char *fmt, ...){
    80000a1c:	711d                	addi	sp,sp,-96
    80000a1e:	ec06                	sd	ra,24(sp)
    80000a20:	e822                	sd	s0,16(sp)
    80000a22:	1000                	addi	s0,sp,32
    80000a24:	e40c                	sd	a1,8(s0)
    80000a26:	e810                	sd	a2,16(s0)
    80000a28:	ec14                	sd	a3,24(s0)
    80000a2a:	f018                	sd	a4,32(s0)
    80000a2c:	f41c                	sd	a5,40(s0)
    80000a2e:	03043823          	sd	a6,48(s0)
    80000a32:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    80000a36:	00840613          	addi	a2,s0,8
    80000a3a:	fec43423          	sd	a2,-24(s0)
  printf_locking(0, fmt, ap);
    80000a3e:	85aa                	mv	a1,a0
    80000a40:	4501                	li	a0,0
    80000a42:	00000097          	auipc	ra,0x0
    80000a46:	dde080e7          	jalr	-546(ra) # 80000820 <printf_locking>
}
    80000a4a:	60e2                	ld	ra,24(sp)
    80000a4c:	6442                	ld	s0,16(sp)
    80000a4e:	6125                	addi	sp,sp,96
    80000a50:	8082                	ret

0000000080000a52 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000a52:	1101                	addi	sp,sp,-32
    80000a54:	ec06                	sd	ra,24(sp)
    80000a56:	e822                	sd	s0,16(sp)
    80000a58:	e426                	sd	s1,8(sp)
    80000a5a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000a5c:	00013497          	auipc	s1,0x13
    80000a60:	01448493          	addi	s1,s1,20 # 80013a70 <pr>
    80000a64:	00007597          	auipc	a1,0x7
    80000a68:	7f458593          	addi	a1,a1,2036 # 80008258 <userret+0x1c8>
    80000a6c:	8526                	mv	a0,s1
    80000a6e:	00000097          	auipc	ra,0x0
    80000a72:	154080e7          	jalr	340(ra) # 80000bc2 <initlock>
  pr.locking = 1;
    80000a76:	4785                	li	a5,1
    80000a78:	d89c                	sw	a5,48(s1)
}
    80000a7a:	60e2                	ld	ra,24(sp)
    80000a7c:	6442                	ld	s0,16(sp)
    80000a7e:	64a2                	ld	s1,8(sp)
    80000a80:	6105                	addi	sp,sp,32
    80000a82:	8082                	ret

0000000080000a84 <uartinit>:
#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))

void
uartinit(void)
{
    80000a84:	1141                	addi	sp,sp,-16
    80000a86:	e422                	sd	s0,8(sp)
    80000a88:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000a8a:	100007b7          	lui	a5,0x10000
    80000a8e:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, 0x80);
    80000a92:	f8000713          	li	a4,-128
    80000a96:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000a9a:	470d                	li	a4,3
    80000a9c:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000aa0:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, 0x03);
    80000aa4:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, 0x07);
    80000aa8:	471d                	li	a4,7
    80000aaa:	00e78123          	sb	a4,2(a5)

  // enable receive interrupts.
  WriteReg(IER, 0x01);
    80000aae:	4705                	li	a4,1
    80000ab0:	00e780a3          	sb	a4,1(a5)
}
    80000ab4:	6422                	ld	s0,8(sp)
    80000ab6:	0141                	addi	sp,sp,16
    80000ab8:	8082                	ret

0000000080000aba <uartputc>:

// write one output character to the UART.
void
uartputc(int c)
{
    80000aba:	1141                	addi	sp,sp,-16
    80000abc:	e422                	sd	s0,8(sp)
    80000abe:	0800                	addi	s0,sp,16
  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & (1 << 5)) == 0)
    80000ac0:	10000737          	lui	a4,0x10000
    80000ac4:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000ac8:	0ff7f793          	andi	a5,a5,255
    80000acc:	0207f793          	andi	a5,a5,32
    80000ad0:	dbf5                	beqz	a5,80000ac4 <uartputc+0xa>
    ;
  WriteReg(THR, c);
    80000ad2:	0ff57513          	andi	a0,a0,255
    80000ad6:	100007b7          	lui	a5,0x10000
    80000ada:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
}
    80000ade:	6422                	ld	s0,8(sp)
    80000ae0:	0141                	addi	sp,sp,16
    80000ae2:	8082                	ret

0000000080000ae4 <uartputs>:
void uartputs(char *msg)
{
	    char c;

	        if (!msg) {
    80000ae4:	c51d                	beqz	a0,80000b12 <uartputs+0x2e>
{
    80000ae6:	1101                	addi	sp,sp,-32
    80000ae8:	ec06                	sd	ra,24(sp)
    80000aea:	e822                	sd	s0,16(sp)
    80000aec:	e426                	sd	s1,8(sp)
    80000aee:	1000                	addi	s0,sp,32
    80000af0:	84aa                	mv	s1,a0
			        return;
				    }

		    while ((c = *msg) != '\0') {
    80000af2:	00054503          	lbu	a0,0(a0)
    80000af6:	c909                	beqz	a0,80000b08 <uartputs+0x24>
			            uartputc(c);
    80000af8:	00000097          	auipc	ra,0x0
    80000afc:	fc2080e7          	jalr	-62(ra) # 80000aba <uartputc>
				            msg++;
    80000b00:	0485                	addi	s1,s1,1
		    while ((c = *msg) != '\0') {
    80000b02:	0004c503          	lbu	a0,0(s1)
    80000b06:	f96d                	bnez	a0,80000af8 <uartputs+0x14>
					        }
}
    80000b08:	60e2                	ld	ra,24(sp)
    80000b0a:	6442                	ld	s0,16(sp)
    80000b0c:	64a2                	ld	s1,8(sp)
    80000b0e:	6105                	addi	sp,sp,32
    80000b10:	8082                	ret
    80000b12:	8082                	ret

0000000080000b14 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000b14:	1141                	addi	sp,sp,-16
    80000b16:	e422                	sd	s0,8(sp)
    80000b18:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000b1a:	100007b7          	lui	a5,0x10000
    80000b1e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000b22:	8b85                	andi	a5,a5,1
    80000b24:	cb91                	beqz	a5,80000b38 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000b26:	100007b7          	lui	a5,0x10000
    80000b2a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80000b2e:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80000b32:	6422                	ld	s0,8(sp)
    80000b34:	0141                	addi	sp,sp,16
    80000b36:	8082                	ret
    return -1;
    80000b38:	557d                	li	a0,-1
    80000b3a:	bfe5                	j	80000b32 <uartgetc+0x1e>

0000000080000b3c <uartintr>:

// trap.c calls here when the uart interrupts.
void
uartintr(void)
{
    80000b3c:	1101                	addi	sp,sp,-32
    80000b3e:	ec06                	sd	ra,24(sp)
    80000b40:	e822                	sd	s0,16(sp)
    80000b42:	e426                	sd	s1,8(sp)
    80000b44:	1000                	addi	s0,sp,32
  while(1){
    int c = uartgetc();
    if(c == -1)
    80000b46:	54fd                	li	s1,-1
    int c = uartgetc();
    80000b48:	00000097          	auipc	ra,0x0
    80000b4c:	fcc080e7          	jalr	-52(ra) # 80000b14 <uartgetc>
    if(c == -1)
    80000b50:	00950763          	beq	a0,s1,80000b5e <uartintr+0x22>
      break;
    consoleintr(c);
    80000b54:	00000097          	auipc	ra,0x0
    80000b58:	8c4080e7          	jalr	-1852(ra) # 80000418 <consoleintr>
  while(1){
    80000b5c:	b7f5                	j	80000b48 <uartintr+0xc>
  }
}
    80000b5e:	60e2                	ld	ra,24(sp)
    80000b60:	6442                	ld	s0,16(sp)
    80000b62:	64a2                	ld	s1,8(sp)
    80000b64:	6105                	addi	sp,sp,32
    80000b66:	8082                	ret

0000000080000b68 <kinit>:
extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

void
kinit()
{
    80000b68:	1141                	addi	sp,sp,-16
    80000b6a:	e406                	sd	ra,8(sp)
    80000b6c:	e022                	sd	s0,0(sp)
    80000b6e:	0800                	addi	s0,sp,16
  char *p = (char *) PGROUNDUP((uint64) end);
  bd_init(p, (void*)PHYSTOP);
    80000b70:	45c5                	li	a1,17
    80000b72:	05ee                	slli	a1,a1,0x1b
    80000b74:	0002e517          	auipc	a0,0x2e
    80000b78:	53750513          	addi	a0,a0,1335 # 8002f0ab <end+0xfff>
    80000b7c:	77fd                	lui	a5,0xfffff
    80000b7e:	8d7d                	and	a0,a0,a5
    80000b80:	00007097          	auipc	ra,0x7
    80000b84:	ae0080e7          	jalr	-1312(ra) # 80007660 <bd_init>
}
    80000b88:	60a2                	ld	ra,8(sp)
    80000b8a:	6402                	ld	s0,0(sp)
    80000b8c:	0141                	addi	sp,sp,16
    80000b8e:	8082                	ret

0000000080000b90 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000b90:	1141                	addi	sp,sp,-16
    80000b92:	e406                	sd	ra,8(sp)
    80000b94:	e022                	sd	s0,0(sp)
    80000b96:	0800                	addi	s0,sp,16
  bd_free(pa);
    80000b98:	00006097          	auipc	ra,0x6
    80000b9c:	5f4080e7          	jalr	1524(ra) # 8000718c <bd_free>
}
    80000ba0:	60a2                	ld	ra,8(sp)
    80000ba2:	6402                	ld	s0,0(sp)
    80000ba4:	0141                	addi	sp,sp,16
    80000ba6:	8082                	ret

0000000080000ba8 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ba8:	1141                	addi	sp,sp,-16
    80000baa:	e406                	sd	ra,8(sp)
    80000bac:	e022                	sd	s0,0(sp)
    80000bae:	0800                	addi	s0,sp,16
  return bd_malloc(PGSIZE);
    80000bb0:	6505                	lui	a0,0x1
    80000bb2:	00006097          	auipc	ra,0x6
    80000bb6:	3d6080e7          	jalr	982(ra) # 80006f88 <bd_malloc>
}
    80000bba:	60a2                	ld	ra,8(sp)
    80000bbc:	6402                	ld	s0,0(sp)
    80000bbe:	0141                	addi	sp,sp,16
    80000bc0:	8082                	ret

0000000080000bc2 <initlock>:

// assumes locks are not freed
void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
    80000bc2:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000bc4:	00052023          	sw	zero,0(a0) # 1000 <_entry-0x7ffff000>
  lk->cpu = 0;
    80000bc8:	00053823          	sd	zero,16(a0)
  lk->nts = 0;
    80000bcc:	02052423          	sw	zero,40(a0)
  lk->n = 0;
    80000bd0:	02052223          	sw	zero,36(a0)
  if(nlock >= NLOCK)
    80000bd4:	0002d797          	auipc	a5,0x2d
    80000bd8:	49c78793          	addi	a5,a5,1180 # 8002e070 <nlock>
    80000bdc:	439c                	lw	a5,0(a5)
    80000bde:	3e700713          	li	a4,999
    80000be2:	02f74063          	blt	a4,a5,80000c02 <initlock+0x40>
    panic("initlock");
  locks[nlock] = lk;
    80000be6:	00379693          	slli	a3,a5,0x3
    80000bea:	00013717          	auipc	a4,0x13
    80000bee:	ebe70713          	addi	a4,a4,-322 # 80013aa8 <locks>
    80000bf2:	9736                	add	a4,a4,a3
    80000bf4:	e308                	sd	a0,0(a4)
  nlock++;
    80000bf6:	2785                	addiw	a5,a5,1
    80000bf8:	0002d717          	auipc	a4,0x2d
    80000bfc:	46f72c23          	sw	a5,1144(a4) # 8002e070 <nlock>
    80000c00:	8082                	ret
{
    80000c02:	1141                	addi	sp,sp,-16
    80000c04:	e406                	sd	ra,8(sp)
    80000c06:	e022                	sd	s0,0(sp)
    80000c08:	0800                	addi	s0,sp,16
    panic("initlock");
    80000c0a:	00007517          	auipc	a0,0x7
    80000c0e:	65650513          	addi	a0,a0,1622 # 80008260 <userret+0x1d0>
    80000c12:	00000097          	auipc	ra,0x0
    80000c16:	bb4080e7          	jalr	-1100(ra) # 800007c6 <panic>

0000000080000c1a <dump_locks>:
}

void dump_locks(void){
    80000c1a:	7139                	addi	sp,sp,-64
    80000c1c:	fc06                	sd	ra,56(sp)
    80000c1e:	f822                	sd	s0,48(sp)
    80000c20:	f426                	sd	s1,40(sp)
    80000c22:	f04a                	sd	s2,32(sp)
    80000c24:	ec4e                	sd	s3,24(sp)
    80000c26:	e852                	sd	s4,16(sp)
    80000c28:	e456                	sd	s5,8(sp)
    80000c2a:	0080                	addi	s0,sp,64
  printf_no_lock("LID\tLOCKED\tCPU\tPID\tNAME\t\tPC\n");
    80000c2c:	00007517          	auipc	a0,0x7
    80000c30:	64450513          	addi	a0,a0,1604 # 80008270 <userret+0x1e0>
    80000c34:	00000097          	auipc	ra,0x0
    80000c38:	de8080e7          	jalr	-536(ra) # 80000a1c <printf_no_lock>
  for(int i = 0; i < nlock; i++){
    80000c3c:	0002d797          	auipc	a5,0x2d
    80000c40:	43478793          	addi	a5,a5,1076 # 8002e070 <nlock>
    80000c44:	439c                	lw	a5,0(a5)
    80000c46:	04f05d63          	blez	a5,80000ca0 <dump_locks+0x86>
    80000c4a:	00013917          	auipc	s2,0x13
    80000c4e:	e5e90913          	addi	s2,s2,-418 # 80013aa8 <locks>
    80000c52:	4481                	li	s1,0
    if(locks[i]->locked)
      printf_no_lock("%d\t%d\t%d\t%d\t%s\t\t%p\n",
                     i,
                     locks[i]->locked,
                     locks[i]->cpu - cpus,
    80000c54:	00015a97          	auipc	s5,0x15
    80000c58:	e44a8a93          	addi	s5,s5,-444 # 80015a98 <cpus>
      printf_no_lock("%d\t%d\t%d\t%d\t%s\t\t%p\n",
    80000c5c:	00007a17          	auipc	s4,0x7
    80000c60:	634a0a13          	addi	s4,s4,1588 # 80008290 <userret+0x200>
  for(int i = 0; i < nlock; i++){
    80000c64:	0002d997          	auipc	s3,0x2d
    80000c68:	40c98993          	addi	s3,s3,1036 # 8002e070 <nlock>
    80000c6c:	a02d                	j	80000c96 <dump_locks+0x7c>
                     locks[i]->cpu - cpus,
    80000c6e:	6b14                	ld	a3,16(a4)
    80000c70:	415686b3          	sub	a3,a3,s5
      printf_no_lock("%d\t%d\t%d\t%d\t%s\t\t%p\n",
    80000c74:	01873803          	ld	a6,24(a4)
    80000c78:	671c                	ld	a5,8(a4)
    80000c7a:	5318                	lw	a4,32(a4)
    80000c7c:	869d                	srai	a3,a3,0x7
    80000c7e:	85a6                	mv	a1,s1
    80000c80:	8552                	mv	a0,s4
    80000c82:	00000097          	auipc	ra,0x0
    80000c86:	d9a080e7          	jalr	-614(ra) # 80000a1c <printf_no_lock>
  for(int i = 0; i < nlock; i++){
    80000c8a:	2485                	addiw	s1,s1,1
    80000c8c:	0921                	addi	s2,s2,8
    80000c8e:	0009a783          	lw	a5,0(s3)
    80000c92:	00f4d763          	ble	a5,s1,80000ca0 <dump_locks+0x86>
    if(locks[i]->locked)
    80000c96:	00093703          	ld	a4,0(s2)
    80000c9a:	4310                	lw	a2,0(a4)
    80000c9c:	d67d                	beqz	a2,80000c8a <dump_locks+0x70>
    80000c9e:	bfc1                	j	80000c6e <dump_locks+0x54>
                     locks[i]->pid,
                     locks[i]->name,
                     locks[i]->pc
        );
  }
}
    80000ca0:	70e2                	ld	ra,56(sp)
    80000ca2:	7442                	ld	s0,48(sp)
    80000ca4:	74a2                	ld	s1,40(sp)
    80000ca6:	7902                	ld	s2,32(sp)
    80000ca8:	69e2                	ld	s3,24(sp)
    80000caa:	6a42                	ld	s4,16(sp)
    80000cac:	6aa2                	ld	s5,8(sp)
    80000cae:	6121                	addi	sp,sp,64
    80000cb0:	8082                	ret

0000000080000cb2 <holding>:
// Must be called with interrupts off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000cb2:	411c                	lw	a5,0(a0)
    80000cb4:	e399                	bnez	a5,80000cba <holding+0x8>
    80000cb6:	4501                	li	a0,0
  return r;
}
    80000cb8:	8082                	ret
{
    80000cba:	1101                	addi	sp,sp,-32
    80000cbc:	ec06                	sd	ra,24(sp)
    80000cbe:	e822                	sd	s0,16(sp)
    80000cc0:	e426                	sd	s1,8(sp)
    80000cc2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000cc4:	6904                	ld	s1,16(a0)
    80000cc6:	00001097          	auipc	ra,0x1
    80000cca:	318080e7          	jalr	792(ra) # 80001fde <mycpu>
    80000cce:	40a48533          	sub	a0,s1,a0
    80000cd2:	00153513          	seqz	a0,a0
}
    80000cd6:	60e2                	ld	ra,24(sp)
    80000cd8:	6442                	ld	s0,16(sp)
    80000cda:	64a2                	ld	s1,8(sp)
    80000cdc:	6105                	addi	sp,sp,32
    80000cde:	8082                	ret

0000000080000ce0 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000ce0:	1101                	addi	sp,sp,-32
    80000ce2:	ec06                	sd	ra,24(sp)
    80000ce4:	e822                	sd	s0,16(sp)
    80000ce6:	e426                	sd	s1,8(sp)
    80000ce8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000cea:	100024f3          	csrr	s1,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000cee:	8889                	andi	s1,s1,2
  int old = intr_get();
  if(old)
    80000cf0:	c491                	beqz	s1,80000cfc <push_off+0x1c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000cf2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000cf6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000cf8:	10079073          	csrw	sstatus,a5
    intr_off();
  if(mycpu()->noff == 0)
    80000cfc:	00001097          	auipc	ra,0x1
    80000d00:	2e2080e7          	jalr	738(ra) # 80001fde <mycpu>
    80000d04:	5d3c                	lw	a5,120(a0)
    80000d06:	cf89                	beqz	a5,80000d20 <push_off+0x40>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000d08:	00001097          	auipc	ra,0x1
    80000d0c:	2d6080e7          	jalr	726(ra) # 80001fde <mycpu>
    80000d10:	5d3c                	lw	a5,120(a0)
    80000d12:	2785                	addiw	a5,a5,1
    80000d14:	dd3c                	sw	a5,120(a0)
}
    80000d16:	60e2                	ld	ra,24(sp)
    80000d18:	6442                	ld	s0,16(sp)
    80000d1a:	64a2                	ld	s1,8(sp)
    80000d1c:	6105                	addi	sp,sp,32
    80000d1e:	8082                	ret
    mycpu()->intena = old;
    80000d20:	00001097          	auipc	ra,0x1
    80000d24:	2be080e7          	jalr	702(ra) # 80001fde <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000d28:	009034b3          	snez	s1,s1
    80000d2c:	dd64                	sw	s1,124(a0)
    80000d2e:	bfe9                	j	80000d08 <push_off+0x28>

0000000080000d30 <acquire>:
{
    80000d30:	7159                	addi	sp,sp,-112
    80000d32:	f486                	sd	ra,104(sp)
    80000d34:	f0a2                	sd	s0,96(sp)
    80000d36:	eca6                	sd	s1,88(sp)
    80000d38:	e8ca                	sd	s2,80(sp)
    80000d3a:	e4ce                	sd	s3,72(sp)
    80000d3c:	e0d2                	sd	s4,64(sp)
    80000d3e:	fc56                	sd	s5,56(sp)
    80000d40:	f85a                	sd	s6,48(sp)
    80000d42:	f45e                	sd	s7,40(sp)
    80000d44:	f062                	sd	s8,32(sp)
    80000d46:	ec66                	sd	s9,24(sp)
    80000d48:	e86a                	sd	s10,16(sp)
    80000d4a:	e46e                	sd	s11,8(sp)
    80000d4c:	1880                	addi	s0,sp,112
    80000d4e:	84aa                	mv	s1,a0
  asm volatile("mv %0, ra" : "=r" (ra));
    80000d50:	8a86                	mv	s5,ra
  ra -= 4;
    80000d52:	1af1                	addi	s5,s5,-4
  push_off(); // disable interrupts to avoid deadlock.
    80000d54:	00000097          	auipc	ra,0x0
    80000d58:	f8c080e7          	jalr	-116(ra) # 80000ce0 <push_off>
  if(holding(lk)){
    80000d5c:	8526                	mv	a0,s1
    80000d5e:	00000097          	auipc	ra,0x0
    80000d62:	f54080e7          	jalr	-172(ra) # 80000cb2 <holding>
    80000d66:	e121                	bnez	a0,80000da6 <acquire+0x76>
    80000d68:	892a                	mv	s2,a0
  __sync_fetch_and_add(&(lk->n), 1);
    80000d6a:	4785                	li	a5,1
    80000d6c:	02448713          	addi	a4,s1,36
    80000d70:	0f50000f          	fence	iorw,ow
    80000d74:	04f7202f          	amoadd.w.aq	zero,a5,(a4)
  int warned = 0;
    80000d78:	872a                	mv	a4,a0
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80000d7a:	4985                	li	s3,1
    if(nbtries > MAXTRIES && !warned){
    80000d7c:	6a61                	lui	s4,0x18
    80000d7e:	6a0a0a13          	addi	s4,s4,1696 # 186a0 <_entry-0x7ffe7960>
      printf_no_lock("CPU %d: Blocked while acquiring %s (%p)\n", cpuid(), lk->name, lk);
    80000d82:	00007d17          	auipc	s10,0x7
    80000d86:	5aed0d13          	addi	s10,s10,1454 # 80008330 <userret+0x2a0>
                     lk->cpu - cpus,
    80000d8a:	00015c97          	auipc	s9,0x15
    80000d8e:	d0ec8c93          	addi	s9,s9,-754 # 80015a98 <cpus>
      printf_no_lock("process %d (CPU %d) took it at pc=%p \n", lk->pid,
    80000d92:	00007c17          	auipc	s8,0x7
    80000d96:	53ec0c13          	addi	s8,s8,1342 # 800082d0 <userret+0x240>
      printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000d9a:	5bfd                	li	s7,-1
    80000d9c:	00007b17          	auipc	s6,0x7
    80000da0:	55cb0b13          	addi	s6,s6,1372 # 800082f8 <userret+0x268>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80000da4:	a84d                	j	80000e56 <acquire+0x126>
    printf_no_lock("requesting %s (%p) but already have it\n", lk->name, lk);
    80000da6:	8626                	mv	a2,s1
    80000da8:	648c                	ld	a1,8(s1)
    80000daa:	00007517          	auipc	a0,0x7
    80000dae:	4fe50513          	addi	a0,a0,1278 # 800082a8 <userret+0x218>
    80000db2:	00000097          	auipc	ra,0x0
    80000db6:	c6a080e7          	jalr	-918(ra) # 80000a1c <printf_no_lock>
                   lk->cpu - cpus,
    80000dba:	6890                	ld	a2,16(s1)
    80000dbc:	00015797          	auipc	a5,0x15
    80000dc0:	cdc78793          	addi	a5,a5,-804 # 80015a98 <cpus>
    80000dc4:	8e1d                	sub	a2,a2,a5
    printf_no_lock("process %d (CPU %d) took it at pc=%p \n", lk->pid,
    80000dc6:	6c94                	ld	a3,24(s1)
    80000dc8:	861d                	srai	a2,a2,0x7
    80000dca:	508c                	lw	a1,32(s1)
    80000dcc:	00007517          	auipc	a0,0x7
    80000dd0:	50450513          	addi	a0,a0,1284 # 800082d0 <userret+0x240>
    80000dd4:	00000097          	auipc	ra,0x0
    80000dd8:	c48080e7          	jalr	-952(ra) # 80000a1c <printf_no_lock>
                   myproc() ? myproc()->pid : -1,
    80000ddc:	00001097          	auipc	ra,0x1
    80000de0:	21e080e7          	jalr	542(ra) # 80001ffa <myproc>
    printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000de4:	54fd                	li	s1,-1
    80000de6:	c511                	beqz	a0,80000df2 <acquire+0xc2>
                   myproc() ? myproc()->pid : -1,
    80000de8:	00001097          	auipc	ra,0x1
    80000dec:	212080e7          	jalr	530(ra) # 80001ffa <myproc>
    printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000df0:	4924                	lw	s1,80(a0)
    80000df2:	00001097          	auipc	ra,0x1
    80000df6:	1dc080e7          	jalr	476(ra) # 80001fce <cpuid>
    80000dfa:	86aa                	mv	a3,a0
    80000dfc:	8626                	mv	a2,s1
    80000dfe:	85d6                	mv	a1,s5
    80000e00:	00007517          	auipc	a0,0x7
    80000e04:	4f850513          	addi	a0,a0,1272 # 800082f8 <userret+0x268>
    80000e08:	00000097          	auipc	ra,0x0
    80000e0c:	c14080e7          	jalr	-1004(ra) # 80000a1c <printf_no_lock>
    procdump();
    80000e10:	00002097          	auipc	ra,0x2
    80000e14:	cf2080e7          	jalr	-782(ra) # 80002b02 <procdump>
    panic("acquire");
    80000e18:	00007517          	auipc	a0,0x7
    80000e1c:	51050513          	addi	a0,a0,1296 # 80008328 <userret+0x298>
    80000e20:	00000097          	auipc	ra,0x0
    80000e24:	9a6080e7          	jalr	-1626(ra) # 800007c6 <panic>
      printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000e28:	00001097          	auipc	ra,0x1
    80000e2c:	1a6080e7          	jalr	422(ra) # 80001fce <cpuid>
    80000e30:	86aa                	mv	a3,a0
    80000e32:	866e                	mv	a2,s11
    80000e34:	85d6                	mv	a1,s5
    80000e36:	855a                	mv	a0,s6
    80000e38:	00000097          	auipc	ra,0x0
    80000e3c:	be4080e7          	jalr	-1052(ra) # 80000a1c <printf_no_lock>
      procdump();
    80000e40:	00002097          	auipc	ra,0x2
    80000e44:	cc2080e7          	jalr	-830(ra) # 80002b02 <procdump>
      warned = 1;
    80000e48:	4705                	li	a4,1
     __sync_fetch_and_add(&lk->nts, 1);
    80000e4a:	02848793          	addi	a5,s1,40
    80000e4e:	0f50000f          	fence	iorw,ow
    80000e52:	0537a02f          	amoadd.w.aq	zero,s3,(a5)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80000e56:	87ce                	mv	a5,s3
    80000e58:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000e5c:	2781                	sext.w	a5,a5
    80000e5e:	cba9                	beqz	a5,80000eb0 <acquire+0x180>
    nbtries++;
    80000e60:	2905                	addiw	s2,s2,1
    if(nbtries > MAXTRIES && !warned){
    80000e62:	ff2a54e3          	ble	s2,s4,80000e4a <acquire+0x11a>
    80000e66:	f375                	bnez	a4,80000e4a <acquire+0x11a>
      printf_no_lock("CPU %d: Blocked while acquiring %s (%p)\n", cpuid(), lk->name, lk);
    80000e68:	00001097          	auipc	ra,0x1
    80000e6c:	166080e7          	jalr	358(ra) # 80001fce <cpuid>
    80000e70:	86a6                	mv	a3,s1
    80000e72:	6490                	ld	a2,8(s1)
    80000e74:	85aa                	mv	a1,a0
    80000e76:	856a                	mv	a0,s10
    80000e78:	00000097          	auipc	ra,0x0
    80000e7c:	ba4080e7          	jalr	-1116(ra) # 80000a1c <printf_no_lock>
                     lk->cpu - cpus,
    80000e80:	6890                	ld	a2,16(s1)
    80000e82:	41960633          	sub	a2,a2,s9
      printf_no_lock("process %d (CPU %d) took it at pc=%p \n", lk->pid,
    80000e86:	6c94                	ld	a3,24(s1)
    80000e88:	861d                	srai	a2,a2,0x7
    80000e8a:	508c                	lw	a1,32(s1)
    80000e8c:	8562                	mv	a0,s8
    80000e8e:	00000097          	auipc	ra,0x0
    80000e92:	b8e080e7          	jalr	-1138(ra) # 80000a1c <printf_no_lock>
                     myproc() ? myproc()->pid : -1,
    80000e96:	00001097          	auipc	ra,0x1
    80000e9a:	164080e7          	jalr	356(ra) # 80001ffa <myproc>
      printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000e9e:	8dde                	mv	s11,s7
    80000ea0:	d541                	beqz	a0,80000e28 <acquire+0xf8>
                     myproc() ? myproc()->pid : -1,
    80000ea2:	00001097          	auipc	ra,0x1
    80000ea6:	158080e7          	jalr	344(ra) # 80001ffa <myproc>
      printf_no_lock("I am myself at pc=%p in pid=%d on CPU %d\n",
    80000eaa:	05052d83          	lw	s11,80(a0)
    80000eae:	bfad                	j	80000e28 <acquire+0xf8>
  if(warned){
    80000eb0:	e729                	bnez	a4,80000efa <acquire+0x1ca>
  __sync_synchronize();
    80000eb2:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000eb6:	00001097          	auipc	ra,0x1
    80000eba:	128080e7          	jalr	296(ra) # 80001fde <mycpu>
    80000ebe:	e888                	sd	a0,16(s1)
  lk->pc = ra;
    80000ec0:	0154bc23          	sd	s5,24(s1)
  lk->pid = myproc() ? myproc()->pid : -1;
    80000ec4:	00001097          	auipc	ra,0x1
    80000ec8:	136080e7          	jalr	310(ra) # 80001ffa <myproc>
    80000ecc:	57fd                	li	a5,-1
    80000ece:	c511                	beqz	a0,80000eda <acquire+0x1aa>
    80000ed0:	00001097          	auipc	ra,0x1
    80000ed4:	12a080e7          	jalr	298(ra) # 80001ffa <myproc>
    80000ed8:	493c                	lw	a5,80(a0)
    80000eda:	d09c                	sw	a5,32(s1)
}
    80000edc:	70a6                	ld	ra,104(sp)
    80000ede:	7406                	ld	s0,96(sp)
    80000ee0:	64e6                	ld	s1,88(sp)
    80000ee2:	6946                	ld	s2,80(sp)
    80000ee4:	69a6                	ld	s3,72(sp)
    80000ee6:	6a06                	ld	s4,64(sp)
    80000ee8:	7ae2                	ld	s5,56(sp)
    80000eea:	7b42                	ld	s6,48(sp)
    80000eec:	7ba2                	ld	s7,40(sp)
    80000eee:	7c02                	ld	s8,32(sp)
    80000ef0:	6ce2                	ld	s9,24(sp)
    80000ef2:	6d42                	ld	s10,16(sp)
    80000ef4:	6da2                	ld	s11,8(sp)
    80000ef6:	6165                	addi	sp,sp,112
    80000ef8:	8082                	ret
    printf_no_lock("CPU %d: Finally acquired %s (%p) after %d tries\n", cpuid(), lk->name, lk, nbtries);
    80000efa:	00001097          	auipc	ra,0x1
    80000efe:	0d4080e7          	jalr	212(ra) # 80001fce <cpuid>
    80000f02:	874a                	mv	a4,s2
    80000f04:	86a6                	mv	a3,s1
    80000f06:	6490                	ld	a2,8(s1)
    80000f08:	85aa                	mv	a1,a0
    80000f0a:	00007517          	auipc	a0,0x7
    80000f0e:	45650513          	addi	a0,a0,1110 # 80008360 <userret+0x2d0>
    80000f12:	00000097          	auipc	ra,0x0
    80000f16:	b0a080e7          	jalr	-1270(ra) # 80000a1c <printf_no_lock>
    80000f1a:	bf61                	j	80000eb2 <acquire+0x182>

0000000080000f1c <pop_off>:

void
pop_off(void)
{
    80000f1c:	1141                	addi	sp,sp,-16
    80000f1e:	e406                	sd	ra,8(sp)
    80000f20:	e022                	sd	s0,0(sp)
    80000f22:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000f24:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000f28:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000f2a:	eb8d                	bnez	a5,80000f5c <pop_off+0x40>
    panic("pop_off - interruptible");
  struct cpu *c = mycpu();
    80000f2c:	00001097          	auipc	ra,0x1
    80000f30:	0b2080e7          	jalr	178(ra) # 80001fde <mycpu>
  if(c->noff < 1)
    80000f34:	5d3c                	lw	a5,120(a0)
    80000f36:	02f05b63          	blez	a5,80000f6c <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000f3a:	37fd                	addiw	a5,a5,-1
    80000f3c:	0007871b          	sext.w	a4,a5
    80000f40:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000f42:	eb09                	bnez	a4,80000f54 <pop_off+0x38>
    80000f44:	5d7c                	lw	a5,124(a0)
    80000f46:	c799                	beqz	a5,80000f54 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000f48:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000f4c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000f50:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000f54:	60a2                	ld	ra,8(sp)
    80000f56:	6402                	ld	s0,0(sp)
    80000f58:	0141                	addi	sp,sp,16
    80000f5a:	8082                	ret
    panic("pop_off - interruptible");
    80000f5c:	00007517          	auipc	a0,0x7
    80000f60:	43c50513          	addi	a0,a0,1084 # 80008398 <userret+0x308>
    80000f64:	00000097          	auipc	ra,0x0
    80000f68:	862080e7          	jalr	-1950(ra) # 800007c6 <panic>
    panic("pop_off");
    80000f6c:	00007517          	auipc	a0,0x7
    80000f70:	44450513          	addi	a0,a0,1092 # 800083b0 <userret+0x320>
    80000f74:	00000097          	auipc	ra,0x0
    80000f78:	852080e7          	jalr	-1966(ra) # 800007c6 <panic>

0000000080000f7c <release>:
{
    80000f7c:	1101                	addi	sp,sp,-32
    80000f7e:	ec06                	sd	ra,24(sp)
    80000f80:	e822                	sd	s0,16(sp)
    80000f82:	e426                	sd	s1,8(sp)
    80000f84:	1000                	addi	s0,sp,32
    80000f86:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000f88:	00000097          	auipc	ra,0x0
    80000f8c:	d2a080e7          	jalr	-726(ra) # 80000cb2 <holding>
    80000f90:	c115                	beqz	a0,80000fb4 <release+0x38>
  lk->cpu = 0;
    80000f92:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000f96:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000f9a:	0f50000f          	fence	iorw,ow
    80000f9e:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000fa2:	00000097          	auipc	ra,0x0
    80000fa6:	f7a080e7          	jalr	-134(ra) # 80000f1c <pop_off>
}
    80000faa:	60e2                	ld	ra,24(sp)
    80000fac:	6442                	ld	s0,16(sp)
    80000fae:	64a2                	ld	s1,8(sp)
    80000fb0:	6105                	addi	sp,sp,32
    80000fb2:	8082                	ret
    panic("release");
    80000fb4:	00007517          	auipc	a0,0x7
    80000fb8:	40450513          	addi	a0,a0,1028 # 800083b8 <userret+0x328>
    80000fbc:	00000097          	auipc	ra,0x0
    80000fc0:	80a080e7          	jalr	-2038(ra) # 800007c6 <panic>

0000000080000fc4 <print_lock>:

void
print_lock(struct spinlock *lk)
{
  if(lk->n > 0) 
    80000fc4:	5154                	lw	a3,36(a0)
    80000fc6:	e291                	bnez	a3,80000fca <print_lock+0x6>
    80000fc8:	8082                	ret
{
    80000fca:	1141                	addi	sp,sp,-16
    80000fcc:	e406                	sd	ra,8(sp)
    80000fce:	e022                	sd	s0,0(sp)
    80000fd0:	0800                	addi	s0,sp,16
    printf("lock: %s: #test-and-set %d #acquire() %d\n", lk->name, lk->nts, lk->n);
    80000fd2:	5510                	lw	a2,40(a0)
    80000fd4:	650c                	ld	a1,8(a0)
    80000fd6:	00007517          	auipc	a0,0x7
    80000fda:	3ea50513          	addi	a0,a0,1002 # 800083c0 <userret+0x330>
    80000fde:	00000097          	auipc	ra,0x0
    80000fe2:	a00080e7          	jalr	-1536(ra) # 800009de <printf>
}
    80000fe6:	60a2                	ld	ra,8(sp)
    80000fe8:	6402                	ld	s0,0(sp)
    80000fea:	0141                	addi	sp,sp,16
    80000fec:	8082                	ret

0000000080000fee <sys_ntas>:

uint64
sys_ntas(void)
{
    80000fee:	715d                	addi	sp,sp,-80
    80000ff0:	e486                	sd	ra,72(sp)
    80000ff2:	e0a2                	sd	s0,64(sp)
    80000ff4:	fc26                	sd	s1,56(sp)
    80000ff6:	f84a                	sd	s2,48(sp)
    80000ff8:	f44e                	sd	s3,40(sp)
    80000ffa:	f052                	sd	s4,32(sp)
    80000ffc:	ec56                	sd	s5,24(sp)
    80000ffe:	e85a                	sd	s6,16(sp)
    80001000:	0880                	addi	s0,sp,80
  int zero = 0;
    80001002:	fa042e23          	sw	zero,-68(s0)
  int tot = 0;
  
  if (argint(0, &zero) < 0) {
    80001006:	fbc40593          	addi	a1,s0,-68
    8000100a:	4501                	li	a0,0
    8000100c:	00002097          	auipc	ra,0x2
    80001010:	24a080e7          	jalr	586(ra) # 80003256 <argint>
    80001014:	18054263          	bltz	a0,80001198 <sys_ntas+0x1aa>
    return -1;
  }
  if(zero == 0) {
    80001018:	fbc42783          	lw	a5,-68(s0)
    8000101c:	e3a9                	bnez	a5,8000105e <sys_ntas+0x70>
    for(int i = 0; i < NLOCK; i++) {
      if(locks[i] == 0)
    8000101e:	00013797          	auipc	a5,0x13
    80001022:	a8a78793          	addi	a5,a5,-1398 # 80013aa8 <locks>
    80001026:	639c                	ld	a5,0(a5)
    80001028:	16078a63          	beqz	a5,8000119c <sys_ntas+0x1ae>
        break;
      locks[i]->nts = 0;
    8000102c:	0207a423          	sw	zero,40(a5)
      locks[i]->n = 0;
    80001030:	0207a223          	sw	zero,36(a5)
    for(int i = 0; i < NLOCK; i++) {
    80001034:	00013797          	auipc	a5,0x13
    80001038:	a7c78793          	addi	a5,a5,-1412 # 80013ab0 <locks+0x8>
    8000103c:	00015697          	auipc	a3,0x15
    80001040:	9ac68693          	addi	a3,a3,-1620 # 800159e8 <prio_lock>
      if(locks[i] == 0)
    80001044:	6398                	ld	a4,0(a5)
    80001046:	14070d63          	beqz	a4,800011a0 <sys_ntas+0x1b2>
      locks[i]->nts = 0;
    8000104a:	02072423          	sw	zero,40(a4)
      locks[i]->n = 0;
    8000104e:	6398                	ld	a4,0(a5)
    80001050:	02072223          	sw	zero,36(a4)
    for(int i = 0; i < NLOCK; i++) {
    80001054:	07a1                	addi	a5,a5,8
    80001056:	fed797e3          	bne	a5,a3,80001044 <sys_ntas+0x56>
    }
    return 0;
    8000105a:	4501                	li	a0,0
    8000105c:	a225                	j	80001184 <sys_ntas+0x196>
  }

  printf("=== lock kmem/bcache stats\n");
    8000105e:	00007517          	auipc	a0,0x7
    80001062:	39250513          	addi	a0,a0,914 # 800083f0 <userret+0x360>
    80001066:	00000097          	auipc	ra,0x0
    8000106a:	978080e7          	jalr	-1672(ra) # 800009de <printf>
  for(int i = 0; i < NLOCK; i++) {
    if(locks[i] == 0)
    8000106e:	00013797          	auipc	a5,0x13
    80001072:	a3a78793          	addi	a5,a5,-1478 # 80013aa8 <locks>
    80001076:	639c                	ld	a5,0(a5)
    80001078:	c3d1                	beqz	a5,800010fc <sys_ntas+0x10e>
    8000107a:	00013497          	auipc	s1,0x13
    8000107e:	a2e48493          	addi	s1,s1,-1490 # 80013aa8 <locks>
    80001082:	00015a97          	auipc	s5,0x15
    80001086:	95ea8a93          	addi	s5,s5,-1698 # 800159e0 <locks+0x1f38>
  int tot = 0;
    8000108a:	4981                	li	s3,0
      break;
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    8000108c:	00007917          	auipc	s2,0x7
    80001090:	38490913          	addi	s2,s2,900 # 80008410 <userret+0x380>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    80001094:	00007b17          	auipc	s6,0x7
    80001098:	384b0b13          	addi	s6,s6,900 # 80008418 <userret+0x388>
    8000109c:	a831                	j	800010b8 <sys_ntas+0xca>
      tot += locks[i]->nts;
    8000109e:	6088                	ld	a0,0(s1)
    800010a0:	551c                	lw	a5,40(a0)
    800010a2:	013789bb          	addw	s3,a5,s3
      print_lock(locks[i]);
    800010a6:	00000097          	auipc	ra,0x0
    800010aa:	f1e080e7          	jalr	-226(ra) # 80000fc4 <print_lock>
  for(int i = 0; i < NLOCK; i++) {
    800010ae:	05548863          	beq	s1,s5,800010fe <sys_ntas+0x110>
    if(locks[i] == 0)
    800010b2:	04a1                	addi	s1,s1,8
    800010b4:	609c                	ld	a5,0(s1)
    800010b6:	c7a1                	beqz	a5,800010fe <sys_ntas+0x110>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    800010b8:	0087ba03          	ld	s4,8(a5)
    800010bc:	854a                	mv	a0,s2
    800010be:	00000097          	auipc	ra,0x0
    800010c2:	290080e7          	jalr	656(ra) # 8000134e <strlen>
    800010c6:	0005061b          	sext.w	a2,a0
    800010ca:	85ca                	mv	a1,s2
    800010cc:	8552                	mv	a0,s4
    800010ce:	00000097          	auipc	ra,0x0
    800010d2:	1be080e7          	jalr	446(ra) # 8000128c <strncmp>
    800010d6:	d561                	beqz	a0,8000109e <sys_ntas+0xb0>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    800010d8:	609c                	ld	a5,0(s1)
    800010da:	0087ba03          	ld	s4,8(a5)
    800010de:	855a                	mv	a0,s6
    800010e0:	00000097          	auipc	ra,0x0
    800010e4:	26e080e7          	jalr	622(ra) # 8000134e <strlen>
    800010e8:	0005061b          	sext.w	a2,a0
    800010ec:	85da                	mv	a1,s6
    800010ee:	8552                	mv	a0,s4
    800010f0:	00000097          	auipc	ra,0x0
    800010f4:	19c080e7          	jalr	412(ra) # 8000128c <strncmp>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    800010f8:	f95d                	bnez	a0,800010ae <sys_ntas+0xc0>
    800010fa:	b755                	j	8000109e <sys_ntas+0xb0>
  int tot = 0;
    800010fc:	4981                	li	s3,0
    }
  }

  printf("=== top 5 contended locks:\n");
    800010fe:	00007517          	auipc	a0,0x7
    80001102:	32250513          	addi	a0,a0,802 # 80008420 <userret+0x390>
    80001106:	00000097          	auipc	ra,0x0
    8000110a:	8d8080e7          	jalr	-1832(ra) # 800009de <printf>
    8000110e:	4a15                	li	s4,5
  int last = 100000000;
    80001110:	05f5e537          	lui	a0,0x5f5e
    80001114:	10050513          	addi	a0,a0,256 # 5f5e100 <_entry-0x7a0a1f00>
  // stupid way to compute top 5 contended locks
  for(int t= 0; t < 5; t++) {
    int top = 0;
    for(int i = 0; i < NLOCK; i++) {
      if(locks[i] == 0)
    80001118:	00013497          	auipc	s1,0x13
    8000111c:	99048493          	addi	s1,s1,-1648 # 80013aa8 <locks>
    for(int i = 0; i < NLOCK; i++) {
    80001120:	4a81                	li	s5,0
    80001122:	3e800913          	li	s2,1000
    80001126:	a0a1                	j	8000116e <sys_ntas+0x180>
    80001128:	2705                	addiw	a4,a4,1
    8000112a:	03270363          	beq	a4,s2,80001150 <sys_ntas+0x162>
      if(locks[i] == 0)
    8000112e:	06a1                	addi	a3,a3,8
    80001130:	ff86b783          	ld	a5,-8(a3)
    80001134:	cf91                	beqz	a5,80001150 <sys_ntas+0x162>
        break;
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80001136:	5790                	lw	a2,40(a5)
    80001138:	00359793          	slli	a5,a1,0x3
    8000113c:	97a6                	add	a5,a5,s1
    8000113e:	639c                	ld	a5,0(a5)
    80001140:	579c                	lw	a5,40(a5)
    80001142:	fec7f3e3          	bleu	a2,a5,80001128 <sys_ntas+0x13a>
    80001146:	fea671e3          	bleu	a0,a2,80001128 <sys_ntas+0x13a>
    8000114a:	85ba                	mv	a1,a4
    8000114c:	bff1                	j	80001128 <sys_ntas+0x13a>
    int top = 0;
    8000114e:	85d6                	mv	a1,s5
        top = i;
      }
    }
    print_lock(locks[top]);
    80001150:	058e                	slli	a1,a1,0x3
    80001152:	00b48b33          	add	s6,s1,a1
    80001156:	000b3503          	ld	a0,0(s6)
    8000115a:	00000097          	auipc	ra,0x0
    8000115e:	e6a080e7          	jalr	-406(ra) # 80000fc4 <print_lock>
    last = locks[top]->nts;
    80001162:	000b3783          	ld	a5,0(s6)
    80001166:	5788                	lw	a0,40(a5)
  for(int t= 0; t < 5; t++) {
    80001168:	3a7d                	addiw	s4,s4,-1
    8000116a:	000a0c63          	beqz	s4,80001182 <sys_ntas+0x194>
      if(locks[i] == 0)
    8000116e:	609c                	ld	a5,0(s1)
    80001170:	dff9                	beqz	a5,8000114e <sys_ntas+0x160>
    80001172:	00013697          	auipc	a3,0x13
    80001176:	93e68693          	addi	a3,a3,-1730 # 80013ab0 <locks+0x8>
    for(int i = 0; i < NLOCK; i++) {
    8000117a:	8756                	mv	a4,s5
    int top = 0;
    8000117c:	85d6                	mv	a1,s5
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    8000117e:	2501                	sext.w	a0,a0
    80001180:	bf5d                	j	80001136 <sys_ntas+0x148>
  }
  return tot;
    80001182:	854e                	mv	a0,s3
}
    80001184:	60a6                	ld	ra,72(sp)
    80001186:	6406                	ld	s0,64(sp)
    80001188:	74e2                	ld	s1,56(sp)
    8000118a:	7942                	ld	s2,48(sp)
    8000118c:	79a2                	ld	s3,40(sp)
    8000118e:	7a02                	ld	s4,32(sp)
    80001190:	6ae2                	ld	s5,24(sp)
    80001192:	6b42                	ld	s6,16(sp)
    80001194:	6161                	addi	sp,sp,80
    80001196:	8082                	ret
    return -1;
    80001198:	557d                	li	a0,-1
    8000119a:	b7ed                	j	80001184 <sys_ntas+0x196>
    return 0;
    8000119c:	4501                	li	a0,0
    8000119e:	b7dd                	j	80001184 <sys_ntas+0x196>
    800011a0:	4501                	li	a0,0
    800011a2:	b7cd                	j	80001184 <sys_ntas+0x196>

00000000800011a4 <memset>:
#include "types.h"
#include "defs.h"

void*
memset(void *dst, int c, uint n)
{
    800011a4:	1141                	addi	sp,sp,-16
    800011a6:	e422                	sd	s0,8(sp)
    800011a8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    800011aa:	ce09                	beqz	a2,800011c4 <memset+0x20>
    800011ac:	87aa                	mv	a5,a0
    800011ae:	fff6071b          	addiw	a4,a2,-1
    800011b2:	1702                	slli	a4,a4,0x20
    800011b4:	9301                	srli	a4,a4,0x20
    800011b6:	0705                	addi	a4,a4,1
    800011b8:	972a                	add	a4,a4,a0
    cdst[i] = c;
    800011ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    800011be:	0785                	addi	a5,a5,1
    800011c0:	fee79de3          	bne	a5,a4,800011ba <memset+0x16>
  }
  return dst;
}
    800011c4:	6422                	ld	s0,8(sp)
    800011c6:	0141                	addi	sp,sp,16
    800011c8:	8082                	ret

00000000800011ca <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800011ca:	1141                	addi	sp,sp,-16
    800011cc:	e422                	sd	s0,8(sp)
    800011ce:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800011d0:	ce15                	beqz	a2,8000120c <memcmp+0x42>
    800011d2:	fff6069b          	addiw	a3,a2,-1
    if(*s1 != *s2)
    800011d6:	00054783          	lbu	a5,0(a0)
    800011da:	0005c703          	lbu	a4,0(a1)
    800011de:	02e79063          	bne	a5,a4,800011fe <memcmp+0x34>
    800011e2:	1682                	slli	a3,a3,0x20
    800011e4:	9281                	srli	a3,a3,0x20
    800011e6:	0685                	addi	a3,a3,1
    800011e8:	96aa                	add	a3,a3,a0
      return *s1 - *s2;
    s1++, s2++;
    800011ea:	0505                	addi	a0,a0,1
    800011ec:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800011ee:	00d50d63          	beq	a0,a3,80001208 <memcmp+0x3e>
    if(*s1 != *s2)
    800011f2:	00054783          	lbu	a5,0(a0)
    800011f6:	0005c703          	lbu	a4,0(a1)
    800011fa:	fee788e3          	beq	a5,a4,800011ea <memcmp+0x20>
      return *s1 - *s2;
    800011fe:	40e7853b          	subw	a0,a5,a4
  }

  return 0;
}
    80001202:	6422                	ld	s0,8(sp)
    80001204:	0141                	addi	sp,sp,16
    80001206:	8082                	ret
  return 0;
    80001208:	4501                	li	a0,0
    8000120a:	bfe5                	j	80001202 <memcmp+0x38>
    8000120c:	4501                	li	a0,0
    8000120e:	bfd5                	j	80001202 <memcmp+0x38>

0000000080001210 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80001210:	1141                	addi	sp,sp,-16
    80001212:	e422                	sd	s0,8(sp)
    80001214:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    80001216:	00a5f963          	bleu	a0,a1,80001228 <memmove+0x18>
    8000121a:	02061713          	slli	a4,a2,0x20
    8000121e:	9301                	srli	a4,a4,0x20
    80001220:	00e587b3          	add	a5,a1,a4
    80001224:	02f56563          	bltu	a0,a5,8000124e <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80001228:	fff6069b          	addiw	a3,a2,-1
    8000122c:	ce11                	beqz	a2,80001248 <memmove+0x38>
    8000122e:	1682                	slli	a3,a3,0x20
    80001230:	9281                	srli	a3,a3,0x20
    80001232:	0685                	addi	a3,a3,1
    80001234:	96ae                	add	a3,a3,a1
    80001236:	87aa                	mv	a5,a0
      *d++ = *s++;
    80001238:	0585                	addi	a1,a1,1
    8000123a:	0785                	addi	a5,a5,1
    8000123c:	fff5c703          	lbu	a4,-1(a1)
    80001240:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    80001244:	fed59ae3          	bne	a1,a3,80001238 <memmove+0x28>

  return dst;
}
    80001248:	6422                	ld	s0,8(sp)
    8000124a:	0141                	addi	sp,sp,16
    8000124c:	8082                	ret
    d += n;
    8000124e:	972a                	add	a4,a4,a0
    while(n-- > 0)
    80001250:	fff6069b          	addiw	a3,a2,-1
    80001254:	da75                	beqz	a2,80001248 <memmove+0x38>
    80001256:	02069613          	slli	a2,a3,0x20
    8000125a:	9201                	srli	a2,a2,0x20
    8000125c:	fff64613          	not	a2,a2
    80001260:	963e                	add	a2,a2,a5
      *--d = *--s;
    80001262:	17fd                	addi	a5,a5,-1
    80001264:	177d                	addi	a4,a4,-1
    80001266:	0007c683          	lbu	a3,0(a5)
    8000126a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    8000126e:	fef61ae3          	bne	a2,a5,80001262 <memmove+0x52>
    80001272:	bfd9                	j	80001248 <memmove+0x38>

0000000080001274 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80001274:	1141                	addi	sp,sp,-16
    80001276:	e406                	sd	ra,8(sp)
    80001278:	e022                	sd	s0,0(sp)
    8000127a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000127c:	00000097          	auipc	ra,0x0
    80001280:	f94080e7          	jalr	-108(ra) # 80001210 <memmove>
}
    80001284:	60a2                	ld	ra,8(sp)
    80001286:	6402                	ld	s0,0(sp)
    80001288:	0141                	addi	sp,sp,16
    8000128a:	8082                	ret

000000008000128c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000128c:	1141                	addi	sp,sp,-16
    8000128e:	e422                	sd	s0,8(sp)
    80001290:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80001292:	c229                	beqz	a2,800012d4 <strncmp+0x48>
    80001294:	00054783          	lbu	a5,0(a0)
    80001298:	c795                	beqz	a5,800012c4 <strncmp+0x38>
    8000129a:	0005c703          	lbu	a4,0(a1)
    8000129e:	02f71363          	bne	a4,a5,800012c4 <strncmp+0x38>
    800012a2:	fff6071b          	addiw	a4,a2,-1
    800012a6:	1702                	slli	a4,a4,0x20
    800012a8:	9301                	srli	a4,a4,0x20
    800012aa:	0705                	addi	a4,a4,1
    800012ac:	972a                	add	a4,a4,a0
    n--, p++, q++;
    800012ae:	0505                	addi	a0,a0,1
    800012b0:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    800012b2:	02e50363          	beq	a0,a4,800012d8 <strncmp+0x4c>
    800012b6:	00054783          	lbu	a5,0(a0)
    800012ba:	c789                	beqz	a5,800012c4 <strncmp+0x38>
    800012bc:	0005c683          	lbu	a3,0(a1)
    800012c0:	fef687e3          	beq	a3,a5,800012ae <strncmp+0x22>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
    800012c4:	00054503          	lbu	a0,0(a0)
    800012c8:	0005c783          	lbu	a5,0(a1)
    800012cc:	9d1d                	subw	a0,a0,a5
}
    800012ce:	6422                	ld	s0,8(sp)
    800012d0:	0141                	addi	sp,sp,16
    800012d2:	8082                	ret
    return 0;
    800012d4:	4501                	li	a0,0
    800012d6:	bfe5                	j	800012ce <strncmp+0x42>
    800012d8:	4501                	li	a0,0
    800012da:	bfd5                	j	800012ce <strncmp+0x42>

00000000800012dc <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800012dc:	1141                	addi	sp,sp,-16
    800012de:	e422                	sd	s0,8(sp)
    800012e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    800012e2:	872a                	mv	a4,a0
    800012e4:	a011                	j	800012e8 <strncpy+0xc>
    800012e6:	8636                	mv	a2,a3
    800012e8:	fff6069b          	addiw	a3,a2,-1
    800012ec:	00c05963          	blez	a2,800012fe <strncpy+0x22>
    800012f0:	0705                	addi	a4,a4,1
    800012f2:	0005c783          	lbu	a5,0(a1)
    800012f6:	fef70fa3          	sb	a5,-1(a4)
    800012fa:	0585                	addi	a1,a1,1
    800012fc:	f7ed                	bnez	a5,800012e6 <strncpy+0xa>
    ;
  while(n-- > 0)
    800012fe:	00d05c63          	blez	a3,80001316 <strncpy+0x3a>
    80001302:	86ba                	mv	a3,a4
    *s++ = 0;
    80001304:	0685                	addi	a3,a3,1
    80001306:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    8000130a:	fff6c793          	not	a5,a3
    8000130e:	9fb9                	addw	a5,a5,a4
    80001310:	9fb1                	addw	a5,a5,a2
    80001312:	fef049e3          	bgtz	a5,80001304 <strncpy+0x28>
  return os;
}
    80001316:	6422                	ld	s0,8(sp)
    80001318:	0141                	addi	sp,sp,16
    8000131a:	8082                	ret

000000008000131c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000131c:	1141                	addi	sp,sp,-16
    8000131e:	e422                	sd	s0,8(sp)
    80001320:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80001322:	02c05363          	blez	a2,80001348 <safestrcpy+0x2c>
    80001326:	fff6069b          	addiw	a3,a2,-1
    8000132a:	1682                	slli	a3,a3,0x20
    8000132c:	9281                	srli	a3,a3,0x20
    8000132e:	96ae                	add	a3,a3,a1
    80001330:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80001332:	00d58963          	beq	a1,a3,80001344 <safestrcpy+0x28>
    80001336:	0585                	addi	a1,a1,1
    80001338:	0785                	addi	a5,a5,1
    8000133a:	fff5c703          	lbu	a4,-1(a1)
    8000133e:	fee78fa3          	sb	a4,-1(a5)
    80001342:	fb65                	bnez	a4,80001332 <safestrcpy+0x16>
    ;
  *s = 0;
    80001344:	00078023          	sb	zero,0(a5)
  return os;
}
    80001348:	6422                	ld	s0,8(sp)
    8000134a:	0141                	addi	sp,sp,16
    8000134c:	8082                	ret

000000008000134e <strlen>:

int
strlen(const char *s)
{
    8000134e:	1141                	addi	sp,sp,-16
    80001350:	e422                	sd	s0,8(sp)
    80001352:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80001354:	00054783          	lbu	a5,0(a0)
    80001358:	cf91                	beqz	a5,80001374 <strlen+0x26>
    8000135a:	0505                	addi	a0,a0,1
    8000135c:	87aa                	mv	a5,a0
    8000135e:	4685                	li	a3,1
    80001360:	9e89                	subw	a3,a3,a0
    80001362:	00f6853b          	addw	a0,a3,a5
    80001366:	0785                	addi	a5,a5,1
    80001368:	fff7c703          	lbu	a4,-1(a5)
    8000136c:	fb7d                	bnez	a4,80001362 <strlen+0x14>
    ;
  return n;
}
    8000136e:	6422                	ld	s0,8(sp)
    80001370:	0141                	addi	sp,sp,16
    80001372:	8082                	ret
  for(n = 0; s[n]; n++)
    80001374:	4501                	li	a0,0
    80001376:	bfe5                	j	8000136e <strlen+0x20>

0000000080001378 <strjoin>:


char* strjoin(char **s){
    80001378:	7139                	addi	sp,sp,-64
    8000137a:	fc06                	sd	ra,56(sp)
    8000137c:	f822                	sd	s0,48(sp)
    8000137e:	f426                	sd	s1,40(sp)
    80001380:	f04a                	sd	s2,32(sp)
    80001382:	ec4e                	sd	s3,24(sp)
    80001384:	e852                	sd	s4,16(sp)
    80001386:	e456                	sd	s5,8(sp)
    80001388:	e05a                	sd	s6,0(sp)
    8000138a:	0080                	addi	s0,sp,64
    8000138c:	89aa                	mv	s3,a0
  int n = 0;
  char** os = s;
  while(*s){
    8000138e:	6108                	ld	a0,0(a0)
    80001390:	cd3d                	beqz	a0,8000140e <strjoin+0x96>
    80001392:	84ce                	mv	s1,s3
  int n = 0;
    80001394:	4901                	li	s2,0
    n += strlen(*s) + 1;
    80001396:	00000097          	auipc	ra,0x0
    8000139a:	fb8080e7          	jalr	-72(ra) # 8000134e <strlen>
    8000139e:	2505                	addiw	a0,a0,1
    800013a0:	0125093b          	addw	s2,a0,s2
    s++;
    800013a4:	04a1                	addi	s1,s1,8
  while(*s){
    800013a6:	6088                	ld	a0,0(s1)
    800013a8:	f57d                	bnez	a0,80001396 <strjoin+0x1e>
  }
  char* d = bd_malloc(n);
    800013aa:	854a                	mv	a0,s2
    800013ac:	00006097          	auipc	ra,0x6
    800013b0:	bdc080e7          	jalr	-1060(ra) # 80006f88 <bd_malloc>
    800013b4:	8b2a                	mv	s6,a0
  s = os;
  char* od = d;
  while(*s){
    800013b6:	0009b903          	ld	s2,0(s3)
    800013ba:	04090c63          	beqz	s2,80001412 <strjoin+0x9a>
  char* d = bd_malloc(n);
    800013be:	8a2a                	mv	s4,a0
    n = strlen(*s);
    safestrcpy(d, *s, n+1);
    d+=n;
    *d++ = ' ';
    800013c0:	02000a93          	li	s5,32
    n = strlen(*s);
    800013c4:	854a                	mv	a0,s2
    800013c6:	00000097          	auipc	ra,0x0
    800013ca:	f88080e7          	jalr	-120(ra) # 8000134e <strlen>
    800013ce:	84aa                	mv	s1,a0
    safestrcpy(d, *s, n+1);
    800013d0:	0015061b          	addiw	a2,a0,1
    800013d4:	85ca                	mv	a1,s2
    800013d6:	8552                	mv	a0,s4
    800013d8:	00000097          	auipc	ra,0x0
    800013dc:	f44080e7          	jalr	-188(ra) # 8000131c <safestrcpy>
    d+=n;
    800013e0:	94d2                	add	s1,s1,s4
    *d++ = ' ';
    800013e2:	00148a13          	addi	s4,s1,1
    800013e6:	01548023          	sb	s5,0(s1)
    s++;
    800013ea:	09a1                	addi	s3,s3,8
  while(*s){
    800013ec:	0009b903          	ld	s2,0(s3)
    800013f0:	fc091ae3          	bnez	s2,800013c4 <strjoin+0x4c>
  }
  d[-1] = 0;
    800013f4:	fe0a0fa3          	sb	zero,-1(s4)
  return od;
}
    800013f8:	855a                	mv	a0,s6
    800013fa:	70e2                	ld	ra,56(sp)
    800013fc:	7442                	ld	s0,48(sp)
    800013fe:	74a2                	ld	s1,40(sp)
    80001400:	7902                	ld	s2,32(sp)
    80001402:	69e2                	ld	s3,24(sp)
    80001404:	6a42                	ld	s4,16(sp)
    80001406:	6aa2                	ld	s5,8(sp)
    80001408:	6b02                	ld	s6,0(sp)
    8000140a:	6121                	addi	sp,sp,64
    8000140c:	8082                	ret
  int n = 0;
    8000140e:	4901                	li	s2,0
    80001410:	bf69                	j	800013aa <strjoin+0x32>
  char* d = bd_malloc(n);
    80001412:	8a2a                	mv	s4,a0
    80001414:	b7c5                	j	800013f4 <strjoin+0x7c>

0000000080001416 <strdup>:


char* strdup(char *s){
    80001416:	7179                	addi	sp,sp,-48
    80001418:	f406                	sd	ra,40(sp)
    8000141a:	f022                	sd	s0,32(sp)
    8000141c:	ec26                	sd	s1,24(sp)
    8000141e:	e84a                	sd	s2,16(sp)
    80001420:	e44e                	sd	s3,8(sp)
    80001422:	1800                	addi	s0,sp,48
    80001424:	89aa                	mv	s3,a0
  int n = 0;
  n = strlen(s) + 1;
    80001426:	00000097          	auipc	ra,0x0
    8000142a:	f28080e7          	jalr	-216(ra) # 8000134e <strlen>
    8000142e:	0015049b          	addiw	s1,a0,1
  char* d = bd_malloc(n);
    80001432:	8526                	mv	a0,s1
    80001434:	00006097          	auipc	ra,0x6
    80001438:	b54080e7          	jalr	-1196(ra) # 80006f88 <bd_malloc>
    8000143c:	892a                	mv	s2,a0
  safestrcpy(d, s, n);
    8000143e:	8626                	mv	a2,s1
    80001440:	85ce                	mv	a1,s3
    80001442:	00000097          	auipc	ra,0x0
    80001446:	eda080e7          	jalr	-294(ra) # 8000131c <safestrcpy>
  return d;
}
    8000144a:	854a                	mv	a0,s2
    8000144c:	70a2                	ld	ra,40(sp)
    8000144e:	7402                	ld	s0,32(sp)
    80001450:	64e2                	ld	s1,24(sp)
    80001452:	6942                	ld	s2,16(sp)
    80001454:	69a2                	ld	s3,8(sp)
    80001456:	6145                	addi	sp,sp,48
    80001458:	8082                	ret

000000008000145a <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    8000145a:	1141                	addi	sp,sp,-16
    8000145c:	e406                	sd	ra,8(sp)
    8000145e:	e022                	sd	s0,0(sp)
    80001460:	0800                	addi	s0,sp,16
  uartputs("enter main \n");
    80001462:	00007517          	auipc	a0,0x7
    80001466:	fde50513          	addi	a0,a0,-34 # 80008440 <userret+0x3b0>
    8000146a:	fffff097          	auipc	ra,0xfffff
    8000146e:	67a080e7          	jalr	1658(ra) # 80000ae4 <uartputs>
  if(cpuid() == 0){
    80001472:	00001097          	auipc	ra,0x1
    80001476:	b5c080e7          	jalr	-1188(ra) # 80001fce <cpuid>
    virtio_disk_init(minor(ROOTDEV)); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    8000147a:	0002d717          	auipc	a4,0x2d
    8000147e:	bfa70713          	addi	a4,a4,-1030 # 8002e074 <started>
  if(cpuid() == 0){
    80001482:	c139                	beqz	a0,800014c8 <main+0x6e>
    while(started == 0)
    80001484:	431c                	lw	a5,0(a4)
    80001486:	2781                	sext.w	a5,a5
    80001488:	dff5                	beqz	a5,80001484 <main+0x2a>
      ;
    __sync_synchronize();
    8000148a:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000148e:	00001097          	auipc	ra,0x1
    80001492:	b40080e7          	jalr	-1216(ra) # 80001fce <cpuid>
    80001496:	85aa                	mv	a1,a0
    80001498:	00007517          	auipc	a0,0x7
    8000149c:	fd050513          	addi	a0,a0,-48 # 80008468 <userret+0x3d8>
    800014a0:	fffff097          	auipc	ra,0xfffff
    800014a4:	53e080e7          	jalr	1342(ra) # 800009de <printf>
    kvminithart();    // turn on paging
    800014a8:	00000097          	auipc	ra,0x0
    800014ac:	1f2080e7          	jalr	498(ra) # 8000169a <kvminithart>
    trapinithart();   // install kernel trap vector
    800014b0:	00002097          	auipc	ra,0x2
    800014b4:	8c4080e7          	jalr	-1852(ra) # 80002d74 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800014b8:	00005097          	auipc	ra,0x5
    800014bc:	0e8080e7          	jalr	232(ra) # 800065a0 <plicinithart>
  }

  scheduler();        
    800014c0:	00001097          	auipc	ra,0x1
    800014c4:	058080e7          	jalr	88(ra) # 80002518 <scheduler>
    consoleinit();
    800014c8:	fffff097          	auipc	ra,0xfffff
    800014cc:	1ae080e7          	jalr	430(ra) # 80000676 <consoleinit>
    watchdoginit();
    800014d0:	00006097          	auipc	ra,0x6
    800014d4:	56c080e7          	jalr	1388(ra) # 80007a3c <watchdoginit>
    printfinit();
    800014d8:	fffff097          	auipc	ra,0xfffff
    800014dc:	57a080e7          	jalr	1402(ra) # 80000a52 <printfinit>
    printf("\n");
    800014e0:	00007517          	auipc	a0,0x7
    800014e4:	18850513          	addi	a0,a0,392 # 80008668 <userret+0x5d8>
    800014e8:	fffff097          	auipc	ra,0xfffff
    800014ec:	4f6080e7          	jalr	1270(ra) # 800009de <printf>
    printf("xv6 kernel is booting\n");
    800014f0:	00007517          	auipc	a0,0x7
    800014f4:	f6050513          	addi	a0,a0,-160 # 80008450 <userret+0x3c0>
    800014f8:	fffff097          	auipc	ra,0xfffff
    800014fc:	4e6080e7          	jalr	1254(ra) # 800009de <printf>
    printf("\n");
    80001500:	00007517          	auipc	a0,0x7
    80001504:	16850513          	addi	a0,a0,360 # 80008668 <userret+0x5d8>
    80001508:	fffff097          	auipc	ra,0xfffff
    8000150c:	4d6080e7          	jalr	1238(ra) # 800009de <printf>
    kinit();         // physical page allocator
    80001510:	fffff097          	auipc	ra,0xfffff
    80001514:	658080e7          	jalr	1624(ra) # 80000b68 <kinit>
    kvminit();       // create kernel page table
    80001518:	00000097          	auipc	ra,0x0
    8000151c:	312080e7          	jalr	786(ra) # 8000182a <kvminit>
    kvminithart();   // turn on paging
    80001520:	00000097          	auipc	ra,0x0
    80001524:	17a080e7          	jalr	378(ra) # 8000169a <kvminithart>
    procinit();      // process table
    80001528:	00001097          	auipc	ra,0x1
    8000152c:	9a4080e7          	jalr	-1628(ra) # 80001ecc <procinit>
    trapinit();      // trap vectors
    80001530:	00002097          	auipc	ra,0x2
    80001534:	81c080e7          	jalr	-2020(ra) # 80002d4c <trapinit>
    trapinithart();  // install kernel trap vector
    80001538:	00002097          	auipc	ra,0x2
    8000153c:	83c080e7          	jalr	-1988(ra) # 80002d74 <trapinithart>
    plicinit();      // set up interrupt controller
    80001540:	00005097          	auipc	ra,0x5
    80001544:	04a080e7          	jalr	74(ra) # 8000658a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001548:	00005097          	auipc	ra,0x5
    8000154c:	058080e7          	jalr	88(ra) # 800065a0 <plicinithart>
    binit();         // buffer cache
    80001550:	00002097          	auipc	ra,0x2
    80001554:	ffe080e7          	jalr	-2(ra) # 8000354e <binit>
    iinit();         // inode cache
    80001558:	00002097          	auipc	ra,0x2
    8000155c:	6d4080e7          	jalr	1748(ra) # 80003c2c <iinit>
    fileinit();      // file table
    80001560:	00003097          	auipc	ra,0x3
    80001564:	766080e7          	jalr	1894(ra) # 80004cc6 <fileinit>
    virtio_disk_init(minor(ROOTDEV)); // emulated hard disk
    80001568:	4501                	li	a0,0
    8000156a:	00005097          	auipc	ra,0x5
    8000156e:	156080e7          	jalr	342(ra) # 800066c0 <virtio_disk_init>
    userinit();      // first user process
    80001572:	00001097          	auipc	ra,0x1
    80001576:	d18080e7          	jalr	-744(ra) # 8000228a <userinit>
    __sync_synchronize();
    8000157a:	0ff0000f          	fence
    started = 1;
    8000157e:	4785                	li	a5,1
    80001580:	0002d717          	auipc	a4,0x2d
    80001584:	aef72a23          	sw	a5,-1292(a4) # 8002e074 <started>
    80001588:	bf25                	j	800014c0 <main+0x66>

000000008000158a <walk>:
//   21..39 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..12 -- 12 bits of byte offset within the page.
static pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000158a:	7139                	addi	sp,sp,-64
    8000158c:	fc06                	sd	ra,56(sp)
    8000158e:	f822                	sd	s0,48(sp)
    80001590:	f426                	sd	s1,40(sp)
    80001592:	f04a                	sd	s2,32(sp)
    80001594:	ec4e                	sd	s3,24(sp)
    80001596:	e852                	sd	s4,16(sp)
    80001598:	e456                	sd	s5,8(sp)
    8000159a:	e05a                	sd	s6,0(sp)
    8000159c:	0080                	addi	s0,sp,64
    8000159e:	84aa                	mv	s1,a0
    800015a0:	89ae                	mv	s3,a1
    800015a2:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    800015a4:	57fd                	li	a5,-1
    800015a6:	83e9                	srli	a5,a5,0x1a
    800015a8:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800015aa:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800015ac:	04b7f263          	bleu	a1,a5,800015f0 <walk+0x66>
    panic("walk");
    800015b0:	00007517          	auipc	a0,0x7
    800015b4:	ed050513          	addi	a0,a0,-304 # 80008480 <userret+0x3f0>
    800015b8:	fffff097          	auipc	ra,0xfffff
    800015bc:	20e080e7          	jalr	526(ra) # 800007c6 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800015c0:	060b0663          	beqz	s6,8000162c <walk+0xa2>
    800015c4:	fffff097          	auipc	ra,0xfffff
    800015c8:	5e4080e7          	jalr	1508(ra) # 80000ba8 <kalloc>
    800015cc:	84aa                	mv	s1,a0
    800015ce:	c529                	beqz	a0,80001618 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800015d0:	6605                	lui	a2,0x1
    800015d2:	4581                	li	a1,0
    800015d4:	00000097          	auipc	ra,0x0
    800015d8:	bd0080e7          	jalr	-1072(ra) # 800011a4 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800015dc:	00c4d793          	srli	a5,s1,0xc
    800015e0:	07aa                	slli	a5,a5,0xa
    800015e2:	0017e793          	ori	a5,a5,1
    800015e6:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800015ea:	3a5d                	addiw	s4,s4,-9
    800015ec:	035a0063          	beq	s4,s5,8000160c <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800015f0:	0149d933          	srl	s2,s3,s4
    800015f4:	1ff97913          	andi	s2,s2,511
    800015f8:	090e                	slli	s2,s2,0x3
    800015fa:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800015fc:	00093483          	ld	s1,0(s2)
    80001600:	0014f793          	andi	a5,s1,1
    80001604:	dfd5                	beqz	a5,800015c0 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001606:	80a9                	srli	s1,s1,0xa
    80001608:	04b2                	slli	s1,s1,0xc
    8000160a:	b7c5                	j	800015ea <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000160c:	00c9d513          	srli	a0,s3,0xc
    80001610:	1ff57513          	andi	a0,a0,511
    80001614:	050e                	slli	a0,a0,0x3
    80001616:	9526                	add	a0,a0,s1
}
    80001618:	70e2                	ld	ra,56(sp)
    8000161a:	7442                	ld	s0,48(sp)
    8000161c:	74a2                	ld	s1,40(sp)
    8000161e:	7902                	ld	s2,32(sp)
    80001620:	69e2                	ld	s3,24(sp)
    80001622:	6a42                	ld	s4,16(sp)
    80001624:	6aa2                	ld	s5,8(sp)
    80001626:	6b02                	ld	s6,0(sp)
    80001628:	6121                	addi	sp,sp,64
    8000162a:	8082                	ret
        return 0;
    8000162c:	4501                	li	a0,0
    8000162e:	b7ed                	j	80001618 <walk+0x8e>

0000000080001630 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
static void
freewalk(pagetable_t pagetable)
{
    80001630:	7179                	addi	sp,sp,-48
    80001632:	f406                	sd	ra,40(sp)
    80001634:	f022                	sd	s0,32(sp)
    80001636:	ec26                	sd	s1,24(sp)
    80001638:	e84a                	sd	s2,16(sp)
    8000163a:	e44e                	sd	s3,8(sp)
    8000163c:	e052                	sd	s4,0(sp)
    8000163e:	1800                	addi	s0,sp,48
    80001640:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001642:	84aa                	mv	s1,a0
    80001644:	6905                	lui	s2,0x1
    80001646:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001648:	4985                	li	s3,1
    8000164a:	a821                	j	80001662 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000164c:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000164e:	0532                	slli	a0,a0,0xc
    80001650:	00000097          	auipc	ra,0x0
    80001654:	fe0080e7          	jalr	-32(ra) # 80001630 <freewalk>
      pagetable[i] = 0;
    80001658:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000165c:	04a1                	addi	s1,s1,8
    8000165e:	03248163          	beq	s1,s2,80001680 <freewalk+0x50>
    pte_t pte = pagetable[i];
    80001662:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001664:	00f57793          	andi	a5,a0,15
    80001668:	ff3782e3          	beq	a5,s3,8000164c <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000166c:	8905                	andi	a0,a0,1
    8000166e:	d57d                	beqz	a0,8000165c <freewalk+0x2c>
      panic("freewalk: leaf");
    80001670:	00007517          	auipc	a0,0x7
    80001674:	e1850513          	addi	a0,a0,-488 # 80008488 <userret+0x3f8>
    80001678:	fffff097          	auipc	ra,0xfffff
    8000167c:	14e080e7          	jalr	334(ra) # 800007c6 <panic>
    }
  }
  kfree((void*)pagetable);
    80001680:	8552                	mv	a0,s4
    80001682:	fffff097          	auipc	ra,0xfffff
    80001686:	50e080e7          	jalr	1294(ra) # 80000b90 <kfree>
}
    8000168a:	70a2                	ld	ra,40(sp)
    8000168c:	7402                	ld	s0,32(sp)
    8000168e:	64e2                	ld	s1,24(sp)
    80001690:	6942                	ld	s2,16(sp)
    80001692:	69a2                	ld	s3,8(sp)
    80001694:	6a02                	ld	s4,0(sp)
    80001696:	6145                	addi	sp,sp,48
    80001698:	8082                	ret

000000008000169a <kvminithart>:
{
    8000169a:	1141                	addi	sp,sp,-16
    8000169c:	e422                	sd	s0,8(sp)
    8000169e:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    800016a0:	0002d797          	auipc	a5,0x2d
    800016a4:	9d878793          	addi	a5,a5,-1576 # 8002e078 <kernel_pagetable>
    800016a8:	639c                	ld	a5,0(a5)
    800016aa:	83b1                	srli	a5,a5,0xc
    800016ac:	577d                	li	a4,-1
    800016ae:	177e                	slli	a4,a4,0x3f
    800016b0:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800016b2:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800016b6:	12000073          	sfence.vma
}
    800016ba:	6422                	ld	s0,8(sp)
    800016bc:	0141                	addi	sp,sp,16
    800016be:	8082                	ret

00000000800016c0 <walkaddr>:
  if(va >= MAXVA)
    800016c0:	57fd                	li	a5,-1
    800016c2:	83e9                	srli	a5,a5,0x1a
    800016c4:	00b7f463          	bleu	a1,a5,800016cc <walkaddr+0xc>
    return 0;
    800016c8:	4501                	li	a0,0
}
    800016ca:	8082                	ret
{
    800016cc:	1141                	addi	sp,sp,-16
    800016ce:	e406                	sd	ra,8(sp)
    800016d0:	e022                	sd	s0,0(sp)
    800016d2:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800016d4:	4601                	li	a2,0
    800016d6:	00000097          	auipc	ra,0x0
    800016da:	eb4080e7          	jalr	-332(ra) # 8000158a <walk>
  if(pte == 0)
    800016de:	c105                	beqz	a0,800016fe <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    800016e0:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800016e2:	0117f693          	andi	a3,a5,17
    800016e6:	4745                	li	a4,17
    return 0;
    800016e8:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800016ea:	00e68663          	beq	a3,a4,800016f6 <walkaddr+0x36>
}
    800016ee:	60a2                	ld	ra,8(sp)
    800016f0:	6402                	ld	s0,0(sp)
    800016f2:	0141                	addi	sp,sp,16
    800016f4:	8082                	ret
  pa = PTE2PA(*pte);
    800016f6:	00a7d513          	srli	a0,a5,0xa
    800016fa:	0532                	slli	a0,a0,0xc
  return pa;
    800016fc:	bfcd                	j	800016ee <walkaddr+0x2e>
    return 0;
    800016fe:	4501                	li	a0,0
    80001700:	b7fd                	j	800016ee <walkaddr+0x2e>

0000000080001702 <kvmpa>:
{
    80001702:	1101                	addi	sp,sp,-32
    80001704:	ec06                	sd	ra,24(sp)
    80001706:	e822                	sd	s0,16(sp)
    80001708:	e426                	sd	s1,8(sp)
    8000170a:	1000                	addi	s0,sp,32
    8000170c:	85aa                	mv	a1,a0
  uint64 off = va % PGSIZE;
    8000170e:	6785                	lui	a5,0x1
    80001710:	17fd                	addi	a5,a5,-1
    80001712:	00f574b3          	and	s1,a0,a5
  pte = walk(kernel_pagetable, va, 0);
    80001716:	4601                	li	a2,0
    80001718:	0002d797          	auipc	a5,0x2d
    8000171c:	96078793          	addi	a5,a5,-1696 # 8002e078 <kernel_pagetable>
    80001720:	6388                	ld	a0,0(a5)
    80001722:	00000097          	auipc	ra,0x0
    80001726:	e68080e7          	jalr	-408(ra) # 8000158a <walk>
  if(pte == 0)
    8000172a:	cd09                	beqz	a0,80001744 <kvmpa+0x42>
  if((*pte & PTE_V) == 0)
    8000172c:	6108                	ld	a0,0(a0)
    8000172e:	00157793          	andi	a5,a0,1
    80001732:	c38d                	beqz	a5,80001754 <kvmpa+0x52>
  pa = PTE2PA(*pte);
    80001734:	8129                	srli	a0,a0,0xa
    80001736:	0532                	slli	a0,a0,0xc
}
    80001738:	9526                	add	a0,a0,s1
    8000173a:	60e2                	ld	ra,24(sp)
    8000173c:	6442                	ld	s0,16(sp)
    8000173e:	64a2                	ld	s1,8(sp)
    80001740:	6105                	addi	sp,sp,32
    80001742:	8082                	ret
    panic("kvmpa");
    80001744:	00007517          	auipc	a0,0x7
    80001748:	d5450513          	addi	a0,a0,-684 # 80008498 <userret+0x408>
    8000174c:	fffff097          	auipc	ra,0xfffff
    80001750:	07a080e7          	jalr	122(ra) # 800007c6 <panic>
    panic("kvmpa");
    80001754:	00007517          	auipc	a0,0x7
    80001758:	d4450513          	addi	a0,a0,-700 # 80008498 <userret+0x408>
    8000175c:	fffff097          	auipc	ra,0xfffff
    80001760:	06a080e7          	jalr	106(ra) # 800007c6 <panic>

0000000080001764 <mappages>:
{
    80001764:	715d                	addi	sp,sp,-80
    80001766:	e486                	sd	ra,72(sp)
    80001768:	e0a2                	sd	s0,64(sp)
    8000176a:	fc26                	sd	s1,56(sp)
    8000176c:	f84a                	sd	s2,48(sp)
    8000176e:	f44e                	sd	s3,40(sp)
    80001770:	f052                	sd	s4,32(sp)
    80001772:	ec56                	sd	s5,24(sp)
    80001774:	e85a                	sd	s6,16(sp)
    80001776:	e45e                	sd	s7,8(sp)
    80001778:	0880                	addi	s0,sp,80
    8000177a:	8aaa                	mv	s5,a0
    8000177c:	8b3a                	mv	s6,a4
  a = PGROUNDDOWN(va);
    8000177e:	79fd                	lui	s3,0xfffff
    80001780:	0135fa33          	and	s4,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    80001784:	167d                	addi	a2,a2,-1
    80001786:	962e                	add	a2,a2,a1
    80001788:	013679b3          	and	s3,a2,s3
  a = PGROUNDDOWN(va);
    8000178c:	8952                	mv	s2,s4
    8000178e:	41468a33          	sub	s4,a3,s4
    a += PGSIZE;
    80001792:	6b85                	lui	s7,0x1
    80001794:	a811                	j	800017a8 <mappages+0x44>
      panic("remap");
    80001796:	00007517          	auipc	a0,0x7
    8000179a:	d0a50513          	addi	a0,a0,-758 # 800084a0 <userret+0x410>
    8000179e:	fffff097          	auipc	ra,0xfffff
    800017a2:	028080e7          	jalr	40(ra) # 800007c6 <panic>
    a += PGSIZE;
    800017a6:	995e                	add	s2,s2,s7
  for(;;){
    800017a8:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800017ac:	4605                	li	a2,1
    800017ae:	85ca                	mv	a1,s2
    800017b0:	8556                	mv	a0,s5
    800017b2:	00000097          	auipc	ra,0x0
    800017b6:	dd8080e7          	jalr	-552(ra) # 8000158a <walk>
    800017ba:	cd19                	beqz	a0,800017d8 <mappages+0x74>
    if(*pte & PTE_V)
    800017bc:	611c                	ld	a5,0(a0)
    800017be:	8b85                	andi	a5,a5,1
    800017c0:	fbf9                	bnez	a5,80001796 <mappages+0x32>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800017c2:	80b1                	srli	s1,s1,0xc
    800017c4:	04aa                	slli	s1,s1,0xa
    800017c6:	0164e4b3          	or	s1,s1,s6
    800017ca:	0014e493          	ori	s1,s1,1
    800017ce:	e104                	sd	s1,0(a0)
    if(a == last)
    800017d0:	fd391be3          	bne	s2,s3,800017a6 <mappages+0x42>
  return 0;
    800017d4:	4501                	li	a0,0
    800017d6:	a011                	j	800017da <mappages+0x76>
      return -1;
    800017d8:	557d                	li	a0,-1
}
    800017da:	60a6                	ld	ra,72(sp)
    800017dc:	6406                	ld	s0,64(sp)
    800017de:	74e2                	ld	s1,56(sp)
    800017e0:	7942                	ld	s2,48(sp)
    800017e2:	79a2                	ld	s3,40(sp)
    800017e4:	7a02                	ld	s4,32(sp)
    800017e6:	6ae2                	ld	s5,24(sp)
    800017e8:	6b42                	ld	s6,16(sp)
    800017ea:	6ba2                	ld	s7,8(sp)
    800017ec:	6161                	addi	sp,sp,80
    800017ee:	8082                	ret

00000000800017f0 <kvmmap>:
{
    800017f0:	1141                	addi	sp,sp,-16
    800017f2:	e406                	sd	ra,8(sp)
    800017f4:	e022                	sd	s0,0(sp)
    800017f6:	0800                	addi	s0,sp,16
  if(mappages(kernel_pagetable, va, sz, pa, perm) != 0)
    800017f8:	8736                	mv	a4,a3
    800017fa:	86ae                	mv	a3,a1
    800017fc:	85aa                	mv	a1,a0
    800017fe:	0002d797          	auipc	a5,0x2d
    80001802:	87a78793          	addi	a5,a5,-1926 # 8002e078 <kernel_pagetable>
    80001806:	6388                	ld	a0,0(a5)
    80001808:	00000097          	auipc	ra,0x0
    8000180c:	f5c080e7          	jalr	-164(ra) # 80001764 <mappages>
    80001810:	e509                	bnez	a0,8000181a <kvmmap+0x2a>
}
    80001812:	60a2                	ld	ra,8(sp)
    80001814:	6402                	ld	s0,0(sp)
    80001816:	0141                	addi	sp,sp,16
    80001818:	8082                	ret
    panic("kvmmap");
    8000181a:	00007517          	auipc	a0,0x7
    8000181e:	c8e50513          	addi	a0,a0,-882 # 800084a8 <userret+0x418>
    80001822:	fffff097          	auipc	ra,0xfffff
    80001826:	fa4080e7          	jalr	-92(ra) # 800007c6 <panic>

000000008000182a <kvminit>:
{
    8000182a:	1101                	addi	sp,sp,-32
    8000182c:	ec06                	sd	ra,24(sp)
    8000182e:	e822                	sd	s0,16(sp)
    80001830:	e426                	sd	s1,8(sp)
    80001832:	1000                	addi	s0,sp,32
  kernel_pagetable = (pagetable_t) kalloc();
    80001834:	fffff097          	auipc	ra,0xfffff
    80001838:	374080e7          	jalr	884(ra) # 80000ba8 <kalloc>
    8000183c:	0002d797          	auipc	a5,0x2d
    80001840:	82a7be23          	sd	a0,-1988(a5) # 8002e078 <kernel_pagetable>
  memset(kernel_pagetable, 0, PGSIZE);
    80001844:	6605                	lui	a2,0x1
    80001846:	4581                	li	a1,0
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	95c080e7          	jalr	-1700(ra) # 800011a4 <memset>
  kvmmap(UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001850:	4699                	li	a3,6
    80001852:	6605                	lui	a2,0x1
    80001854:	100005b7          	lui	a1,0x10000
    80001858:	10000537          	lui	a0,0x10000
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	f94080e7          	jalr	-108(ra) # 800017f0 <kvmmap>
  kvmmap(VIRTION(0), VIRTION(0), PGSIZE, PTE_R | PTE_W);
    80001864:	4699                	li	a3,6
    80001866:	6605                	lui	a2,0x1
    80001868:	100015b7          	lui	a1,0x10001
    8000186c:	10001537          	lui	a0,0x10001
    80001870:	00000097          	auipc	ra,0x0
    80001874:	f80080e7          	jalr	-128(ra) # 800017f0 <kvmmap>
  kvmmap(VIRTION(1), VIRTION(1), PGSIZE, PTE_R | PTE_W);
    80001878:	4699                	li	a3,6
    8000187a:	6605                	lui	a2,0x1
    8000187c:	100025b7          	lui	a1,0x10002
    80001880:	10002537          	lui	a0,0x10002
    80001884:	00000097          	auipc	ra,0x0
    80001888:	f6c080e7          	jalr	-148(ra) # 800017f0 <kvmmap>
  kvmmap(CLINT, CLINT, 0x10000, PTE_R | PTE_W);
    8000188c:	4699                	li	a3,6
    8000188e:	6641                	lui	a2,0x10
    80001890:	020005b7          	lui	a1,0x2000
    80001894:	02000537          	lui	a0,0x2000
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	f58080e7          	jalr	-168(ra) # 800017f0 <kvmmap>
  kvmmap(PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800018a0:	4699                	li	a3,6
    800018a2:	00400637          	lui	a2,0x400
    800018a6:	0c0005b7          	lui	a1,0xc000
    800018aa:	0c000537          	lui	a0,0xc000
    800018ae:	00000097          	auipc	ra,0x0
    800018b2:	f42080e7          	jalr	-190(ra) # 800017f0 <kvmmap>
  kvmmap(KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800018b6:	00008497          	auipc	s1,0x8
    800018ba:	74a48493          	addi	s1,s1,1866 # 8000a000 <initcode>
    800018be:	46a9                	li	a3,10
    800018c0:	80008617          	auipc	a2,0x80008
    800018c4:	74060613          	addi	a2,a2,1856 # a000 <_entry-0x7fff6000>
    800018c8:	4585                	li	a1,1
    800018ca:	05fe                	slli	a1,a1,0x1f
    800018cc:	852e                	mv	a0,a1
    800018ce:	00000097          	auipc	ra,0x0
    800018d2:	f22080e7          	jalr	-222(ra) # 800017f0 <kvmmap>
  kvmmap((uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800018d6:	4699                	li	a3,6
    800018d8:	4645                	li	a2,17
    800018da:	066e                	slli	a2,a2,0x1b
    800018dc:	8e05                	sub	a2,a2,s1
    800018de:	85a6                	mv	a1,s1
    800018e0:	8526                	mv	a0,s1
    800018e2:	00000097          	auipc	ra,0x0
    800018e6:	f0e080e7          	jalr	-242(ra) # 800017f0 <kvmmap>
  kvmmap(TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800018ea:	46a9                	li	a3,10
    800018ec:	6605                	lui	a2,0x1
    800018ee:	00006597          	auipc	a1,0x6
    800018f2:	71258593          	addi	a1,a1,1810 # 80008000 <trampoline>
    800018f6:	04000537          	lui	a0,0x4000
    800018fa:	157d                	addi	a0,a0,-1
    800018fc:	0532                	slli	a0,a0,0xc
    800018fe:	00000097          	auipc	ra,0x0
    80001902:	ef2080e7          	jalr	-270(ra) # 800017f0 <kvmmap>
}
    80001906:	60e2                	ld	ra,24(sp)
    80001908:	6442                	ld	s0,16(sp)
    8000190a:	64a2                	ld	s1,8(sp)
    8000190c:	6105                	addi	sp,sp,32
    8000190e:	8082                	ret

0000000080001910 <uvmunmap>:
{
    80001910:	715d                	addi	sp,sp,-80
    80001912:	e486                	sd	ra,72(sp)
    80001914:	e0a2                	sd	s0,64(sp)
    80001916:	fc26                	sd	s1,56(sp)
    80001918:	f84a                	sd	s2,48(sp)
    8000191a:	f44e                	sd	s3,40(sp)
    8000191c:	f052                	sd	s4,32(sp)
    8000191e:	ec56                	sd	s5,24(sp)
    80001920:	e85a                	sd	s6,16(sp)
    80001922:	e45e                	sd	s7,8(sp)
    80001924:	0880                	addi	s0,sp,80
    80001926:	8a2a                	mv	s4,a0
    80001928:	8ab6                	mv	s5,a3
  a = PGROUNDDOWN(va);
    8000192a:	79fd                	lui	s3,0xfffff
    8000192c:	0135f933          	and	s2,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    80001930:	167d                	addi	a2,a2,-1
    80001932:	962e                	add	a2,a2,a1
    80001934:	013679b3          	and	s3,a2,s3
    if(PTE_FLAGS(*pte) == PTE_V)
    80001938:	4b05                	li	s6,1
    a += PGSIZE;
    8000193a:	6b85                	lui	s7,0x1
    8000193c:	a8b1                	j	80001998 <uvmunmap+0x88>
      panic("uvmunmap: walk");
    8000193e:	00007517          	auipc	a0,0x7
    80001942:	b7250513          	addi	a0,a0,-1166 # 800084b0 <userret+0x420>
    80001946:	fffff097          	auipc	ra,0xfffff
    8000194a:	e80080e7          	jalr	-384(ra) # 800007c6 <panic>
      printf("va=%p pte=%p\n", a, *pte);
    8000194e:	862a                	mv	a2,a0
    80001950:	85ca                	mv	a1,s2
    80001952:	00007517          	auipc	a0,0x7
    80001956:	b6e50513          	addi	a0,a0,-1170 # 800084c0 <userret+0x430>
    8000195a:	fffff097          	auipc	ra,0xfffff
    8000195e:	084080e7          	jalr	132(ra) # 800009de <printf>
      panic("uvmunmap: not mapped");
    80001962:	00007517          	auipc	a0,0x7
    80001966:	b6e50513          	addi	a0,a0,-1170 # 800084d0 <userret+0x440>
    8000196a:	fffff097          	auipc	ra,0xfffff
    8000196e:	e5c080e7          	jalr	-420(ra) # 800007c6 <panic>
      panic("uvmunmap: not a leaf");
    80001972:	00007517          	auipc	a0,0x7
    80001976:	b7650513          	addi	a0,a0,-1162 # 800084e8 <userret+0x458>
    8000197a:	fffff097          	auipc	ra,0xfffff
    8000197e:	e4c080e7          	jalr	-436(ra) # 800007c6 <panic>
      pa = PTE2PA(*pte);
    80001982:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80001984:	0532                	slli	a0,a0,0xc
    80001986:	fffff097          	auipc	ra,0xfffff
    8000198a:	20a080e7          	jalr	522(ra) # 80000b90 <kfree>
    *pte = 0;
    8000198e:	0004b023          	sd	zero,0(s1)
    if(a == last)
    80001992:	03390763          	beq	s2,s3,800019c0 <uvmunmap+0xb0>
    a += PGSIZE;
    80001996:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 0)) == 0)
    80001998:	4601                	li	a2,0
    8000199a:	85ca                	mv	a1,s2
    8000199c:	8552                	mv	a0,s4
    8000199e:	00000097          	auipc	ra,0x0
    800019a2:	bec080e7          	jalr	-1044(ra) # 8000158a <walk>
    800019a6:	84aa                	mv	s1,a0
    800019a8:	d959                	beqz	a0,8000193e <uvmunmap+0x2e>
    if((*pte & PTE_V) == 0){
    800019aa:	6108                	ld	a0,0(a0)
    800019ac:	00157793          	andi	a5,a0,1
    800019b0:	dfd9                	beqz	a5,8000194e <uvmunmap+0x3e>
    if(PTE_FLAGS(*pte) == PTE_V)
    800019b2:	3ff57793          	andi	a5,a0,1023
    800019b6:	fb678ee3          	beq	a5,s6,80001972 <uvmunmap+0x62>
    if(do_free){
    800019ba:	fc0a8ae3          	beqz	s5,8000198e <uvmunmap+0x7e>
    800019be:	b7d1                	j	80001982 <uvmunmap+0x72>
}
    800019c0:	60a6                	ld	ra,72(sp)
    800019c2:	6406                	ld	s0,64(sp)
    800019c4:	74e2                	ld	s1,56(sp)
    800019c6:	7942                	ld	s2,48(sp)
    800019c8:	79a2                	ld	s3,40(sp)
    800019ca:	7a02                	ld	s4,32(sp)
    800019cc:	6ae2                	ld	s5,24(sp)
    800019ce:	6b42                	ld	s6,16(sp)
    800019d0:	6ba2                	ld	s7,8(sp)
    800019d2:	6161                	addi	sp,sp,80
    800019d4:	8082                	ret

00000000800019d6 <uvmcreate>:
{
    800019d6:	1101                	addi	sp,sp,-32
    800019d8:	ec06                	sd	ra,24(sp)
    800019da:	e822                	sd	s0,16(sp)
    800019dc:	e426                	sd	s1,8(sp)
    800019de:	1000                	addi	s0,sp,32
  pagetable = (pagetable_t) kalloc();
    800019e0:	fffff097          	auipc	ra,0xfffff
    800019e4:	1c8080e7          	jalr	456(ra) # 80000ba8 <kalloc>
  if(pagetable == 0)
    800019e8:	cd11                	beqz	a0,80001a04 <uvmcreate+0x2e>
    800019ea:	84aa                	mv	s1,a0
  memset(pagetable, 0, PGSIZE);
    800019ec:	6605                	lui	a2,0x1
    800019ee:	4581                	li	a1,0
    800019f0:	fffff097          	auipc	ra,0xfffff
    800019f4:	7b4080e7          	jalr	1972(ra) # 800011a4 <memset>
}
    800019f8:	8526                	mv	a0,s1
    800019fa:	60e2                	ld	ra,24(sp)
    800019fc:	6442                	ld	s0,16(sp)
    800019fe:	64a2                	ld	s1,8(sp)
    80001a00:	6105                	addi	sp,sp,32
    80001a02:	8082                	ret
    panic("uvmcreate: out of memory");
    80001a04:	00007517          	auipc	a0,0x7
    80001a08:	afc50513          	addi	a0,a0,-1284 # 80008500 <userret+0x470>
    80001a0c:	fffff097          	auipc	ra,0xfffff
    80001a10:	dba080e7          	jalr	-582(ra) # 800007c6 <panic>

0000000080001a14 <uvminit>:
{
    80001a14:	7179                	addi	sp,sp,-48
    80001a16:	f406                	sd	ra,40(sp)
    80001a18:	f022                	sd	s0,32(sp)
    80001a1a:	ec26                	sd	s1,24(sp)
    80001a1c:	e84a                	sd	s2,16(sp)
    80001a1e:	e44e                	sd	s3,8(sp)
    80001a20:	e052                	sd	s4,0(sp)
    80001a22:	1800                	addi	s0,sp,48
  if(sz >= PGSIZE)
    80001a24:	6785                	lui	a5,0x1
    80001a26:	04f67863          	bleu	a5,a2,80001a76 <uvminit+0x62>
    80001a2a:	8a2a                	mv	s4,a0
    80001a2c:	89ae                	mv	s3,a1
    80001a2e:	84b2                	mv	s1,a2
  mem = kalloc();
    80001a30:	fffff097          	auipc	ra,0xfffff
    80001a34:	178080e7          	jalr	376(ra) # 80000ba8 <kalloc>
    80001a38:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001a3a:	6605                	lui	a2,0x1
    80001a3c:	4581                	li	a1,0
    80001a3e:	fffff097          	auipc	ra,0xfffff
    80001a42:	766080e7          	jalr	1894(ra) # 800011a4 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001a46:	4779                	li	a4,30
    80001a48:	86ca                	mv	a3,s2
    80001a4a:	6605                	lui	a2,0x1
    80001a4c:	4581                	li	a1,0
    80001a4e:	8552                	mv	a0,s4
    80001a50:	00000097          	auipc	ra,0x0
    80001a54:	d14080e7          	jalr	-748(ra) # 80001764 <mappages>
  memmove(mem, src, sz);
    80001a58:	8626                	mv	a2,s1
    80001a5a:	85ce                	mv	a1,s3
    80001a5c:	854a                	mv	a0,s2
    80001a5e:	fffff097          	auipc	ra,0xfffff
    80001a62:	7b2080e7          	jalr	1970(ra) # 80001210 <memmove>
}
    80001a66:	70a2                	ld	ra,40(sp)
    80001a68:	7402                	ld	s0,32(sp)
    80001a6a:	64e2                	ld	s1,24(sp)
    80001a6c:	6942                	ld	s2,16(sp)
    80001a6e:	69a2                	ld	s3,8(sp)
    80001a70:	6a02                	ld	s4,0(sp)
    80001a72:	6145                	addi	sp,sp,48
    80001a74:	8082                	ret
    panic("inituvm: more than a page");
    80001a76:	00007517          	auipc	a0,0x7
    80001a7a:	aaa50513          	addi	a0,a0,-1366 # 80008520 <userret+0x490>
    80001a7e:	fffff097          	auipc	ra,0xfffff
    80001a82:	d48080e7          	jalr	-696(ra) # 800007c6 <panic>

0000000080001a86 <uvmdealloc>:
{
    80001a86:	1101                	addi	sp,sp,-32
    80001a88:	ec06                	sd	ra,24(sp)
    80001a8a:	e822                	sd	s0,16(sp)
    80001a8c:	e426                	sd	s1,8(sp)
    80001a8e:	1000                	addi	s0,sp,32
    return oldsz;
    80001a90:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80001a92:	00b67d63          	bleu	a1,a2,80001aac <uvmdealloc+0x26>
    80001a96:	84b2                	mv	s1,a2
  uint64 newup = PGROUNDUP(newsz);
    80001a98:	6785                	lui	a5,0x1
    80001a9a:	17fd                	addi	a5,a5,-1
    80001a9c:	00f60733          	add	a4,a2,a5
    80001aa0:	76fd                	lui	a3,0xfffff
    80001aa2:	8f75                	and	a4,a4,a3
  if(newup < PGROUNDUP(oldsz))
    80001aa4:	97ae                	add	a5,a5,a1
    80001aa6:	8ff5                	and	a5,a5,a3
    80001aa8:	00f76863          	bltu	a4,a5,80001ab8 <uvmdealloc+0x32>
}
    80001aac:	8526                	mv	a0,s1
    80001aae:	60e2                	ld	ra,24(sp)
    80001ab0:	6442                	ld	s0,16(sp)
    80001ab2:	64a2                	ld	s1,8(sp)
    80001ab4:	6105                	addi	sp,sp,32
    80001ab6:	8082                	ret
    uvmunmap(pagetable, newup, oldsz - newup, 1);
    80001ab8:	4685                	li	a3,1
    80001aba:	40e58633          	sub	a2,a1,a4
    80001abe:	85ba                	mv	a1,a4
    80001ac0:	00000097          	auipc	ra,0x0
    80001ac4:	e50080e7          	jalr	-432(ra) # 80001910 <uvmunmap>
    80001ac8:	b7d5                	j	80001aac <uvmdealloc+0x26>

0000000080001aca <uvmalloc>:
  if(newsz < oldsz)
    80001aca:	0ab66163          	bltu	a2,a1,80001b6c <uvmalloc+0xa2>
{
    80001ace:	7139                	addi	sp,sp,-64
    80001ad0:	fc06                	sd	ra,56(sp)
    80001ad2:	f822                	sd	s0,48(sp)
    80001ad4:	f426                	sd	s1,40(sp)
    80001ad6:	f04a                	sd	s2,32(sp)
    80001ad8:	ec4e                	sd	s3,24(sp)
    80001ada:	e852                	sd	s4,16(sp)
    80001adc:	e456                	sd	s5,8(sp)
    80001ade:	0080                	addi	s0,sp,64
  oldsz = PGROUNDUP(oldsz);
    80001ae0:	6a05                	lui	s4,0x1
    80001ae2:	1a7d                	addi	s4,s4,-1
    80001ae4:	95d2                	add	a1,a1,s4
    80001ae6:	7a7d                	lui	s4,0xfffff
    80001ae8:	0145fa33          	and	s4,a1,s4
  for(; a < newsz; a += PGSIZE){
    80001aec:	08ca7263          	bleu	a2,s4,80001b70 <uvmalloc+0xa6>
    80001af0:	89b2                	mv	s3,a2
    80001af2:	8aaa                	mv	s5,a0
  a = oldsz;
    80001af4:	8952                	mv	s2,s4
    mem = kalloc();
    80001af6:	fffff097          	auipc	ra,0xfffff
    80001afa:	0b2080e7          	jalr	178(ra) # 80000ba8 <kalloc>
    80001afe:	84aa                	mv	s1,a0
    if(mem == 0){
    80001b00:	c51d                	beqz	a0,80001b2e <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    80001b02:	6605                	lui	a2,0x1
    80001b04:	4581                	li	a1,0
    80001b06:	fffff097          	auipc	ra,0xfffff
    80001b0a:	69e080e7          	jalr	1694(ra) # 800011a4 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001b0e:	4779                	li	a4,30
    80001b10:	86a6                	mv	a3,s1
    80001b12:	6605                	lui	a2,0x1
    80001b14:	85ca                	mv	a1,s2
    80001b16:	8556                	mv	a0,s5
    80001b18:	00000097          	auipc	ra,0x0
    80001b1c:	c4c080e7          	jalr	-948(ra) # 80001764 <mappages>
    80001b20:	e905                	bnez	a0,80001b50 <uvmalloc+0x86>
  for(; a < newsz; a += PGSIZE){
    80001b22:	6785                	lui	a5,0x1
    80001b24:	993e                	add	s2,s2,a5
    80001b26:	fd3968e3          	bltu	s2,s3,80001af6 <uvmalloc+0x2c>
  return newsz;
    80001b2a:	854e                	mv	a0,s3
    80001b2c:	a809                	j	80001b3e <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80001b2e:	8652                	mv	a2,s4
    80001b30:	85ca                	mv	a1,s2
    80001b32:	8556                	mv	a0,s5
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	f52080e7          	jalr	-174(ra) # 80001a86 <uvmdealloc>
      return 0;
    80001b3c:	4501                	li	a0,0
}
    80001b3e:	70e2                	ld	ra,56(sp)
    80001b40:	7442                	ld	s0,48(sp)
    80001b42:	74a2                	ld	s1,40(sp)
    80001b44:	7902                	ld	s2,32(sp)
    80001b46:	69e2                	ld	s3,24(sp)
    80001b48:	6a42                	ld	s4,16(sp)
    80001b4a:	6aa2                	ld	s5,8(sp)
    80001b4c:	6121                	addi	sp,sp,64
    80001b4e:	8082                	ret
      kfree(mem);
    80001b50:	8526                	mv	a0,s1
    80001b52:	fffff097          	auipc	ra,0xfffff
    80001b56:	03e080e7          	jalr	62(ra) # 80000b90 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001b5a:	8652                	mv	a2,s4
    80001b5c:	85ca                	mv	a1,s2
    80001b5e:	8556                	mv	a0,s5
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	f26080e7          	jalr	-218(ra) # 80001a86 <uvmdealloc>
      return 0;
    80001b68:	4501                	li	a0,0
    80001b6a:	bfd1                	j	80001b3e <uvmalloc+0x74>
    return oldsz;
    80001b6c:	852e                	mv	a0,a1
}
    80001b6e:	8082                	ret
  return newsz;
    80001b70:	8532                	mv	a0,a2
    80001b72:	b7f1                	j	80001b3e <uvmalloc+0x74>

0000000080001b74 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80001b74:	1101                	addi	sp,sp,-32
    80001b76:	ec06                	sd	ra,24(sp)
    80001b78:	e822                	sd	s0,16(sp)
    80001b7a:	e426                	sd	s1,8(sp)
    80001b7c:	1000                	addi	s0,sp,32
    80001b7e:	84aa                	mv	s1,a0
  uvmunmap(pagetable, 0, sz, 1);
    80001b80:	4685                	li	a3,1
    80001b82:	862e                	mv	a2,a1
    80001b84:	4581                	li	a1,0
    80001b86:	00000097          	auipc	ra,0x0
    80001b8a:	d8a080e7          	jalr	-630(ra) # 80001910 <uvmunmap>
  freewalk(pagetable);
    80001b8e:	8526                	mv	a0,s1
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	aa0080e7          	jalr	-1376(ra) # 80001630 <freewalk>
}
    80001b98:	60e2                	ld	ra,24(sp)
    80001b9a:	6442                	ld	s0,16(sp)
    80001b9c:	64a2                	ld	s1,8(sp)
    80001b9e:	6105                	addi	sp,sp,32
    80001ba0:	8082                	ret

0000000080001ba2 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001ba2:	c671                	beqz	a2,80001c6e <uvmcopy+0xcc>
{
    80001ba4:	715d                	addi	sp,sp,-80
    80001ba6:	e486                	sd	ra,72(sp)
    80001ba8:	e0a2                	sd	s0,64(sp)
    80001baa:	fc26                	sd	s1,56(sp)
    80001bac:	f84a                	sd	s2,48(sp)
    80001bae:	f44e                	sd	s3,40(sp)
    80001bb0:	f052                	sd	s4,32(sp)
    80001bb2:	ec56                	sd	s5,24(sp)
    80001bb4:	e85a                	sd	s6,16(sp)
    80001bb6:	e45e                	sd	s7,8(sp)
    80001bb8:	0880                	addi	s0,sp,80
    80001bba:	8ab2                	mv	s5,a2
    80001bbc:	8b2e                	mv	s6,a1
    80001bbe:	8baa                	mv	s7,a0
  for(i = 0; i < sz; i += PGSIZE){
    80001bc0:	4901                	li	s2,0
    if((pte = walk(old, i, 0)) == 0)
    80001bc2:	4601                	li	a2,0
    80001bc4:	85ca                	mv	a1,s2
    80001bc6:	855e                	mv	a0,s7
    80001bc8:	00000097          	auipc	ra,0x0
    80001bcc:	9c2080e7          	jalr	-1598(ra) # 8000158a <walk>
    80001bd0:	c531                	beqz	a0,80001c1c <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80001bd2:	6118                	ld	a4,0(a0)
    80001bd4:	00177793          	andi	a5,a4,1
    80001bd8:	cbb1                	beqz	a5,80001c2c <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80001bda:	00a75593          	srli	a1,a4,0xa
    80001bde:	00c59993          	slli	s3,a1,0xc
    flags = PTE_FLAGS(*pte);
    80001be2:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80001be6:	fffff097          	auipc	ra,0xfffff
    80001bea:	fc2080e7          	jalr	-62(ra) # 80000ba8 <kalloc>
    80001bee:	8a2a                	mv	s4,a0
    80001bf0:	c939                	beqz	a0,80001c46 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80001bf2:	6605                	lui	a2,0x1
    80001bf4:	85ce                	mv	a1,s3
    80001bf6:	fffff097          	auipc	ra,0xfffff
    80001bfa:	61a080e7          	jalr	1562(ra) # 80001210 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80001bfe:	8726                	mv	a4,s1
    80001c00:	86d2                	mv	a3,s4
    80001c02:	6605                	lui	a2,0x1
    80001c04:	85ca                	mv	a1,s2
    80001c06:	855a                	mv	a0,s6
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	b5c080e7          	jalr	-1188(ra) # 80001764 <mappages>
    80001c10:	e515                	bnez	a0,80001c3c <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80001c12:	6785                	lui	a5,0x1
    80001c14:	993e                	add	s2,s2,a5
    80001c16:	fb5966e3          	bltu	s2,s5,80001bc2 <uvmcopy+0x20>
    80001c1a:	a83d                	j	80001c58 <uvmcopy+0xb6>
      panic("uvmcopy: pte should exist");
    80001c1c:	00007517          	auipc	a0,0x7
    80001c20:	92450513          	addi	a0,a0,-1756 # 80008540 <userret+0x4b0>
    80001c24:	fffff097          	auipc	ra,0xfffff
    80001c28:	ba2080e7          	jalr	-1118(ra) # 800007c6 <panic>
      panic("uvmcopy: page not present");
    80001c2c:	00007517          	auipc	a0,0x7
    80001c30:	93450513          	addi	a0,a0,-1740 # 80008560 <userret+0x4d0>
    80001c34:	fffff097          	auipc	ra,0xfffff
    80001c38:	b92080e7          	jalr	-1134(ra) # 800007c6 <panic>
      kfree(mem);
    80001c3c:	8552                	mv	a0,s4
    80001c3e:	fffff097          	auipc	ra,0xfffff
    80001c42:	f52080e7          	jalr	-174(ra) # 80000b90 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i, 1);
    80001c46:	4685                	li	a3,1
    80001c48:	864a                	mv	a2,s2
    80001c4a:	4581                	li	a1,0
    80001c4c:	855a                	mv	a0,s6
    80001c4e:	00000097          	auipc	ra,0x0
    80001c52:	cc2080e7          	jalr	-830(ra) # 80001910 <uvmunmap>
  return -1;
    80001c56:	557d                	li	a0,-1
}
    80001c58:	60a6                	ld	ra,72(sp)
    80001c5a:	6406                	ld	s0,64(sp)
    80001c5c:	74e2                	ld	s1,56(sp)
    80001c5e:	7942                	ld	s2,48(sp)
    80001c60:	79a2                	ld	s3,40(sp)
    80001c62:	7a02                	ld	s4,32(sp)
    80001c64:	6ae2                	ld	s5,24(sp)
    80001c66:	6b42                	ld	s6,16(sp)
    80001c68:	6ba2                	ld	s7,8(sp)
    80001c6a:	6161                	addi	sp,sp,80
    80001c6c:	8082                	ret
  return 0;
    80001c6e:	4501                	li	a0,0
}
    80001c70:	8082                	ret

0000000080001c72 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001c72:	1141                	addi	sp,sp,-16
    80001c74:	e406                	sd	ra,8(sp)
    80001c76:	e022                	sd	s0,0(sp)
    80001c78:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001c7a:	4601                	li	a2,0
    80001c7c:	00000097          	auipc	ra,0x0
    80001c80:	90e080e7          	jalr	-1778(ra) # 8000158a <walk>
  if(pte == 0)
    80001c84:	c901                	beqz	a0,80001c94 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80001c86:	611c                	ld	a5,0(a0)
    80001c88:	9bbd                	andi	a5,a5,-17
    80001c8a:	e11c                	sd	a5,0(a0)
}
    80001c8c:	60a2                	ld	ra,8(sp)
    80001c8e:	6402                	ld	s0,0(sp)
    80001c90:	0141                	addi	sp,sp,16
    80001c92:	8082                	ret
    panic("uvmclear");
    80001c94:	00007517          	auipc	a0,0x7
    80001c98:	8ec50513          	addi	a0,a0,-1812 # 80008580 <userret+0x4f0>
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	b2a080e7          	jalr	-1238(ra) # 800007c6 <panic>

0000000080001ca4 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001ca4:	c6bd                	beqz	a3,80001d12 <copyout+0x6e>
{
    80001ca6:	715d                	addi	sp,sp,-80
    80001ca8:	e486                	sd	ra,72(sp)
    80001caa:	e0a2                	sd	s0,64(sp)
    80001cac:	fc26                	sd	s1,56(sp)
    80001cae:	f84a                	sd	s2,48(sp)
    80001cb0:	f44e                	sd	s3,40(sp)
    80001cb2:	f052                	sd	s4,32(sp)
    80001cb4:	ec56                	sd	s5,24(sp)
    80001cb6:	e85a                	sd	s6,16(sp)
    80001cb8:	e45e                	sd	s7,8(sp)
    80001cba:	e062                	sd	s8,0(sp)
    80001cbc:	0880                	addi	s0,sp,80
    80001cbe:	8baa                	mv	s7,a0
    80001cc0:	8a2e                	mv	s4,a1
    80001cc2:	8ab2                	mv	s5,a2
    80001cc4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80001cc6:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80001cc8:	6b05                	lui	s6,0x1
    80001cca:	a015                	j	80001cee <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001ccc:	9552                	add	a0,a0,s4
    80001cce:	0004861b          	sext.w	a2,s1
    80001cd2:	85d6                	mv	a1,s5
    80001cd4:	41250533          	sub	a0,a0,s2
    80001cd8:	fffff097          	auipc	ra,0xfffff
    80001cdc:	538080e7          	jalr	1336(ra) # 80001210 <memmove>

    len -= n;
    80001ce0:	409989b3          	sub	s3,s3,s1
    src += n;
    80001ce4:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    80001ce6:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80001cea:	02098263          	beqz	s3,80001d0e <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80001cee:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    80001cf2:	85ca                	mv	a1,s2
    80001cf4:	855e                	mv	a0,s7
    80001cf6:	00000097          	auipc	ra,0x0
    80001cfa:	9ca080e7          	jalr	-1590(ra) # 800016c0 <walkaddr>
    if(pa0 == 0)
    80001cfe:	cd01                	beqz	a0,80001d16 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80001d00:	414904b3          	sub	s1,s2,s4
    80001d04:	94da                	add	s1,s1,s6
    if(n > len)
    80001d06:	fc99f3e3          	bleu	s1,s3,80001ccc <copyout+0x28>
    80001d0a:	84ce                	mv	s1,s3
    80001d0c:	b7c1                	j	80001ccc <copyout+0x28>
  }
  return 0;
    80001d0e:	4501                	li	a0,0
    80001d10:	a021                	j	80001d18 <copyout+0x74>
    80001d12:	4501                	li	a0,0
}
    80001d14:	8082                	ret
      return -1;
    80001d16:	557d                	li	a0,-1
}
    80001d18:	60a6                	ld	ra,72(sp)
    80001d1a:	6406                	ld	s0,64(sp)
    80001d1c:	74e2                	ld	s1,56(sp)
    80001d1e:	7942                	ld	s2,48(sp)
    80001d20:	79a2                	ld	s3,40(sp)
    80001d22:	7a02                	ld	s4,32(sp)
    80001d24:	6ae2                	ld	s5,24(sp)
    80001d26:	6b42                	ld	s6,16(sp)
    80001d28:	6ba2                	ld	s7,8(sp)
    80001d2a:	6c02                	ld	s8,0(sp)
    80001d2c:	6161                	addi	sp,sp,80
    80001d2e:	8082                	ret

0000000080001d30 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001d30:	caa5                	beqz	a3,80001da0 <copyin+0x70>
{
    80001d32:	715d                	addi	sp,sp,-80
    80001d34:	e486                	sd	ra,72(sp)
    80001d36:	e0a2                	sd	s0,64(sp)
    80001d38:	fc26                	sd	s1,56(sp)
    80001d3a:	f84a                	sd	s2,48(sp)
    80001d3c:	f44e                	sd	s3,40(sp)
    80001d3e:	f052                	sd	s4,32(sp)
    80001d40:	ec56                	sd	s5,24(sp)
    80001d42:	e85a                	sd	s6,16(sp)
    80001d44:	e45e                	sd	s7,8(sp)
    80001d46:	e062                	sd	s8,0(sp)
    80001d48:	0880                	addi	s0,sp,80
    80001d4a:	8baa                	mv	s7,a0
    80001d4c:	8aae                	mv	s5,a1
    80001d4e:	8a32                	mv	s4,a2
    80001d50:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001d52:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001d54:	6b05                	lui	s6,0x1
    80001d56:	a01d                	j	80001d7c <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001d58:	014505b3          	add	a1,a0,s4
    80001d5c:	0004861b          	sext.w	a2,s1
    80001d60:	412585b3          	sub	a1,a1,s2
    80001d64:	8556                	mv	a0,s5
    80001d66:	fffff097          	auipc	ra,0xfffff
    80001d6a:	4aa080e7          	jalr	1194(ra) # 80001210 <memmove>

    len -= n;
    80001d6e:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001d72:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    80001d74:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80001d78:	02098263          	beqz	s3,80001d9c <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001d7c:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    80001d80:	85ca                	mv	a1,s2
    80001d82:	855e                	mv	a0,s7
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	93c080e7          	jalr	-1732(ra) # 800016c0 <walkaddr>
    if(pa0 == 0)
    80001d8c:	cd01                	beqz	a0,80001da4 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001d8e:	414904b3          	sub	s1,s2,s4
    80001d92:	94da                	add	s1,s1,s6
    if(n > len)
    80001d94:	fc99f2e3          	bleu	s1,s3,80001d58 <copyin+0x28>
    80001d98:	84ce                	mv	s1,s3
    80001d9a:	bf7d                	j	80001d58 <copyin+0x28>
  }
  return 0;
    80001d9c:	4501                	li	a0,0
    80001d9e:	a021                	j	80001da6 <copyin+0x76>
    80001da0:	4501                	li	a0,0
}
    80001da2:	8082                	ret
      return -1;
    80001da4:	557d                	li	a0,-1
}
    80001da6:	60a6                	ld	ra,72(sp)
    80001da8:	6406                	ld	s0,64(sp)
    80001daa:	74e2                	ld	s1,56(sp)
    80001dac:	7942                	ld	s2,48(sp)
    80001dae:	79a2                	ld	s3,40(sp)
    80001db0:	7a02                	ld	s4,32(sp)
    80001db2:	6ae2                	ld	s5,24(sp)
    80001db4:	6b42                	ld	s6,16(sp)
    80001db6:	6ba2                	ld	s7,8(sp)
    80001db8:	6c02                	ld	s8,0(sp)
    80001dba:	6161                	addi	sp,sp,80
    80001dbc:	8082                	ret

0000000080001dbe <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001dbe:	ced5                	beqz	a3,80001e7a <copyinstr+0xbc>
{
    80001dc0:	715d                	addi	sp,sp,-80
    80001dc2:	e486                	sd	ra,72(sp)
    80001dc4:	e0a2                	sd	s0,64(sp)
    80001dc6:	fc26                	sd	s1,56(sp)
    80001dc8:	f84a                	sd	s2,48(sp)
    80001dca:	f44e                	sd	s3,40(sp)
    80001dcc:	f052                	sd	s4,32(sp)
    80001dce:	ec56                	sd	s5,24(sp)
    80001dd0:	e85a                	sd	s6,16(sp)
    80001dd2:	e45e                	sd	s7,8(sp)
    80001dd4:	e062                	sd	s8,0(sp)
    80001dd6:	0880                	addi	s0,sp,80
    80001dd8:	8aaa                	mv	s5,a0
    80001dda:	84ae                	mv	s1,a1
    80001ddc:	8c32                	mv	s8,a2
    80001dde:	8bb6                	mv	s7,a3
    va0 = PGROUNDDOWN(srcva);
    80001de0:	7a7d                	lui	s4,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001de2:	6985                	lui	s3,0x1
    80001de4:	4b05                	li	s6,1
    80001de6:	a801                	j	80001df6 <copyinstr+0x38>
    if(n > max)
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
    80001de8:	87a6                	mv	a5,s1
    80001dea:	a085                	j	80001e4a <copyinstr+0x8c>
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    80001dec:	84b2                	mv	s1,a2
    }

    srcva = va0 + PGSIZE;
    80001dee:	01390c33          	add	s8,s2,s3
  while(got_null == 0 && max > 0){
    80001df2:	080b8063          	beqz	s7,80001e72 <copyinstr+0xb4>
    va0 = PGROUNDDOWN(srcva);
    80001df6:	014c7933          	and	s2,s8,s4
    pa0 = walkaddr(pagetable, va0);
    80001dfa:	85ca                	mv	a1,s2
    80001dfc:	8556                	mv	a0,s5
    80001dfe:	00000097          	auipc	ra,0x0
    80001e02:	8c2080e7          	jalr	-1854(ra) # 800016c0 <walkaddr>
    if(pa0 == 0)
    80001e06:	c925                	beqz	a0,80001e76 <copyinstr+0xb8>
    n = PGSIZE - (srcva - va0);
    80001e08:	41890633          	sub	a2,s2,s8
    80001e0c:	964e                	add	a2,a2,s3
    if(n > max)
    80001e0e:	00cbf363          	bleu	a2,s7,80001e14 <copyinstr+0x56>
    80001e12:	865e                	mv	a2,s7
    char *p = (char *) (pa0 + (srcva - va0));
    80001e14:	9562                	add	a0,a0,s8
    80001e16:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80001e1a:	da71                	beqz	a2,80001dee <copyinstr+0x30>
      if(*p == '\0'){
    80001e1c:	00054703          	lbu	a4,0(a0)
    80001e20:	d761                	beqz	a4,80001de8 <copyinstr+0x2a>
    80001e22:	9626                	add	a2,a2,s1
    80001e24:	87a6                	mv	a5,s1
    80001e26:	1bfd                	addi	s7,s7,-1
    80001e28:	009b86b3          	add	a3,s7,s1
    80001e2c:	409b04b3          	sub	s1,s6,s1
    80001e30:	94aa                	add	s1,s1,a0
        *dst = *p;
    80001e32:	00e78023          	sb	a4,0(a5) # 1000 <_entry-0x7ffff000>
      --max;
    80001e36:	40f68bb3          	sub	s7,a3,a5
      p++;
    80001e3a:	00f48733          	add	a4,s1,a5
      dst++;
    80001e3e:	0785                	addi	a5,a5,1
    while(n > 0){
    80001e40:	faf606e3          	beq	a2,a5,80001dec <copyinstr+0x2e>
      if(*p == '\0'){
    80001e44:	00074703          	lbu	a4,0(a4)
    80001e48:	f76d                	bnez	a4,80001e32 <copyinstr+0x74>
        *dst = '\0';
    80001e4a:	00078023          	sb	zero,0(a5)
    80001e4e:	4785                	li	a5,1
  }
  if(got_null){
    80001e50:	0017b513          	seqz	a0,a5
    80001e54:	40a0053b          	negw	a0,a0
    80001e58:	2501                	sext.w	a0,a0
    return 0;
  } else {
    return -1;
  }
}
    80001e5a:	60a6                	ld	ra,72(sp)
    80001e5c:	6406                	ld	s0,64(sp)
    80001e5e:	74e2                	ld	s1,56(sp)
    80001e60:	7942                	ld	s2,48(sp)
    80001e62:	79a2                	ld	s3,40(sp)
    80001e64:	7a02                	ld	s4,32(sp)
    80001e66:	6ae2                	ld	s5,24(sp)
    80001e68:	6b42                	ld	s6,16(sp)
    80001e6a:	6ba2                	ld	s7,8(sp)
    80001e6c:	6c02                	ld	s8,0(sp)
    80001e6e:	6161                	addi	sp,sp,80
    80001e70:	8082                	ret
    80001e72:	4781                	li	a5,0
    80001e74:	bff1                	j	80001e50 <copyinstr+0x92>
      return -1;
    80001e76:	557d                	li	a0,-1
    80001e78:	b7cd                	j	80001e5a <copyinstr+0x9c>
  int got_null = 0;
    80001e7a:	4781                	li	a5,0
  if(got_null){
    80001e7c:	0017b513          	seqz	a0,a5
    80001e80:	40a0053b          	negw	a0,a0
    80001e84:	2501                	sext.w	a0,a0
}
    80001e86:	8082                	ret

0000000080001e88 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80001e88:	1101                	addi	sp,sp,-32
    80001e8a:	ec06                	sd	ra,24(sp)
    80001e8c:	e822                	sd	s0,16(sp)
    80001e8e:	e426                	sd	s1,8(sp)
    80001e90:	1000                	addi	s0,sp,32
    80001e92:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	e1e080e7          	jalr	-482(ra) # 80000cb2 <holding>
    80001e9c:	c909                	beqz	a0,80001eae <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    80001e9e:	60bc                	ld	a5,64(s1)
    80001ea0:	00978f63          	beq	a5,s1,80001ebe <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    80001ea4:	60e2                	ld	ra,24(sp)
    80001ea6:	6442                	ld	s0,16(sp)
    80001ea8:	64a2                	ld	s1,8(sp)
    80001eaa:	6105                	addi	sp,sp,32
    80001eac:	8082                	ret
    panic("wakeup1");
    80001eae:	00006517          	auipc	a0,0x6
    80001eb2:	6e250513          	addi	a0,a0,1762 # 80008590 <userret+0x500>
    80001eb6:	fffff097          	auipc	ra,0xfffff
    80001eba:	910080e7          	jalr	-1776(ra) # 800007c6 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    80001ebe:	5898                	lw	a4,48(s1)
    80001ec0:	4785                	li	a5,1
    80001ec2:	fef711e3          	bne	a4,a5,80001ea4 <wakeup1+0x1c>
    p->state = RUNNABLE;
    80001ec6:	4789                	li	a5,2
    80001ec8:	d89c                	sw	a5,48(s1)
}
    80001eca:	bfe9                	j	80001ea4 <wakeup1+0x1c>

0000000080001ecc <procinit>:
{
    80001ecc:	715d                	addi	sp,sp,-80
    80001ece:	e486                	sd	ra,72(sp)
    80001ed0:	e0a2                	sd	s0,64(sp)
    80001ed2:	fc26                	sd	s1,56(sp)
    80001ed4:	f84a                	sd	s2,48(sp)
    80001ed6:	f44e                	sd	s3,40(sp)
    80001ed8:	f052                	sd	s4,32(sp)
    80001eda:	ec56                	sd	s5,24(sp)
    80001edc:	e85a                	sd	s6,16(sp)
    80001ede:	e45e                	sd	s7,8(sp)
    80001ee0:	0880                	addi	s0,sp,80
  initlock(&prio_lock, "priolock");
    80001ee2:	00006597          	auipc	a1,0x6
    80001ee6:	6b658593          	addi	a1,a1,1718 # 80008598 <userret+0x508>
    80001eea:	00014517          	auipc	a0,0x14
    80001eee:	afe50513          	addi	a0,a0,-1282 # 800159e8 <prio_lock>
    80001ef2:	fffff097          	auipc	ra,0xfffff
    80001ef6:	cd0080e7          	jalr	-816(ra) # 80000bc2 <initlock>
  for(int i = 0; i < NPRIO; i++){
    80001efa:	00014797          	auipc	a5,0x14
    80001efe:	b1e78793          	addi	a5,a5,-1250 # 80015a18 <prio>
    80001f02:	00014717          	auipc	a4,0x14
    80001f06:	b6670713          	addi	a4,a4,-1178 # 80015a68 <pid_lock>
    prio[i] = 0;
    80001f0a:	0007b023          	sd	zero,0(a5)
  for(int i = 0; i < NPRIO; i++){
    80001f0e:	07a1                	addi	a5,a5,8
    80001f10:	fee79de3          	bne	a5,a4,80001f0a <procinit+0x3e>
  initlock(&pid_lock, "nextpid");
    80001f14:	00006597          	auipc	a1,0x6
    80001f18:	69458593          	addi	a1,a1,1684 # 800085a8 <userret+0x518>
    80001f1c:	00014517          	auipc	a0,0x14
    80001f20:	b4c50513          	addi	a0,a0,-1204 # 80015a68 <pid_lock>
    80001f24:	fffff097          	auipc	ra,0xfffff
    80001f28:	c9e080e7          	jalr	-866(ra) # 80000bc2 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001f2c:	00014917          	auipc	s2,0x14
    80001f30:	f6c90913          	addi	s2,s2,-148 # 80015e98 <proc>
      initlock(&p->lock, "proc");
    80001f34:	00006b97          	auipc	s7,0x6
    80001f38:	67cb8b93          	addi	s7,s7,1660 # 800085b0 <userret+0x520>
      uint64 va = KSTACK((int) (p - proc));
    80001f3c:	8b4a                	mv	s6,s2
    80001f3e:	00007a97          	auipc	s5,0x7
    80001f42:	212a8a93          	addi	s5,s5,530 # 80009150 <syscalls+0xd8>
    80001f46:	040009b7          	lui	s3,0x4000
    80001f4a:	19fd                	addi	s3,s3,-1
    80001f4c:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001f4e:	0001aa17          	auipc	s4,0x1a
    80001f52:	14aa0a13          	addi	s4,s4,330 # 8001c098 <tickslock>
      initlock(&p->lock, "proc");
    80001f56:	85de                	mv	a1,s7
    80001f58:	854a                	mv	a0,s2
    80001f5a:	fffff097          	auipc	ra,0xfffff
    80001f5e:	c68080e7          	jalr	-920(ra) # 80000bc2 <initlock>
      char *pa = kalloc();
    80001f62:	fffff097          	auipc	ra,0xfffff
    80001f66:	c46080e7          	jalr	-954(ra) # 80000ba8 <kalloc>
    80001f6a:	85aa                	mv	a1,a0
      if(pa == 0)
    80001f6c:	c929                	beqz	a0,80001fbe <procinit+0xf2>
      uint64 va = KSTACK((int) (p - proc));
    80001f6e:	416904b3          	sub	s1,s2,s6
    80001f72:	848d                	srai	s1,s1,0x3
    80001f74:	000ab783          	ld	a5,0(s5)
    80001f78:	02f484b3          	mul	s1,s1,a5
    80001f7c:	2485                	addiw	s1,s1,1
    80001f7e:	00d4949b          	slliw	s1,s1,0xd
    80001f82:	409984b3          	sub	s1,s3,s1
      kvmmap(va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001f86:	4699                	li	a3,6
    80001f88:	6605                	lui	a2,0x1
    80001f8a:	8526                	mv	a0,s1
    80001f8c:	00000097          	auipc	ra,0x0
    80001f90:	864080e7          	jalr	-1948(ra) # 800017f0 <kvmmap>
      p->kstack = va;
    80001f94:	04993c23          	sd	s1,88(s2)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001f98:	18890913          	addi	s2,s2,392
    80001f9c:	fb491de3          	bne	s2,s4,80001f56 <procinit+0x8a>
  kvminithart();
    80001fa0:	fffff097          	auipc	ra,0xfffff
    80001fa4:	6fa080e7          	jalr	1786(ra) # 8000169a <kvminithart>
}
    80001fa8:	60a6                	ld	ra,72(sp)
    80001faa:	6406                	ld	s0,64(sp)
    80001fac:	74e2                	ld	s1,56(sp)
    80001fae:	7942                	ld	s2,48(sp)
    80001fb0:	79a2                	ld	s3,40(sp)
    80001fb2:	7a02                	ld	s4,32(sp)
    80001fb4:	6ae2                	ld	s5,24(sp)
    80001fb6:	6b42                	ld	s6,16(sp)
    80001fb8:	6ba2                	ld	s7,8(sp)
    80001fba:	6161                	addi	sp,sp,80
    80001fbc:	8082                	ret
        panic("kalloc");
    80001fbe:	00006517          	auipc	a0,0x6
    80001fc2:	5fa50513          	addi	a0,a0,1530 # 800085b8 <userret+0x528>
    80001fc6:	fffff097          	auipc	ra,0xfffff
    80001fca:	800080e7          	jalr	-2048(ra) # 800007c6 <panic>

0000000080001fce <cpuid>:
{
    80001fce:	1141                	addi	sp,sp,-16
    80001fd0:	e422                	sd	s0,8(sp)
    80001fd2:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001fd4:	8512                	mv	a0,tp
}
    80001fd6:	2501                	sext.w	a0,a0
    80001fd8:	6422                	ld	s0,8(sp)
    80001fda:	0141                	addi	sp,sp,16
    80001fdc:	8082                	ret

0000000080001fde <mycpu>:
mycpu(void) {
    80001fde:	1141                	addi	sp,sp,-16
    80001fe0:	e422                	sd	s0,8(sp)
    80001fe2:	0800                	addi	s0,sp,16
    80001fe4:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    80001fe6:	2781                	sext.w	a5,a5
    80001fe8:	079e                	slli	a5,a5,0x7
}
    80001fea:	00014517          	auipc	a0,0x14
    80001fee:	aae50513          	addi	a0,a0,-1362 # 80015a98 <cpus>
    80001ff2:	953e                	add	a0,a0,a5
    80001ff4:	6422                	ld	s0,8(sp)
    80001ff6:	0141                	addi	sp,sp,16
    80001ff8:	8082                	ret

0000000080001ffa <myproc>:
myproc(void) {
    80001ffa:	1101                	addi	sp,sp,-32
    80001ffc:	ec06                	sd	ra,24(sp)
    80001ffe:	e822                	sd	s0,16(sp)
    80002000:	e426                	sd	s1,8(sp)
    80002002:	1000                	addi	s0,sp,32
  push_off();
    80002004:	fffff097          	auipc	ra,0xfffff
    80002008:	cdc080e7          	jalr	-804(ra) # 80000ce0 <push_off>
    8000200c:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    8000200e:	2781                	sext.w	a5,a5
    80002010:	079e                	slli	a5,a5,0x7
    80002012:	00014717          	auipc	a4,0x14
    80002016:	9d670713          	addi	a4,a4,-1578 # 800159e8 <prio_lock>
    8000201a:	97ba                	add	a5,a5,a4
    8000201c:	7bc4                	ld	s1,176(a5)
  pop_off();
    8000201e:	fffff097          	auipc	ra,0xfffff
    80002022:	efe080e7          	jalr	-258(ra) # 80000f1c <pop_off>
}
    80002026:	8526                	mv	a0,s1
    80002028:	60e2                	ld	ra,24(sp)
    8000202a:	6442                	ld	s0,16(sp)
    8000202c:	64a2                	ld	s1,8(sp)
    8000202e:	6105                	addi	sp,sp,32
    80002030:	8082                	ret

0000000080002032 <forkret>:
{
    80002032:	1141                	addi	sp,sp,-16
    80002034:	e406                	sd	ra,8(sp)
    80002036:	e022                	sd	s0,0(sp)
    80002038:	0800                	addi	s0,sp,16
  release(&myproc()->lock);
    8000203a:	00000097          	auipc	ra,0x0
    8000203e:	fc0080e7          	jalr	-64(ra) # 80001ffa <myproc>
    80002042:	fffff097          	auipc	ra,0xfffff
    80002046:	f3a080e7          	jalr	-198(ra) # 80000f7c <release>
  if (first) {
    8000204a:	00008797          	auipc	a5,0x8
    8000204e:	00e78793          	addi	a5,a5,14 # 8000a058 <first.1792>
    80002052:	439c                	lw	a5,0(a5)
    80002054:	eb89                	bnez	a5,80002066 <forkret+0x34>
  usertrapret();
    80002056:	00001097          	auipc	ra,0x1
    8000205a:	d36080e7          	jalr	-714(ra) # 80002d8c <usertrapret>
}
    8000205e:	60a2                	ld	ra,8(sp)
    80002060:	6402                	ld	s0,0(sp)
    80002062:	0141                	addi	sp,sp,16
    80002064:	8082                	ret
    first = 0;
    80002066:	00008797          	auipc	a5,0x8
    8000206a:	fe07a923          	sw	zero,-14(a5) # 8000a058 <first.1792>
    fsinit(minor(ROOTDEV));
    8000206e:	4501                	li	a0,0
    80002070:	00002097          	auipc	ra,0x2
    80002074:	b3e080e7          	jalr	-1218(ra) # 80003bae <fsinit>
    80002078:	bff9                	j	80002056 <forkret+0x24>

000000008000207a <allocpid>:
allocpid() {
    8000207a:	1101                	addi	sp,sp,-32
    8000207c:	ec06                	sd	ra,24(sp)
    8000207e:	e822                	sd	s0,16(sp)
    80002080:	e426                	sd	s1,8(sp)
    80002082:	e04a                	sd	s2,0(sp)
    80002084:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80002086:	00014917          	auipc	s2,0x14
    8000208a:	9e290913          	addi	s2,s2,-1566 # 80015a68 <pid_lock>
    8000208e:	854a                	mv	a0,s2
    80002090:	fffff097          	auipc	ra,0xfffff
    80002094:	ca0080e7          	jalr	-864(ra) # 80000d30 <acquire>
  pid = nextpid;
    80002098:	00008797          	auipc	a5,0x8
    8000209c:	fc478793          	addi	a5,a5,-60 # 8000a05c <nextpid>
    800020a0:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800020a2:	0014871b          	addiw	a4,s1,1
    800020a6:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800020a8:	854a                	mv	a0,s2
    800020aa:	fffff097          	auipc	ra,0xfffff
    800020ae:	ed2080e7          	jalr	-302(ra) # 80000f7c <release>
}
    800020b2:	8526                	mv	a0,s1
    800020b4:	60e2                	ld	ra,24(sp)
    800020b6:	6442                	ld	s0,16(sp)
    800020b8:	64a2                	ld	s1,8(sp)
    800020ba:	6902                	ld	s2,0(sp)
    800020bc:	6105                	addi	sp,sp,32
    800020be:	8082                	ret

00000000800020c0 <proc_pagetable>:
{
    800020c0:	1101                	addi	sp,sp,-32
    800020c2:	ec06                	sd	ra,24(sp)
    800020c4:	e822                	sd	s0,16(sp)
    800020c6:	e426                	sd	s1,8(sp)
    800020c8:	e04a                	sd	s2,0(sp)
    800020ca:	1000                	addi	s0,sp,32
    800020cc:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    800020ce:	00000097          	auipc	ra,0x0
    800020d2:	908080e7          	jalr	-1784(ra) # 800019d6 <uvmcreate>
    800020d6:	84aa                	mv	s1,a0
  mappages(pagetable, TRAMPOLINE, PGSIZE,
    800020d8:	4729                	li	a4,10
    800020da:	00006697          	auipc	a3,0x6
    800020de:	f2668693          	addi	a3,a3,-218 # 80008000 <trampoline>
    800020e2:	6605                	lui	a2,0x1
    800020e4:	040005b7          	lui	a1,0x4000
    800020e8:	15fd                	addi	a1,a1,-1
    800020ea:	05b2                	slli	a1,a1,0xc
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	678080e7          	jalr	1656(ra) # 80001764 <mappages>
  mappages(pagetable, TRAPFRAME, PGSIZE,
    800020f4:	4719                	li	a4,6
    800020f6:	07093683          	ld	a3,112(s2)
    800020fa:	6605                	lui	a2,0x1
    800020fc:	020005b7          	lui	a1,0x2000
    80002100:	15fd                	addi	a1,a1,-1
    80002102:	05b6                	slli	a1,a1,0xd
    80002104:	8526                	mv	a0,s1
    80002106:	fffff097          	auipc	ra,0xfffff
    8000210a:	65e080e7          	jalr	1630(ra) # 80001764 <mappages>
}
    8000210e:	8526                	mv	a0,s1
    80002110:	60e2                	ld	ra,24(sp)
    80002112:	6442                	ld	s0,16(sp)
    80002114:	64a2                	ld	s1,8(sp)
    80002116:	6902                	ld	s2,0(sp)
    80002118:	6105                	addi	sp,sp,32
    8000211a:	8082                	ret

000000008000211c <allocproc>:
{
    8000211c:	1101                	addi	sp,sp,-32
    8000211e:	ec06                	sd	ra,24(sp)
    80002120:	e822                	sd	s0,16(sp)
    80002122:	e426                	sd	s1,8(sp)
    80002124:	e04a                	sd	s2,0(sp)
    80002126:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80002128:	00014497          	auipc	s1,0x14
    8000212c:	d7048493          	addi	s1,s1,-656 # 80015e98 <proc>
    80002130:	0001a917          	auipc	s2,0x1a
    80002134:	f6890913          	addi	s2,s2,-152 # 8001c098 <tickslock>
    acquire(&p->lock);
    80002138:	8526                	mv	a0,s1
    8000213a:	fffff097          	auipc	ra,0xfffff
    8000213e:	bf6080e7          	jalr	-1034(ra) # 80000d30 <acquire>
    if(p->state == UNUSED) {
    80002142:	589c                	lw	a5,48(s1)
    80002144:	cf81                	beqz	a5,8000215c <allocproc+0x40>
      release(&p->lock);
    80002146:	8526                	mv	a0,s1
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	e34080e7          	jalr	-460(ra) # 80000f7c <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002150:	18848493          	addi	s1,s1,392
    80002154:	ff2492e3          	bne	s1,s2,80002138 <allocproc+0x1c>
  return 0;
    80002158:	4481                	li	s1,0
    8000215a:	a0b9                	j	800021a8 <allocproc+0x8c>
  p->pid = allocpid();
    8000215c:	00000097          	auipc	ra,0x0
    80002160:	f1e080e7          	jalr	-226(ra) # 8000207a <allocpid>
    80002164:	c8a8                	sw	a0,80(s1)
  if((p->tf = (struct trapframe *)kalloc()) == 0){
    80002166:	fffff097          	auipc	ra,0xfffff
    8000216a:	a42080e7          	jalr	-1470(ra) # 80000ba8 <kalloc>
    8000216e:	892a                	mv	s2,a0
    80002170:	f8a8                	sd	a0,112(s1)
    80002172:	c131                	beqz	a0,800021b6 <allocproc+0x9a>
  p->pagetable = proc_pagetable(p);
    80002174:	8526                	mv	a0,s1
    80002176:	00000097          	auipc	ra,0x0
    8000217a:	f4a080e7          	jalr	-182(ra) # 800020c0 <proc_pagetable>
    8000217e:	f4a8                	sd	a0,104(s1)
  p->priority = DEF_PRIO;
    80002180:	4795                	li	a5,5
    80002182:	c8fc                	sw	a5,84(s1)
  memset(&p->context, 0, sizeof p->context);
    80002184:	07000613          	li	a2,112
    80002188:	4581                	li	a1,0
    8000218a:	07848513          	addi	a0,s1,120
    8000218e:	fffff097          	auipc	ra,0xfffff
    80002192:	016080e7          	jalr	22(ra) # 800011a4 <memset>
  p->context.ra = (uint64)forkret;
    80002196:	00000797          	auipc	a5,0x0
    8000219a:	e9c78793          	addi	a5,a5,-356 # 80002032 <forkret>
    8000219e:	fcbc                	sd	a5,120(s1)
  p->context.sp = p->kstack + PGSIZE;
    800021a0:	6cbc                	ld	a5,88(s1)
    800021a2:	6705                	lui	a4,0x1
    800021a4:	97ba                	add	a5,a5,a4
    800021a6:	e0dc                	sd	a5,128(s1)
}
    800021a8:	8526                	mv	a0,s1
    800021aa:	60e2                	ld	ra,24(sp)
    800021ac:	6442                	ld	s0,16(sp)
    800021ae:	64a2                	ld	s1,8(sp)
    800021b0:	6902                	ld	s2,0(sp)
    800021b2:	6105                	addi	sp,sp,32
    800021b4:	8082                	ret
    release(&p->lock);
    800021b6:	8526                	mv	a0,s1
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	dc4080e7          	jalr	-572(ra) # 80000f7c <release>
    return 0;
    800021c0:	84ca                	mv	s1,s2
    800021c2:	b7dd                	j	800021a8 <allocproc+0x8c>

00000000800021c4 <proc_freepagetable>:
{
    800021c4:	1101                	addi	sp,sp,-32
    800021c6:	ec06                	sd	ra,24(sp)
    800021c8:	e822                	sd	s0,16(sp)
    800021ca:	e426                	sd	s1,8(sp)
    800021cc:	e04a                	sd	s2,0(sp)
    800021ce:	1000                	addi	s0,sp,32
    800021d0:	84aa                	mv	s1,a0
    800021d2:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, PGSIZE, 0);
    800021d4:	4681                	li	a3,0
    800021d6:	6605                	lui	a2,0x1
    800021d8:	040005b7          	lui	a1,0x4000
    800021dc:	15fd                	addi	a1,a1,-1
    800021de:	05b2                	slli	a1,a1,0xc
    800021e0:	fffff097          	auipc	ra,0xfffff
    800021e4:	730080e7          	jalr	1840(ra) # 80001910 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, PGSIZE, 0);
    800021e8:	4681                	li	a3,0
    800021ea:	6605                	lui	a2,0x1
    800021ec:	020005b7          	lui	a1,0x2000
    800021f0:	15fd                	addi	a1,a1,-1
    800021f2:	05b6                	slli	a1,a1,0xd
    800021f4:	8526                	mv	a0,s1
    800021f6:	fffff097          	auipc	ra,0xfffff
    800021fa:	71a080e7          	jalr	1818(ra) # 80001910 <uvmunmap>
  if(sz > 0)
    800021fe:	00091863          	bnez	s2,8000220e <proc_freepagetable+0x4a>
}
    80002202:	60e2                	ld	ra,24(sp)
    80002204:	6442                	ld	s0,16(sp)
    80002206:	64a2                	ld	s1,8(sp)
    80002208:	6902                	ld	s2,0(sp)
    8000220a:	6105                	addi	sp,sp,32
    8000220c:	8082                	ret
    uvmfree(pagetable, sz);
    8000220e:	85ca                	mv	a1,s2
    80002210:	8526                	mv	a0,s1
    80002212:	00000097          	auipc	ra,0x0
    80002216:	962080e7          	jalr	-1694(ra) # 80001b74 <uvmfree>
}
    8000221a:	b7e5                	j	80002202 <proc_freepagetable+0x3e>

000000008000221c <freeproc>:
{
    8000221c:	1101                	addi	sp,sp,-32
    8000221e:	ec06                	sd	ra,24(sp)
    80002220:	e822                	sd	s0,16(sp)
    80002222:	e426                	sd	s1,8(sp)
    80002224:	1000                	addi	s0,sp,32
    80002226:	84aa                	mv	s1,a0
  if(p->tf)
    80002228:	7928                	ld	a0,112(a0)
    8000222a:	c509                	beqz	a0,80002234 <freeproc+0x18>
    kfree((void*)p->tf);
    8000222c:	fffff097          	auipc	ra,0xfffff
    80002230:	964080e7          	jalr	-1692(ra) # 80000b90 <kfree>
  p->tf = 0;
    80002234:	0604b823          	sd	zero,112(s1)
  if(p->pagetable)
    80002238:	74a8                	ld	a0,104(s1)
    8000223a:	c511                	beqz	a0,80002246 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    8000223c:	70ac                	ld	a1,96(s1)
    8000223e:	00000097          	auipc	ra,0x0
    80002242:	f86080e7          	jalr	-122(ra) # 800021c4 <proc_freepagetable>
  if(p->cmd)
    80002246:	1804b503          	ld	a0,384(s1)
    8000224a:	c509                	beqz	a0,80002254 <freeproc+0x38>
    bd_free(p->cmd);
    8000224c:	00005097          	auipc	ra,0x5
    80002250:	f40080e7          	jalr	-192(ra) # 8000718c <bd_free>
  p->cmd = 0;
    80002254:	1804b023          	sd	zero,384(s1)
  p->priority = 0;
    80002258:	0404aa23          	sw	zero,84(s1)
  p->pagetable = 0;
    8000225c:	0604b423          	sd	zero,104(s1)
  p->sz = 0;
    80002260:	0604b023          	sd	zero,96(s1)
  p->pid = 0;
    80002264:	0404a823          	sw	zero,80(s1)
  p->parent = 0;
    80002268:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000226c:	16048823          	sb	zero,368(s1)
  p->chan = 0;
    80002270:	0404b023          	sd	zero,64(s1)
  p->killed = 0;
    80002274:	0404a423          	sw	zero,72(s1)
  p->xstate = 0;
    80002278:	0404a623          	sw	zero,76(s1)
  p->state = UNUSED;
    8000227c:	0204a823          	sw	zero,48(s1)
}
    80002280:	60e2                	ld	ra,24(sp)
    80002282:	6442                	ld	s0,16(sp)
    80002284:	64a2                	ld	s1,8(sp)
    80002286:	6105                	addi	sp,sp,32
    80002288:	8082                	ret

000000008000228a <userinit>:
{
    8000228a:	1101                	addi	sp,sp,-32
    8000228c:	ec06                	sd	ra,24(sp)
    8000228e:	e822                	sd	s0,16(sp)
    80002290:	e426                	sd	s1,8(sp)
    80002292:	1000                	addi	s0,sp,32
  p = allocproc();
    80002294:	00000097          	auipc	ra,0x0
    80002298:	e88080e7          	jalr	-376(ra) # 8000211c <allocproc>
    8000229c:	84aa                	mv	s1,a0
  initproc = p;
    8000229e:	0002c797          	auipc	a5,0x2c
    800022a2:	dea7b123          	sd	a0,-542(a5) # 8002e080 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    800022a6:	03300613          	li	a2,51
    800022aa:	00008597          	auipc	a1,0x8
    800022ae:	d5658593          	addi	a1,a1,-682 # 8000a000 <initcode>
    800022b2:	7528                	ld	a0,104(a0)
    800022b4:	fffff097          	auipc	ra,0xfffff
    800022b8:	760080e7          	jalr	1888(ra) # 80001a14 <uvminit>
  p->sz = PGSIZE;
    800022bc:	6785                	lui	a5,0x1
    800022be:	f0bc                	sd	a5,96(s1)
  p->tf->epc = 0;      // user program counter
    800022c0:	78b8                	ld	a4,112(s1)
    800022c2:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->tf->sp = PGSIZE;  // user stack pointer
    800022c6:	78b8                	ld	a4,112(s1)
    800022c8:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800022ca:	4641                	li	a2,16
    800022cc:	00006597          	auipc	a1,0x6
    800022d0:	2f458593          	addi	a1,a1,756 # 800085c0 <userret+0x530>
    800022d4:	17048513          	addi	a0,s1,368
    800022d8:	fffff097          	auipc	ra,0xfffff
    800022dc:	044080e7          	jalr	68(ra) # 8000131c <safestrcpy>
  p->cmd = strdup("init");
    800022e0:	00006517          	auipc	a0,0x6
    800022e4:	2f050513          	addi	a0,a0,752 # 800085d0 <userret+0x540>
    800022e8:	fffff097          	auipc	ra,0xfffff
    800022ec:	12e080e7          	jalr	302(ra) # 80001416 <strdup>
    800022f0:	18a4b023          	sd	a0,384(s1)
  p->cwd = namei("/");
    800022f4:	00006517          	auipc	a0,0x6
    800022f8:	2e450513          	addi	a0,a0,740 # 800085d8 <userret+0x548>
    800022fc:	00002097          	auipc	ra,0x2
    80002300:	2c0080e7          	jalr	704(ra) # 800045bc <namei>
    80002304:	16a4b423          	sd	a0,360(s1)
  p->state = RUNNABLE;
    80002308:	4789                	li	a5,2
    8000230a:	d89c                	sw	a5,48(s1)
  release(&p->lock);
    8000230c:	8526                	mv	a0,s1
    8000230e:	fffff097          	auipc	ra,0xfffff
    80002312:	c6e080e7          	jalr	-914(ra) # 80000f7c <release>
}
    80002316:	60e2                	ld	ra,24(sp)
    80002318:	6442                	ld	s0,16(sp)
    8000231a:	64a2                	ld	s1,8(sp)
    8000231c:	6105                	addi	sp,sp,32
    8000231e:	8082                	ret

0000000080002320 <growproc>:
{
    80002320:	1101                	addi	sp,sp,-32
    80002322:	ec06                	sd	ra,24(sp)
    80002324:	e822                	sd	s0,16(sp)
    80002326:	e426                	sd	s1,8(sp)
    80002328:	e04a                	sd	s2,0(sp)
    8000232a:	1000                	addi	s0,sp,32
    8000232c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000232e:	00000097          	auipc	ra,0x0
    80002332:	ccc080e7          	jalr	-820(ra) # 80001ffa <myproc>
    80002336:	892a                	mv	s2,a0
  sz = p->sz;
    80002338:	712c                	ld	a1,96(a0)
    8000233a:	0005851b          	sext.w	a0,a1
  if(n > 0){
    8000233e:	00904f63          	bgtz	s1,8000235c <growproc+0x3c>
  } else if(n < 0){
    80002342:	0204cd63          	bltz	s1,8000237c <growproc+0x5c>
  p->sz = sz;
    80002346:	1502                	slli	a0,a0,0x20
    80002348:	9101                	srli	a0,a0,0x20
    8000234a:	06a93023          	sd	a0,96(s2)
  return 0;
    8000234e:	4501                	li	a0,0
}
    80002350:	60e2                	ld	ra,24(sp)
    80002352:	6442                	ld	s0,16(sp)
    80002354:	64a2                	ld	s1,8(sp)
    80002356:	6902                	ld	s2,0(sp)
    80002358:	6105                	addi	sp,sp,32
    8000235a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    8000235c:	00a4863b          	addw	a2,s1,a0
    80002360:	1602                	slli	a2,a2,0x20
    80002362:	9201                	srli	a2,a2,0x20
    80002364:	1582                	slli	a1,a1,0x20
    80002366:	9181                	srli	a1,a1,0x20
    80002368:	06893503          	ld	a0,104(s2)
    8000236c:	fffff097          	auipc	ra,0xfffff
    80002370:	75e080e7          	jalr	1886(ra) # 80001aca <uvmalloc>
    80002374:	2501                	sext.w	a0,a0
    80002376:	f961                	bnez	a0,80002346 <growproc+0x26>
      return -1;
    80002378:	557d                	li	a0,-1
    8000237a:	bfd9                	j	80002350 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000237c:	00a4863b          	addw	a2,s1,a0
    80002380:	1602                	slli	a2,a2,0x20
    80002382:	9201                	srli	a2,a2,0x20
    80002384:	1582                	slli	a1,a1,0x20
    80002386:	9181                	srli	a1,a1,0x20
    80002388:	06893503          	ld	a0,104(s2)
    8000238c:	fffff097          	auipc	ra,0xfffff
    80002390:	6fa080e7          	jalr	1786(ra) # 80001a86 <uvmdealloc>
    80002394:	2501                	sext.w	a0,a0
    80002396:	bf45                	j	80002346 <growproc+0x26>

0000000080002398 <fork>:
{
    80002398:	7179                	addi	sp,sp,-48
    8000239a:	f406                	sd	ra,40(sp)
    8000239c:	f022                	sd	s0,32(sp)
    8000239e:	ec26                	sd	s1,24(sp)
    800023a0:	e84a                	sd	s2,16(sp)
    800023a2:	e44e                	sd	s3,8(sp)
    800023a4:	e052                	sd	s4,0(sp)
    800023a6:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	c52080e7          	jalr	-942(ra) # 80001ffa <myproc>
    800023b0:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    800023b2:	00000097          	auipc	ra,0x0
    800023b6:	d6a080e7          	jalr	-662(ra) # 8000211c <allocproc>
    800023ba:	c975                	beqz	a0,800024ae <fork+0x116>
    800023bc:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800023be:	06093603          	ld	a2,96(s2)
    800023c2:	752c                	ld	a1,104(a0)
    800023c4:	06893503          	ld	a0,104(s2)
    800023c8:	fffff097          	auipc	ra,0xfffff
    800023cc:	7da080e7          	jalr	2010(ra) # 80001ba2 <uvmcopy>
    800023d0:	04054863          	bltz	a0,80002420 <fork+0x88>
  np->sz = p->sz;
    800023d4:	06093783          	ld	a5,96(s2)
    800023d8:	06f9b023          	sd	a5,96(s3) # 4000060 <_entry-0x7bffffa0>
  np->parent = p;
    800023dc:	0329bc23          	sd	s2,56(s3)
  *(np->tf) = *(p->tf);
    800023e0:	07093683          	ld	a3,112(s2)
    800023e4:	87b6                	mv	a5,a3
    800023e6:	0709b703          	ld	a4,112(s3)
    800023ea:	12068693          	addi	a3,a3,288
    800023ee:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800023f2:	6788                	ld	a0,8(a5)
    800023f4:	6b8c                	ld	a1,16(a5)
    800023f6:	6f90                	ld	a2,24(a5)
    800023f8:	01073023          	sd	a6,0(a4)
    800023fc:	e708                	sd	a0,8(a4)
    800023fe:	eb0c                	sd	a1,16(a4)
    80002400:	ef10                	sd	a2,24(a4)
    80002402:	02078793          	addi	a5,a5,32
    80002406:	02070713          	addi	a4,a4,32
    8000240a:	fed792e3          	bne	a5,a3,800023ee <fork+0x56>
  np->tf->a0 = 0;
    8000240e:	0709b783          	ld	a5,112(s3)
    80002412:	0607b823          	sd	zero,112(a5)
    80002416:	0e800493          	li	s1,232
  for(i = 0; i < NOFILE; i++)
    8000241a:	16800a13          	li	s4,360
    8000241e:	a03d                	j	8000244c <fork+0xb4>
    freeproc(np);
    80002420:	854e                	mv	a0,s3
    80002422:	00000097          	auipc	ra,0x0
    80002426:	dfa080e7          	jalr	-518(ra) # 8000221c <freeproc>
    release(&np->lock);
    8000242a:	854e                	mv	a0,s3
    8000242c:	fffff097          	auipc	ra,0xfffff
    80002430:	b50080e7          	jalr	-1200(ra) # 80000f7c <release>
    return -1;
    80002434:	54fd                	li	s1,-1
    80002436:	a09d                	j	8000249c <fork+0x104>
      np->ofile[i] = filedup(p->ofile[i]);
    80002438:	00003097          	auipc	ra,0x3
    8000243c:	934080e7          	jalr	-1740(ra) # 80004d6c <filedup>
    80002440:	009987b3          	add	a5,s3,s1
    80002444:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    80002446:	04a1                	addi	s1,s1,8
    80002448:	01448763          	beq	s1,s4,80002456 <fork+0xbe>
    if(p->ofile[i])
    8000244c:	009907b3          	add	a5,s2,s1
    80002450:	6388                	ld	a0,0(a5)
    80002452:	f17d                	bnez	a0,80002438 <fork+0xa0>
    80002454:	bfcd                	j	80002446 <fork+0xae>
  np->cwd = idup(p->cwd);
    80002456:	16893503          	ld	a0,360(s2)
    8000245a:	00002097          	auipc	ra,0x2
    8000245e:	990080e7          	jalr	-1648(ra) # 80003dea <idup>
    80002462:	16a9b423          	sd	a0,360(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80002466:	4641                	li	a2,16
    80002468:	17090593          	addi	a1,s2,368
    8000246c:	17098513          	addi	a0,s3,368
    80002470:	fffff097          	auipc	ra,0xfffff
    80002474:	eac080e7          	jalr	-340(ra) # 8000131c <safestrcpy>
  np->cmd = strdup(p->cmd);
    80002478:	18093503          	ld	a0,384(s2)
    8000247c:	fffff097          	auipc	ra,0xfffff
    80002480:	f9a080e7          	jalr	-102(ra) # 80001416 <strdup>
    80002484:	18a9b023          	sd	a0,384(s3)
  pid = np->pid;
    80002488:	0509a483          	lw	s1,80(s3)
  np->state = RUNNABLE;
    8000248c:	4789                	li	a5,2
    8000248e:	02f9a823          	sw	a5,48(s3)
  release(&np->lock);
    80002492:	854e                	mv	a0,s3
    80002494:	fffff097          	auipc	ra,0xfffff
    80002498:	ae8080e7          	jalr	-1304(ra) # 80000f7c <release>
}
    8000249c:	8526                	mv	a0,s1
    8000249e:	70a2                	ld	ra,40(sp)
    800024a0:	7402                	ld	s0,32(sp)
    800024a2:	64e2                	ld	s1,24(sp)
    800024a4:	6942                	ld	s2,16(sp)
    800024a6:	69a2                	ld	s3,8(sp)
    800024a8:	6a02                	ld	s4,0(sp)
    800024aa:	6145                	addi	sp,sp,48
    800024ac:	8082                	ret
    return -1;
    800024ae:	54fd                	li	s1,-1
    800024b0:	b7f5                	j	8000249c <fork+0x104>

00000000800024b2 <reparent>:
{
    800024b2:	7179                	addi	sp,sp,-48
    800024b4:	f406                	sd	ra,40(sp)
    800024b6:	f022                	sd	s0,32(sp)
    800024b8:	ec26                	sd	s1,24(sp)
    800024ba:	e84a                	sd	s2,16(sp)
    800024bc:	e44e                	sd	s3,8(sp)
    800024be:	e052                	sd	s4,0(sp)
    800024c0:	1800                	addi	s0,sp,48
    800024c2:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800024c4:	00014497          	auipc	s1,0x14
    800024c8:	9d448493          	addi	s1,s1,-1580 # 80015e98 <proc>
      pp->parent = initproc;
    800024cc:	0002ca17          	auipc	s4,0x2c
    800024d0:	bb4a0a13          	addi	s4,s4,-1100 # 8002e080 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800024d4:	0001a917          	auipc	s2,0x1a
    800024d8:	bc490913          	addi	s2,s2,-1084 # 8001c098 <tickslock>
    800024dc:	a029                	j	800024e6 <reparent+0x34>
    800024de:	18848493          	addi	s1,s1,392
    800024e2:	03248363          	beq	s1,s2,80002508 <reparent+0x56>
    if(pp->parent == p){
    800024e6:	7c9c                	ld	a5,56(s1)
    800024e8:	ff379be3          	bne	a5,s3,800024de <reparent+0x2c>
      acquire(&pp->lock);
    800024ec:	8526                	mv	a0,s1
    800024ee:	fffff097          	auipc	ra,0xfffff
    800024f2:	842080e7          	jalr	-1982(ra) # 80000d30 <acquire>
      pp->parent = initproc;
    800024f6:	000a3783          	ld	a5,0(s4)
    800024fa:	fc9c                	sd	a5,56(s1)
      release(&pp->lock);
    800024fc:	8526                	mv	a0,s1
    800024fe:	fffff097          	auipc	ra,0xfffff
    80002502:	a7e080e7          	jalr	-1410(ra) # 80000f7c <release>
    80002506:	bfe1                	j	800024de <reparent+0x2c>
}
    80002508:	70a2                	ld	ra,40(sp)
    8000250a:	7402                	ld	s0,32(sp)
    8000250c:	64e2                	ld	s1,24(sp)
    8000250e:	6942                	ld	s2,16(sp)
    80002510:	69a2                	ld	s3,8(sp)
    80002512:	6a02                	ld	s4,0(sp)
    80002514:	6145                	addi	sp,sp,48
    80002516:	8082                	ret

0000000080002518 <scheduler>:
{
    80002518:	715d                	addi	sp,sp,-80
    8000251a:	e486                	sd	ra,72(sp)
    8000251c:	e0a2                	sd	s0,64(sp)
    8000251e:	fc26                	sd	s1,56(sp)
    80002520:	f84a                	sd	s2,48(sp)
    80002522:	f44e                	sd	s3,40(sp)
    80002524:	f052                	sd	s4,32(sp)
    80002526:	ec56                	sd	s5,24(sp)
    80002528:	e85a                	sd	s6,16(sp)
    8000252a:	e45e                	sd	s7,8(sp)
    8000252c:	e062                	sd	s8,0(sp)
    8000252e:	0880                	addi	s0,sp,80
    80002530:	8792                	mv	a5,tp
  int id = r_tp();
    80002532:	2781                	sext.w	a5,a5
  c->proc = 0;
    80002534:	00779b93          	slli	s7,a5,0x7
    80002538:	00013717          	auipc	a4,0x13
    8000253c:	4b070713          	addi	a4,a4,1200 # 800159e8 <prio_lock>
    80002540:	975e                	add	a4,a4,s7
    80002542:	0a073823          	sd	zero,176(a4)
        swtch(&c->scheduler, &p->context);
    80002546:	00013717          	auipc	a4,0x13
    8000254a:	55a70713          	addi	a4,a4,1370 # 80015aa0 <cpus+0x8>
    8000254e:	9bba                	add	s7,s7,a4
        p->state = RUNNING;
    80002550:	4c0d                	li	s8,3
        c->proc = p;
    80002552:	079e                	slli	a5,a5,0x7
    80002554:	00013917          	auipc	s2,0x13
    80002558:	49490913          	addi	s2,s2,1172 # 800159e8 <prio_lock>
    8000255c:	993e                	add	s2,s2,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000255e:	0001aa17          	auipc	s4,0x1a
    80002562:	b3aa0a13          	addi	s4,s4,-1222 # 8001c098 <tickslock>
    80002566:	a091                	j	800025aa <scheduler+0x92>
        p->state = RUNNING;
    80002568:	0384a823          	sw	s8,48(s1)
        c->proc = p;
    8000256c:	0a993823          	sd	s1,176(s2)
        swtch(&c->scheduler, &p->context);
    80002570:	07848593          	addi	a1,s1,120
    80002574:	855e                	mv	a0,s7
    80002576:	00000097          	auipc	ra,0x0
    8000257a:	6d2080e7          	jalr	1746(ra) # 80002c48 <swtch>
        c->proc = 0;
    8000257e:	0a093823          	sd	zero,176(s2)
        found = 1;
    80002582:	8ada                	mv	s5,s6
      c->intena = 0;
    80002584:	12092623          	sw	zero,300(s2)
    for(p = proc; p < &proc[NPROC]; p++) {
    80002588:	18848493          	addi	s1,s1,392
    8000258c:	01448b63          	beq	s1,s4,800025a2 <scheduler+0x8a>
      acquire(&p->lock);
    80002590:	8526                	mv	a0,s1
    80002592:	ffffe097          	auipc	ra,0xffffe
    80002596:	79e080e7          	jalr	1950(ra) # 80000d30 <acquire>
      if(p->state == RUNNABLE) {
    8000259a:	589c                	lw	a5,48(s1)
    8000259c:	ff3794e3          	bne	a5,s3,80002584 <scheduler+0x6c>
    800025a0:	b7e1                	j	80002568 <scheduler+0x50>
    if(found == 0){
    800025a2:	000a9463          	bnez	s5,800025aa <scheduler+0x92>
      asm volatile("wfi");
    800025a6:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800025aa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800025ae:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025b2:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800025b6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800025ba:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025bc:	10079073          	csrw	sstatus,a5
    int found = 0;
    800025c0:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    800025c2:	00014497          	auipc	s1,0x14
    800025c6:	8d648493          	addi	s1,s1,-1834 # 80015e98 <proc>
      if(p->state == RUNNABLE) {
    800025ca:	4989                	li	s3,2
        found = 1;
    800025cc:	4b05                	li	s6,1
    800025ce:	b7c9                	j	80002590 <scheduler+0x78>

00000000800025d0 <sched>:
{
    800025d0:	7179                	addi	sp,sp,-48
    800025d2:	f406                	sd	ra,40(sp)
    800025d4:	f022                	sd	s0,32(sp)
    800025d6:	ec26                	sd	s1,24(sp)
    800025d8:	e84a                	sd	s2,16(sp)
    800025da:	e44e                	sd	s3,8(sp)
    800025dc:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800025de:	00000097          	auipc	ra,0x0
    800025e2:	a1c080e7          	jalr	-1508(ra) # 80001ffa <myproc>
    800025e6:	892a                	mv	s2,a0
  if(!holding(&p->lock))
    800025e8:	ffffe097          	auipc	ra,0xffffe
    800025ec:	6ca080e7          	jalr	1738(ra) # 80000cb2 <holding>
    800025f0:	cd25                	beqz	a0,80002668 <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    800025f2:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800025f4:	2781                	sext.w	a5,a5
    800025f6:	079e                	slli	a5,a5,0x7
    800025f8:	00013717          	auipc	a4,0x13
    800025fc:	3f070713          	addi	a4,a4,1008 # 800159e8 <prio_lock>
    80002600:	97ba                	add	a5,a5,a4
    80002602:	1287a703          	lw	a4,296(a5)
    80002606:	4785                	li	a5,1
    80002608:	06f71863          	bne	a4,a5,80002678 <sched+0xa8>
  if(p->state == RUNNING)
    8000260c:	03092703          	lw	a4,48(s2)
    80002610:	478d                	li	a5,3
    80002612:	06f70b63          	beq	a4,a5,80002688 <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002616:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000261a:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000261c:	efb5                	bnez	a5,80002698 <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000261e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80002620:	00013497          	auipc	s1,0x13
    80002624:	3c848493          	addi	s1,s1,968 # 800159e8 <prio_lock>
    80002628:	2781                	sext.w	a5,a5
    8000262a:	079e                	slli	a5,a5,0x7
    8000262c:	97a6                	add	a5,a5,s1
    8000262e:	12c7a983          	lw	s3,300(a5)
    80002632:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->scheduler);
    80002634:	2781                	sext.w	a5,a5
    80002636:	079e                	slli	a5,a5,0x7
    80002638:	00013597          	auipc	a1,0x13
    8000263c:	46858593          	addi	a1,a1,1128 # 80015aa0 <cpus+0x8>
    80002640:	95be                	add	a1,a1,a5
    80002642:	07890513          	addi	a0,s2,120
    80002646:	00000097          	auipc	ra,0x0
    8000264a:	602080e7          	jalr	1538(ra) # 80002c48 <swtch>
    8000264e:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80002650:	2781                	sext.w	a5,a5
    80002652:	079e                	slli	a5,a5,0x7
    80002654:	97a6                	add	a5,a5,s1
    80002656:	1337a623          	sw	s3,300(a5)
}
    8000265a:	70a2                	ld	ra,40(sp)
    8000265c:	7402                	ld	s0,32(sp)
    8000265e:	64e2                	ld	s1,24(sp)
    80002660:	6942                	ld	s2,16(sp)
    80002662:	69a2                	ld	s3,8(sp)
    80002664:	6145                	addi	sp,sp,48
    80002666:	8082                	ret
    panic("sched p->lock");
    80002668:	00006517          	auipc	a0,0x6
    8000266c:	f7850513          	addi	a0,a0,-136 # 800085e0 <userret+0x550>
    80002670:	ffffe097          	auipc	ra,0xffffe
    80002674:	156080e7          	jalr	342(ra) # 800007c6 <panic>
    panic("sched locks");
    80002678:	00006517          	auipc	a0,0x6
    8000267c:	f7850513          	addi	a0,a0,-136 # 800085f0 <userret+0x560>
    80002680:	ffffe097          	auipc	ra,0xffffe
    80002684:	146080e7          	jalr	326(ra) # 800007c6 <panic>
    panic("sched running");
    80002688:	00006517          	auipc	a0,0x6
    8000268c:	f7850513          	addi	a0,a0,-136 # 80008600 <userret+0x570>
    80002690:	ffffe097          	auipc	ra,0xffffe
    80002694:	136080e7          	jalr	310(ra) # 800007c6 <panic>
    panic("sched interruptible");
    80002698:	00006517          	auipc	a0,0x6
    8000269c:	f7850513          	addi	a0,a0,-136 # 80008610 <userret+0x580>
    800026a0:	ffffe097          	auipc	ra,0xffffe
    800026a4:	126080e7          	jalr	294(ra) # 800007c6 <panic>

00000000800026a8 <exit>:
{
    800026a8:	7179                	addi	sp,sp,-48
    800026aa:	f406                	sd	ra,40(sp)
    800026ac:	f022                	sd	s0,32(sp)
    800026ae:	ec26                	sd	s1,24(sp)
    800026b0:	e84a                	sd	s2,16(sp)
    800026b2:	e44e                	sd	s3,8(sp)
    800026b4:	e052                	sd	s4,0(sp)
    800026b6:	1800                	addi	s0,sp,48
    800026b8:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800026ba:	00000097          	auipc	ra,0x0
    800026be:	940080e7          	jalr	-1728(ra) # 80001ffa <myproc>
    800026c2:	89aa                	mv	s3,a0
  if(p == initproc)
    800026c4:	0002c797          	auipc	a5,0x2c
    800026c8:	9bc78793          	addi	a5,a5,-1604 # 8002e080 <initproc>
    800026cc:	639c                	ld	a5,0(a5)
    800026ce:	0e850493          	addi	s1,a0,232
    800026d2:	16850913          	addi	s2,a0,360
    800026d6:	02a79363          	bne	a5,a0,800026fc <exit+0x54>
    panic("init exiting");
    800026da:	00006517          	auipc	a0,0x6
    800026de:	f4e50513          	addi	a0,a0,-178 # 80008628 <userret+0x598>
    800026e2:	ffffe097          	auipc	ra,0xffffe
    800026e6:	0e4080e7          	jalr	228(ra) # 800007c6 <panic>
      fileclose(f);
    800026ea:	00002097          	auipc	ra,0x2
    800026ee:	6d4080e7          	jalr	1748(ra) # 80004dbe <fileclose>
      p->ofile[fd] = 0;
    800026f2:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800026f6:	04a1                	addi	s1,s1,8
    800026f8:	01248563          	beq	s1,s2,80002702 <exit+0x5a>
    if(p->ofile[fd]){
    800026fc:	6088                	ld	a0,0(s1)
    800026fe:	f575                	bnez	a0,800026ea <exit+0x42>
    80002700:	bfdd                	j	800026f6 <exit+0x4e>
  begin_op(ROOTDEV);
    80002702:	4501                	li	a0,0
    80002704:	00002097          	auipc	ra,0x2
    80002708:	0fe080e7          	jalr	254(ra) # 80004802 <begin_op>
  iput(p->cwd);
    8000270c:	1689b503          	ld	a0,360(s3)
    80002710:	00002097          	auipc	ra,0x2
    80002714:	828080e7          	jalr	-2008(ra) # 80003f38 <iput>
  end_op(ROOTDEV);
    80002718:	4501                	li	a0,0
    8000271a:	00002097          	auipc	ra,0x2
    8000271e:	194080e7          	jalr	404(ra) # 800048ae <end_op>
  p->cwd = 0;
    80002722:	1609b423          	sd	zero,360(s3)
  acquire(&initproc->lock);
    80002726:	0002c497          	auipc	s1,0x2c
    8000272a:	95a48493          	addi	s1,s1,-1702 # 8002e080 <initproc>
    8000272e:	6088                	ld	a0,0(s1)
    80002730:	ffffe097          	auipc	ra,0xffffe
    80002734:	600080e7          	jalr	1536(ra) # 80000d30 <acquire>
  wakeup1(initproc);
    80002738:	6088                	ld	a0,0(s1)
    8000273a:	fffff097          	auipc	ra,0xfffff
    8000273e:	74e080e7          	jalr	1870(ra) # 80001e88 <wakeup1>
  release(&initproc->lock);
    80002742:	6088                	ld	a0,0(s1)
    80002744:	fffff097          	auipc	ra,0xfffff
    80002748:	838080e7          	jalr	-1992(ra) # 80000f7c <release>
  acquire(&p->lock);
    8000274c:	854e                	mv	a0,s3
    8000274e:	ffffe097          	auipc	ra,0xffffe
    80002752:	5e2080e7          	jalr	1506(ra) # 80000d30 <acquire>
  struct proc *original_parent = p->parent;
    80002756:	0389b483          	ld	s1,56(s3)
  release(&p->lock);
    8000275a:	854e                	mv	a0,s3
    8000275c:	fffff097          	auipc	ra,0xfffff
    80002760:	820080e7          	jalr	-2016(ra) # 80000f7c <release>
  acquire(&original_parent->lock);
    80002764:	8526                	mv	a0,s1
    80002766:	ffffe097          	auipc	ra,0xffffe
    8000276a:	5ca080e7          	jalr	1482(ra) # 80000d30 <acquire>
  acquire(&p->lock);
    8000276e:	854e                	mv	a0,s3
    80002770:	ffffe097          	auipc	ra,0xffffe
    80002774:	5c0080e7          	jalr	1472(ra) # 80000d30 <acquire>
  reparent(p);
    80002778:	854e                	mv	a0,s3
    8000277a:	00000097          	auipc	ra,0x0
    8000277e:	d38080e7          	jalr	-712(ra) # 800024b2 <reparent>
  wakeup1(original_parent);
    80002782:	8526                	mv	a0,s1
    80002784:	fffff097          	auipc	ra,0xfffff
    80002788:	704080e7          	jalr	1796(ra) # 80001e88 <wakeup1>
  p->xstate = status;
    8000278c:	0549a623          	sw	s4,76(s3)
  p->state = ZOMBIE;
    80002790:	4791                	li	a5,4
    80002792:	02f9a823          	sw	a5,48(s3)
  release(&original_parent->lock);
    80002796:	8526                	mv	a0,s1
    80002798:	ffffe097          	auipc	ra,0xffffe
    8000279c:	7e4080e7          	jalr	2020(ra) # 80000f7c <release>
  sched();
    800027a0:	00000097          	auipc	ra,0x0
    800027a4:	e30080e7          	jalr	-464(ra) # 800025d0 <sched>
  panic("zombie exit");
    800027a8:	00006517          	auipc	a0,0x6
    800027ac:	e9050513          	addi	a0,a0,-368 # 80008638 <userret+0x5a8>
    800027b0:	ffffe097          	auipc	ra,0xffffe
    800027b4:	016080e7          	jalr	22(ra) # 800007c6 <panic>

00000000800027b8 <yield>:
{
    800027b8:	1101                	addi	sp,sp,-32
    800027ba:	ec06                	sd	ra,24(sp)
    800027bc:	e822                	sd	s0,16(sp)
    800027be:	e426                	sd	s1,8(sp)
    800027c0:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800027c2:	00000097          	auipc	ra,0x0
    800027c6:	838080e7          	jalr	-1992(ra) # 80001ffa <myproc>
    800027ca:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800027cc:	ffffe097          	auipc	ra,0xffffe
    800027d0:	564080e7          	jalr	1380(ra) # 80000d30 <acquire>
  p->state = RUNNABLE;
    800027d4:	4789                	li	a5,2
    800027d6:	d89c                	sw	a5,48(s1)
  sched();
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	df8080e7          	jalr	-520(ra) # 800025d0 <sched>
  release(&p->lock);
    800027e0:	8526                	mv	a0,s1
    800027e2:	ffffe097          	auipc	ra,0xffffe
    800027e6:	79a080e7          	jalr	1946(ra) # 80000f7c <release>
}
    800027ea:	60e2                	ld	ra,24(sp)
    800027ec:	6442                	ld	s0,16(sp)
    800027ee:	64a2                	ld	s1,8(sp)
    800027f0:	6105                	addi	sp,sp,32
    800027f2:	8082                	ret

00000000800027f4 <sleep>:
{
    800027f4:	7179                	addi	sp,sp,-48
    800027f6:	f406                	sd	ra,40(sp)
    800027f8:	f022                	sd	s0,32(sp)
    800027fa:	ec26                	sd	s1,24(sp)
    800027fc:	e84a                	sd	s2,16(sp)
    800027fe:	e44e                	sd	s3,8(sp)
    80002800:	1800                	addi	s0,sp,48
    80002802:	89aa                	mv	s3,a0
    80002804:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002806:	fffff097          	auipc	ra,0xfffff
    8000280a:	7f4080e7          	jalr	2036(ra) # 80001ffa <myproc>
    8000280e:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    80002810:	05250663          	beq	a0,s2,8000285c <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    80002814:	ffffe097          	auipc	ra,0xffffe
    80002818:	51c080e7          	jalr	1308(ra) # 80000d30 <acquire>
    release(lk);
    8000281c:	854a                	mv	a0,s2
    8000281e:	ffffe097          	auipc	ra,0xffffe
    80002822:	75e080e7          	jalr	1886(ra) # 80000f7c <release>
  p->chan = chan;
    80002826:	0534b023          	sd	s3,64(s1)
  p->state = SLEEPING;
    8000282a:	4785                	li	a5,1
    8000282c:	d89c                	sw	a5,48(s1)
  sched();
    8000282e:	00000097          	auipc	ra,0x0
    80002832:	da2080e7          	jalr	-606(ra) # 800025d0 <sched>
  p->chan = 0;
    80002836:	0404b023          	sd	zero,64(s1)
    release(&p->lock);
    8000283a:	8526                	mv	a0,s1
    8000283c:	ffffe097          	auipc	ra,0xffffe
    80002840:	740080e7          	jalr	1856(ra) # 80000f7c <release>
    acquire(lk);
    80002844:	854a                	mv	a0,s2
    80002846:	ffffe097          	auipc	ra,0xffffe
    8000284a:	4ea080e7          	jalr	1258(ra) # 80000d30 <acquire>
}
    8000284e:	70a2                	ld	ra,40(sp)
    80002850:	7402                	ld	s0,32(sp)
    80002852:	64e2                	ld	s1,24(sp)
    80002854:	6942                	ld	s2,16(sp)
    80002856:	69a2                	ld	s3,8(sp)
    80002858:	6145                	addi	sp,sp,48
    8000285a:	8082                	ret
  p->chan = chan;
    8000285c:	05353023          	sd	s3,64(a0)
  p->state = SLEEPING;
    80002860:	4785                	li	a5,1
    80002862:	d91c                	sw	a5,48(a0)
  sched();
    80002864:	00000097          	auipc	ra,0x0
    80002868:	d6c080e7          	jalr	-660(ra) # 800025d0 <sched>
  p->chan = 0;
    8000286c:	0404b023          	sd	zero,64(s1)
  if(lk != &p->lock){
    80002870:	bff9                	j	8000284e <sleep+0x5a>

0000000080002872 <wait>:
{
    80002872:	715d                	addi	sp,sp,-80
    80002874:	e486                	sd	ra,72(sp)
    80002876:	e0a2                	sd	s0,64(sp)
    80002878:	fc26                	sd	s1,56(sp)
    8000287a:	f84a                	sd	s2,48(sp)
    8000287c:	f44e                	sd	s3,40(sp)
    8000287e:	f052                	sd	s4,32(sp)
    80002880:	ec56                	sd	s5,24(sp)
    80002882:	e85a                	sd	s6,16(sp)
    80002884:	e45e                	sd	s7,8(sp)
    80002886:	e062                	sd	s8,0(sp)
    80002888:	0880                	addi	s0,sp,80
    8000288a:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	76e080e7          	jalr	1902(ra) # 80001ffa <myproc>
    80002894:	892a                	mv	s2,a0
  acquire(&p->lock);
    80002896:	8c2a                	mv	s8,a0
    80002898:	ffffe097          	auipc	ra,0xffffe
    8000289c:	498080e7          	jalr	1176(ra) # 80000d30 <acquire>
    havekids = 0;
    800028a0:	4b01                	li	s6,0
        if(np->state == ZOMBIE){
    800028a2:	4a11                	li	s4,4
    for(np = proc; np < &proc[NPROC]; np++){
    800028a4:	00019997          	auipc	s3,0x19
    800028a8:	7f498993          	addi	s3,s3,2036 # 8001c098 <tickslock>
        havekids = 1;
    800028ac:	4a85                	li	s5,1
    havekids = 0;
    800028ae:	875a                	mv	a4,s6
    for(np = proc; np < &proc[NPROC]; np++){
    800028b0:	00013497          	auipc	s1,0x13
    800028b4:	5e848493          	addi	s1,s1,1512 # 80015e98 <proc>
    800028b8:	a08d                	j	8000291a <wait+0xa8>
          pid = np->pid;
    800028ba:	0504a983          	lw	s3,80(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800028be:	000b8e63          	beqz	s7,800028da <wait+0x68>
    800028c2:	4691                	li	a3,4
    800028c4:	04c48613          	addi	a2,s1,76
    800028c8:	85de                	mv	a1,s7
    800028ca:	06893503          	ld	a0,104(s2)
    800028ce:	fffff097          	auipc	ra,0xfffff
    800028d2:	3d6080e7          	jalr	982(ra) # 80001ca4 <copyout>
    800028d6:	02054263          	bltz	a0,800028fa <wait+0x88>
          freeproc(np);
    800028da:	8526                	mv	a0,s1
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	940080e7          	jalr	-1728(ra) # 8000221c <freeproc>
          release(&np->lock);
    800028e4:	8526                	mv	a0,s1
    800028e6:	ffffe097          	auipc	ra,0xffffe
    800028ea:	696080e7          	jalr	1686(ra) # 80000f7c <release>
          release(&p->lock);
    800028ee:	854a                	mv	a0,s2
    800028f0:	ffffe097          	auipc	ra,0xffffe
    800028f4:	68c080e7          	jalr	1676(ra) # 80000f7c <release>
          return pid;
    800028f8:	a8a9                	j	80002952 <wait+0xe0>
            release(&np->lock);
    800028fa:	8526                	mv	a0,s1
    800028fc:	ffffe097          	auipc	ra,0xffffe
    80002900:	680080e7          	jalr	1664(ra) # 80000f7c <release>
            release(&p->lock);
    80002904:	854a                	mv	a0,s2
    80002906:	ffffe097          	auipc	ra,0xffffe
    8000290a:	676080e7          	jalr	1654(ra) # 80000f7c <release>
            return -1;
    8000290e:	59fd                	li	s3,-1
    80002910:	a089                	j	80002952 <wait+0xe0>
    for(np = proc; np < &proc[NPROC]; np++){
    80002912:	18848493          	addi	s1,s1,392
    80002916:	03348463          	beq	s1,s3,8000293e <wait+0xcc>
      if(np->parent == p){
    8000291a:	7c9c                	ld	a5,56(s1)
    8000291c:	ff279be3          	bne	a5,s2,80002912 <wait+0xa0>
        acquire(&np->lock);
    80002920:	8526                	mv	a0,s1
    80002922:	ffffe097          	auipc	ra,0xffffe
    80002926:	40e080e7          	jalr	1038(ra) # 80000d30 <acquire>
        if(np->state == ZOMBIE){
    8000292a:	589c                	lw	a5,48(s1)
    8000292c:	f94787e3          	beq	a5,s4,800028ba <wait+0x48>
        release(&np->lock);
    80002930:	8526                	mv	a0,s1
    80002932:	ffffe097          	auipc	ra,0xffffe
    80002936:	64a080e7          	jalr	1610(ra) # 80000f7c <release>
        havekids = 1;
    8000293a:	8756                	mv	a4,s5
    8000293c:	bfd9                	j	80002912 <wait+0xa0>
    if(!havekids || p->killed){
    8000293e:	c701                	beqz	a4,80002946 <wait+0xd4>
    80002940:	04892783          	lw	a5,72(s2)
    80002944:	c785                	beqz	a5,8000296c <wait+0xfa>
      release(&p->lock);
    80002946:	854a                	mv	a0,s2
    80002948:	ffffe097          	auipc	ra,0xffffe
    8000294c:	634080e7          	jalr	1588(ra) # 80000f7c <release>
      return -1;
    80002950:	59fd                	li	s3,-1
}
    80002952:	854e                	mv	a0,s3
    80002954:	60a6                	ld	ra,72(sp)
    80002956:	6406                	ld	s0,64(sp)
    80002958:	74e2                	ld	s1,56(sp)
    8000295a:	7942                	ld	s2,48(sp)
    8000295c:	79a2                	ld	s3,40(sp)
    8000295e:	7a02                	ld	s4,32(sp)
    80002960:	6ae2                	ld	s5,24(sp)
    80002962:	6b42                	ld	s6,16(sp)
    80002964:	6ba2                	ld	s7,8(sp)
    80002966:	6c02                	ld	s8,0(sp)
    80002968:	6161                	addi	sp,sp,80
    8000296a:	8082                	ret
    sleep(p, &p->lock);  //DOC: wait-sleep
    8000296c:	85e2                	mv	a1,s8
    8000296e:	854a                	mv	a0,s2
    80002970:	00000097          	auipc	ra,0x0
    80002974:	e84080e7          	jalr	-380(ra) # 800027f4 <sleep>
    havekids = 0;
    80002978:	bf1d                	j	800028ae <wait+0x3c>

000000008000297a <wakeup>:
{
    8000297a:	7139                	addi	sp,sp,-64
    8000297c:	fc06                	sd	ra,56(sp)
    8000297e:	f822                	sd	s0,48(sp)
    80002980:	f426                	sd	s1,40(sp)
    80002982:	f04a                	sd	s2,32(sp)
    80002984:	ec4e                	sd	s3,24(sp)
    80002986:	e852                	sd	s4,16(sp)
    80002988:	e456                	sd	s5,8(sp)
    8000298a:	0080                	addi	s0,sp,64
    8000298c:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    8000298e:	00013497          	auipc	s1,0x13
    80002992:	50a48493          	addi	s1,s1,1290 # 80015e98 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    80002996:	4985                	li	s3,1
      p->state = RUNNABLE;
    80002998:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    8000299a:	00019917          	auipc	s2,0x19
    8000299e:	6fe90913          	addi	s2,s2,1790 # 8001c098 <tickslock>
    800029a2:	a821                	j	800029ba <wakeup+0x40>
      p->state = RUNNABLE;
    800029a4:	0354a823          	sw	s5,48(s1)
    release(&p->lock);
    800029a8:	8526                	mv	a0,s1
    800029aa:	ffffe097          	auipc	ra,0xffffe
    800029ae:	5d2080e7          	jalr	1490(ra) # 80000f7c <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800029b2:	18848493          	addi	s1,s1,392
    800029b6:	01248e63          	beq	s1,s2,800029d2 <wakeup+0x58>
    acquire(&p->lock);
    800029ba:	8526                	mv	a0,s1
    800029bc:	ffffe097          	auipc	ra,0xffffe
    800029c0:	374080e7          	jalr	884(ra) # 80000d30 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    800029c4:	589c                	lw	a5,48(s1)
    800029c6:	ff3791e3          	bne	a5,s3,800029a8 <wakeup+0x2e>
    800029ca:	60bc                	ld	a5,64(s1)
    800029cc:	fd479ee3          	bne	a5,s4,800029a8 <wakeup+0x2e>
    800029d0:	bfd1                	j	800029a4 <wakeup+0x2a>
}
    800029d2:	70e2                	ld	ra,56(sp)
    800029d4:	7442                	ld	s0,48(sp)
    800029d6:	74a2                	ld	s1,40(sp)
    800029d8:	7902                	ld	s2,32(sp)
    800029da:	69e2                	ld	s3,24(sp)
    800029dc:	6a42                	ld	s4,16(sp)
    800029de:	6aa2                	ld	s5,8(sp)
    800029e0:	6121                	addi	sp,sp,64
    800029e2:	8082                	ret

00000000800029e4 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800029e4:	7179                	addi	sp,sp,-48
    800029e6:	f406                	sd	ra,40(sp)
    800029e8:	f022                	sd	s0,32(sp)
    800029ea:	ec26                	sd	s1,24(sp)
    800029ec:	e84a                	sd	s2,16(sp)
    800029ee:	e44e                	sd	s3,8(sp)
    800029f0:	1800                	addi	s0,sp,48
    800029f2:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800029f4:	00013497          	auipc	s1,0x13
    800029f8:	4a448493          	addi	s1,s1,1188 # 80015e98 <proc>
    800029fc:	00019997          	auipc	s3,0x19
    80002a00:	69c98993          	addi	s3,s3,1692 # 8001c098 <tickslock>
    acquire(&p->lock);
    80002a04:	8526                	mv	a0,s1
    80002a06:	ffffe097          	auipc	ra,0xffffe
    80002a0a:	32a080e7          	jalr	810(ra) # 80000d30 <acquire>
    if(p->pid == pid){
    80002a0e:	48bc                	lw	a5,80(s1)
    80002a10:	01278d63          	beq	a5,s2,80002a2a <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002a14:	8526                	mv	a0,s1
    80002a16:	ffffe097          	auipc	ra,0xffffe
    80002a1a:	566080e7          	jalr	1382(ra) # 80000f7c <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002a1e:	18848493          	addi	s1,s1,392
    80002a22:	ff3491e3          	bne	s1,s3,80002a04 <kill+0x20>
  }
  return -1;
    80002a26:	557d                	li	a0,-1
    80002a28:	a829                	j	80002a42 <kill+0x5e>
      p->killed = 1;
    80002a2a:	4785                	li	a5,1
    80002a2c:	c4bc                	sw	a5,72(s1)
      if(p->state == SLEEPING){
    80002a2e:	5898                	lw	a4,48(s1)
    80002a30:	4785                	li	a5,1
    80002a32:	00f70f63          	beq	a4,a5,80002a50 <kill+0x6c>
      release(&p->lock);
    80002a36:	8526                	mv	a0,s1
    80002a38:	ffffe097          	auipc	ra,0xffffe
    80002a3c:	544080e7          	jalr	1348(ra) # 80000f7c <release>
      return 0;
    80002a40:	4501                	li	a0,0
}
    80002a42:	70a2                	ld	ra,40(sp)
    80002a44:	7402                	ld	s0,32(sp)
    80002a46:	64e2                	ld	s1,24(sp)
    80002a48:	6942                	ld	s2,16(sp)
    80002a4a:	69a2                	ld	s3,8(sp)
    80002a4c:	6145                	addi	sp,sp,48
    80002a4e:	8082                	ret
        p->state = RUNNABLE;
    80002a50:	4789                	li	a5,2
    80002a52:	d89c                	sw	a5,48(s1)
    80002a54:	b7cd                	j	80002a36 <kill+0x52>

0000000080002a56 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002a56:	7179                	addi	sp,sp,-48
    80002a58:	f406                	sd	ra,40(sp)
    80002a5a:	f022                	sd	s0,32(sp)
    80002a5c:	ec26                	sd	s1,24(sp)
    80002a5e:	e84a                	sd	s2,16(sp)
    80002a60:	e44e                	sd	s3,8(sp)
    80002a62:	e052                	sd	s4,0(sp)
    80002a64:	1800                	addi	s0,sp,48
    80002a66:	84aa                	mv	s1,a0
    80002a68:	892e                	mv	s2,a1
    80002a6a:	89b2                	mv	s3,a2
    80002a6c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002a6e:	fffff097          	auipc	ra,0xfffff
    80002a72:	58c080e7          	jalr	1420(ra) # 80001ffa <myproc>
  if(user_dst){
    80002a76:	c08d                	beqz	s1,80002a98 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80002a78:	86d2                	mv	a3,s4
    80002a7a:	864e                	mv	a2,s3
    80002a7c:	85ca                	mv	a1,s2
    80002a7e:	7528                	ld	a0,104(a0)
    80002a80:	fffff097          	auipc	ra,0xfffff
    80002a84:	224080e7          	jalr	548(ra) # 80001ca4 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80002a88:	70a2                	ld	ra,40(sp)
    80002a8a:	7402                	ld	s0,32(sp)
    80002a8c:	64e2                	ld	s1,24(sp)
    80002a8e:	6942                	ld	s2,16(sp)
    80002a90:	69a2                	ld	s3,8(sp)
    80002a92:	6a02                	ld	s4,0(sp)
    80002a94:	6145                	addi	sp,sp,48
    80002a96:	8082                	ret
    memmove((char *)dst, src, len);
    80002a98:	000a061b          	sext.w	a2,s4
    80002a9c:	85ce                	mv	a1,s3
    80002a9e:	854a                	mv	a0,s2
    80002aa0:	ffffe097          	auipc	ra,0xffffe
    80002aa4:	770080e7          	jalr	1904(ra) # 80001210 <memmove>
    return 0;
    80002aa8:	8526                	mv	a0,s1
    80002aaa:	bff9                	j	80002a88 <either_copyout+0x32>

0000000080002aac <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80002aac:	7179                	addi	sp,sp,-48
    80002aae:	f406                	sd	ra,40(sp)
    80002ab0:	f022                	sd	s0,32(sp)
    80002ab2:	ec26                	sd	s1,24(sp)
    80002ab4:	e84a                	sd	s2,16(sp)
    80002ab6:	e44e                	sd	s3,8(sp)
    80002ab8:	e052                	sd	s4,0(sp)
    80002aba:	1800                	addi	s0,sp,48
    80002abc:	892a                	mv	s2,a0
    80002abe:	84ae                	mv	s1,a1
    80002ac0:	89b2                	mv	s3,a2
    80002ac2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002ac4:	fffff097          	auipc	ra,0xfffff
    80002ac8:	536080e7          	jalr	1334(ra) # 80001ffa <myproc>
  if(user_src){
    80002acc:	c08d                	beqz	s1,80002aee <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002ace:	86d2                	mv	a3,s4
    80002ad0:	864e                	mv	a2,s3
    80002ad2:	85ca                	mv	a1,s2
    80002ad4:	7528                	ld	a0,104(a0)
    80002ad6:	fffff097          	auipc	ra,0xfffff
    80002ada:	25a080e7          	jalr	602(ra) # 80001d30 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002ade:	70a2                	ld	ra,40(sp)
    80002ae0:	7402                	ld	s0,32(sp)
    80002ae2:	64e2                	ld	s1,24(sp)
    80002ae4:	6942                	ld	s2,16(sp)
    80002ae6:	69a2                	ld	s3,8(sp)
    80002ae8:	6a02                	ld	s4,0(sp)
    80002aea:	6145                	addi	sp,sp,48
    80002aec:	8082                	ret
    memmove(dst, (char*)src, len);
    80002aee:	000a061b          	sext.w	a2,s4
    80002af2:	85ce                	mv	a1,s3
    80002af4:	854a                	mv	a0,s2
    80002af6:	ffffe097          	auipc	ra,0xffffe
    80002afa:	71a080e7          	jalr	1818(ra) # 80001210 <memmove>
    return 0;
    80002afe:	8526                	mv	a0,s1
    80002b00:	bff9                	j	80002ade <either_copyin+0x32>

0000000080002b02 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80002b02:	715d                	addi	sp,sp,-80
    80002b04:	e486                	sd	ra,72(sp)
    80002b06:	e0a2                	sd	s0,64(sp)
    80002b08:	fc26                	sd	s1,56(sp)
    80002b0a:	f84a                	sd	s2,48(sp)
    80002b0c:	f44e                	sd	s3,40(sp)
    80002b0e:	f052                	sd	s4,32(sp)
    80002b10:	ec56                	sd	s5,24(sp)
    80002b12:	e85a                	sd	s6,16(sp)
    80002b14:	e45e                	sd	s7,8(sp)
    80002b16:	e062                	sd	s8,0(sp)
    80002b18:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\nPID\tPPID\tPRIO\tSTATE\tCMD\n");
    80002b1a:	00006517          	auipc	a0,0x6
    80002b1e:	b3650513          	addi	a0,a0,-1226 # 80008650 <userret+0x5c0>
    80002b22:	ffffe097          	auipc	ra,0xffffe
    80002b26:	ebc080e7          	jalr	-324(ra) # 800009de <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002b2a:	00013497          	auipc	s1,0x13
    80002b2e:	36e48493          	addi	s1,s1,878 # 80015e98 <proc>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002b32:	4b91                	li	s7,4
      state = states[p->state];
    else
      state = "???";
    80002b34:	00006997          	auipc	s3,0x6
    80002b38:	b1498993          	addi	s3,s3,-1260 # 80008648 <userret+0x5b8>
    printf("%d\t%d\t%d\t%s\t'%s'",
    80002b3c:	5b7d                	li	s6,-1
    80002b3e:	00006a97          	auipc	s5,0x6
    80002b42:	b32a8a93          	addi	s5,s5,-1230 # 80008670 <userret+0x5e0>
           p->parent ? p->parent->pid : -1,
           p->priority,
           state,
           p->cmd
           );
    printf("\n");
    80002b46:	00006a17          	auipc	s4,0x6
    80002b4a:	b22a0a13          	addi	s4,s4,-1246 # 80008668 <userret+0x5d8>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002b4e:	00006c17          	auipc	s8,0x6
    80002b52:	3eac0c13          	addi	s8,s8,1002 # 80008f38 <states.1832>
  for(p = proc; p < &proc[NPROC]; p++){
    80002b56:	00019917          	auipc	s2,0x19
    80002b5a:	54290913          	addi	s2,s2,1346 # 8001c098 <tickslock>
    80002b5e:	a03d                	j	80002b8c <procdump+0x8a>
    printf("%d\t%d\t%d\t%s\t'%s'",
    80002b60:	48ac                	lw	a1,80(s1)
           p->parent ? p->parent->pid : -1,
    80002b62:	7c9c                	ld	a5,56(s1)
    printf("%d\t%d\t%d\t%s\t'%s'",
    80002b64:	865a                	mv	a2,s6
    80002b66:	c391                	beqz	a5,80002b6a <procdump+0x68>
    80002b68:	4bb0                	lw	a2,80(a5)
    80002b6a:	1804b783          	ld	a5,384(s1)
    80002b6e:	48f4                	lw	a3,84(s1)
    80002b70:	8556                	mv	a0,s5
    80002b72:	ffffe097          	auipc	ra,0xffffe
    80002b76:	e6c080e7          	jalr	-404(ra) # 800009de <printf>
    printf("\n");
    80002b7a:	8552                	mv	a0,s4
    80002b7c:	ffffe097          	auipc	ra,0xffffe
    80002b80:	e62080e7          	jalr	-414(ra) # 800009de <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002b84:	18848493          	addi	s1,s1,392
    80002b88:	01248f63          	beq	s1,s2,80002ba6 <procdump+0xa4>
    if(p->state == UNUSED)
    80002b8c:	589c                	lw	a5,48(s1)
    80002b8e:	dbfd                	beqz	a5,80002b84 <procdump+0x82>
      state = "???";
    80002b90:	874e                	mv	a4,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002b92:	fcfbe7e3          	bltu	s7,a5,80002b60 <procdump+0x5e>
    80002b96:	1782                	slli	a5,a5,0x20
    80002b98:	9381                	srli	a5,a5,0x20
    80002b9a:	078e                	slli	a5,a5,0x3
    80002b9c:	97e2                	add	a5,a5,s8
    80002b9e:	6398                	ld	a4,0(a5)
    80002ba0:	f361                	bnez	a4,80002b60 <procdump+0x5e>
      state = "???";
    80002ba2:	874e                	mv	a4,s3
    80002ba4:	bf75                	j	80002b60 <procdump+0x5e>
  }
}
    80002ba6:	60a6                	ld	ra,72(sp)
    80002ba8:	6406                	ld	s0,64(sp)
    80002baa:	74e2                	ld	s1,56(sp)
    80002bac:	7942                	ld	s2,48(sp)
    80002bae:	79a2                	ld	s3,40(sp)
    80002bb0:	7a02                	ld	s4,32(sp)
    80002bb2:	6ae2                	ld	s5,24(sp)
    80002bb4:	6b42                	ld	s6,16(sp)
    80002bb6:	6ba2                	ld	s7,8(sp)
    80002bb8:	6c02                	ld	s8,0(sp)
    80002bba:	6161                	addi	sp,sp,80
    80002bbc:	8082                	ret

0000000080002bbe <priodump>:

// No lock to avoid wedging a stuck machine further.
void priodump(void){
    80002bbe:	715d                	addi	sp,sp,-80
    80002bc0:	e486                	sd	ra,72(sp)
    80002bc2:	e0a2                	sd	s0,64(sp)
    80002bc4:	fc26                	sd	s1,56(sp)
    80002bc6:	f84a                	sd	s2,48(sp)
    80002bc8:	f44e                	sd	s3,40(sp)
    80002bca:	f052                	sd	s4,32(sp)
    80002bcc:	ec56                	sd	s5,24(sp)
    80002bce:	e85a                	sd	s6,16(sp)
    80002bd0:	e45e                	sd	s7,8(sp)
    80002bd2:	0880                	addi	s0,sp,80
  for (int i = 0; i < NPRIO; i++){
    80002bd4:	00013a17          	auipc	s4,0x13
    80002bd8:	e44a0a13          	addi	s4,s4,-444 # 80015a18 <prio>
    80002bdc:	4981                	li	s3,0
    struct list_proc* l = prio[i];
    printf("Priority queue for priority = %d: ", i);
    80002bde:	00006b97          	auipc	s7,0x6
    80002be2:	aaab8b93          	addi	s7,s7,-1366 # 80008688 <userret+0x5f8>
    while(l){
      printf("%d ", l->p->pid);
    80002be6:	00006917          	auipc	s2,0x6
    80002bea:	aca90913          	addi	s2,s2,-1334 # 800086b0 <userret+0x620>
      l = l->next;
    }
    printf("\n");
    80002bee:	00006b17          	auipc	s6,0x6
    80002bf2:	a7ab0b13          	addi	s6,s6,-1414 # 80008668 <userret+0x5d8>
  for (int i = 0; i < NPRIO; i++){
    80002bf6:	4aa9                	li	s5,10
    80002bf8:	a811                	j	80002c0c <priodump+0x4e>
    printf("\n");
    80002bfa:	855a                	mv	a0,s6
    80002bfc:	ffffe097          	auipc	ra,0xffffe
    80002c00:	de2080e7          	jalr	-542(ra) # 800009de <printf>
  for (int i = 0; i < NPRIO; i++){
    80002c04:	2985                	addiw	s3,s3,1
    80002c06:	0a21                	addi	s4,s4,8
    80002c08:	03598563          	beq	s3,s5,80002c32 <priodump+0x74>
    struct list_proc* l = prio[i];
    80002c0c:	000a3483          	ld	s1,0(s4)
    printf("Priority queue for priority = %d: ", i);
    80002c10:	85ce                	mv	a1,s3
    80002c12:	855e                	mv	a0,s7
    80002c14:	ffffe097          	auipc	ra,0xffffe
    80002c18:	dca080e7          	jalr	-566(ra) # 800009de <printf>
    while(l){
    80002c1c:	dcf9                	beqz	s1,80002bfa <priodump+0x3c>
      printf("%d ", l->p->pid);
    80002c1e:	609c                	ld	a5,0(s1)
    80002c20:	4bac                	lw	a1,80(a5)
    80002c22:	854a                	mv	a0,s2
    80002c24:	ffffe097          	auipc	ra,0xffffe
    80002c28:	dba080e7          	jalr	-582(ra) # 800009de <printf>
      l = l->next;
    80002c2c:	6484                	ld	s1,8(s1)
    while(l){
    80002c2e:	f8e5                	bnez	s1,80002c1e <priodump+0x60>
    80002c30:	b7e9                	j	80002bfa <priodump+0x3c>
  }
}
    80002c32:	60a6                	ld	ra,72(sp)
    80002c34:	6406                	ld	s0,64(sp)
    80002c36:	74e2                	ld	s1,56(sp)
    80002c38:	7942                	ld	s2,48(sp)
    80002c3a:	79a2                	ld	s3,40(sp)
    80002c3c:	7a02                	ld	s4,32(sp)
    80002c3e:	6ae2                	ld	s5,24(sp)
    80002c40:	6b42                	ld	s6,16(sp)
    80002c42:	6ba2                	ld	s7,8(sp)
    80002c44:	6161                	addi	sp,sp,80
    80002c46:	8082                	ret

0000000080002c48 <swtch>:
    80002c48:	00153023          	sd	ra,0(a0)
    80002c4c:	00253423          	sd	sp,8(a0)
    80002c50:	e900                	sd	s0,16(a0)
    80002c52:	ed04                	sd	s1,24(a0)
    80002c54:	03253023          	sd	s2,32(a0)
    80002c58:	03353423          	sd	s3,40(a0)
    80002c5c:	03453823          	sd	s4,48(a0)
    80002c60:	03553c23          	sd	s5,56(a0)
    80002c64:	05653023          	sd	s6,64(a0)
    80002c68:	05753423          	sd	s7,72(a0)
    80002c6c:	05853823          	sd	s8,80(a0)
    80002c70:	05953c23          	sd	s9,88(a0)
    80002c74:	07a53023          	sd	s10,96(a0)
    80002c78:	07b53423          	sd	s11,104(a0)
    80002c7c:	0005b083          	ld	ra,0(a1)
    80002c80:	0085b103          	ld	sp,8(a1)
    80002c84:	6980                	ld	s0,16(a1)
    80002c86:	6d84                	ld	s1,24(a1)
    80002c88:	0205b903          	ld	s2,32(a1)
    80002c8c:	0285b983          	ld	s3,40(a1)
    80002c90:	0305ba03          	ld	s4,48(a1)
    80002c94:	0385ba83          	ld	s5,56(a1)
    80002c98:	0405bb03          	ld	s6,64(a1)
    80002c9c:	0485bb83          	ld	s7,72(a1)
    80002ca0:	0505bc03          	ld	s8,80(a1)
    80002ca4:	0585bc83          	ld	s9,88(a1)
    80002ca8:	0605bd03          	ld	s10,96(a1)
    80002cac:	0685bd83          	ld	s11,104(a1)
    80002cb0:	8082                	ret

0000000080002cb2 <scause_desc>:
  }
}

static const char *
scause_desc(uint64 stval)
{
    80002cb2:	1141                	addi	sp,sp,-16
    80002cb4:	e422                	sd	s0,8(sp)
    80002cb6:	0800                	addi	s0,sp,16
    80002cb8:	872a                	mv	a4,a0
    [13] "load page fault",
    [14] "<reserved for future standard use>",
    [15] "store/AMO page fault",
  };
  uint64 interrupt = stval & 0x8000000000000000L;
  uint64 code = stval & ~0x8000000000000000L;
    80002cba:	57fd                	li	a5,-1
    80002cbc:	8385                	srli	a5,a5,0x1
    80002cbe:	8fe9                	and	a5,a5,a0
  if (interrupt) {
    80002cc0:	04054c63          	bltz	a0,80002d18 <scause_desc+0x66>
      return intr_desc[code];
    } else {
      return "<reserved for platform use>";
    }
  } else {
    if (code < NELEM(nointr_desc)) {
    80002cc4:	5685                	li	a3,-31
    80002cc6:	8285                	srli	a3,a3,0x1
    80002cc8:	8ee9                	and	a3,a3,a0
    80002cca:	caad                	beqz	a3,80002d3c <scause_desc+0x8a>
      return nointr_desc[code];
    } else if (code <= 23) {
    80002ccc:	46dd                	li	a3,23
      return "<reserved for future standard use>";
    80002cce:	00006517          	auipc	a0,0x6
    80002cd2:	a1250513          	addi	a0,a0,-1518 # 800086e0 <userret+0x650>
    } else if (code <= 23) {
    80002cd6:	06f6f063          	bleu	a5,a3,80002d36 <scause_desc+0x84>
    } else if (code <= 31) {
    80002cda:	fc100693          	li	a3,-63
    80002cde:	8285                	srli	a3,a3,0x1
    80002ce0:	8ef9                	and	a3,a3,a4
      return "<reserved for custom use>";
    80002ce2:	00006517          	auipc	a0,0x6
    80002ce6:	a2650513          	addi	a0,a0,-1498 # 80008708 <userret+0x678>
    } else if (code <= 31) {
    80002cea:	c6b1                	beqz	a3,80002d36 <scause_desc+0x84>
    } else if (code <= 47) {
    80002cec:	02f00693          	li	a3,47
      return "<reserved for future standard use>";
    80002cf0:	00006517          	auipc	a0,0x6
    80002cf4:	9f050513          	addi	a0,a0,-1552 # 800086e0 <userret+0x650>
    } else if (code <= 47) {
    80002cf8:	02f6ff63          	bleu	a5,a3,80002d36 <scause_desc+0x84>
    } else if (code <= 63) {
    80002cfc:	f8100513          	li	a0,-127
    80002d00:	8105                	srli	a0,a0,0x1
    80002d02:	8f69                	and	a4,a4,a0
      return "<reserved for custom use>";
    80002d04:	00006517          	auipc	a0,0x6
    80002d08:	a0450513          	addi	a0,a0,-1532 # 80008708 <userret+0x678>
    } else if (code <= 63) {
    80002d0c:	c70d                	beqz	a4,80002d36 <scause_desc+0x84>
    } else {
      return "<reserved for future standard use>";
    80002d0e:	00006517          	auipc	a0,0x6
    80002d12:	9d250513          	addi	a0,a0,-1582 # 800086e0 <userret+0x650>
    80002d16:	a005                	j	80002d36 <scause_desc+0x84>
    if (code < NELEM(intr_desc)) {
    80002d18:	5505                	li	a0,-31
    80002d1a:	8105                	srli	a0,a0,0x1
    80002d1c:	8f69                	and	a4,a4,a0
      return "<reserved for platform use>";
    80002d1e:	00006517          	auipc	a0,0x6
    80002d22:	a0a50513          	addi	a0,a0,-1526 # 80008728 <userret+0x698>
    if (code < NELEM(intr_desc)) {
    80002d26:	eb01                	bnez	a4,80002d36 <scause_desc+0x84>
      return intr_desc[code];
    80002d28:	078e                	slli	a5,a5,0x3
    80002d2a:	00006717          	auipc	a4,0x6
    80002d2e:	23670713          	addi	a4,a4,566 # 80008f60 <intr_desc.1651>
    80002d32:	97ba                	add	a5,a5,a4
    80002d34:	6388                	ld	a0,0(a5)
    }
  }
}
    80002d36:	6422                	ld	s0,8(sp)
    80002d38:	0141                	addi	sp,sp,16
    80002d3a:	8082                	ret
      return nointr_desc[code];
    80002d3c:	078e                	slli	a5,a5,0x3
    80002d3e:	00006717          	auipc	a4,0x6
    80002d42:	22270713          	addi	a4,a4,546 # 80008f60 <intr_desc.1651>
    80002d46:	97ba                	add	a5,a5,a4
    80002d48:	63c8                	ld	a0,128(a5)
    80002d4a:	b7f5                	j	80002d36 <scause_desc+0x84>

0000000080002d4c <trapinit>:
{
    80002d4c:	1141                	addi	sp,sp,-16
    80002d4e:	e406                	sd	ra,8(sp)
    80002d50:	e022                	sd	s0,0(sp)
    80002d52:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002d54:	00006597          	auipc	a1,0x6
    80002d58:	9f458593          	addi	a1,a1,-1548 # 80008748 <userret+0x6b8>
    80002d5c:	00019517          	auipc	a0,0x19
    80002d60:	33c50513          	addi	a0,a0,828 # 8001c098 <tickslock>
    80002d64:	ffffe097          	auipc	ra,0xffffe
    80002d68:	e5e080e7          	jalr	-418(ra) # 80000bc2 <initlock>
}
    80002d6c:	60a2                	ld	ra,8(sp)
    80002d6e:	6402                	ld	s0,0(sp)
    80002d70:	0141                	addi	sp,sp,16
    80002d72:	8082                	ret

0000000080002d74 <trapinithart>:
{
    80002d74:	1141                	addi	sp,sp,-16
    80002d76:	e422                	sd	s0,8(sp)
    80002d78:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002d7a:	00003797          	auipc	a5,0x3
    80002d7e:	75678793          	addi	a5,a5,1878 # 800064d0 <kernelvec>
    80002d82:	10579073          	csrw	stvec,a5
}
    80002d86:	6422                	ld	s0,8(sp)
    80002d88:	0141                	addi	sp,sp,16
    80002d8a:	8082                	ret

0000000080002d8c <usertrapret>:
{
    80002d8c:	1141                	addi	sp,sp,-16
    80002d8e:	e406                	sd	ra,8(sp)
    80002d90:	e022                	sd	s0,0(sp)
    80002d92:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80002d94:	fffff097          	auipc	ra,0xfffff
    80002d98:	266080e7          	jalr	614(ra) # 80001ffa <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002d9c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002da0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002da2:	10079073          	csrw	sstatus,a5
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80002da6:	00005617          	auipc	a2,0x5
    80002daa:	25a60613          	addi	a2,a2,602 # 80008000 <trampoline>
    80002dae:	00005697          	auipc	a3,0x5
    80002db2:	25268693          	addi	a3,a3,594 # 80008000 <trampoline>
    80002db6:	8e91                	sub	a3,a3,a2
    80002db8:	040007b7          	lui	a5,0x4000
    80002dbc:	17fd                	addi	a5,a5,-1
    80002dbe:	07b2                	slli	a5,a5,0xc
    80002dc0:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002dc2:	10569073          	csrw	stvec,a3
  p->tf->kernel_satp = r_satp();         // kernel page table
    80002dc6:	7938                	ld	a4,112(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002dc8:	180026f3          	csrr	a3,satp
    80002dcc:	e314                	sd	a3,0(a4)
  p->tf->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002dce:	7938                	ld	a4,112(a0)
    80002dd0:	6d34                	ld	a3,88(a0)
    80002dd2:	6585                	lui	a1,0x1
    80002dd4:	96ae                	add	a3,a3,a1
    80002dd6:	e714                	sd	a3,8(a4)
  p->tf->kernel_trap = (uint64)usertrap;
    80002dd8:	7938                	ld	a4,112(a0)
    80002dda:	00000697          	auipc	a3,0x0
    80002dde:	18468693          	addi	a3,a3,388 # 80002f5e <usertrap>
    80002de2:	eb14                	sd	a3,16(a4)
  p->tf->kernel_hartid = r_tp();         // hartid for cpuid()
    80002de4:	7938                	ld	a4,112(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80002de6:	8692                	mv	a3,tp
    80002de8:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002dea:	100026f3          	csrr	a3,sstatus
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002dee:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002df2:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002df6:	10069073          	csrw	sstatus,a3
  w_sepc(p->tf->epc);
    80002dfa:	7938                	ld	a4,112(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002dfc:	6f18                	ld	a4,24(a4)
    80002dfe:	14171073          	csrw	sepc,a4
  uint64 satp = MAKE_SATP(p->pagetable);
    80002e02:	752c                	ld	a1,104(a0)
    80002e04:	81b1                	srli	a1,a1,0xc
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80002e06:	00005717          	auipc	a4,0x5
    80002e0a:	28a70713          	addi	a4,a4,650 # 80008090 <userret>
    80002e0e:	8f11                	sub	a4,a4,a2
    80002e10:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002e12:	577d                	li	a4,-1
    80002e14:	177e                	slli	a4,a4,0x3f
    80002e16:	8dd9                	or	a1,a1,a4
    80002e18:	02000537          	lui	a0,0x2000
    80002e1c:	157d                	addi	a0,a0,-1
    80002e1e:	0536                	slli	a0,a0,0xd
    80002e20:	9782                	jalr	a5
}
    80002e22:	60a2                	ld	ra,8(sp)
    80002e24:	6402                	ld	s0,0(sp)
    80002e26:	0141                	addi	sp,sp,16
    80002e28:	8082                	ret

0000000080002e2a <clockintr>:
{
    80002e2a:	1141                	addi	sp,sp,-16
    80002e2c:	e406                	sd	ra,8(sp)
    80002e2e:	e022                	sd	s0,0(sp)
    80002e30:	0800                	addi	s0,sp,16
  acquire(&watchdog_lock);
    80002e32:	0002b517          	auipc	a0,0x2b
    80002e36:	1fe50513          	addi	a0,a0,510 # 8002e030 <watchdog_lock>
    80002e3a:	ffffe097          	auipc	ra,0xffffe
    80002e3e:	ef6080e7          	jalr	-266(ra) # 80000d30 <acquire>
  acquire(&tickslock);
    80002e42:	00019517          	auipc	a0,0x19
    80002e46:	25650513          	addi	a0,a0,598 # 8001c098 <tickslock>
    80002e4a:	ffffe097          	auipc	ra,0xffffe
    80002e4e:	ee6080e7          	jalr	-282(ra) # 80000d30 <acquire>
  if (watchdog_time && ticks - watchdog_value > watchdog_time){
    80002e52:	0002b797          	auipc	a5,0x2b
    80002e56:	25278793          	addi	a5,a5,594 # 8002e0a4 <watchdog_time>
    80002e5a:	439c                	lw	a5,0(a5)
    80002e5c:	cf99                	beqz	a5,80002e7a <clockintr+0x50>
    80002e5e:	0002b717          	auipc	a4,0x2b
    80002e62:	22a70713          	addi	a4,a4,554 # 8002e088 <ticks>
    80002e66:	4318                	lw	a4,0(a4)
    80002e68:	0002b697          	auipc	a3,0x2b
    80002e6c:	24068693          	addi	a3,a3,576 # 8002e0a8 <watchdog_value>
    80002e70:	4294                	lw	a3,0(a3)
    80002e72:	9f15                	subw	a4,a4,a3
    80002e74:	2781                	sext.w	a5,a5
    80002e76:	04e7e163          	bltu	a5,a4,80002eb8 <clockintr+0x8e>
  ticks++;
    80002e7a:	0002b517          	auipc	a0,0x2b
    80002e7e:	20e50513          	addi	a0,a0,526 # 8002e088 <ticks>
    80002e82:	411c                	lw	a5,0(a0)
    80002e84:	2785                	addiw	a5,a5,1
    80002e86:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002e88:	00000097          	auipc	ra,0x0
    80002e8c:	af2080e7          	jalr	-1294(ra) # 8000297a <wakeup>
  release(&tickslock);
    80002e90:	00019517          	auipc	a0,0x19
    80002e94:	20850513          	addi	a0,a0,520 # 8001c098 <tickslock>
    80002e98:	ffffe097          	auipc	ra,0xffffe
    80002e9c:	0e4080e7          	jalr	228(ra) # 80000f7c <release>
  release(&watchdog_lock);
    80002ea0:	0002b517          	auipc	a0,0x2b
    80002ea4:	19050513          	addi	a0,a0,400 # 8002e030 <watchdog_lock>
    80002ea8:	ffffe097          	auipc	ra,0xffffe
    80002eac:	0d4080e7          	jalr	212(ra) # 80000f7c <release>
}
    80002eb0:	60a2                	ld	ra,8(sp)
    80002eb2:	6402                	ld	s0,0(sp)
    80002eb4:	0141                	addi	sp,sp,16
    80002eb6:	8082                	ret
    panic("watchdog !!!");
    80002eb8:	00006517          	auipc	a0,0x6
    80002ebc:	89850513          	addi	a0,a0,-1896 # 80008750 <userret+0x6c0>
    80002ec0:	ffffe097          	auipc	ra,0xffffe
    80002ec4:	906080e7          	jalr	-1786(ra) # 800007c6 <panic>

0000000080002ec8 <devintr>:
{
    80002ec8:	1101                	addi	sp,sp,-32
    80002eca:	ec06                	sd	ra,24(sp)
    80002ecc:	e822                	sd	s0,16(sp)
    80002ece:	e426                	sd	s1,8(sp)
    80002ed0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002ed2:	14202773          	csrr	a4,scause
  if((scause & 0x8000000000000000L) &&
    80002ed6:	00074d63          	bltz	a4,80002ef0 <devintr+0x28>
  } else if(scause == 0x8000000000000001L){
    80002eda:	57fd                	li	a5,-1
    80002edc:	17fe                	slli	a5,a5,0x3f
    80002ede:	0785                	addi	a5,a5,1
    return 0;
    80002ee0:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002ee2:	04f70d63          	beq	a4,a5,80002f3c <devintr+0x74>
}
    80002ee6:	60e2                	ld	ra,24(sp)
    80002ee8:	6442                	ld	s0,16(sp)
    80002eea:	64a2                	ld	s1,8(sp)
    80002eec:	6105                	addi	sp,sp,32
    80002eee:	8082                	ret
     (scause & 0xff) == 9){
    80002ef0:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80002ef4:	46a5                	li	a3,9
    80002ef6:	fed792e3          	bne	a5,a3,80002eda <devintr+0x12>
    int irq = plic_claim();
    80002efa:	00003097          	auipc	ra,0x3
    80002efe:	6de080e7          	jalr	1758(ra) # 800065d8 <plic_claim>
    80002f02:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002f04:	47a9                	li	a5,10
    80002f06:	00f50a63          	beq	a0,a5,80002f1a <devintr+0x52>
    } else if(irq == VIRTIO0_IRQ || irq == VIRTIO1_IRQ ){
    80002f0a:	fff5079b          	addiw	a5,a0,-1
    80002f0e:	4705                	li	a4,1
    80002f10:	00f77a63          	bleu	a5,a4,80002f24 <devintr+0x5c>
    return 1;
    80002f14:	4505                	li	a0,1
    if(irq)
    80002f16:	d8e1                	beqz	s1,80002ee6 <devintr+0x1e>
    80002f18:	a819                	j	80002f2e <devintr+0x66>
      uartintr();
    80002f1a:	ffffe097          	auipc	ra,0xffffe
    80002f1e:	c22080e7          	jalr	-990(ra) # 80000b3c <uartintr>
    80002f22:	a031                	j	80002f2e <devintr+0x66>
      virtio_disk_intr(irq - VIRTIO0_IRQ);
    80002f24:	853e                	mv	a0,a5
    80002f26:	00004097          	auipc	ra,0x4
    80002f2a:	ca8080e7          	jalr	-856(ra) # 80006bce <virtio_disk_intr>
      plic_complete(irq);
    80002f2e:	8526                	mv	a0,s1
    80002f30:	00003097          	auipc	ra,0x3
    80002f34:	6cc080e7          	jalr	1740(ra) # 800065fc <plic_complete>
    return 1;
    80002f38:	4505                	li	a0,1
    80002f3a:	b775                	j	80002ee6 <devintr+0x1e>
    if(cpuid() == 0){
    80002f3c:	fffff097          	auipc	ra,0xfffff
    80002f40:	092080e7          	jalr	146(ra) # 80001fce <cpuid>
    80002f44:	c901                	beqz	a0,80002f54 <devintr+0x8c>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002f46:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002f4a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002f4c:	14479073          	csrw	sip,a5
    return 2;
    80002f50:	4509                	li	a0,2
    80002f52:	bf51                	j	80002ee6 <devintr+0x1e>
      clockintr();
    80002f54:	00000097          	auipc	ra,0x0
    80002f58:	ed6080e7          	jalr	-298(ra) # 80002e2a <clockintr>
    80002f5c:	b7ed                	j	80002f46 <devintr+0x7e>

0000000080002f5e <usertrap>:
{
    80002f5e:	7179                	addi	sp,sp,-48
    80002f60:	f406                	sd	ra,40(sp)
    80002f62:	f022                	sd	s0,32(sp)
    80002f64:	ec26                	sd	s1,24(sp)
    80002f66:	e84a                	sd	s2,16(sp)
    80002f68:	e44e                	sd	s3,8(sp)
    80002f6a:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002f6c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002f70:	1007f793          	andi	a5,a5,256
    80002f74:	e3b5                	bnez	a5,80002fd8 <usertrap+0x7a>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002f76:	00003797          	auipc	a5,0x3
    80002f7a:	55a78793          	addi	a5,a5,1370 # 800064d0 <kernelvec>
    80002f7e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002f82:	fffff097          	auipc	ra,0xfffff
    80002f86:	078080e7          	jalr	120(ra) # 80001ffa <myproc>
    80002f8a:	84aa                	mv	s1,a0
  p->tf->epc = r_sepc();
    80002f8c:	793c                	ld	a5,112(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002f8e:	14102773          	csrr	a4,sepc
    80002f92:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002f94:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002f98:	47a1                	li	a5,8
    80002f9a:	04f71d63          	bne	a4,a5,80002ff4 <usertrap+0x96>
    if(p->killed)
    80002f9e:	453c                	lw	a5,72(a0)
    80002fa0:	e7a1                	bnez	a5,80002fe8 <usertrap+0x8a>
    p->tf->epc += 4;
    80002fa2:	78b8                	ld	a4,112(s1)
    80002fa4:	6f1c                	ld	a5,24(a4)
    80002fa6:	0791                	addi	a5,a5,4
    80002fa8:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002faa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002fae:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002fb2:	10079073          	csrw	sstatus,a5
    syscall();
    80002fb6:	00000097          	auipc	ra,0x0
    80002fba:	314080e7          	jalr	788(ra) # 800032ca <syscall>
  if(p->killed)
    80002fbe:	44bc                	lw	a5,72(s1)
    80002fc0:	e3cd                	bnez	a5,80003062 <usertrap+0x104>
  usertrapret();
    80002fc2:	00000097          	auipc	ra,0x0
    80002fc6:	dca080e7          	jalr	-566(ra) # 80002d8c <usertrapret>
}
    80002fca:	70a2                	ld	ra,40(sp)
    80002fcc:	7402                	ld	s0,32(sp)
    80002fce:	64e2                	ld	s1,24(sp)
    80002fd0:	6942                	ld	s2,16(sp)
    80002fd2:	69a2                	ld	s3,8(sp)
    80002fd4:	6145                	addi	sp,sp,48
    80002fd6:	8082                	ret
    panic("usertrap: not from user mode");
    80002fd8:	00005517          	auipc	a0,0x5
    80002fdc:	78850513          	addi	a0,a0,1928 # 80008760 <userret+0x6d0>
    80002fe0:	ffffd097          	auipc	ra,0xffffd
    80002fe4:	7e6080e7          	jalr	2022(ra) # 800007c6 <panic>
      exit(-1);
    80002fe8:	557d                	li	a0,-1
    80002fea:	fffff097          	auipc	ra,0xfffff
    80002fee:	6be080e7          	jalr	1726(ra) # 800026a8 <exit>
    80002ff2:	bf45                	j	80002fa2 <usertrap+0x44>
  } else if((which_dev = devintr()) != 0){
    80002ff4:	00000097          	auipc	ra,0x0
    80002ff8:	ed4080e7          	jalr	-300(ra) # 80002ec8 <devintr>
    80002ffc:	892a                	mv	s2,a0
    80002ffe:	c501                	beqz	a0,80003006 <usertrap+0xa8>
  if(p->killed)
    80003000:	44bc                	lw	a5,72(s1)
    80003002:	cba1                	beqz	a5,80003052 <usertrap+0xf4>
    80003004:	a091                	j	80003048 <usertrap+0xea>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003006:	142029f3          	csrr	s3,scause
    8000300a:	14202573          	csrr	a0,scause
    printf("usertrap(): unexpected scause %p (%s) pid=%d\n", r_scause(), scause_desc(r_scause()), p->pid);
    8000300e:	00000097          	auipc	ra,0x0
    80003012:	ca4080e7          	jalr	-860(ra) # 80002cb2 <scause_desc>
    80003016:	48b4                	lw	a3,80(s1)
    80003018:	862a                	mv	a2,a0
    8000301a:	85ce                	mv	a1,s3
    8000301c:	00005517          	auipc	a0,0x5
    80003020:	76450513          	addi	a0,a0,1892 # 80008780 <userret+0x6f0>
    80003024:	ffffe097          	auipc	ra,0xffffe
    80003028:	9ba080e7          	jalr	-1606(ra) # 800009de <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000302c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003030:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003034:	00005517          	auipc	a0,0x5
    80003038:	77c50513          	addi	a0,a0,1916 # 800087b0 <userret+0x720>
    8000303c:	ffffe097          	auipc	ra,0xffffe
    80003040:	9a2080e7          	jalr	-1630(ra) # 800009de <printf>
    p->killed = 1;
    80003044:	4785                	li	a5,1
    80003046:	c4bc                	sw	a5,72(s1)
    exit(-1);
    80003048:	557d                	li	a0,-1
    8000304a:	fffff097          	auipc	ra,0xfffff
    8000304e:	65e080e7          	jalr	1630(ra) # 800026a8 <exit>
  if(which_dev == 2)
    80003052:	4789                	li	a5,2
    80003054:	f6f917e3          	bne	s2,a5,80002fc2 <usertrap+0x64>
    yield();
    80003058:	fffff097          	auipc	ra,0xfffff
    8000305c:	760080e7          	jalr	1888(ra) # 800027b8 <yield>
    80003060:	b78d                	j	80002fc2 <usertrap+0x64>
  int which_dev = 0;
    80003062:	4901                	li	s2,0
    80003064:	b7d5                	j	80003048 <usertrap+0xea>

0000000080003066 <kerneltrap>:
{
    80003066:	7179                	addi	sp,sp,-48
    80003068:	f406                	sd	ra,40(sp)
    8000306a:	f022                	sd	s0,32(sp)
    8000306c:	ec26                	sd	s1,24(sp)
    8000306e:	e84a                	sd	s2,16(sp)
    80003070:	e44e                	sd	s3,8(sp)
    80003072:	1800                	addi	s0,sp,48
  uartputs("kerneltrap\n");
    80003074:	00005517          	auipc	a0,0x5
    80003078:	75c50513          	addi	a0,a0,1884 # 800087d0 <userret+0x740>
    8000307c:	ffffe097          	auipc	ra,0xffffe
    80003080:	a68080e7          	jalr	-1432(ra) # 80000ae4 <uartputs>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003084:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80003088:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000308c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80003090:	1004f793          	andi	a5,s1,256
    80003094:	cb85                	beqz	a5,800030c4 <kerneltrap+0x5e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80003096:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000309a:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    8000309c:	ef85                	bnez	a5,800030d4 <kerneltrap+0x6e>
  if((which_dev = devintr()) == 0){
    8000309e:	00000097          	auipc	ra,0x0
    800030a2:	e2a080e7          	jalr	-470(ra) # 80002ec8 <devintr>
    800030a6:	cd1d                	beqz	a0,800030e4 <kerneltrap+0x7e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800030a8:	4789                	li	a5,2
    800030aa:	08f50063          	beq	a0,a5,8000312a <kerneltrap+0xc4>
  asm volatile("csrw sepc, %0" : : "r" (x));
    800030ae:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800030b2:	10049073          	csrw	sstatus,s1
}
    800030b6:	70a2                	ld	ra,40(sp)
    800030b8:	7402                	ld	s0,32(sp)
    800030ba:	64e2                	ld	s1,24(sp)
    800030bc:	6942                	ld	s2,16(sp)
    800030be:	69a2                	ld	s3,8(sp)
    800030c0:	6145                	addi	sp,sp,48
    800030c2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800030c4:	00005517          	auipc	a0,0x5
    800030c8:	71c50513          	addi	a0,a0,1820 # 800087e0 <userret+0x750>
    800030cc:	ffffd097          	auipc	ra,0xffffd
    800030d0:	6fa080e7          	jalr	1786(ra) # 800007c6 <panic>
    panic("kerneltrap: interrupts enabled");
    800030d4:	00005517          	auipc	a0,0x5
    800030d8:	73450513          	addi	a0,a0,1844 # 80008808 <userret+0x778>
    800030dc:	ffffd097          	auipc	ra,0xffffd
    800030e0:	6ea080e7          	jalr	1770(ra) # 800007c6 <panic>
    printf("scause %p (%s)\n", scause, scause_desc(scause));
    800030e4:	854e                	mv	a0,s3
    800030e6:	00000097          	auipc	ra,0x0
    800030ea:	bcc080e7          	jalr	-1076(ra) # 80002cb2 <scause_desc>
    800030ee:	862a                	mv	a2,a0
    800030f0:	85ce                	mv	a1,s3
    800030f2:	00005517          	auipc	a0,0x5
    800030f6:	73650513          	addi	a0,a0,1846 # 80008828 <userret+0x798>
    800030fa:	ffffe097          	auipc	ra,0xffffe
    800030fe:	8e4080e7          	jalr	-1820(ra) # 800009de <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003102:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003106:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000310a:	00005517          	auipc	a0,0x5
    8000310e:	72e50513          	addi	a0,a0,1838 # 80008838 <userret+0x7a8>
    80003112:	ffffe097          	auipc	ra,0xffffe
    80003116:	8cc080e7          	jalr	-1844(ra) # 800009de <printf>
    panic("kerneltrap");
    8000311a:	00005517          	auipc	a0,0x5
    8000311e:	73650513          	addi	a0,a0,1846 # 80008850 <userret+0x7c0>
    80003122:	ffffd097          	auipc	ra,0xffffd
    80003126:	6a4080e7          	jalr	1700(ra) # 800007c6 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000312a:	fffff097          	auipc	ra,0xfffff
    8000312e:	ed0080e7          	jalr	-304(ra) # 80001ffa <myproc>
    80003132:	dd35                	beqz	a0,800030ae <kerneltrap+0x48>
    80003134:	fffff097          	auipc	ra,0xfffff
    80003138:	ec6080e7          	jalr	-314(ra) # 80001ffa <myproc>
    8000313c:	5918                	lw	a4,48(a0)
    8000313e:	478d                	li	a5,3
    80003140:	f6f717e3          	bne	a4,a5,800030ae <kerneltrap+0x48>
    yield();
    80003144:	fffff097          	auipc	ra,0xfffff
    80003148:	674080e7          	jalr	1652(ra) # 800027b8 <yield>
    8000314c:	b78d                	j	800030ae <kerneltrap+0x48>

000000008000314e <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    8000314e:	1101                	addi	sp,sp,-32
    80003150:	ec06                	sd	ra,24(sp)
    80003152:	e822                	sd	s0,16(sp)
    80003154:	e426                	sd	s1,8(sp)
    80003156:	1000                	addi	s0,sp,32
    80003158:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000315a:	fffff097          	auipc	ra,0xfffff
    8000315e:	ea0080e7          	jalr	-352(ra) # 80001ffa <myproc>
  switch (n) {
    80003162:	4795                	li	a5,5
    80003164:	0497e363          	bltu	a5,s1,800031aa <argraw+0x5c>
    80003168:	1482                	slli	s1,s1,0x20
    8000316a:	9081                	srli	s1,s1,0x20
    8000316c:	048a                	slli	s1,s1,0x2
    8000316e:	00006717          	auipc	a4,0x6
    80003172:	ef270713          	addi	a4,a4,-270 # 80009060 <nointr_desc.1652+0x80>
    80003176:	94ba                	add	s1,s1,a4
    80003178:	409c                	lw	a5,0(s1)
    8000317a:	97ba                	add	a5,a5,a4
    8000317c:	8782                	jr	a5
  case 0:
    return p->tf->a0;
    8000317e:	793c                	ld	a5,112(a0)
    80003180:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->tf->a5;
  }
  panic("argraw");
  return -1;
}
    80003182:	60e2                	ld	ra,24(sp)
    80003184:	6442                	ld	s0,16(sp)
    80003186:	64a2                	ld	s1,8(sp)
    80003188:	6105                	addi	sp,sp,32
    8000318a:	8082                	ret
    return p->tf->a1;
    8000318c:	793c                	ld	a5,112(a0)
    8000318e:	7fa8                	ld	a0,120(a5)
    80003190:	bfcd                	j	80003182 <argraw+0x34>
    return p->tf->a2;
    80003192:	793c                	ld	a5,112(a0)
    80003194:	63c8                	ld	a0,128(a5)
    80003196:	b7f5                	j	80003182 <argraw+0x34>
    return p->tf->a3;
    80003198:	793c                	ld	a5,112(a0)
    8000319a:	67c8                	ld	a0,136(a5)
    8000319c:	b7dd                	j	80003182 <argraw+0x34>
    return p->tf->a4;
    8000319e:	793c                	ld	a5,112(a0)
    800031a0:	6bc8                	ld	a0,144(a5)
    800031a2:	b7c5                	j	80003182 <argraw+0x34>
    return p->tf->a5;
    800031a4:	793c                	ld	a5,112(a0)
    800031a6:	6fc8                	ld	a0,152(a5)
    800031a8:	bfe9                	j	80003182 <argraw+0x34>
  panic("argraw");
    800031aa:	00006517          	auipc	a0,0x6
    800031ae:	8ae50513          	addi	a0,a0,-1874 # 80008a58 <userret+0x9c8>
    800031b2:	ffffd097          	auipc	ra,0xffffd
    800031b6:	614080e7          	jalr	1556(ra) # 800007c6 <panic>

00000000800031ba <fetchaddr>:
{
    800031ba:	1101                	addi	sp,sp,-32
    800031bc:	ec06                	sd	ra,24(sp)
    800031be:	e822                	sd	s0,16(sp)
    800031c0:	e426                	sd	s1,8(sp)
    800031c2:	e04a                	sd	s2,0(sp)
    800031c4:	1000                	addi	s0,sp,32
    800031c6:	84aa                	mv	s1,a0
    800031c8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800031ca:	fffff097          	auipc	ra,0xfffff
    800031ce:	e30080e7          	jalr	-464(ra) # 80001ffa <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    800031d2:	713c                	ld	a5,96(a0)
    800031d4:	02f4f963          	bleu	a5,s1,80003206 <fetchaddr+0x4c>
    800031d8:	00848713          	addi	a4,s1,8
    800031dc:	02e7e763          	bltu	a5,a4,8000320a <fetchaddr+0x50>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800031e0:	46a1                	li	a3,8
    800031e2:	8626                	mv	a2,s1
    800031e4:	85ca                	mv	a1,s2
    800031e6:	7528                	ld	a0,104(a0)
    800031e8:	fffff097          	auipc	ra,0xfffff
    800031ec:	b48080e7          	jalr	-1208(ra) # 80001d30 <copyin>
    800031f0:	00a03533          	snez	a0,a0
    800031f4:	40a0053b          	negw	a0,a0
    800031f8:	2501                	sext.w	a0,a0
}
    800031fa:	60e2                	ld	ra,24(sp)
    800031fc:	6442                	ld	s0,16(sp)
    800031fe:	64a2                	ld	s1,8(sp)
    80003200:	6902                	ld	s2,0(sp)
    80003202:	6105                	addi	sp,sp,32
    80003204:	8082                	ret
    return -1;
    80003206:	557d                	li	a0,-1
    80003208:	bfcd                	j	800031fa <fetchaddr+0x40>
    8000320a:	557d                	li	a0,-1
    8000320c:	b7fd                	j	800031fa <fetchaddr+0x40>

000000008000320e <fetchstr>:
{
    8000320e:	7179                	addi	sp,sp,-48
    80003210:	f406                	sd	ra,40(sp)
    80003212:	f022                	sd	s0,32(sp)
    80003214:	ec26                	sd	s1,24(sp)
    80003216:	e84a                	sd	s2,16(sp)
    80003218:	e44e                	sd	s3,8(sp)
    8000321a:	1800                	addi	s0,sp,48
    8000321c:	892a                	mv	s2,a0
    8000321e:	84ae                	mv	s1,a1
    80003220:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80003222:	fffff097          	auipc	ra,0xfffff
    80003226:	dd8080e7          	jalr	-552(ra) # 80001ffa <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    8000322a:	86ce                	mv	a3,s3
    8000322c:	864a                	mv	a2,s2
    8000322e:	85a6                	mv	a1,s1
    80003230:	7528                	ld	a0,104(a0)
    80003232:	fffff097          	auipc	ra,0xfffff
    80003236:	b8c080e7          	jalr	-1140(ra) # 80001dbe <copyinstr>
  if(err < 0)
    8000323a:	00054763          	bltz	a0,80003248 <fetchstr+0x3a>
  return strlen(buf);
    8000323e:	8526                	mv	a0,s1
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	10e080e7          	jalr	270(ra) # 8000134e <strlen>
}
    80003248:	70a2                	ld	ra,40(sp)
    8000324a:	7402                	ld	s0,32(sp)
    8000324c:	64e2                	ld	s1,24(sp)
    8000324e:	6942                	ld	s2,16(sp)
    80003250:	69a2                	ld	s3,8(sp)
    80003252:	6145                	addi	sp,sp,48
    80003254:	8082                	ret

0000000080003256 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80003256:	1101                	addi	sp,sp,-32
    80003258:	ec06                	sd	ra,24(sp)
    8000325a:	e822                	sd	s0,16(sp)
    8000325c:	e426                	sd	s1,8(sp)
    8000325e:	1000                	addi	s0,sp,32
    80003260:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80003262:	00000097          	auipc	ra,0x0
    80003266:	eec080e7          	jalr	-276(ra) # 8000314e <argraw>
    8000326a:	c088                	sw	a0,0(s1)
  return 0;
}
    8000326c:	4501                	li	a0,0
    8000326e:	60e2                	ld	ra,24(sp)
    80003270:	6442                	ld	s0,16(sp)
    80003272:	64a2                	ld	s1,8(sp)
    80003274:	6105                	addi	sp,sp,32
    80003276:	8082                	ret

0000000080003278 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80003278:	1101                	addi	sp,sp,-32
    8000327a:	ec06                	sd	ra,24(sp)
    8000327c:	e822                	sd	s0,16(sp)
    8000327e:	e426                	sd	s1,8(sp)
    80003280:	1000                	addi	s0,sp,32
    80003282:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80003284:	00000097          	auipc	ra,0x0
    80003288:	eca080e7          	jalr	-310(ra) # 8000314e <argraw>
    8000328c:	e088                	sd	a0,0(s1)
  return 0;
}
    8000328e:	4501                	li	a0,0
    80003290:	60e2                	ld	ra,24(sp)
    80003292:	6442                	ld	s0,16(sp)
    80003294:	64a2                	ld	s1,8(sp)
    80003296:	6105                	addi	sp,sp,32
    80003298:	8082                	ret

000000008000329a <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000329a:	1101                	addi	sp,sp,-32
    8000329c:	ec06                	sd	ra,24(sp)
    8000329e:	e822                	sd	s0,16(sp)
    800032a0:	e426                	sd	s1,8(sp)
    800032a2:	e04a                	sd	s2,0(sp)
    800032a4:	1000                	addi	s0,sp,32
    800032a6:	84ae                	mv	s1,a1
    800032a8:	8932                	mv	s2,a2
  *ip = argraw(n);
    800032aa:	00000097          	auipc	ra,0x0
    800032ae:	ea4080e7          	jalr	-348(ra) # 8000314e <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    800032b2:	864a                	mv	a2,s2
    800032b4:	85a6                	mv	a1,s1
    800032b6:	00000097          	auipc	ra,0x0
    800032ba:	f58080e7          	jalr	-168(ra) # 8000320e <fetchstr>
}
    800032be:	60e2                	ld	ra,24(sp)
    800032c0:	6442                	ld	s0,16(sp)
    800032c2:	64a2                	ld	s1,8(sp)
    800032c4:	6902                	ld	s2,0(sp)
    800032c6:	6105                	addi	sp,sp,32
    800032c8:	8082                	ret

00000000800032ca <syscall>:
[SYS_release_mutex]  sys_release_mutex,
};

void
syscall(void)
{
    800032ca:	1101                	addi	sp,sp,-32
    800032cc:	ec06                	sd	ra,24(sp)
    800032ce:	e822                	sd	s0,16(sp)
    800032d0:	e426                	sd	s1,8(sp)
    800032d2:	e04a                	sd	s2,0(sp)
    800032d4:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    800032d6:	fffff097          	auipc	ra,0xfffff
    800032da:	d24080e7          	jalr	-732(ra) # 80001ffa <myproc>
    800032de:	84aa                	mv	s1,a0

  num = p->tf->a7;
    800032e0:	07053903          	ld	s2,112(a0)
    800032e4:	0a893783          	ld	a5,168(s2)
    800032e8:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800032ec:	37fd                	addiw	a5,a5,-1
    800032ee:	4765                	li	a4,25
    800032f0:	00f76f63          	bltu	a4,a5,8000330e <syscall+0x44>
    800032f4:	00369713          	slli	a4,a3,0x3
    800032f8:	00006797          	auipc	a5,0x6
    800032fc:	d8078793          	addi	a5,a5,-640 # 80009078 <syscalls>
    80003300:	97ba                	add	a5,a5,a4
    80003302:	639c                	ld	a5,0(a5)
    80003304:	c789                	beqz	a5,8000330e <syscall+0x44>
    p->tf->a0 = syscalls[num]();
    80003306:	9782                	jalr	a5
    80003308:	06a93823          	sd	a0,112(s2)
    8000330c:	a839                	j	8000332a <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    8000330e:	17048613          	addi	a2,s1,368
    80003312:	48ac                	lw	a1,80(s1)
    80003314:	00005517          	auipc	a0,0x5
    80003318:	74c50513          	addi	a0,a0,1868 # 80008a60 <userret+0x9d0>
    8000331c:	ffffd097          	auipc	ra,0xffffd
    80003320:	6c2080e7          	jalr	1730(ra) # 800009de <printf>
            p->pid, p->name, num);
    p->tf->a0 = -1;
    80003324:	78bc                	ld	a5,112(s1)
    80003326:	577d                	li	a4,-1
    80003328:	fbb8                	sd	a4,112(a5)
  }
}
    8000332a:	60e2                	ld	ra,24(sp)
    8000332c:	6442                	ld	s0,16(sp)
    8000332e:	64a2                	ld	s1,8(sp)
    80003330:	6902                	ld	s2,0(sp)
    80003332:	6105                	addi	sp,sp,32
    80003334:	8082                	ret

0000000080003336 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80003336:	1101                	addi	sp,sp,-32
    80003338:	ec06                	sd	ra,24(sp)
    8000333a:	e822                	sd	s0,16(sp)
    8000333c:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8000333e:	fec40593          	addi	a1,s0,-20
    80003342:	4501                	li	a0,0
    80003344:	00000097          	auipc	ra,0x0
    80003348:	f12080e7          	jalr	-238(ra) # 80003256 <argint>
    return -1;
    8000334c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000334e:	00054963          	bltz	a0,80003360 <sys_exit+0x2a>
  exit(n);
    80003352:	fec42503          	lw	a0,-20(s0)
    80003356:	fffff097          	auipc	ra,0xfffff
    8000335a:	352080e7          	jalr	850(ra) # 800026a8 <exit>
  return 0;  // not reached
    8000335e:	4781                	li	a5,0
}
    80003360:	853e                	mv	a0,a5
    80003362:	60e2                	ld	ra,24(sp)
    80003364:	6442                	ld	s0,16(sp)
    80003366:	6105                	addi	sp,sp,32
    80003368:	8082                	ret

000000008000336a <sys_getpid>:

uint64
sys_getpid(void)
{
    8000336a:	1141                	addi	sp,sp,-16
    8000336c:	e406                	sd	ra,8(sp)
    8000336e:	e022                	sd	s0,0(sp)
    80003370:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80003372:	fffff097          	auipc	ra,0xfffff
    80003376:	c88080e7          	jalr	-888(ra) # 80001ffa <myproc>
}
    8000337a:	4928                	lw	a0,80(a0)
    8000337c:	60a2                	ld	ra,8(sp)
    8000337e:	6402                	ld	s0,0(sp)
    80003380:	0141                	addi	sp,sp,16
    80003382:	8082                	ret

0000000080003384 <sys_fork>:

uint64
sys_fork(void)
{
    80003384:	1141                	addi	sp,sp,-16
    80003386:	e406                	sd	ra,8(sp)
    80003388:	e022                	sd	s0,0(sp)
    8000338a:	0800                	addi	s0,sp,16
  return fork();
    8000338c:	fffff097          	auipc	ra,0xfffff
    80003390:	00c080e7          	jalr	12(ra) # 80002398 <fork>
}
    80003394:	60a2                	ld	ra,8(sp)
    80003396:	6402                	ld	s0,0(sp)
    80003398:	0141                	addi	sp,sp,16
    8000339a:	8082                	ret

000000008000339c <sys_wait>:

uint64
sys_wait(void)
{
    8000339c:	1101                	addi	sp,sp,-32
    8000339e:	ec06                	sd	ra,24(sp)
    800033a0:	e822                	sd	s0,16(sp)
    800033a2:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    800033a4:	fe840593          	addi	a1,s0,-24
    800033a8:	4501                	li	a0,0
    800033aa:	00000097          	auipc	ra,0x0
    800033ae:	ece080e7          	jalr	-306(ra) # 80003278 <argaddr>
    return -1;
    800033b2:	57fd                	li	a5,-1
  if(argaddr(0, &p) < 0)
    800033b4:	00054963          	bltz	a0,800033c6 <sys_wait+0x2a>
  return wait(p);
    800033b8:	fe843503          	ld	a0,-24(s0)
    800033bc:	fffff097          	auipc	ra,0xfffff
    800033c0:	4b6080e7          	jalr	1206(ra) # 80002872 <wait>
    800033c4:	87aa                	mv	a5,a0
}
    800033c6:	853e                	mv	a0,a5
    800033c8:	60e2                	ld	ra,24(sp)
    800033ca:	6442                	ld	s0,16(sp)
    800033cc:	6105                	addi	sp,sp,32
    800033ce:	8082                	ret

00000000800033d0 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800033d0:	7179                	addi	sp,sp,-48
    800033d2:	f406                	sd	ra,40(sp)
    800033d4:	f022                	sd	s0,32(sp)
    800033d6:	ec26                	sd	s1,24(sp)
    800033d8:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800033da:	fdc40593          	addi	a1,s0,-36
    800033de:	4501                	li	a0,0
    800033e0:	00000097          	auipc	ra,0x0
    800033e4:	e76080e7          	jalr	-394(ra) # 80003256 <argint>
    return -1;
    800033e8:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    800033ea:	00054f63          	bltz	a0,80003408 <sys_sbrk+0x38>
  addr = myproc()->sz;
    800033ee:	fffff097          	auipc	ra,0xfffff
    800033f2:	c0c080e7          	jalr	-1012(ra) # 80001ffa <myproc>
    800033f6:	5124                	lw	s1,96(a0)
  if(growproc(n) < 0)
    800033f8:	fdc42503          	lw	a0,-36(s0)
    800033fc:	fffff097          	auipc	ra,0xfffff
    80003400:	f24080e7          	jalr	-220(ra) # 80002320 <growproc>
    80003404:	00054863          	bltz	a0,80003414 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    80003408:	8526                	mv	a0,s1
    8000340a:	70a2                	ld	ra,40(sp)
    8000340c:	7402                	ld	s0,32(sp)
    8000340e:	64e2                	ld	s1,24(sp)
    80003410:	6145                	addi	sp,sp,48
    80003412:	8082                	ret
    return -1;
    80003414:	54fd                	li	s1,-1
    80003416:	bfcd                	j	80003408 <sys_sbrk+0x38>

0000000080003418 <sys_sleep>:

uint64
sys_sleep(void)
{
    80003418:	7139                	addi	sp,sp,-64
    8000341a:	fc06                	sd	ra,56(sp)
    8000341c:	f822                	sd	s0,48(sp)
    8000341e:	f426                	sd	s1,40(sp)
    80003420:	f04a                	sd	s2,32(sp)
    80003422:	ec4e                	sd	s3,24(sp)
    80003424:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80003426:	fcc40593          	addi	a1,s0,-52
    8000342a:	4501                	li	a0,0
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	e2a080e7          	jalr	-470(ra) # 80003256 <argint>
    return -1;
    80003434:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80003436:	06054763          	bltz	a0,800034a4 <sys_sleep+0x8c>
  acquire(&tickslock);
    8000343a:	00019517          	auipc	a0,0x19
    8000343e:	c5e50513          	addi	a0,a0,-930 # 8001c098 <tickslock>
    80003442:	ffffe097          	auipc	ra,0xffffe
    80003446:	8ee080e7          	jalr	-1810(ra) # 80000d30 <acquire>
  ticks0 = ticks;
    8000344a:	0002b797          	auipc	a5,0x2b
    8000344e:	c3e78793          	addi	a5,a5,-962 # 8002e088 <ticks>
    80003452:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    80003456:	fcc42783          	lw	a5,-52(s0)
    8000345a:	cf85                	beqz	a5,80003492 <sys_sleep+0x7a>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000345c:	00019997          	auipc	s3,0x19
    80003460:	c3c98993          	addi	s3,s3,-964 # 8001c098 <tickslock>
    80003464:	0002b497          	auipc	s1,0x2b
    80003468:	c2448493          	addi	s1,s1,-988 # 8002e088 <ticks>
    if(myproc()->killed){
    8000346c:	fffff097          	auipc	ra,0xfffff
    80003470:	b8e080e7          	jalr	-1138(ra) # 80001ffa <myproc>
    80003474:	453c                	lw	a5,72(a0)
    80003476:	ef9d                	bnez	a5,800034b4 <sys_sleep+0x9c>
    sleep(&ticks, &tickslock);
    80003478:	85ce                	mv	a1,s3
    8000347a:	8526                	mv	a0,s1
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	378080e7          	jalr	888(ra) # 800027f4 <sleep>
  while(ticks - ticks0 < n){
    80003484:	409c                	lw	a5,0(s1)
    80003486:	412787bb          	subw	a5,a5,s2
    8000348a:	fcc42703          	lw	a4,-52(s0)
    8000348e:	fce7efe3          	bltu	a5,a4,8000346c <sys_sleep+0x54>
  }
  release(&tickslock);
    80003492:	00019517          	auipc	a0,0x19
    80003496:	c0650513          	addi	a0,a0,-1018 # 8001c098 <tickslock>
    8000349a:	ffffe097          	auipc	ra,0xffffe
    8000349e:	ae2080e7          	jalr	-1310(ra) # 80000f7c <release>
  return 0;
    800034a2:	4781                	li	a5,0
}
    800034a4:	853e                	mv	a0,a5
    800034a6:	70e2                	ld	ra,56(sp)
    800034a8:	7442                	ld	s0,48(sp)
    800034aa:	74a2                	ld	s1,40(sp)
    800034ac:	7902                	ld	s2,32(sp)
    800034ae:	69e2                	ld	s3,24(sp)
    800034b0:	6121                	addi	sp,sp,64
    800034b2:	8082                	ret
      release(&tickslock);
    800034b4:	00019517          	auipc	a0,0x19
    800034b8:	be450513          	addi	a0,a0,-1052 # 8001c098 <tickslock>
    800034bc:	ffffe097          	auipc	ra,0xffffe
    800034c0:	ac0080e7          	jalr	-1344(ra) # 80000f7c <release>
      return -1;
    800034c4:	57fd                	li	a5,-1
    800034c6:	bff9                	j	800034a4 <sys_sleep+0x8c>

00000000800034c8 <sys_nice>:

uint64
sys_nice(void){
    800034c8:	1141                	addi	sp,sp,-16
    800034ca:	e422                	sd	s0,8(sp)
    800034cc:	0800                	addi	s0,sp,16
  return 0;
}
    800034ce:	4501                	li	a0,0
    800034d0:	6422                	ld	s0,8(sp)
    800034d2:	0141                	addi	sp,sp,16
    800034d4:	8082                	ret

00000000800034d6 <sys_kill>:

uint64
sys_kill(void)
{
    800034d6:	1101                	addi	sp,sp,-32
    800034d8:	ec06                	sd	ra,24(sp)
    800034da:	e822                	sd	s0,16(sp)
    800034dc:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    800034de:	fec40593          	addi	a1,s0,-20
    800034e2:	4501                	li	a0,0
    800034e4:	00000097          	auipc	ra,0x0
    800034e8:	d72080e7          	jalr	-654(ra) # 80003256 <argint>
    return -1;
    800034ec:	57fd                	li	a5,-1
  if(argint(0, &pid) < 0)
    800034ee:	00054963          	bltz	a0,80003500 <sys_kill+0x2a>
  return kill(pid);
    800034f2:	fec42503          	lw	a0,-20(s0)
    800034f6:	fffff097          	auipc	ra,0xfffff
    800034fa:	4ee080e7          	jalr	1262(ra) # 800029e4 <kill>
    800034fe:	87aa                	mv	a5,a0
}
    80003500:	853e                	mv	a0,a5
    80003502:	60e2                	ld	ra,24(sp)
    80003504:	6442                	ld	s0,16(sp)
    80003506:	6105                	addi	sp,sp,32
    80003508:	8082                	ret

000000008000350a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000350a:	1101                	addi	sp,sp,-32
    8000350c:	ec06                	sd	ra,24(sp)
    8000350e:	e822                	sd	s0,16(sp)
    80003510:	e426                	sd	s1,8(sp)
    80003512:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003514:	00019517          	auipc	a0,0x19
    80003518:	b8450513          	addi	a0,a0,-1148 # 8001c098 <tickslock>
    8000351c:	ffffe097          	auipc	ra,0xffffe
    80003520:	814080e7          	jalr	-2028(ra) # 80000d30 <acquire>
  xticks = ticks;
    80003524:	0002b797          	auipc	a5,0x2b
    80003528:	b6478793          	addi	a5,a5,-1180 # 8002e088 <ticks>
    8000352c:	4384                	lw	s1,0(a5)
  release(&tickslock);
    8000352e:	00019517          	auipc	a0,0x19
    80003532:	b6a50513          	addi	a0,a0,-1174 # 8001c098 <tickslock>
    80003536:	ffffe097          	auipc	ra,0xffffe
    8000353a:	a46080e7          	jalr	-1466(ra) # 80000f7c <release>
  return xticks;
}
    8000353e:	02049513          	slli	a0,s1,0x20
    80003542:	9101                	srli	a0,a0,0x20
    80003544:	60e2                	ld	ra,24(sp)
    80003546:	6442                	ld	s0,16(sp)
    80003548:	64a2                	ld	s1,8(sp)
    8000354a:	6105                	addi	sp,sp,32
    8000354c:	8082                	ret

000000008000354e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000354e:	7179                	addi	sp,sp,-48
    80003550:	f406                	sd	ra,40(sp)
    80003552:	f022                	sd	s0,32(sp)
    80003554:	ec26                	sd	s1,24(sp)
    80003556:	e84a                	sd	s2,16(sp)
    80003558:	e44e                	sd	s3,8(sp)
    8000355a:	e052                	sd	s4,0(sp)
    8000355c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000355e:	00005597          	auipc	a1,0x5
    80003562:	eb258593          	addi	a1,a1,-334 # 80008410 <userret+0x380>
    80003566:	00019517          	auipc	a0,0x19
    8000356a:	b6250513          	addi	a0,a0,-1182 # 8001c0c8 <bcache>
    8000356e:	ffffd097          	auipc	ra,0xffffd
    80003572:	654080e7          	jalr	1620(ra) # 80000bc2 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80003576:	00021797          	auipc	a5,0x21
    8000357a:	b5278793          	addi	a5,a5,-1198 # 800240c8 <bcache+0x8000>
    8000357e:	00021717          	auipc	a4,0x21
    80003582:	09a70713          	addi	a4,a4,154 # 80024618 <bcache+0x8550>
    80003586:	5ae7b823          	sd	a4,1456(a5)
  bcache.head.next = &bcache.head;
    8000358a:	5ae7bc23          	sd	a4,1464(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000358e:	00019497          	auipc	s1,0x19
    80003592:	b6a48493          	addi	s1,s1,-1174 # 8001c0f8 <bcache+0x30>
    b->next = bcache.head.next;
    80003596:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80003598:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000359a:	00005a17          	auipc	s4,0x5
    8000359e:	4e6a0a13          	addi	s4,s4,1254 # 80008a80 <userret+0x9f0>
    b->next = bcache.head.next;
    800035a2:	5b893783          	ld	a5,1464(s2)
    800035a6:	f4bc                	sd	a5,104(s1)
    b->prev = &bcache.head;
    800035a8:	0734b023          	sd	s3,96(s1)
    initsleeplock(&b->lock, "buffer");
    800035ac:	85d2                	mv	a1,s4
    800035ae:	01048513          	addi	a0,s1,16
    800035b2:	00001097          	auipc	ra,0x1
    800035b6:	5ea080e7          	jalr	1514(ra) # 80004b9c <initsleeplock>
    bcache.head.next->prev = b;
    800035ba:	5b893783          	ld	a5,1464(s2)
    800035be:	f3a4                	sd	s1,96(a5)
    bcache.head.next = b;
    800035c0:	5a993c23          	sd	s1,1464(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800035c4:	47048493          	addi	s1,s1,1136
    800035c8:	fd349de3          	bne	s1,s3,800035a2 <binit+0x54>
  }
}
    800035cc:	70a2                	ld	ra,40(sp)
    800035ce:	7402                	ld	s0,32(sp)
    800035d0:	64e2                	ld	s1,24(sp)
    800035d2:	6942                	ld	s2,16(sp)
    800035d4:	69a2                	ld	s3,8(sp)
    800035d6:	6a02                	ld	s4,0(sp)
    800035d8:	6145                	addi	sp,sp,48
    800035da:	8082                	ret

00000000800035dc <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800035dc:	7179                	addi	sp,sp,-48
    800035de:	f406                	sd	ra,40(sp)
    800035e0:	f022                	sd	s0,32(sp)
    800035e2:	ec26                	sd	s1,24(sp)
    800035e4:	e84a                	sd	s2,16(sp)
    800035e6:	e44e                	sd	s3,8(sp)
    800035e8:	1800                	addi	s0,sp,48
    800035ea:	89aa                	mv	s3,a0
    800035ec:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800035ee:	00019517          	auipc	a0,0x19
    800035f2:	ada50513          	addi	a0,a0,-1318 # 8001c0c8 <bcache>
    800035f6:	ffffd097          	auipc	ra,0xffffd
    800035fa:	73a080e7          	jalr	1850(ra) # 80000d30 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800035fe:	00021797          	auipc	a5,0x21
    80003602:	aca78793          	addi	a5,a5,-1334 # 800240c8 <bcache+0x8000>
    80003606:	5b87b483          	ld	s1,1464(a5)
    8000360a:	00021797          	auipc	a5,0x21
    8000360e:	00e78793          	addi	a5,a5,14 # 80024618 <bcache+0x8550>
    80003612:	02f48f63          	beq	s1,a5,80003650 <bread+0x74>
    80003616:	873e                	mv	a4,a5
    80003618:	a021                	j	80003620 <bread+0x44>
    8000361a:	74a4                	ld	s1,104(s1)
    8000361c:	02e48a63          	beq	s1,a4,80003650 <bread+0x74>
    if(b->dev == dev && b->blockno == blockno){
    80003620:	449c                	lw	a5,8(s1)
    80003622:	ff379ce3          	bne	a5,s3,8000361a <bread+0x3e>
    80003626:	44dc                	lw	a5,12(s1)
    80003628:	ff2799e3          	bne	a5,s2,8000361a <bread+0x3e>
      b->refcnt++;
    8000362c:	4cbc                	lw	a5,88(s1)
    8000362e:	2785                	addiw	a5,a5,1
    80003630:	ccbc                	sw	a5,88(s1)
      release(&bcache.lock);
    80003632:	00019517          	auipc	a0,0x19
    80003636:	a9650513          	addi	a0,a0,-1386 # 8001c0c8 <bcache>
    8000363a:	ffffe097          	auipc	ra,0xffffe
    8000363e:	942080e7          	jalr	-1726(ra) # 80000f7c <release>
      acquiresleep(&b->lock);
    80003642:	01048513          	addi	a0,s1,16
    80003646:	00001097          	auipc	ra,0x1
    8000364a:	590080e7          	jalr	1424(ra) # 80004bd6 <acquiresleep>
      return b;
    8000364e:	a8b1                	j	800036aa <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003650:	00021797          	auipc	a5,0x21
    80003654:	a7878793          	addi	a5,a5,-1416 # 800240c8 <bcache+0x8000>
    80003658:	5b07b483          	ld	s1,1456(a5)
    8000365c:	00021797          	auipc	a5,0x21
    80003660:	fbc78793          	addi	a5,a5,-68 # 80024618 <bcache+0x8550>
    80003664:	04f48d63          	beq	s1,a5,800036be <bread+0xe2>
    if(b->refcnt == 0) {
    80003668:	4cbc                	lw	a5,88(s1)
    8000366a:	cb91                	beqz	a5,8000367e <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000366c:	00021717          	auipc	a4,0x21
    80003670:	fac70713          	addi	a4,a4,-84 # 80024618 <bcache+0x8550>
    80003674:	70a4                	ld	s1,96(s1)
    80003676:	04e48463          	beq	s1,a4,800036be <bread+0xe2>
    if(b->refcnt == 0) {
    8000367a:	4cbc                	lw	a5,88(s1)
    8000367c:	ffe5                	bnez	a5,80003674 <bread+0x98>
      b->dev = dev;
    8000367e:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    80003682:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80003686:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8000368a:	4785                	li	a5,1
    8000368c:	ccbc                	sw	a5,88(s1)
      release(&bcache.lock);
    8000368e:	00019517          	auipc	a0,0x19
    80003692:	a3a50513          	addi	a0,a0,-1478 # 8001c0c8 <bcache>
    80003696:	ffffe097          	auipc	ra,0xffffe
    8000369a:	8e6080e7          	jalr	-1818(ra) # 80000f7c <release>
      acquiresleep(&b->lock);
    8000369e:	01048513          	addi	a0,s1,16
    800036a2:	00001097          	auipc	ra,0x1
    800036a6:	534080e7          	jalr	1332(ra) # 80004bd6 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800036aa:	409c                	lw	a5,0(s1)
    800036ac:	c38d                	beqz	a5,800036ce <bread+0xf2>
    virtio_disk_rw(b->dev, b, 0);
    b->valid = 1;
  }
  return b;
}
    800036ae:	8526                	mv	a0,s1
    800036b0:	70a2                	ld	ra,40(sp)
    800036b2:	7402                	ld	s0,32(sp)
    800036b4:	64e2                	ld	s1,24(sp)
    800036b6:	6942                	ld	s2,16(sp)
    800036b8:	69a2                	ld	s3,8(sp)
    800036ba:	6145                	addi	sp,sp,48
    800036bc:	8082                	ret
  panic("bget: no buffers");
    800036be:	00005517          	auipc	a0,0x5
    800036c2:	3ca50513          	addi	a0,a0,970 # 80008a88 <userret+0x9f8>
    800036c6:	ffffd097          	auipc	ra,0xffffd
    800036ca:	100080e7          	jalr	256(ra) # 800007c6 <panic>
    virtio_disk_rw(b->dev, b, 0);
    800036ce:	4601                	li	a2,0
    800036d0:	85a6                	mv	a1,s1
    800036d2:	4488                	lw	a0,8(s1)
    800036d4:	00003097          	auipc	ra,0x3
    800036d8:	1d6080e7          	jalr	470(ra) # 800068aa <virtio_disk_rw>
    b->valid = 1;
    800036dc:	4785                	li	a5,1
    800036de:	c09c                	sw	a5,0(s1)
  return b;
    800036e0:	b7f9                	j	800036ae <bread+0xd2>

00000000800036e2 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800036e2:	1101                	addi	sp,sp,-32
    800036e4:	ec06                	sd	ra,24(sp)
    800036e6:	e822                	sd	s0,16(sp)
    800036e8:	e426                	sd	s1,8(sp)
    800036ea:	1000                	addi	s0,sp,32
    800036ec:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800036ee:	0541                	addi	a0,a0,16
    800036f0:	00001097          	auipc	ra,0x1
    800036f4:	580080e7          	jalr	1408(ra) # 80004c70 <holdingsleep>
    800036f8:	cd09                	beqz	a0,80003712 <bwrite+0x30>
    panic("bwrite");
  virtio_disk_rw(b->dev, b, 1);
    800036fa:	4605                	li	a2,1
    800036fc:	85a6                	mv	a1,s1
    800036fe:	4488                	lw	a0,8(s1)
    80003700:	00003097          	auipc	ra,0x3
    80003704:	1aa080e7          	jalr	426(ra) # 800068aa <virtio_disk_rw>
}
    80003708:	60e2                	ld	ra,24(sp)
    8000370a:	6442                	ld	s0,16(sp)
    8000370c:	64a2                	ld	s1,8(sp)
    8000370e:	6105                	addi	sp,sp,32
    80003710:	8082                	ret
    panic("bwrite");
    80003712:	00005517          	auipc	a0,0x5
    80003716:	38e50513          	addi	a0,a0,910 # 80008aa0 <userret+0xa10>
    8000371a:	ffffd097          	auipc	ra,0xffffd
    8000371e:	0ac080e7          	jalr	172(ra) # 800007c6 <panic>

0000000080003722 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
    80003722:	1101                	addi	sp,sp,-32
    80003724:	ec06                	sd	ra,24(sp)
    80003726:	e822                	sd	s0,16(sp)
    80003728:	e426                	sd	s1,8(sp)
    8000372a:	e04a                	sd	s2,0(sp)
    8000372c:	1000                	addi	s0,sp,32
    8000372e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003730:	01050913          	addi	s2,a0,16
    80003734:	854a                	mv	a0,s2
    80003736:	00001097          	auipc	ra,0x1
    8000373a:	53a080e7          	jalr	1338(ra) # 80004c70 <holdingsleep>
    8000373e:	c92d                	beqz	a0,800037b0 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80003740:	854a                	mv	a0,s2
    80003742:	00001097          	auipc	ra,0x1
    80003746:	4ea080e7          	jalr	1258(ra) # 80004c2c <releasesleep>

  acquire(&bcache.lock);
    8000374a:	00019517          	auipc	a0,0x19
    8000374e:	97e50513          	addi	a0,a0,-1666 # 8001c0c8 <bcache>
    80003752:	ffffd097          	auipc	ra,0xffffd
    80003756:	5de080e7          	jalr	1502(ra) # 80000d30 <acquire>
  b->refcnt--;
    8000375a:	4cbc                	lw	a5,88(s1)
    8000375c:	37fd                	addiw	a5,a5,-1
    8000375e:	0007871b          	sext.w	a4,a5
    80003762:	ccbc                	sw	a5,88(s1)
  if (b->refcnt == 0) {
    80003764:	eb05                	bnez	a4,80003794 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003766:	74bc                	ld	a5,104(s1)
    80003768:	70b8                	ld	a4,96(s1)
    8000376a:	f3b8                	sd	a4,96(a5)
    b->prev->next = b->next;
    8000376c:	70bc                	ld	a5,96(s1)
    8000376e:	74b8                	ld	a4,104(s1)
    80003770:	f7b8                	sd	a4,104(a5)
    b->next = bcache.head.next;
    80003772:	00021797          	auipc	a5,0x21
    80003776:	95678793          	addi	a5,a5,-1706 # 800240c8 <bcache+0x8000>
    8000377a:	5b87b703          	ld	a4,1464(a5)
    8000377e:	f4b8                	sd	a4,104(s1)
    b->prev = &bcache.head;
    80003780:	00021717          	auipc	a4,0x21
    80003784:	e9870713          	addi	a4,a4,-360 # 80024618 <bcache+0x8550>
    80003788:	f0b8                	sd	a4,96(s1)
    bcache.head.next->prev = b;
    8000378a:	5b87b703          	ld	a4,1464(a5)
    8000378e:	f324                	sd	s1,96(a4)
    bcache.head.next = b;
    80003790:	5a97bc23          	sd	s1,1464(a5)
  }
  
  release(&bcache.lock);
    80003794:	00019517          	auipc	a0,0x19
    80003798:	93450513          	addi	a0,a0,-1740 # 8001c0c8 <bcache>
    8000379c:	ffffd097          	auipc	ra,0xffffd
    800037a0:	7e0080e7          	jalr	2016(ra) # 80000f7c <release>
}
    800037a4:	60e2                	ld	ra,24(sp)
    800037a6:	6442                	ld	s0,16(sp)
    800037a8:	64a2                	ld	s1,8(sp)
    800037aa:	6902                	ld	s2,0(sp)
    800037ac:	6105                	addi	sp,sp,32
    800037ae:	8082                	ret
    panic("brelse");
    800037b0:	00005517          	auipc	a0,0x5
    800037b4:	2f850513          	addi	a0,a0,760 # 80008aa8 <userret+0xa18>
    800037b8:	ffffd097          	auipc	ra,0xffffd
    800037bc:	00e080e7          	jalr	14(ra) # 800007c6 <panic>

00000000800037c0 <bpin>:

void
bpin(struct buf *b) {
    800037c0:	1101                	addi	sp,sp,-32
    800037c2:	ec06                	sd	ra,24(sp)
    800037c4:	e822                	sd	s0,16(sp)
    800037c6:	e426                	sd	s1,8(sp)
    800037c8:	1000                	addi	s0,sp,32
    800037ca:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800037cc:	00019517          	auipc	a0,0x19
    800037d0:	8fc50513          	addi	a0,a0,-1796 # 8001c0c8 <bcache>
    800037d4:	ffffd097          	auipc	ra,0xffffd
    800037d8:	55c080e7          	jalr	1372(ra) # 80000d30 <acquire>
  b->refcnt++;
    800037dc:	4cbc                	lw	a5,88(s1)
    800037de:	2785                	addiw	a5,a5,1
    800037e0:	ccbc                	sw	a5,88(s1)
  release(&bcache.lock);
    800037e2:	00019517          	auipc	a0,0x19
    800037e6:	8e650513          	addi	a0,a0,-1818 # 8001c0c8 <bcache>
    800037ea:	ffffd097          	auipc	ra,0xffffd
    800037ee:	792080e7          	jalr	1938(ra) # 80000f7c <release>
}
    800037f2:	60e2                	ld	ra,24(sp)
    800037f4:	6442                	ld	s0,16(sp)
    800037f6:	64a2                	ld	s1,8(sp)
    800037f8:	6105                	addi	sp,sp,32
    800037fa:	8082                	ret

00000000800037fc <bunpin>:

void
bunpin(struct buf *b) {
    800037fc:	1101                	addi	sp,sp,-32
    800037fe:	ec06                	sd	ra,24(sp)
    80003800:	e822                	sd	s0,16(sp)
    80003802:	e426                	sd	s1,8(sp)
    80003804:	1000                	addi	s0,sp,32
    80003806:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003808:	00019517          	auipc	a0,0x19
    8000380c:	8c050513          	addi	a0,a0,-1856 # 8001c0c8 <bcache>
    80003810:	ffffd097          	auipc	ra,0xffffd
    80003814:	520080e7          	jalr	1312(ra) # 80000d30 <acquire>
  b->refcnt--;
    80003818:	4cbc                	lw	a5,88(s1)
    8000381a:	37fd                	addiw	a5,a5,-1
    8000381c:	ccbc                	sw	a5,88(s1)
  release(&bcache.lock);
    8000381e:	00019517          	auipc	a0,0x19
    80003822:	8aa50513          	addi	a0,a0,-1878 # 8001c0c8 <bcache>
    80003826:	ffffd097          	auipc	ra,0xffffd
    8000382a:	756080e7          	jalr	1878(ra) # 80000f7c <release>
}
    8000382e:	60e2                	ld	ra,24(sp)
    80003830:	6442                	ld	s0,16(sp)
    80003832:	64a2                	ld	s1,8(sp)
    80003834:	6105                	addi	sp,sp,32
    80003836:	8082                	ret

0000000080003838 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003838:	1101                	addi	sp,sp,-32
    8000383a:	ec06                	sd	ra,24(sp)
    8000383c:	e822                	sd	s0,16(sp)
    8000383e:	e426                	sd	s1,8(sp)
    80003840:	e04a                	sd	s2,0(sp)
    80003842:	1000                	addi	s0,sp,32
    80003844:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003846:	00d5d59b          	srliw	a1,a1,0xd
    8000384a:	00021797          	auipc	a5,0x21
    8000384e:	23e78793          	addi	a5,a5,574 # 80024a88 <sb>
    80003852:	4fdc                	lw	a5,28(a5)
    80003854:	9dbd                	addw	a1,a1,a5
    80003856:	00000097          	auipc	ra,0x0
    8000385a:	d86080e7          	jalr	-634(ra) # 800035dc <bread>
  bi = b % BPB;
    8000385e:	2481                	sext.w	s1,s1
  m = 1 << (bi % 8);
    80003860:	0074f793          	andi	a5,s1,7
    80003864:	4705                	li	a4,1
    80003866:	00f7173b          	sllw	a4,a4,a5
  bi = b % BPB;
    8000386a:	6789                	lui	a5,0x2
    8000386c:	17fd                	addi	a5,a5,-1
    8000386e:	8cfd                	and	s1,s1,a5
  if((bp->data[bi/8] & m) == 0)
    80003870:	41f4d79b          	sraiw	a5,s1,0x1f
    80003874:	01d7d79b          	srliw	a5,a5,0x1d
    80003878:	9fa5                	addw	a5,a5,s1
    8000387a:	4037d79b          	sraiw	a5,a5,0x3
    8000387e:	00f506b3          	add	a3,a0,a5
    80003882:	0706c683          	lbu	a3,112(a3)
    80003886:	00d77633          	and	a2,a4,a3
    8000388a:	c61d                	beqz	a2,800038b8 <bfree+0x80>
    8000388c:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    8000388e:	97aa                	add	a5,a5,a0
    80003890:	fff74713          	not	a4,a4
    80003894:	8f75                	and	a4,a4,a3
    80003896:	06e78823          	sb	a4,112(a5) # 2070 <_entry-0x7fffdf90>
  log_write(bp);
    8000389a:	00001097          	auipc	ra,0x1
    8000389e:	1b2080e7          	jalr	434(ra) # 80004a4c <log_write>
  brelse(bp);
    800038a2:	854a                	mv	a0,s2
    800038a4:	00000097          	auipc	ra,0x0
    800038a8:	e7e080e7          	jalr	-386(ra) # 80003722 <brelse>
}
    800038ac:	60e2                	ld	ra,24(sp)
    800038ae:	6442                	ld	s0,16(sp)
    800038b0:	64a2                	ld	s1,8(sp)
    800038b2:	6902                	ld	s2,0(sp)
    800038b4:	6105                	addi	sp,sp,32
    800038b6:	8082                	ret
    panic("freeing free block");
    800038b8:	00005517          	auipc	a0,0x5
    800038bc:	1f850513          	addi	a0,a0,504 # 80008ab0 <userret+0xa20>
    800038c0:	ffffd097          	auipc	ra,0xffffd
    800038c4:	f06080e7          	jalr	-250(ra) # 800007c6 <panic>

00000000800038c8 <balloc>:
{
    800038c8:	711d                	addi	sp,sp,-96
    800038ca:	ec86                	sd	ra,88(sp)
    800038cc:	e8a2                	sd	s0,80(sp)
    800038ce:	e4a6                	sd	s1,72(sp)
    800038d0:	e0ca                	sd	s2,64(sp)
    800038d2:	fc4e                	sd	s3,56(sp)
    800038d4:	f852                	sd	s4,48(sp)
    800038d6:	f456                	sd	s5,40(sp)
    800038d8:	f05a                	sd	s6,32(sp)
    800038da:	ec5e                	sd	s7,24(sp)
    800038dc:	e862                	sd	s8,16(sp)
    800038de:	e466                	sd	s9,8(sp)
    800038e0:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800038e2:	00021797          	auipc	a5,0x21
    800038e6:	1a678793          	addi	a5,a5,422 # 80024a88 <sb>
    800038ea:	43dc                	lw	a5,4(a5)
    800038ec:	10078e63          	beqz	a5,80003a08 <balloc+0x140>
    800038f0:	8baa                	mv	s7,a0
    800038f2:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800038f4:	00021b17          	auipc	s6,0x21
    800038f8:	194b0b13          	addi	s6,s6,404 # 80024a88 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800038fc:	4c05                	li	s8,1
      m = 1 << (bi % 8);
    800038fe:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003900:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003902:	6c89                	lui	s9,0x2
    80003904:	a079                	j	80003992 <balloc+0xca>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003906:	8942                	mv	s2,a6
      m = 1 << (bi % 8);
    80003908:	4705                	li	a4,1
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000390a:	4681                	li	a3,0
        bp->data[bi/8] |= m;  // Mark block in use.
    8000390c:	96a6                	add	a3,a3,s1
    8000390e:	8f51                	or	a4,a4,a2
    80003910:	06e68823          	sb	a4,112(a3)
        log_write(bp);
    80003914:	8526                	mv	a0,s1
    80003916:	00001097          	auipc	ra,0x1
    8000391a:	136080e7          	jalr	310(ra) # 80004a4c <log_write>
        brelse(bp);
    8000391e:	8526                	mv	a0,s1
    80003920:	00000097          	auipc	ra,0x0
    80003924:	e02080e7          	jalr	-510(ra) # 80003722 <brelse>
  bp = bread(dev, bno);
    80003928:	85ca                	mv	a1,s2
    8000392a:	855e                	mv	a0,s7
    8000392c:	00000097          	auipc	ra,0x0
    80003930:	cb0080e7          	jalr	-848(ra) # 800035dc <bread>
    80003934:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    80003936:	40000613          	li	a2,1024
    8000393a:	4581                	li	a1,0
    8000393c:	07050513          	addi	a0,a0,112
    80003940:	ffffe097          	auipc	ra,0xffffe
    80003944:	864080e7          	jalr	-1948(ra) # 800011a4 <memset>
  log_write(bp);
    80003948:	8526                	mv	a0,s1
    8000394a:	00001097          	auipc	ra,0x1
    8000394e:	102080e7          	jalr	258(ra) # 80004a4c <log_write>
  brelse(bp);
    80003952:	8526                	mv	a0,s1
    80003954:	00000097          	auipc	ra,0x0
    80003958:	dce080e7          	jalr	-562(ra) # 80003722 <brelse>
}
    8000395c:	854a                	mv	a0,s2
    8000395e:	60e6                	ld	ra,88(sp)
    80003960:	6446                	ld	s0,80(sp)
    80003962:	64a6                	ld	s1,72(sp)
    80003964:	6906                	ld	s2,64(sp)
    80003966:	79e2                	ld	s3,56(sp)
    80003968:	7a42                	ld	s4,48(sp)
    8000396a:	7aa2                	ld	s5,40(sp)
    8000396c:	7b02                	ld	s6,32(sp)
    8000396e:	6be2                	ld	s7,24(sp)
    80003970:	6c42                	ld	s8,16(sp)
    80003972:	6ca2                	ld	s9,8(sp)
    80003974:	6125                	addi	sp,sp,96
    80003976:	8082                	ret
    brelse(bp);
    80003978:	8526                	mv	a0,s1
    8000397a:	00000097          	auipc	ra,0x0
    8000397e:	da8080e7          	jalr	-600(ra) # 80003722 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80003982:	015c87bb          	addw	a5,s9,s5
    80003986:	00078a9b          	sext.w	s5,a5
    8000398a:	004b2703          	lw	a4,4(s6)
    8000398e:	06eafd63          	bleu	a4,s5,80003a08 <balloc+0x140>
    bp = bread(dev, BBLOCK(b, sb));
    80003992:	41fad79b          	sraiw	a5,s5,0x1f
    80003996:	0137d79b          	srliw	a5,a5,0x13
    8000399a:	015787bb          	addw	a5,a5,s5
    8000399e:	40d7d79b          	sraiw	a5,a5,0xd
    800039a2:	01cb2583          	lw	a1,28(s6)
    800039a6:	9dbd                	addw	a1,a1,a5
    800039a8:	855e                	mv	a0,s7
    800039aa:	00000097          	auipc	ra,0x0
    800039ae:	c32080e7          	jalr	-974(ra) # 800035dc <bread>
    800039b2:	84aa                	mv	s1,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800039b4:	000a881b          	sext.w	a6,s5
    800039b8:	004b2503          	lw	a0,4(s6)
    800039bc:	faa87ee3          	bleu	a0,a6,80003978 <balloc+0xb0>
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800039c0:	0704c603          	lbu	a2,112(s1)
    800039c4:	00167793          	andi	a5,a2,1
    800039c8:	df9d                	beqz	a5,80003906 <balloc+0x3e>
    800039ca:	4105053b          	subw	a0,a0,a6
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800039ce:	87e2                	mv	a5,s8
    800039d0:	0107893b          	addw	s2,a5,a6
    800039d4:	faa782e3          	beq	a5,a0,80003978 <balloc+0xb0>
      m = 1 << (bi % 8);
    800039d8:	41f7d71b          	sraiw	a4,a5,0x1f
    800039dc:	01d7561b          	srliw	a2,a4,0x1d
    800039e0:	00f606bb          	addw	a3,a2,a5
    800039e4:	0076f713          	andi	a4,a3,7
    800039e8:	9f11                	subw	a4,a4,a2
    800039ea:	00e9973b          	sllw	a4,s3,a4
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800039ee:	4036d69b          	sraiw	a3,a3,0x3
    800039f2:	00d48633          	add	a2,s1,a3
    800039f6:	07064603          	lbu	a2,112(a2)
    800039fa:	00c775b3          	and	a1,a4,a2
    800039fe:	d599                	beqz	a1,8000390c <balloc+0x44>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003a00:	2785                	addiw	a5,a5,1
    80003a02:	fd4797e3          	bne	a5,s4,800039d0 <balloc+0x108>
    80003a06:	bf8d                	j	80003978 <balloc+0xb0>
  panic("balloc: out of blocks");
    80003a08:	00005517          	auipc	a0,0x5
    80003a0c:	0c050513          	addi	a0,a0,192 # 80008ac8 <userret+0xa38>
    80003a10:	ffffd097          	auipc	ra,0xffffd
    80003a14:	db6080e7          	jalr	-586(ra) # 800007c6 <panic>

0000000080003a18 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80003a18:	7179                	addi	sp,sp,-48
    80003a1a:	f406                	sd	ra,40(sp)
    80003a1c:	f022                	sd	s0,32(sp)
    80003a1e:	ec26                	sd	s1,24(sp)
    80003a20:	e84a                	sd	s2,16(sp)
    80003a22:	e44e                	sd	s3,8(sp)
    80003a24:	e052                	sd	s4,0(sp)
    80003a26:	1800                	addi	s0,sp,48
    80003a28:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003a2a:	47ad                	li	a5,11
    80003a2c:	04b7fe63          	bleu	a1,a5,80003a88 <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80003a30:	ff45849b          	addiw	s1,a1,-12
    80003a34:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80003a38:	0ff00793          	li	a5,255
    80003a3c:	0ae7e363          	bltu	a5,a4,80003ae2 <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80003a40:	09852583          	lw	a1,152(a0)
    80003a44:	c5ad                	beqz	a1,80003aae <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80003a46:	0009a503          	lw	a0,0(s3)
    80003a4a:	00000097          	auipc	ra,0x0
    80003a4e:	b92080e7          	jalr	-1134(ra) # 800035dc <bread>
    80003a52:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80003a54:	07050793          	addi	a5,a0,112
    if((addr = a[bn]) == 0){
    80003a58:	02049593          	slli	a1,s1,0x20
    80003a5c:	9181                	srli	a1,a1,0x20
    80003a5e:	058a                	slli	a1,a1,0x2
    80003a60:	00b784b3          	add	s1,a5,a1
    80003a64:	0004a903          	lw	s2,0(s1)
    80003a68:	04090d63          	beqz	s2,80003ac2 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80003a6c:	8552                	mv	a0,s4
    80003a6e:	00000097          	auipc	ra,0x0
    80003a72:	cb4080e7          	jalr	-844(ra) # 80003722 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80003a76:	854a                	mv	a0,s2
    80003a78:	70a2                	ld	ra,40(sp)
    80003a7a:	7402                	ld	s0,32(sp)
    80003a7c:	64e2                	ld	s1,24(sp)
    80003a7e:	6942                	ld	s2,16(sp)
    80003a80:	69a2                	ld	s3,8(sp)
    80003a82:	6a02                	ld	s4,0(sp)
    80003a84:	6145                	addi	sp,sp,48
    80003a86:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80003a88:	02059493          	slli	s1,a1,0x20
    80003a8c:	9081                	srli	s1,s1,0x20
    80003a8e:	048a                	slli	s1,s1,0x2
    80003a90:	94aa                	add	s1,s1,a0
    80003a92:	0684a903          	lw	s2,104(s1)
    80003a96:	fe0910e3          	bnez	s2,80003a76 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80003a9a:	4108                	lw	a0,0(a0)
    80003a9c:	00000097          	auipc	ra,0x0
    80003aa0:	e2c080e7          	jalr	-468(ra) # 800038c8 <balloc>
    80003aa4:	0005091b          	sext.w	s2,a0
    80003aa8:	0724a423          	sw	s2,104(s1)
    80003aac:	b7e9                	j	80003a76 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80003aae:	4108                	lw	a0,0(a0)
    80003ab0:	00000097          	auipc	ra,0x0
    80003ab4:	e18080e7          	jalr	-488(ra) # 800038c8 <balloc>
    80003ab8:	0005059b          	sext.w	a1,a0
    80003abc:	08b9ac23          	sw	a1,152(s3)
    80003ac0:	b759                	j	80003a46 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80003ac2:	0009a503          	lw	a0,0(s3)
    80003ac6:	00000097          	auipc	ra,0x0
    80003aca:	e02080e7          	jalr	-510(ra) # 800038c8 <balloc>
    80003ace:	0005091b          	sext.w	s2,a0
    80003ad2:	0124a023          	sw	s2,0(s1)
      log_write(bp);
    80003ad6:	8552                	mv	a0,s4
    80003ad8:	00001097          	auipc	ra,0x1
    80003adc:	f74080e7          	jalr	-140(ra) # 80004a4c <log_write>
    80003ae0:	b771                	j	80003a6c <bmap+0x54>
  panic("bmap: out of range");
    80003ae2:	00005517          	auipc	a0,0x5
    80003ae6:	ffe50513          	addi	a0,a0,-2 # 80008ae0 <userret+0xa50>
    80003aea:	ffffd097          	auipc	ra,0xffffd
    80003aee:	cdc080e7          	jalr	-804(ra) # 800007c6 <panic>

0000000080003af2 <iget>:
{
    80003af2:	7179                	addi	sp,sp,-48
    80003af4:	f406                	sd	ra,40(sp)
    80003af6:	f022                	sd	s0,32(sp)
    80003af8:	ec26                	sd	s1,24(sp)
    80003afa:	e84a                	sd	s2,16(sp)
    80003afc:	e44e                	sd	s3,8(sp)
    80003afe:	e052                	sd	s4,0(sp)
    80003b00:	1800                	addi	s0,sp,48
    80003b02:	89aa                	mv	s3,a0
    80003b04:	8a2e                	mv	s4,a1
  acquire(&icache.lock);
    80003b06:	00021517          	auipc	a0,0x21
    80003b0a:	fa250513          	addi	a0,a0,-94 # 80024aa8 <icache>
    80003b0e:	ffffd097          	auipc	ra,0xffffd
    80003b12:	222080e7          	jalr	546(ra) # 80000d30 <acquire>
  empty = 0;
    80003b16:	4901                	li	s2,0
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80003b18:	00021497          	auipc	s1,0x21
    80003b1c:	fc048493          	addi	s1,s1,-64 # 80024ad8 <icache+0x30>
    80003b20:	00023697          	auipc	a3,0x23
    80003b24:	ef868693          	addi	a3,a3,-264 # 80026a18 <log>
    80003b28:	a039                	j	80003b36 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003b2a:	02090b63          	beqz	s2,80003b60 <iget+0x6e>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    80003b2e:	0a048493          	addi	s1,s1,160
    80003b32:	02d48a63          	beq	s1,a3,80003b66 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80003b36:	449c                	lw	a5,8(s1)
    80003b38:	fef059e3          	blez	a5,80003b2a <iget+0x38>
    80003b3c:	4098                	lw	a4,0(s1)
    80003b3e:	ff3716e3          	bne	a4,s3,80003b2a <iget+0x38>
    80003b42:	40d8                	lw	a4,4(s1)
    80003b44:	ff4713e3          	bne	a4,s4,80003b2a <iget+0x38>
      ip->ref++;
    80003b48:	2785                	addiw	a5,a5,1
    80003b4a:	c49c                	sw	a5,8(s1)
      release(&icache.lock);
    80003b4c:	00021517          	auipc	a0,0x21
    80003b50:	f5c50513          	addi	a0,a0,-164 # 80024aa8 <icache>
    80003b54:	ffffd097          	auipc	ra,0xffffd
    80003b58:	428080e7          	jalr	1064(ra) # 80000f7c <release>
      return ip;
    80003b5c:	8926                	mv	s2,s1
    80003b5e:	a03d                	j	80003b8c <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003b60:	f7f9                	bnez	a5,80003b2e <iget+0x3c>
    80003b62:	8926                	mv	s2,s1
    80003b64:	b7e9                	j	80003b2e <iget+0x3c>
  if(empty == 0)
    80003b66:	02090c63          	beqz	s2,80003b9e <iget+0xac>
  ip->dev = dev;
    80003b6a:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80003b6e:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80003b72:	4785                	li	a5,1
    80003b74:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80003b78:	04092c23          	sw	zero,88(s2)
  release(&icache.lock);
    80003b7c:	00021517          	auipc	a0,0x21
    80003b80:	f2c50513          	addi	a0,a0,-212 # 80024aa8 <icache>
    80003b84:	ffffd097          	auipc	ra,0xffffd
    80003b88:	3f8080e7          	jalr	1016(ra) # 80000f7c <release>
}
    80003b8c:	854a                	mv	a0,s2
    80003b8e:	70a2                	ld	ra,40(sp)
    80003b90:	7402                	ld	s0,32(sp)
    80003b92:	64e2                	ld	s1,24(sp)
    80003b94:	6942                	ld	s2,16(sp)
    80003b96:	69a2                	ld	s3,8(sp)
    80003b98:	6a02                	ld	s4,0(sp)
    80003b9a:	6145                	addi	sp,sp,48
    80003b9c:	8082                	ret
    panic("iget: no inodes");
    80003b9e:	00005517          	auipc	a0,0x5
    80003ba2:	f5a50513          	addi	a0,a0,-166 # 80008af8 <userret+0xa68>
    80003ba6:	ffffd097          	auipc	ra,0xffffd
    80003baa:	c20080e7          	jalr	-992(ra) # 800007c6 <panic>

0000000080003bae <fsinit>:
fsinit(int dev) {
    80003bae:	7179                	addi	sp,sp,-48
    80003bb0:	f406                	sd	ra,40(sp)
    80003bb2:	f022                	sd	s0,32(sp)
    80003bb4:	ec26                	sd	s1,24(sp)
    80003bb6:	e84a                	sd	s2,16(sp)
    80003bb8:	e44e                	sd	s3,8(sp)
    80003bba:	1800                	addi	s0,sp,48
    80003bbc:	89aa                	mv	s3,a0
  bp = bread(dev, 1);
    80003bbe:	4585                	li	a1,1
    80003bc0:	00000097          	auipc	ra,0x0
    80003bc4:	a1c080e7          	jalr	-1508(ra) # 800035dc <bread>
    80003bc8:	892a                	mv	s2,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003bca:	00021497          	auipc	s1,0x21
    80003bce:	ebe48493          	addi	s1,s1,-322 # 80024a88 <sb>
    80003bd2:	02000613          	li	a2,32
    80003bd6:	07050593          	addi	a1,a0,112
    80003bda:	8526                	mv	a0,s1
    80003bdc:	ffffd097          	auipc	ra,0xffffd
    80003be0:	634080e7          	jalr	1588(ra) # 80001210 <memmove>
  brelse(bp);
    80003be4:	854a                	mv	a0,s2
    80003be6:	00000097          	auipc	ra,0x0
    80003bea:	b3c080e7          	jalr	-1220(ra) # 80003722 <brelse>
  if(sb.magic != FSMAGIC)
    80003bee:	4098                	lw	a4,0(s1)
    80003bf0:	102037b7          	lui	a5,0x10203
    80003bf4:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003bf8:	02f71263          	bne	a4,a5,80003c1c <fsinit+0x6e>
  initlog(dev, &sb);
    80003bfc:	00021597          	auipc	a1,0x21
    80003c00:	e8c58593          	addi	a1,a1,-372 # 80024a88 <sb>
    80003c04:	854e                	mv	a0,s3
    80003c06:	00001097          	auipc	ra,0x1
    80003c0a:	b30080e7          	jalr	-1232(ra) # 80004736 <initlog>
}
    80003c0e:	70a2                	ld	ra,40(sp)
    80003c10:	7402                	ld	s0,32(sp)
    80003c12:	64e2                	ld	s1,24(sp)
    80003c14:	6942                	ld	s2,16(sp)
    80003c16:	69a2                	ld	s3,8(sp)
    80003c18:	6145                	addi	sp,sp,48
    80003c1a:	8082                	ret
    panic("invalid file system");
    80003c1c:	00005517          	auipc	a0,0x5
    80003c20:	eec50513          	addi	a0,a0,-276 # 80008b08 <userret+0xa78>
    80003c24:	ffffd097          	auipc	ra,0xffffd
    80003c28:	ba2080e7          	jalr	-1118(ra) # 800007c6 <panic>

0000000080003c2c <iinit>:
{
    80003c2c:	7179                	addi	sp,sp,-48
    80003c2e:	f406                	sd	ra,40(sp)
    80003c30:	f022                	sd	s0,32(sp)
    80003c32:	ec26                	sd	s1,24(sp)
    80003c34:	e84a                	sd	s2,16(sp)
    80003c36:	e44e                	sd	s3,8(sp)
    80003c38:	1800                	addi	s0,sp,48
  initlock(&icache.lock, "icache");
    80003c3a:	00005597          	auipc	a1,0x5
    80003c3e:	ee658593          	addi	a1,a1,-282 # 80008b20 <userret+0xa90>
    80003c42:	00021517          	auipc	a0,0x21
    80003c46:	e6650513          	addi	a0,a0,-410 # 80024aa8 <icache>
    80003c4a:	ffffd097          	auipc	ra,0xffffd
    80003c4e:	f78080e7          	jalr	-136(ra) # 80000bc2 <initlock>
  for(i = 0; i < NINODE; i++) {
    80003c52:	00021497          	auipc	s1,0x21
    80003c56:	e9648493          	addi	s1,s1,-362 # 80024ae8 <icache+0x40>
    80003c5a:	00023997          	auipc	s3,0x23
    80003c5e:	dce98993          	addi	s3,s3,-562 # 80026a28 <log+0x10>
    initsleeplock(&icache.inode[i].lock, "inode");
    80003c62:	00005917          	auipc	s2,0x5
    80003c66:	ec690913          	addi	s2,s2,-314 # 80008b28 <userret+0xa98>
    80003c6a:	85ca                	mv	a1,s2
    80003c6c:	8526                	mv	a0,s1
    80003c6e:	00001097          	auipc	ra,0x1
    80003c72:	f2e080e7          	jalr	-210(ra) # 80004b9c <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003c76:	0a048493          	addi	s1,s1,160
    80003c7a:	ff3498e3          	bne	s1,s3,80003c6a <iinit+0x3e>
}
    80003c7e:	70a2                	ld	ra,40(sp)
    80003c80:	7402                	ld	s0,32(sp)
    80003c82:	64e2                	ld	s1,24(sp)
    80003c84:	6942                	ld	s2,16(sp)
    80003c86:	69a2                	ld	s3,8(sp)
    80003c88:	6145                	addi	sp,sp,48
    80003c8a:	8082                	ret

0000000080003c8c <ialloc>:
{
    80003c8c:	715d                	addi	sp,sp,-80
    80003c8e:	e486                	sd	ra,72(sp)
    80003c90:	e0a2                	sd	s0,64(sp)
    80003c92:	fc26                	sd	s1,56(sp)
    80003c94:	f84a                	sd	s2,48(sp)
    80003c96:	f44e                	sd	s3,40(sp)
    80003c98:	f052                	sd	s4,32(sp)
    80003c9a:	ec56                	sd	s5,24(sp)
    80003c9c:	e85a                	sd	s6,16(sp)
    80003c9e:	e45e                	sd	s7,8(sp)
    80003ca0:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80003ca2:	00021797          	auipc	a5,0x21
    80003ca6:	de678793          	addi	a5,a5,-538 # 80024a88 <sb>
    80003caa:	47d8                	lw	a4,12(a5)
    80003cac:	4785                	li	a5,1
    80003cae:	04e7fa63          	bleu	a4,a5,80003d02 <ialloc+0x76>
    80003cb2:	8a2a                	mv	s4,a0
    80003cb4:	8b2e                	mv	s6,a1
    80003cb6:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80003cb8:	00021997          	auipc	s3,0x21
    80003cbc:	dd098993          	addi	s3,s3,-560 # 80024a88 <sb>
    80003cc0:	00048a9b          	sext.w	s5,s1
    80003cc4:	0044d593          	srli	a1,s1,0x4
    80003cc8:	0189a783          	lw	a5,24(s3)
    80003ccc:	9dbd                	addw	a1,a1,a5
    80003cce:	8552                	mv	a0,s4
    80003cd0:	00000097          	auipc	ra,0x0
    80003cd4:	90c080e7          	jalr	-1780(ra) # 800035dc <bread>
    80003cd8:	8baa                	mv	s7,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003cda:	07050913          	addi	s2,a0,112
    80003cde:	00f4f793          	andi	a5,s1,15
    80003ce2:	079a                	slli	a5,a5,0x6
    80003ce4:	993e                	add	s2,s2,a5
    if(dip->type == 0){  // a free inode
    80003ce6:	00091783          	lh	a5,0(s2)
    80003cea:	c785                	beqz	a5,80003d12 <ialloc+0x86>
    brelse(bp);
    80003cec:	00000097          	auipc	ra,0x0
    80003cf0:	a36080e7          	jalr	-1482(ra) # 80003722 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003cf4:	0485                	addi	s1,s1,1
    80003cf6:	00c9a703          	lw	a4,12(s3)
    80003cfa:	0004879b          	sext.w	a5,s1
    80003cfe:	fce7e1e3          	bltu	a5,a4,80003cc0 <ialloc+0x34>
  panic("ialloc: no inodes");
    80003d02:	00005517          	auipc	a0,0x5
    80003d06:	e2e50513          	addi	a0,a0,-466 # 80008b30 <userret+0xaa0>
    80003d0a:	ffffd097          	auipc	ra,0xffffd
    80003d0e:	abc080e7          	jalr	-1348(ra) # 800007c6 <panic>
      memset(dip, 0, sizeof(*dip));
    80003d12:	04000613          	li	a2,64
    80003d16:	4581                	li	a1,0
    80003d18:	854a                	mv	a0,s2
    80003d1a:	ffffd097          	auipc	ra,0xffffd
    80003d1e:	48a080e7          	jalr	1162(ra) # 800011a4 <memset>
      dip->type = type;
    80003d22:	01691023          	sh	s6,0(s2)
      log_write(bp);   // mark it allocated on the disk
    80003d26:	855e                	mv	a0,s7
    80003d28:	00001097          	auipc	ra,0x1
    80003d2c:	d24080e7          	jalr	-732(ra) # 80004a4c <log_write>
      brelse(bp);
    80003d30:	855e                	mv	a0,s7
    80003d32:	00000097          	auipc	ra,0x0
    80003d36:	9f0080e7          	jalr	-1552(ra) # 80003722 <brelse>
      return iget(dev, inum);
    80003d3a:	85d6                	mv	a1,s5
    80003d3c:	8552                	mv	a0,s4
    80003d3e:	00000097          	auipc	ra,0x0
    80003d42:	db4080e7          	jalr	-588(ra) # 80003af2 <iget>
}
    80003d46:	60a6                	ld	ra,72(sp)
    80003d48:	6406                	ld	s0,64(sp)
    80003d4a:	74e2                	ld	s1,56(sp)
    80003d4c:	7942                	ld	s2,48(sp)
    80003d4e:	79a2                	ld	s3,40(sp)
    80003d50:	7a02                	ld	s4,32(sp)
    80003d52:	6ae2                	ld	s5,24(sp)
    80003d54:	6b42                	ld	s6,16(sp)
    80003d56:	6ba2                	ld	s7,8(sp)
    80003d58:	6161                	addi	sp,sp,80
    80003d5a:	8082                	ret

0000000080003d5c <iupdate>:
{
    80003d5c:	1101                	addi	sp,sp,-32
    80003d5e:	ec06                	sd	ra,24(sp)
    80003d60:	e822                	sd	s0,16(sp)
    80003d62:	e426                	sd	s1,8(sp)
    80003d64:	e04a                	sd	s2,0(sp)
    80003d66:	1000                	addi	s0,sp,32
    80003d68:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003d6a:	415c                	lw	a5,4(a0)
    80003d6c:	0047d79b          	srliw	a5,a5,0x4
    80003d70:	00021717          	auipc	a4,0x21
    80003d74:	d1870713          	addi	a4,a4,-744 # 80024a88 <sb>
    80003d78:	4f0c                	lw	a1,24(a4)
    80003d7a:	9dbd                	addw	a1,a1,a5
    80003d7c:	4108                	lw	a0,0(a0)
    80003d7e:	00000097          	auipc	ra,0x0
    80003d82:	85e080e7          	jalr	-1954(ra) # 800035dc <bread>
    80003d86:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003d88:	07050513          	addi	a0,a0,112
    80003d8c:	40dc                	lw	a5,4(s1)
    80003d8e:	8bbd                	andi	a5,a5,15
    80003d90:	079a                	slli	a5,a5,0x6
    80003d92:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80003d94:	05c49783          	lh	a5,92(s1)
    80003d98:	00f51023          	sh	a5,0(a0)
  dip->major = ip->major;
    80003d9c:	05e49783          	lh	a5,94(s1)
    80003da0:	00f51123          	sh	a5,2(a0)
  dip->minor = ip->minor;
    80003da4:	06049783          	lh	a5,96(s1)
    80003da8:	00f51223          	sh	a5,4(a0)
  dip->nlink = ip->nlink;
    80003dac:	06249783          	lh	a5,98(s1)
    80003db0:	00f51323          	sh	a5,6(a0)
  dip->size = ip->size;
    80003db4:	50fc                	lw	a5,100(s1)
    80003db6:	c51c                	sw	a5,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003db8:	03400613          	li	a2,52
    80003dbc:	06848593          	addi	a1,s1,104
    80003dc0:	0531                	addi	a0,a0,12
    80003dc2:	ffffd097          	auipc	ra,0xffffd
    80003dc6:	44e080e7          	jalr	1102(ra) # 80001210 <memmove>
  log_write(bp);
    80003dca:	854a                	mv	a0,s2
    80003dcc:	00001097          	auipc	ra,0x1
    80003dd0:	c80080e7          	jalr	-896(ra) # 80004a4c <log_write>
  brelse(bp);
    80003dd4:	854a                	mv	a0,s2
    80003dd6:	00000097          	auipc	ra,0x0
    80003dda:	94c080e7          	jalr	-1716(ra) # 80003722 <brelse>
}
    80003dde:	60e2                	ld	ra,24(sp)
    80003de0:	6442                	ld	s0,16(sp)
    80003de2:	64a2                	ld	s1,8(sp)
    80003de4:	6902                	ld	s2,0(sp)
    80003de6:	6105                	addi	sp,sp,32
    80003de8:	8082                	ret

0000000080003dea <idup>:
{
    80003dea:	1101                	addi	sp,sp,-32
    80003dec:	ec06                	sd	ra,24(sp)
    80003dee:	e822                	sd	s0,16(sp)
    80003df0:	e426                	sd	s1,8(sp)
    80003df2:	1000                	addi	s0,sp,32
    80003df4:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    80003df6:	00021517          	auipc	a0,0x21
    80003dfa:	cb250513          	addi	a0,a0,-846 # 80024aa8 <icache>
    80003dfe:	ffffd097          	auipc	ra,0xffffd
    80003e02:	f32080e7          	jalr	-206(ra) # 80000d30 <acquire>
  ip->ref++;
    80003e06:	449c                	lw	a5,8(s1)
    80003e08:	2785                	addiw	a5,a5,1
    80003e0a:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    80003e0c:	00021517          	auipc	a0,0x21
    80003e10:	c9c50513          	addi	a0,a0,-868 # 80024aa8 <icache>
    80003e14:	ffffd097          	auipc	ra,0xffffd
    80003e18:	168080e7          	jalr	360(ra) # 80000f7c <release>
}
    80003e1c:	8526                	mv	a0,s1
    80003e1e:	60e2                	ld	ra,24(sp)
    80003e20:	6442                	ld	s0,16(sp)
    80003e22:	64a2                	ld	s1,8(sp)
    80003e24:	6105                	addi	sp,sp,32
    80003e26:	8082                	ret

0000000080003e28 <ilock>:
{
    80003e28:	1101                	addi	sp,sp,-32
    80003e2a:	ec06                	sd	ra,24(sp)
    80003e2c:	e822                	sd	s0,16(sp)
    80003e2e:	e426                	sd	s1,8(sp)
    80003e30:	e04a                	sd	s2,0(sp)
    80003e32:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003e34:	c115                	beqz	a0,80003e58 <ilock+0x30>
    80003e36:	84aa                	mv	s1,a0
    80003e38:	451c                	lw	a5,8(a0)
    80003e3a:	00f05f63          	blez	a5,80003e58 <ilock+0x30>
  acquiresleep(&ip->lock);
    80003e3e:	0541                	addi	a0,a0,16
    80003e40:	00001097          	auipc	ra,0x1
    80003e44:	d96080e7          	jalr	-618(ra) # 80004bd6 <acquiresleep>
  if(ip->valid == 0){
    80003e48:	4cbc                	lw	a5,88(s1)
    80003e4a:	cf99                	beqz	a5,80003e68 <ilock+0x40>
}
    80003e4c:	60e2                	ld	ra,24(sp)
    80003e4e:	6442                	ld	s0,16(sp)
    80003e50:	64a2                	ld	s1,8(sp)
    80003e52:	6902                	ld	s2,0(sp)
    80003e54:	6105                	addi	sp,sp,32
    80003e56:	8082                	ret
    panic("ilock");
    80003e58:	00005517          	auipc	a0,0x5
    80003e5c:	cf050513          	addi	a0,a0,-784 # 80008b48 <userret+0xab8>
    80003e60:	ffffd097          	auipc	ra,0xffffd
    80003e64:	966080e7          	jalr	-1690(ra) # 800007c6 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003e68:	40dc                	lw	a5,4(s1)
    80003e6a:	0047d79b          	srliw	a5,a5,0x4
    80003e6e:	00021717          	auipc	a4,0x21
    80003e72:	c1a70713          	addi	a4,a4,-998 # 80024a88 <sb>
    80003e76:	4f0c                	lw	a1,24(a4)
    80003e78:	9dbd                	addw	a1,a1,a5
    80003e7a:	4088                	lw	a0,0(s1)
    80003e7c:	fffff097          	auipc	ra,0xfffff
    80003e80:	760080e7          	jalr	1888(ra) # 800035dc <bread>
    80003e84:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003e86:	07050593          	addi	a1,a0,112
    80003e8a:	40dc                	lw	a5,4(s1)
    80003e8c:	8bbd                	andi	a5,a5,15
    80003e8e:	079a                	slli	a5,a5,0x6
    80003e90:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003e92:	00059783          	lh	a5,0(a1)
    80003e96:	04f49e23          	sh	a5,92(s1)
    ip->major = dip->major;
    80003e9a:	00259783          	lh	a5,2(a1)
    80003e9e:	04f49f23          	sh	a5,94(s1)
    ip->minor = dip->minor;
    80003ea2:	00459783          	lh	a5,4(a1)
    80003ea6:	06f49023          	sh	a5,96(s1)
    ip->nlink = dip->nlink;
    80003eaa:	00659783          	lh	a5,6(a1)
    80003eae:	06f49123          	sh	a5,98(s1)
    ip->size = dip->size;
    80003eb2:	459c                	lw	a5,8(a1)
    80003eb4:	d0fc                	sw	a5,100(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003eb6:	03400613          	li	a2,52
    80003eba:	05b1                	addi	a1,a1,12
    80003ebc:	06848513          	addi	a0,s1,104
    80003ec0:	ffffd097          	auipc	ra,0xffffd
    80003ec4:	350080e7          	jalr	848(ra) # 80001210 <memmove>
    brelse(bp);
    80003ec8:	854a                	mv	a0,s2
    80003eca:	00000097          	auipc	ra,0x0
    80003ece:	858080e7          	jalr	-1960(ra) # 80003722 <brelse>
    ip->valid = 1;
    80003ed2:	4785                	li	a5,1
    80003ed4:	ccbc                	sw	a5,88(s1)
    if(ip->type == 0)
    80003ed6:	05c49783          	lh	a5,92(s1)
    80003eda:	fbad                	bnez	a5,80003e4c <ilock+0x24>
      panic("ilock: no type");
    80003edc:	00005517          	auipc	a0,0x5
    80003ee0:	c7450513          	addi	a0,a0,-908 # 80008b50 <userret+0xac0>
    80003ee4:	ffffd097          	auipc	ra,0xffffd
    80003ee8:	8e2080e7          	jalr	-1822(ra) # 800007c6 <panic>

0000000080003eec <iunlock>:
{
    80003eec:	1101                	addi	sp,sp,-32
    80003eee:	ec06                	sd	ra,24(sp)
    80003ef0:	e822                	sd	s0,16(sp)
    80003ef2:	e426                	sd	s1,8(sp)
    80003ef4:	e04a                	sd	s2,0(sp)
    80003ef6:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003ef8:	c905                	beqz	a0,80003f28 <iunlock+0x3c>
    80003efa:	84aa                	mv	s1,a0
    80003efc:	01050913          	addi	s2,a0,16
    80003f00:	854a                	mv	a0,s2
    80003f02:	00001097          	auipc	ra,0x1
    80003f06:	d6e080e7          	jalr	-658(ra) # 80004c70 <holdingsleep>
    80003f0a:	cd19                	beqz	a0,80003f28 <iunlock+0x3c>
    80003f0c:	449c                	lw	a5,8(s1)
    80003f0e:	00f05d63          	blez	a5,80003f28 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003f12:	854a                	mv	a0,s2
    80003f14:	00001097          	auipc	ra,0x1
    80003f18:	d18080e7          	jalr	-744(ra) # 80004c2c <releasesleep>
}
    80003f1c:	60e2                	ld	ra,24(sp)
    80003f1e:	6442                	ld	s0,16(sp)
    80003f20:	64a2                	ld	s1,8(sp)
    80003f22:	6902                	ld	s2,0(sp)
    80003f24:	6105                	addi	sp,sp,32
    80003f26:	8082                	ret
    panic("iunlock");
    80003f28:	00005517          	auipc	a0,0x5
    80003f2c:	c3850513          	addi	a0,a0,-968 # 80008b60 <userret+0xad0>
    80003f30:	ffffd097          	auipc	ra,0xffffd
    80003f34:	896080e7          	jalr	-1898(ra) # 800007c6 <panic>

0000000080003f38 <iput>:
{
    80003f38:	7139                	addi	sp,sp,-64
    80003f3a:	fc06                	sd	ra,56(sp)
    80003f3c:	f822                	sd	s0,48(sp)
    80003f3e:	f426                	sd	s1,40(sp)
    80003f40:	f04a                	sd	s2,32(sp)
    80003f42:	ec4e                	sd	s3,24(sp)
    80003f44:	e852                	sd	s4,16(sp)
    80003f46:	e456                	sd	s5,8(sp)
    80003f48:	0080                	addi	s0,sp,64
    80003f4a:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    80003f4c:	00021517          	auipc	a0,0x21
    80003f50:	b5c50513          	addi	a0,a0,-1188 # 80024aa8 <icache>
    80003f54:	ffffd097          	auipc	ra,0xffffd
    80003f58:	ddc080e7          	jalr	-548(ra) # 80000d30 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003f5c:	4498                	lw	a4,8(s1)
    80003f5e:	4785                	li	a5,1
    80003f60:	02f70663          	beq	a4,a5,80003f8c <iput+0x54>
  ip->ref--;
    80003f64:	449c                	lw	a5,8(s1)
    80003f66:	37fd                	addiw	a5,a5,-1
    80003f68:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    80003f6a:	00021517          	auipc	a0,0x21
    80003f6e:	b3e50513          	addi	a0,a0,-1218 # 80024aa8 <icache>
    80003f72:	ffffd097          	auipc	ra,0xffffd
    80003f76:	00a080e7          	jalr	10(ra) # 80000f7c <release>
}
    80003f7a:	70e2                	ld	ra,56(sp)
    80003f7c:	7442                	ld	s0,48(sp)
    80003f7e:	74a2                	ld	s1,40(sp)
    80003f80:	7902                	ld	s2,32(sp)
    80003f82:	69e2                	ld	s3,24(sp)
    80003f84:	6a42                	ld	s4,16(sp)
    80003f86:	6aa2                	ld	s5,8(sp)
    80003f88:	6121                	addi	sp,sp,64
    80003f8a:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003f8c:	4cbc                	lw	a5,88(s1)
    80003f8e:	dbf9                	beqz	a5,80003f64 <iput+0x2c>
    80003f90:	06249783          	lh	a5,98(s1)
    80003f94:	fbe1                	bnez	a5,80003f64 <iput+0x2c>
    acquiresleep(&ip->lock);
    80003f96:	01048a13          	addi	s4,s1,16
    80003f9a:	8552                	mv	a0,s4
    80003f9c:	00001097          	auipc	ra,0x1
    80003fa0:	c3a080e7          	jalr	-966(ra) # 80004bd6 <acquiresleep>
    release(&icache.lock);
    80003fa4:	00021517          	auipc	a0,0x21
    80003fa8:	b0450513          	addi	a0,a0,-1276 # 80024aa8 <icache>
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	fd0080e7          	jalr	-48(ra) # 80000f7c <release>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003fb4:	06848913          	addi	s2,s1,104
    80003fb8:	09848993          	addi	s3,s1,152
    80003fbc:	a819                	j	80003fd2 <iput+0x9a>
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
    80003fbe:	4088                	lw	a0,0(s1)
    80003fc0:	00000097          	auipc	ra,0x0
    80003fc4:	878080e7          	jalr	-1928(ra) # 80003838 <bfree>
      ip->addrs[i] = 0;
    80003fc8:	00092023          	sw	zero,0(s2)
  for(i = 0; i < NDIRECT; i++){
    80003fcc:	0911                	addi	s2,s2,4
    80003fce:	01390663          	beq	s2,s3,80003fda <iput+0xa2>
    if(ip->addrs[i]){
    80003fd2:	00092583          	lw	a1,0(s2)
    80003fd6:	d9fd                	beqz	a1,80003fcc <iput+0x94>
    80003fd8:	b7dd                	j	80003fbe <iput+0x86>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003fda:	0984a583          	lw	a1,152(s1)
    80003fde:	ed9d                	bnez	a1,8000401c <iput+0xe4>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003fe0:	0604a223          	sw	zero,100(s1)
  iupdate(ip);
    80003fe4:	8526                	mv	a0,s1
    80003fe6:	00000097          	auipc	ra,0x0
    80003fea:	d76080e7          	jalr	-650(ra) # 80003d5c <iupdate>
    ip->type = 0;
    80003fee:	04049e23          	sh	zero,92(s1)
    iupdate(ip);
    80003ff2:	8526                	mv	a0,s1
    80003ff4:	00000097          	auipc	ra,0x0
    80003ff8:	d68080e7          	jalr	-664(ra) # 80003d5c <iupdate>
    ip->valid = 0;
    80003ffc:	0404ac23          	sw	zero,88(s1)
    releasesleep(&ip->lock);
    80004000:	8552                	mv	a0,s4
    80004002:	00001097          	auipc	ra,0x1
    80004006:	c2a080e7          	jalr	-982(ra) # 80004c2c <releasesleep>
    acquire(&icache.lock);
    8000400a:	00021517          	auipc	a0,0x21
    8000400e:	a9e50513          	addi	a0,a0,-1378 # 80024aa8 <icache>
    80004012:	ffffd097          	auipc	ra,0xffffd
    80004016:	d1e080e7          	jalr	-738(ra) # 80000d30 <acquire>
    8000401a:	b7a9                	j	80003f64 <iput+0x2c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000401c:	4088                	lw	a0,0(s1)
    8000401e:	fffff097          	auipc	ra,0xfffff
    80004022:	5be080e7          	jalr	1470(ra) # 800035dc <bread>
    80004026:	8aaa                	mv	s5,a0
    for(j = 0; j < NINDIRECT; j++){
    80004028:	07050913          	addi	s2,a0,112
    8000402c:	47050993          	addi	s3,a0,1136
    80004030:	a809                	j	80004042 <iput+0x10a>
        bfree(ip->dev, a[j]);
    80004032:	4088                	lw	a0,0(s1)
    80004034:	00000097          	auipc	ra,0x0
    80004038:	804080e7          	jalr	-2044(ra) # 80003838 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    8000403c:	0911                	addi	s2,s2,4
    8000403e:	01390663          	beq	s2,s3,8000404a <iput+0x112>
      if(a[j])
    80004042:	00092583          	lw	a1,0(s2)
    80004046:	d9fd                	beqz	a1,8000403c <iput+0x104>
    80004048:	b7ed                	j	80004032 <iput+0xfa>
    brelse(bp);
    8000404a:	8556                	mv	a0,s5
    8000404c:	fffff097          	auipc	ra,0xfffff
    80004050:	6d6080e7          	jalr	1750(ra) # 80003722 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80004054:	0984a583          	lw	a1,152(s1)
    80004058:	4088                	lw	a0,0(s1)
    8000405a:	fffff097          	auipc	ra,0xfffff
    8000405e:	7de080e7          	jalr	2014(ra) # 80003838 <bfree>
    ip->addrs[NDIRECT] = 0;
    80004062:	0804ac23          	sw	zero,152(s1)
    80004066:	bfad                	j	80003fe0 <iput+0xa8>

0000000080004068 <iunlockput>:
{
    80004068:	1101                	addi	sp,sp,-32
    8000406a:	ec06                	sd	ra,24(sp)
    8000406c:	e822                	sd	s0,16(sp)
    8000406e:	e426                	sd	s1,8(sp)
    80004070:	1000                	addi	s0,sp,32
    80004072:	84aa                	mv	s1,a0
  iunlock(ip);
    80004074:	00000097          	auipc	ra,0x0
    80004078:	e78080e7          	jalr	-392(ra) # 80003eec <iunlock>
  iput(ip);
    8000407c:	8526                	mv	a0,s1
    8000407e:	00000097          	auipc	ra,0x0
    80004082:	eba080e7          	jalr	-326(ra) # 80003f38 <iput>
}
    80004086:	60e2                	ld	ra,24(sp)
    80004088:	6442                	ld	s0,16(sp)
    8000408a:	64a2                	ld	s1,8(sp)
    8000408c:	6105                	addi	sp,sp,32
    8000408e:	8082                	ret

0000000080004090 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80004090:	1141                	addi	sp,sp,-16
    80004092:	e422                	sd	s0,8(sp)
    80004094:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80004096:	411c                	lw	a5,0(a0)
    80004098:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    8000409a:	415c                	lw	a5,4(a0)
    8000409c:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    8000409e:	05c51783          	lh	a5,92(a0)
    800040a2:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800040a6:	06251783          	lh	a5,98(a0)
    800040aa:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800040ae:	06456783          	lwu	a5,100(a0)
    800040b2:	e99c                	sd	a5,16(a1)
}
    800040b4:	6422                	ld	s0,8(sp)
    800040b6:	0141                	addi	sp,sp,16
    800040b8:	8082                	ret

00000000800040ba <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800040ba:	517c                	lw	a5,100(a0)
    800040bc:	0ed7e563          	bltu	a5,a3,800041a6 <readi+0xec>
{
    800040c0:	7159                	addi	sp,sp,-112
    800040c2:	f486                	sd	ra,104(sp)
    800040c4:	f0a2                	sd	s0,96(sp)
    800040c6:	eca6                	sd	s1,88(sp)
    800040c8:	e8ca                	sd	s2,80(sp)
    800040ca:	e4ce                	sd	s3,72(sp)
    800040cc:	e0d2                	sd	s4,64(sp)
    800040ce:	fc56                	sd	s5,56(sp)
    800040d0:	f85a                	sd	s6,48(sp)
    800040d2:	f45e                	sd	s7,40(sp)
    800040d4:	f062                	sd	s8,32(sp)
    800040d6:	ec66                	sd	s9,24(sp)
    800040d8:	e86a                	sd	s10,16(sp)
    800040da:	e46e                	sd	s11,8(sp)
    800040dc:	1880                	addi	s0,sp,112
    800040de:	8baa                	mv	s7,a0
    800040e0:	8c2e                	mv	s8,a1
    800040e2:	8a32                	mv	s4,a2
    800040e4:	84b6                	mv	s1,a3
    800040e6:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800040e8:	9f35                	addw	a4,a4,a3
    800040ea:	0cd76063          	bltu	a4,a3,800041aa <readi+0xf0>
    return -1;
  if(off + n > ip->size)
    800040ee:	00e7f463          	bleu	a4,a5,800040f6 <readi+0x3c>
    n = ip->size - off;
    800040f2:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800040f6:	080b0763          	beqz	s6,80004184 <readi+0xca>
    800040fa:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    800040fc:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80004100:	5cfd                	li	s9,-1
    80004102:	a82d                	j	8000413c <readi+0x82>
    80004104:	02091d93          	slli	s11,s2,0x20
    80004108:	020ddd93          	srli	s11,s11,0x20
    8000410c:	070a8613          	addi	a2,s5,112
    80004110:	86ee                	mv	a3,s11
    80004112:	963a                	add	a2,a2,a4
    80004114:	85d2                	mv	a1,s4
    80004116:	8562                	mv	a0,s8
    80004118:	fffff097          	auipc	ra,0xfffff
    8000411c:	93e080e7          	jalr	-1730(ra) # 80002a56 <either_copyout>
    80004120:	05950d63          	beq	a0,s9,8000417a <readi+0xc0>
      brelse(bp);
      break;
    }
    brelse(bp);
    80004124:	8556                	mv	a0,s5
    80004126:	fffff097          	auipc	ra,0xfffff
    8000412a:	5fc080e7          	jalr	1532(ra) # 80003722 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000412e:	013909bb          	addw	s3,s2,s3
    80004132:	009904bb          	addw	s1,s2,s1
    80004136:	9a6e                	add	s4,s4,s11
    80004138:	0569f663          	bleu	s6,s3,80004184 <readi+0xca>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000413c:	000ba903          	lw	s2,0(s7)
    80004140:	00a4d59b          	srliw	a1,s1,0xa
    80004144:	855e                	mv	a0,s7
    80004146:	00000097          	auipc	ra,0x0
    8000414a:	8d2080e7          	jalr	-1838(ra) # 80003a18 <bmap>
    8000414e:	0005059b          	sext.w	a1,a0
    80004152:	854a                	mv	a0,s2
    80004154:	fffff097          	auipc	ra,0xfffff
    80004158:	488080e7          	jalr	1160(ra) # 800035dc <bread>
    8000415c:	8aaa                	mv	s5,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000415e:	3ff4f713          	andi	a4,s1,1023
    80004162:	40ed07bb          	subw	a5,s10,a4
    80004166:	413b06bb          	subw	a3,s6,s3
    8000416a:	893e                	mv	s2,a5
    8000416c:	2781                	sext.w	a5,a5
    8000416e:	0006861b          	sext.w	a2,a3
    80004172:	f8f679e3          	bleu	a5,a2,80004104 <readi+0x4a>
    80004176:	8936                	mv	s2,a3
    80004178:	b771                	j	80004104 <readi+0x4a>
      brelse(bp);
    8000417a:	8556                	mv	a0,s5
    8000417c:	fffff097          	auipc	ra,0xfffff
    80004180:	5a6080e7          	jalr	1446(ra) # 80003722 <brelse>
  }
  return n;
    80004184:	000b051b          	sext.w	a0,s6
}
    80004188:	70a6                	ld	ra,104(sp)
    8000418a:	7406                	ld	s0,96(sp)
    8000418c:	64e6                	ld	s1,88(sp)
    8000418e:	6946                	ld	s2,80(sp)
    80004190:	69a6                	ld	s3,72(sp)
    80004192:	6a06                	ld	s4,64(sp)
    80004194:	7ae2                	ld	s5,56(sp)
    80004196:	7b42                	ld	s6,48(sp)
    80004198:	7ba2                	ld	s7,40(sp)
    8000419a:	7c02                	ld	s8,32(sp)
    8000419c:	6ce2                	ld	s9,24(sp)
    8000419e:	6d42                	ld	s10,16(sp)
    800041a0:	6da2                	ld	s11,8(sp)
    800041a2:	6165                	addi	sp,sp,112
    800041a4:	8082                	ret
    return -1;
    800041a6:	557d                	li	a0,-1
}
    800041a8:	8082                	ret
    return -1;
    800041aa:	557d                	li	a0,-1
    800041ac:	bff1                	j	80004188 <readi+0xce>

00000000800041ae <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800041ae:	517c                	lw	a5,100(a0)
    800041b0:	10d7e663          	bltu	a5,a3,800042bc <writei+0x10e>
{
    800041b4:	7159                	addi	sp,sp,-112
    800041b6:	f486                	sd	ra,104(sp)
    800041b8:	f0a2                	sd	s0,96(sp)
    800041ba:	eca6                	sd	s1,88(sp)
    800041bc:	e8ca                	sd	s2,80(sp)
    800041be:	e4ce                	sd	s3,72(sp)
    800041c0:	e0d2                	sd	s4,64(sp)
    800041c2:	fc56                	sd	s5,56(sp)
    800041c4:	f85a                	sd	s6,48(sp)
    800041c6:	f45e                	sd	s7,40(sp)
    800041c8:	f062                	sd	s8,32(sp)
    800041ca:	ec66                	sd	s9,24(sp)
    800041cc:	e86a                	sd	s10,16(sp)
    800041ce:	e46e                	sd	s11,8(sp)
    800041d0:	1880                	addi	s0,sp,112
    800041d2:	8baa                	mv	s7,a0
    800041d4:	8c2e                	mv	s8,a1
    800041d6:	8ab2                	mv	s5,a2
    800041d8:	84b6                	mv	s1,a3
    800041da:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800041dc:	00e687bb          	addw	a5,a3,a4
    800041e0:	0ed7e063          	bltu	a5,a3,800042c0 <writei+0x112>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800041e4:	00043737          	lui	a4,0x43
    800041e8:	0cf76e63          	bltu	a4,a5,800042c4 <writei+0x116>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800041ec:	0a0b0763          	beqz	s6,8000429a <writei+0xec>
    800041f0:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    800041f2:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800041f6:	5cfd                	li	s9,-1
    800041f8:	a091                	j	8000423c <writei+0x8e>
    800041fa:	02091d93          	slli	s11,s2,0x20
    800041fe:	020ddd93          	srli	s11,s11,0x20
    80004202:	07098513          	addi	a0,s3,112
    80004206:	86ee                	mv	a3,s11
    80004208:	8656                	mv	a2,s5
    8000420a:	85e2                	mv	a1,s8
    8000420c:	953a                	add	a0,a0,a4
    8000420e:	fffff097          	auipc	ra,0xfffff
    80004212:	89e080e7          	jalr	-1890(ra) # 80002aac <either_copyin>
    80004216:	07950263          	beq	a0,s9,8000427a <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    8000421a:	854e                	mv	a0,s3
    8000421c:	00001097          	auipc	ra,0x1
    80004220:	830080e7          	jalr	-2000(ra) # 80004a4c <log_write>
    brelse(bp);
    80004224:	854e                	mv	a0,s3
    80004226:	fffff097          	auipc	ra,0xfffff
    8000422a:	4fc080e7          	jalr	1276(ra) # 80003722 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000422e:	01490a3b          	addw	s4,s2,s4
    80004232:	009904bb          	addw	s1,s2,s1
    80004236:	9aee                	add	s5,s5,s11
    80004238:	056a7663          	bleu	s6,s4,80004284 <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000423c:	000ba903          	lw	s2,0(s7)
    80004240:	00a4d59b          	srliw	a1,s1,0xa
    80004244:	855e                	mv	a0,s7
    80004246:	fffff097          	auipc	ra,0xfffff
    8000424a:	7d2080e7          	jalr	2002(ra) # 80003a18 <bmap>
    8000424e:	0005059b          	sext.w	a1,a0
    80004252:	854a                	mv	a0,s2
    80004254:	fffff097          	auipc	ra,0xfffff
    80004258:	388080e7          	jalr	904(ra) # 800035dc <bread>
    8000425c:	89aa                	mv	s3,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000425e:	3ff4f713          	andi	a4,s1,1023
    80004262:	40ed07bb          	subw	a5,s10,a4
    80004266:	414b06bb          	subw	a3,s6,s4
    8000426a:	893e                	mv	s2,a5
    8000426c:	2781                	sext.w	a5,a5
    8000426e:	0006861b          	sext.w	a2,a3
    80004272:	f8f674e3          	bleu	a5,a2,800041fa <writei+0x4c>
    80004276:	8936                	mv	s2,a3
    80004278:	b749                	j	800041fa <writei+0x4c>
      brelse(bp);
    8000427a:	854e                	mv	a0,s3
    8000427c:	fffff097          	auipc	ra,0xfffff
    80004280:	4a6080e7          	jalr	1190(ra) # 80003722 <brelse>
  }

  if(n > 0){
    if(off > ip->size)
    80004284:	064ba783          	lw	a5,100(s7)
    80004288:	0097f463          	bleu	s1,a5,80004290 <writei+0xe2>
      ip->size = off;
    8000428c:	069ba223          	sw	s1,100(s7)
    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    80004290:	855e                	mv	a0,s7
    80004292:	00000097          	auipc	ra,0x0
    80004296:	aca080e7          	jalr	-1334(ra) # 80003d5c <iupdate>
  }

  return n;
    8000429a:	000b051b          	sext.w	a0,s6
}
    8000429e:	70a6                	ld	ra,104(sp)
    800042a0:	7406                	ld	s0,96(sp)
    800042a2:	64e6                	ld	s1,88(sp)
    800042a4:	6946                	ld	s2,80(sp)
    800042a6:	69a6                	ld	s3,72(sp)
    800042a8:	6a06                	ld	s4,64(sp)
    800042aa:	7ae2                	ld	s5,56(sp)
    800042ac:	7b42                	ld	s6,48(sp)
    800042ae:	7ba2                	ld	s7,40(sp)
    800042b0:	7c02                	ld	s8,32(sp)
    800042b2:	6ce2                	ld	s9,24(sp)
    800042b4:	6d42                	ld	s10,16(sp)
    800042b6:	6da2                	ld	s11,8(sp)
    800042b8:	6165                	addi	sp,sp,112
    800042ba:	8082                	ret
    return -1;
    800042bc:	557d                	li	a0,-1
}
    800042be:	8082                	ret
    return -1;
    800042c0:	557d                	li	a0,-1
    800042c2:	bff1                	j	8000429e <writei+0xf0>
    return -1;
    800042c4:	557d                	li	a0,-1
    800042c6:	bfe1                	j	8000429e <writei+0xf0>

00000000800042c8 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800042c8:	1141                	addi	sp,sp,-16
    800042ca:	e406                	sd	ra,8(sp)
    800042cc:	e022                	sd	s0,0(sp)
    800042ce:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800042d0:	4639                	li	a2,14
    800042d2:	ffffd097          	auipc	ra,0xffffd
    800042d6:	fba080e7          	jalr	-70(ra) # 8000128c <strncmp>
}
    800042da:	60a2                	ld	ra,8(sp)
    800042dc:	6402                	ld	s0,0(sp)
    800042de:	0141                	addi	sp,sp,16
    800042e0:	8082                	ret

00000000800042e2 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800042e2:	7139                	addi	sp,sp,-64
    800042e4:	fc06                	sd	ra,56(sp)
    800042e6:	f822                	sd	s0,48(sp)
    800042e8:	f426                	sd	s1,40(sp)
    800042ea:	f04a                	sd	s2,32(sp)
    800042ec:	ec4e                	sd	s3,24(sp)
    800042ee:	e852                	sd	s4,16(sp)
    800042f0:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800042f2:	05c51703          	lh	a4,92(a0)
    800042f6:	4785                	li	a5,1
    800042f8:	00f71a63          	bne	a4,a5,8000430c <dirlookup+0x2a>
    800042fc:	892a                	mv	s2,a0
    800042fe:	89ae                	mv	s3,a1
    80004300:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80004302:	517c                	lw	a5,100(a0)
    80004304:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80004306:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004308:	e79d                	bnez	a5,80004336 <dirlookup+0x54>
    8000430a:	a8a5                	j	80004382 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    8000430c:	00005517          	auipc	a0,0x5
    80004310:	85c50513          	addi	a0,a0,-1956 # 80008b68 <userret+0xad8>
    80004314:	ffffc097          	auipc	ra,0xffffc
    80004318:	4b2080e7          	jalr	1202(ra) # 800007c6 <panic>
      panic("dirlookup read");
    8000431c:	00005517          	auipc	a0,0x5
    80004320:	86450513          	addi	a0,a0,-1948 # 80008b80 <userret+0xaf0>
    80004324:	ffffc097          	auipc	ra,0xffffc
    80004328:	4a2080e7          	jalr	1186(ra) # 800007c6 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000432c:	24c1                	addiw	s1,s1,16
    8000432e:	06492783          	lw	a5,100(s2)
    80004332:	04f4f763          	bleu	a5,s1,80004380 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004336:	4741                	li	a4,16
    80004338:	86a6                	mv	a3,s1
    8000433a:	fc040613          	addi	a2,s0,-64
    8000433e:	4581                	li	a1,0
    80004340:	854a                	mv	a0,s2
    80004342:	00000097          	auipc	ra,0x0
    80004346:	d78080e7          	jalr	-648(ra) # 800040ba <readi>
    8000434a:	47c1                	li	a5,16
    8000434c:	fcf518e3          	bne	a0,a5,8000431c <dirlookup+0x3a>
    if(de.inum == 0)
    80004350:	fc045783          	lhu	a5,-64(s0)
    80004354:	dfe1                	beqz	a5,8000432c <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80004356:	fc240593          	addi	a1,s0,-62
    8000435a:	854e                	mv	a0,s3
    8000435c:	00000097          	auipc	ra,0x0
    80004360:	f6c080e7          	jalr	-148(ra) # 800042c8 <namecmp>
    80004364:	f561                	bnez	a0,8000432c <dirlookup+0x4a>
      if(poff)
    80004366:	000a0463          	beqz	s4,8000436e <dirlookup+0x8c>
        *poff = off;
    8000436a:	009a2023          	sw	s1,0(s4) # 2000 <_entry-0x7fffe000>
      return iget(dp->dev, inum);
    8000436e:	fc045583          	lhu	a1,-64(s0)
    80004372:	00092503          	lw	a0,0(s2)
    80004376:	fffff097          	auipc	ra,0xfffff
    8000437a:	77c080e7          	jalr	1916(ra) # 80003af2 <iget>
    8000437e:	a011                	j	80004382 <dirlookup+0xa0>
  return 0;
    80004380:	4501                	li	a0,0
}
    80004382:	70e2                	ld	ra,56(sp)
    80004384:	7442                	ld	s0,48(sp)
    80004386:	74a2                	ld	s1,40(sp)
    80004388:	7902                	ld	s2,32(sp)
    8000438a:	69e2                	ld	s3,24(sp)
    8000438c:	6a42                	ld	s4,16(sp)
    8000438e:	6121                	addi	sp,sp,64
    80004390:	8082                	ret

0000000080004392 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80004392:	711d                	addi	sp,sp,-96
    80004394:	ec86                	sd	ra,88(sp)
    80004396:	e8a2                	sd	s0,80(sp)
    80004398:	e4a6                	sd	s1,72(sp)
    8000439a:	e0ca                	sd	s2,64(sp)
    8000439c:	fc4e                	sd	s3,56(sp)
    8000439e:	f852                	sd	s4,48(sp)
    800043a0:	f456                	sd	s5,40(sp)
    800043a2:	f05a                	sd	s6,32(sp)
    800043a4:	ec5e                	sd	s7,24(sp)
    800043a6:	e862                	sd	s8,16(sp)
    800043a8:	e466                	sd	s9,8(sp)
    800043aa:	1080                	addi	s0,sp,96
    800043ac:	84aa                	mv	s1,a0
    800043ae:	8bae                	mv	s7,a1
    800043b0:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800043b2:	00054703          	lbu	a4,0(a0)
    800043b6:	02f00793          	li	a5,47
    800043ba:	02f70363          	beq	a4,a5,800043e0 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800043be:	ffffe097          	auipc	ra,0xffffe
    800043c2:	c3c080e7          	jalr	-964(ra) # 80001ffa <myproc>
    800043c6:	16853503          	ld	a0,360(a0)
    800043ca:	00000097          	auipc	ra,0x0
    800043ce:	a20080e7          	jalr	-1504(ra) # 80003dea <idup>
    800043d2:	89aa                	mv	s3,a0
  while(*path == '/')
    800043d4:	02f00913          	li	s2,47
  len = path - s;
    800043d8:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    800043da:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800043dc:	4c05                	li	s8,1
    800043de:	a865                	j	80004496 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    800043e0:	4585                	li	a1,1
    800043e2:	4501                	li	a0,0
    800043e4:	fffff097          	auipc	ra,0xfffff
    800043e8:	70e080e7          	jalr	1806(ra) # 80003af2 <iget>
    800043ec:	89aa                	mv	s3,a0
    800043ee:	b7dd                	j	800043d4 <namex+0x42>
      iunlockput(ip);
    800043f0:	854e                	mv	a0,s3
    800043f2:	00000097          	auipc	ra,0x0
    800043f6:	c76080e7          	jalr	-906(ra) # 80004068 <iunlockput>
      return 0;
    800043fa:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800043fc:	854e                	mv	a0,s3
    800043fe:	60e6                	ld	ra,88(sp)
    80004400:	6446                	ld	s0,80(sp)
    80004402:	64a6                	ld	s1,72(sp)
    80004404:	6906                	ld	s2,64(sp)
    80004406:	79e2                	ld	s3,56(sp)
    80004408:	7a42                	ld	s4,48(sp)
    8000440a:	7aa2                	ld	s5,40(sp)
    8000440c:	7b02                	ld	s6,32(sp)
    8000440e:	6be2                	ld	s7,24(sp)
    80004410:	6c42                	ld	s8,16(sp)
    80004412:	6ca2                	ld	s9,8(sp)
    80004414:	6125                	addi	sp,sp,96
    80004416:	8082                	ret
      iunlock(ip);
    80004418:	854e                	mv	a0,s3
    8000441a:	00000097          	auipc	ra,0x0
    8000441e:	ad2080e7          	jalr	-1326(ra) # 80003eec <iunlock>
      return ip;
    80004422:	bfe9                	j	800043fc <namex+0x6a>
      iunlockput(ip);
    80004424:	854e                	mv	a0,s3
    80004426:	00000097          	auipc	ra,0x0
    8000442a:	c42080e7          	jalr	-958(ra) # 80004068 <iunlockput>
      return 0;
    8000442e:	89d2                	mv	s3,s4
    80004430:	b7f1                	j	800043fc <namex+0x6a>
  len = path - s;
    80004432:	40b48633          	sub	a2,s1,a1
    80004436:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    8000443a:	094cd663          	ble	s4,s9,800044c6 <namex+0x134>
    memmove(name, s, DIRSIZ);
    8000443e:	4639                	li	a2,14
    80004440:	8556                	mv	a0,s5
    80004442:	ffffd097          	auipc	ra,0xffffd
    80004446:	dce080e7          	jalr	-562(ra) # 80001210 <memmove>
  while(*path == '/')
    8000444a:	0004c783          	lbu	a5,0(s1)
    8000444e:	01279763          	bne	a5,s2,8000445c <namex+0xca>
    path++;
    80004452:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004454:	0004c783          	lbu	a5,0(s1)
    80004458:	ff278de3          	beq	a5,s2,80004452 <namex+0xc0>
    ilock(ip);
    8000445c:	854e                	mv	a0,s3
    8000445e:	00000097          	auipc	ra,0x0
    80004462:	9ca080e7          	jalr	-1590(ra) # 80003e28 <ilock>
    if(ip->type != T_DIR){
    80004466:	05c99783          	lh	a5,92(s3)
    8000446a:	f98793e3          	bne	a5,s8,800043f0 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    8000446e:	000b8563          	beqz	s7,80004478 <namex+0xe6>
    80004472:	0004c783          	lbu	a5,0(s1)
    80004476:	d3cd                	beqz	a5,80004418 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80004478:	865a                	mv	a2,s6
    8000447a:	85d6                	mv	a1,s5
    8000447c:	854e                	mv	a0,s3
    8000447e:	00000097          	auipc	ra,0x0
    80004482:	e64080e7          	jalr	-412(ra) # 800042e2 <dirlookup>
    80004486:	8a2a                	mv	s4,a0
    80004488:	dd51                	beqz	a0,80004424 <namex+0x92>
    iunlockput(ip);
    8000448a:	854e                	mv	a0,s3
    8000448c:	00000097          	auipc	ra,0x0
    80004490:	bdc080e7          	jalr	-1060(ra) # 80004068 <iunlockput>
    ip = next;
    80004494:	89d2                	mv	s3,s4
  while(*path == '/')
    80004496:	0004c783          	lbu	a5,0(s1)
    8000449a:	05279d63          	bne	a5,s2,800044f4 <namex+0x162>
    path++;
    8000449e:	0485                	addi	s1,s1,1
  while(*path == '/')
    800044a0:	0004c783          	lbu	a5,0(s1)
    800044a4:	ff278de3          	beq	a5,s2,8000449e <namex+0x10c>
  if(*path == 0)
    800044a8:	cf8d                	beqz	a5,800044e2 <namex+0x150>
  while(*path != '/' && *path != 0)
    800044aa:	01278b63          	beq	a5,s2,800044c0 <namex+0x12e>
    800044ae:	c795                	beqz	a5,800044da <namex+0x148>
    path++;
    800044b0:	85a6                	mv	a1,s1
    path++;
    800044b2:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    800044b4:	0004c783          	lbu	a5,0(s1)
    800044b8:	f7278de3          	beq	a5,s2,80004432 <namex+0xa0>
    800044bc:	fbfd                	bnez	a5,800044b2 <namex+0x120>
    800044be:	bf95                	j	80004432 <namex+0xa0>
    800044c0:	85a6                	mv	a1,s1
  len = path - s;
    800044c2:	8a5a                	mv	s4,s6
    800044c4:	865a                	mv	a2,s6
    memmove(name, s, len);
    800044c6:	2601                	sext.w	a2,a2
    800044c8:	8556                	mv	a0,s5
    800044ca:	ffffd097          	auipc	ra,0xffffd
    800044ce:	d46080e7          	jalr	-698(ra) # 80001210 <memmove>
    name[len] = 0;
    800044d2:	9a56                	add	s4,s4,s5
    800044d4:	000a0023          	sb	zero,0(s4)
    800044d8:	bf8d                	j	8000444a <namex+0xb8>
  while(*path != '/' && *path != 0)
    800044da:	85a6                	mv	a1,s1
  len = path - s;
    800044dc:	8a5a                	mv	s4,s6
    800044de:	865a                	mv	a2,s6
    800044e0:	b7dd                	j	800044c6 <namex+0x134>
  if(nameiparent){
    800044e2:	f00b8de3          	beqz	s7,800043fc <namex+0x6a>
    iput(ip);
    800044e6:	854e                	mv	a0,s3
    800044e8:	00000097          	auipc	ra,0x0
    800044ec:	a50080e7          	jalr	-1456(ra) # 80003f38 <iput>
    return 0;
    800044f0:	4981                	li	s3,0
    800044f2:	b729                	j	800043fc <namex+0x6a>
  if(*path == 0)
    800044f4:	d7fd                	beqz	a5,800044e2 <namex+0x150>
    800044f6:	85a6                	mv	a1,s1
    800044f8:	bf6d                	j	800044b2 <namex+0x120>

00000000800044fa <dirlink>:
{
    800044fa:	7139                	addi	sp,sp,-64
    800044fc:	fc06                	sd	ra,56(sp)
    800044fe:	f822                	sd	s0,48(sp)
    80004500:	f426                	sd	s1,40(sp)
    80004502:	f04a                	sd	s2,32(sp)
    80004504:	ec4e                	sd	s3,24(sp)
    80004506:	e852                	sd	s4,16(sp)
    80004508:	0080                	addi	s0,sp,64
    8000450a:	892a                	mv	s2,a0
    8000450c:	8a2e                	mv	s4,a1
    8000450e:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80004510:	4601                	li	a2,0
    80004512:	00000097          	auipc	ra,0x0
    80004516:	dd0080e7          	jalr	-560(ra) # 800042e2 <dirlookup>
    8000451a:	e93d                	bnez	a0,80004590 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000451c:	06492483          	lw	s1,100(s2)
    80004520:	c49d                	beqz	s1,8000454e <dirlink+0x54>
    80004522:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004524:	4741                	li	a4,16
    80004526:	86a6                	mv	a3,s1
    80004528:	fc040613          	addi	a2,s0,-64
    8000452c:	4581                	li	a1,0
    8000452e:	854a                	mv	a0,s2
    80004530:	00000097          	auipc	ra,0x0
    80004534:	b8a080e7          	jalr	-1142(ra) # 800040ba <readi>
    80004538:	47c1                	li	a5,16
    8000453a:	06f51163          	bne	a0,a5,8000459c <dirlink+0xa2>
    if(de.inum == 0)
    8000453e:	fc045783          	lhu	a5,-64(s0)
    80004542:	c791                	beqz	a5,8000454e <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004544:	24c1                	addiw	s1,s1,16
    80004546:	06492783          	lw	a5,100(s2)
    8000454a:	fcf4ede3          	bltu	s1,a5,80004524 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000454e:	4639                	li	a2,14
    80004550:	85d2                	mv	a1,s4
    80004552:	fc240513          	addi	a0,s0,-62
    80004556:	ffffd097          	auipc	ra,0xffffd
    8000455a:	d86080e7          	jalr	-634(ra) # 800012dc <strncpy>
  de.inum = inum;
    8000455e:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004562:	4741                	li	a4,16
    80004564:	86a6                	mv	a3,s1
    80004566:	fc040613          	addi	a2,s0,-64
    8000456a:	4581                	li	a1,0
    8000456c:	854a                	mv	a0,s2
    8000456e:	00000097          	auipc	ra,0x0
    80004572:	c40080e7          	jalr	-960(ra) # 800041ae <writei>
    80004576:	4741                	li	a4,16
  return 0;
    80004578:	4781                	li	a5,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000457a:	02e51963          	bne	a0,a4,800045ac <dirlink+0xb2>
}
    8000457e:	853e                	mv	a0,a5
    80004580:	70e2                	ld	ra,56(sp)
    80004582:	7442                	ld	s0,48(sp)
    80004584:	74a2                	ld	s1,40(sp)
    80004586:	7902                	ld	s2,32(sp)
    80004588:	69e2                	ld	s3,24(sp)
    8000458a:	6a42                	ld	s4,16(sp)
    8000458c:	6121                	addi	sp,sp,64
    8000458e:	8082                	ret
    iput(ip);
    80004590:	00000097          	auipc	ra,0x0
    80004594:	9a8080e7          	jalr	-1624(ra) # 80003f38 <iput>
    return -1;
    80004598:	57fd                	li	a5,-1
    8000459a:	b7d5                	j	8000457e <dirlink+0x84>
      panic("dirlink read");
    8000459c:	00004517          	auipc	a0,0x4
    800045a0:	5f450513          	addi	a0,a0,1524 # 80008b90 <userret+0xb00>
    800045a4:	ffffc097          	auipc	ra,0xffffc
    800045a8:	222080e7          	jalr	546(ra) # 800007c6 <panic>
    panic("dirlink");
    800045ac:	00004517          	auipc	a0,0x4
    800045b0:	70450513          	addi	a0,a0,1796 # 80008cb0 <userret+0xc20>
    800045b4:	ffffc097          	auipc	ra,0xffffc
    800045b8:	212080e7          	jalr	530(ra) # 800007c6 <panic>

00000000800045bc <namei>:

struct inode*
namei(char *path)
{
    800045bc:	1101                	addi	sp,sp,-32
    800045be:	ec06                	sd	ra,24(sp)
    800045c0:	e822                	sd	s0,16(sp)
    800045c2:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800045c4:	fe040613          	addi	a2,s0,-32
    800045c8:	4581                	li	a1,0
    800045ca:	00000097          	auipc	ra,0x0
    800045ce:	dc8080e7          	jalr	-568(ra) # 80004392 <namex>
}
    800045d2:	60e2                	ld	ra,24(sp)
    800045d4:	6442                	ld	s0,16(sp)
    800045d6:	6105                	addi	sp,sp,32
    800045d8:	8082                	ret

00000000800045da <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800045da:	1141                	addi	sp,sp,-16
    800045dc:	e406                	sd	ra,8(sp)
    800045de:	e022                	sd	s0,0(sp)
    800045e0:	0800                	addi	s0,sp,16
  return namex(path, 1, name);
    800045e2:	862e                	mv	a2,a1
    800045e4:	4585                	li	a1,1
    800045e6:	00000097          	auipc	ra,0x0
    800045ea:	dac080e7          	jalr	-596(ra) # 80004392 <namex>
}
    800045ee:	60a2                	ld	ra,8(sp)
    800045f0:	6402                	ld	s0,0(sp)
    800045f2:	0141                	addi	sp,sp,16
    800045f4:	8082                	ret

00000000800045f6 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(int dev)
{
    800045f6:	7179                	addi	sp,sp,-48
    800045f8:	f406                	sd	ra,40(sp)
    800045fa:	f022                	sd	s0,32(sp)
    800045fc:	ec26                	sd	s1,24(sp)
    800045fe:	e84a                	sd	s2,16(sp)
    80004600:	e44e                	sd	s3,8(sp)
    80004602:	1800                	addi	s0,sp,48
  struct buf *buf = bread(dev, log[dev].start);
    80004604:	00151913          	slli	s2,a0,0x1
    80004608:	992a                	add	s2,s2,a0
    8000460a:	00691793          	slli	a5,s2,0x6
    8000460e:	00022917          	auipc	s2,0x22
    80004612:	40a90913          	addi	s2,s2,1034 # 80026a18 <log>
    80004616:	993e                	add	s2,s2,a5
    80004618:	03092583          	lw	a1,48(s2)
    8000461c:	fffff097          	auipc	ra,0xfffff
    80004620:	fc0080e7          	jalr	-64(ra) # 800035dc <bread>
    80004624:	89aa                	mv	s3,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log[dev].lh.n;
    80004626:	04492783          	lw	a5,68(s2)
    8000462a:	d93c                	sw	a5,112(a0)
  for (i = 0; i < log[dev].lh.n; i++) {
    8000462c:	04492783          	lw	a5,68(s2)
    80004630:	00f05f63          	blez	a5,8000464e <write_head+0x58>
    80004634:	87ca                	mv	a5,s2
    80004636:	07450693          	addi	a3,a0,116
    8000463a:	4701                	li	a4,0
    8000463c:	85ca                	mv	a1,s2
    hb->block[i] = log[dev].lh.block[i];
    8000463e:	47b0                	lw	a2,72(a5)
    80004640:	c290                	sw	a2,0(a3)
  for (i = 0; i < log[dev].lh.n; i++) {
    80004642:	2705                	addiw	a4,a4,1
    80004644:	0791                	addi	a5,a5,4
    80004646:	0691                	addi	a3,a3,4
    80004648:	41f0                	lw	a2,68(a1)
    8000464a:	fec74ae3          	blt	a4,a2,8000463e <write_head+0x48>
  }
  bwrite(buf);
    8000464e:	854e                	mv	a0,s3
    80004650:	fffff097          	auipc	ra,0xfffff
    80004654:	092080e7          	jalr	146(ra) # 800036e2 <bwrite>
  brelse(buf);
    80004658:	854e                	mv	a0,s3
    8000465a:	fffff097          	auipc	ra,0xfffff
    8000465e:	0c8080e7          	jalr	200(ra) # 80003722 <brelse>
}
    80004662:	70a2                	ld	ra,40(sp)
    80004664:	7402                	ld	s0,32(sp)
    80004666:	64e2                	ld	s1,24(sp)
    80004668:	6942                	ld	s2,16(sp)
    8000466a:	69a2                	ld	s3,8(sp)
    8000466c:	6145                	addi	sp,sp,48
    8000466e:	8082                	ret

0000000080004670 <install_trans>:
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004670:	00151793          	slli	a5,a0,0x1
    80004674:	97aa                	add	a5,a5,a0
    80004676:	079a                	slli	a5,a5,0x6
    80004678:	00022717          	auipc	a4,0x22
    8000467c:	3a070713          	addi	a4,a4,928 # 80026a18 <log>
    80004680:	97ba                	add	a5,a5,a4
    80004682:	43fc                	lw	a5,68(a5)
    80004684:	0af05863          	blez	a5,80004734 <install_trans+0xc4>
{
    80004688:	7139                	addi	sp,sp,-64
    8000468a:	fc06                	sd	ra,56(sp)
    8000468c:	f822                	sd	s0,48(sp)
    8000468e:	f426                	sd	s1,40(sp)
    80004690:	f04a                	sd	s2,32(sp)
    80004692:	ec4e                	sd	s3,24(sp)
    80004694:	e852                	sd	s4,16(sp)
    80004696:	e456                	sd	s5,8(sp)
    80004698:	e05a                	sd	s6,0(sp)
    8000469a:	0080                	addi	s0,sp,64
    8000469c:	00151993          	slli	s3,a0,0x1
    800046a0:	99aa                	add	s3,s3,a0
    800046a2:	00699793          	slli	a5,s3,0x6
    800046a6:	00f709b3          	add	s3,a4,a5
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    800046aa:	4901                	li	s2,0
    struct buf *lbuf = bread(dev, log[dev].start+tail+1); // read log block
    800046ac:	00050b1b          	sext.w	s6,a0
    800046b0:	8ace                	mv	s5,s3
    800046b2:	030aa583          	lw	a1,48(s5)
    800046b6:	012585bb          	addw	a1,a1,s2
    800046ba:	2585                	addiw	a1,a1,1
    800046bc:	855a                	mv	a0,s6
    800046be:	fffff097          	auipc	ra,0xfffff
    800046c2:	f1e080e7          	jalr	-226(ra) # 800035dc <bread>
    800046c6:	8a2a                	mv	s4,a0
    struct buf *dbuf = bread(dev, log[dev].lh.block[tail]); // read dst
    800046c8:	0489a583          	lw	a1,72(s3)
    800046cc:	855a                	mv	a0,s6
    800046ce:	fffff097          	auipc	ra,0xfffff
    800046d2:	f0e080e7          	jalr	-242(ra) # 800035dc <bread>
    800046d6:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800046d8:	40000613          	li	a2,1024
    800046dc:	070a0593          	addi	a1,s4,112
    800046e0:	07050513          	addi	a0,a0,112
    800046e4:	ffffd097          	auipc	ra,0xffffd
    800046e8:	b2c080e7          	jalr	-1236(ra) # 80001210 <memmove>
    bwrite(dbuf);  // write dst to disk
    800046ec:	8526                	mv	a0,s1
    800046ee:	fffff097          	auipc	ra,0xfffff
    800046f2:	ff4080e7          	jalr	-12(ra) # 800036e2 <bwrite>
    bunpin(dbuf);
    800046f6:	8526                	mv	a0,s1
    800046f8:	fffff097          	auipc	ra,0xfffff
    800046fc:	104080e7          	jalr	260(ra) # 800037fc <bunpin>
    brelse(lbuf);
    80004700:	8552                	mv	a0,s4
    80004702:	fffff097          	auipc	ra,0xfffff
    80004706:	020080e7          	jalr	32(ra) # 80003722 <brelse>
    brelse(dbuf);
    8000470a:	8526                	mv	a0,s1
    8000470c:	fffff097          	auipc	ra,0xfffff
    80004710:	016080e7          	jalr	22(ra) # 80003722 <brelse>
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004714:	2905                	addiw	s2,s2,1
    80004716:	0991                	addi	s3,s3,4
    80004718:	044aa783          	lw	a5,68(s5)
    8000471c:	f8f94be3          	blt	s2,a5,800046b2 <install_trans+0x42>
}
    80004720:	70e2                	ld	ra,56(sp)
    80004722:	7442                	ld	s0,48(sp)
    80004724:	74a2                	ld	s1,40(sp)
    80004726:	7902                	ld	s2,32(sp)
    80004728:	69e2                	ld	s3,24(sp)
    8000472a:	6a42                	ld	s4,16(sp)
    8000472c:	6aa2                	ld	s5,8(sp)
    8000472e:	6b02                	ld	s6,0(sp)
    80004730:	6121                	addi	sp,sp,64
    80004732:	8082                	ret
    80004734:	8082                	ret

0000000080004736 <initlog>:
{
    80004736:	7179                	addi	sp,sp,-48
    80004738:	f406                	sd	ra,40(sp)
    8000473a:	f022                	sd	s0,32(sp)
    8000473c:	ec26                	sd	s1,24(sp)
    8000473e:	e84a                	sd	s2,16(sp)
    80004740:	e44e                	sd	s3,8(sp)
    80004742:	e052                	sd	s4,0(sp)
    80004744:	1800                	addi	s0,sp,48
    80004746:	892a                	mv	s2,a0
    80004748:	8a2e                	mv	s4,a1
  initlock(&log[dev].lock, "log");
    8000474a:	00151713          	slli	a4,a0,0x1
    8000474e:	972a                	add	a4,a4,a0
    80004750:	00671493          	slli	s1,a4,0x6
    80004754:	00022997          	auipc	s3,0x22
    80004758:	2c498993          	addi	s3,s3,708 # 80026a18 <log>
    8000475c:	99a6                	add	s3,s3,s1
    8000475e:	00004597          	auipc	a1,0x4
    80004762:	44258593          	addi	a1,a1,1090 # 80008ba0 <userret+0xb10>
    80004766:	854e                	mv	a0,s3
    80004768:	ffffc097          	auipc	ra,0xffffc
    8000476c:	45a080e7          	jalr	1114(ra) # 80000bc2 <initlock>
  log[dev].start = sb->logstart;
    80004770:	014a2583          	lw	a1,20(s4)
    80004774:	02b9a823          	sw	a1,48(s3)
  log[dev].size = sb->nlog;
    80004778:	010a2783          	lw	a5,16(s4)
    8000477c:	02f9aa23          	sw	a5,52(s3)
  log[dev].dev = dev;
    80004780:	0529a023          	sw	s2,64(s3)
  struct buf *buf = bread(dev, log[dev].start);
    80004784:	854a                	mv	a0,s2
    80004786:	fffff097          	auipc	ra,0xfffff
    8000478a:	e56080e7          	jalr	-426(ra) # 800035dc <bread>
  log[dev].lh.n = lh->n;
    8000478e:	593c                	lw	a5,112(a0)
    80004790:	04f9a223          	sw	a5,68(s3)
  for (i = 0; i < log[dev].lh.n; i++) {
    80004794:	02f05663          	blez	a5,800047c0 <initlog+0x8a>
    80004798:	07450693          	addi	a3,a0,116
    8000479c:	00022717          	auipc	a4,0x22
    800047a0:	2c470713          	addi	a4,a4,708 # 80026a60 <log+0x48>
    800047a4:	9726                	add	a4,a4,s1
    800047a6:	37fd                	addiw	a5,a5,-1
    800047a8:	1782                	slli	a5,a5,0x20
    800047aa:	9381                	srli	a5,a5,0x20
    800047ac:	078a                	slli	a5,a5,0x2
    800047ae:	07850613          	addi	a2,a0,120
    800047b2:	97b2                	add	a5,a5,a2
    log[dev].lh.block[i] = lh->block[i];
    800047b4:	4290                	lw	a2,0(a3)
    800047b6:	c310                	sw	a2,0(a4)
  for (i = 0; i < log[dev].lh.n; i++) {
    800047b8:	0691                	addi	a3,a3,4
    800047ba:	0711                	addi	a4,a4,4
    800047bc:	fef69ce3          	bne	a3,a5,800047b4 <initlog+0x7e>
  brelse(buf);
    800047c0:	fffff097          	auipc	ra,0xfffff
    800047c4:	f62080e7          	jalr	-158(ra) # 80003722 <brelse>

static void
recover_from_log(int dev)
{
  read_head(dev);
  install_trans(dev); // if committed, copy from log to disk
    800047c8:	854a                	mv	a0,s2
    800047ca:	00000097          	auipc	ra,0x0
    800047ce:	ea6080e7          	jalr	-346(ra) # 80004670 <install_trans>
  log[dev].lh.n = 0;
    800047d2:	00191793          	slli	a5,s2,0x1
    800047d6:	97ca                	add	a5,a5,s2
    800047d8:	079a                	slli	a5,a5,0x6
    800047da:	00022717          	auipc	a4,0x22
    800047de:	23e70713          	addi	a4,a4,574 # 80026a18 <log>
    800047e2:	97ba                	add	a5,a5,a4
    800047e4:	0407a223          	sw	zero,68(a5)
  write_head(dev); // clear the log
    800047e8:	854a                	mv	a0,s2
    800047ea:	00000097          	auipc	ra,0x0
    800047ee:	e0c080e7          	jalr	-500(ra) # 800045f6 <write_head>
}
    800047f2:	70a2                	ld	ra,40(sp)
    800047f4:	7402                	ld	s0,32(sp)
    800047f6:	64e2                	ld	s1,24(sp)
    800047f8:	6942                	ld	s2,16(sp)
    800047fa:	69a2                	ld	s3,8(sp)
    800047fc:	6a02                	ld	s4,0(sp)
    800047fe:	6145                	addi	sp,sp,48
    80004800:	8082                	ret

0000000080004802 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(int dev)
{
    80004802:	7139                	addi	sp,sp,-64
    80004804:	fc06                	sd	ra,56(sp)
    80004806:	f822                	sd	s0,48(sp)
    80004808:	f426                	sd	s1,40(sp)
    8000480a:	f04a                	sd	s2,32(sp)
    8000480c:	ec4e                	sd	s3,24(sp)
    8000480e:	e852                	sd	s4,16(sp)
    80004810:	e456                	sd	s5,8(sp)
    80004812:	0080                	addi	s0,sp,64
    80004814:	8aaa                	mv	s5,a0
  acquire(&log[dev].lock);
    80004816:	00151913          	slli	s2,a0,0x1
    8000481a:	992a                	add	s2,s2,a0
    8000481c:	00691793          	slli	a5,s2,0x6
    80004820:	00022917          	auipc	s2,0x22
    80004824:	1f890913          	addi	s2,s2,504 # 80026a18 <log>
    80004828:	993e                	add	s2,s2,a5
    8000482a:	854a                	mv	a0,s2
    8000482c:	ffffc097          	auipc	ra,0xffffc
    80004830:	504080e7          	jalr	1284(ra) # 80000d30 <acquire>
  while(1){
    if(log[dev].committing){
    80004834:	00022997          	auipc	s3,0x22
    80004838:	1e498993          	addi	s3,s3,484 # 80026a18 <log>
    8000483c:	84ca                	mv	s1,s2
      sleep(&log, &log[dev].lock);
    } else if(log[dev].lh.n + (log[dev].outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000483e:	4a79                	li	s4,30
    80004840:	a039                	j	8000484e <begin_op+0x4c>
      sleep(&log, &log[dev].lock);
    80004842:	85ca                	mv	a1,s2
    80004844:	854e                	mv	a0,s3
    80004846:	ffffe097          	auipc	ra,0xffffe
    8000484a:	fae080e7          	jalr	-82(ra) # 800027f4 <sleep>
    if(log[dev].committing){
    8000484e:	5cdc                	lw	a5,60(s1)
    80004850:	fbed                	bnez	a5,80004842 <begin_op+0x40>
    } else if(log[dev].lh.n + (log[dev].outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004852:	5c9c                	lw	a5,56(s1)
    80004854:	0017871b          	addiw	a4,a5,1
    80004858:	0007069b          	sext.w	a3,a4
    8000485c:	0027179b          	slliw	a5,a4,0x2
    80004860:	9fb9                	addw	a5,a5,a4
    80004862:	0017979b          	slliw	a5,a5,0x1
    80004866:	40f8                	lw	a4,68(s1)
    80004868:	9fb9                	addw	a5,a5,a4
    8000486a:	00fa5963          	ble	a5,s4,8000487c <begin_op+0x7a>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log[dev].lock);
    8000486e:	85ca                	mv	a1,s2
    80004870:	854e                	mv	a0,s3
    80004872:	ffffe097          	auipc	ra,0xffffe
    80004876:	f82080e7          	jalr	-126(ra) # 800027f4 <sleep>
    8000487a:	bfd1                	j	8000484e <begin_op+0x4c>
    } else {
      log[dev].outstanding += 1;
    8000487c:	001a9793          	slli	a5,s5,0x1
    80004880:	9abe                	add	s5,s5,a5
    80004882:	0a9a                	slli	s5,s5,0x6
    80004884:	00022797          	auipc	a5,0x22
    80004888:	19478793          	addi	a5,a5,404 # 80026a18 <log>
    8000488c:	9abe                	add	s5,s5,a5
    8000488e:	02daac23          	sw	a3,56(s5)
      release(&log[dev].lock);
    80004892:	854a                	mv	a0,s2
    80004894:	ffffc097          	auipc	ra,0xffffc
    80004898:	6e8080e7          	jalr	1768(ra) # 80000f7c <release>
      break;
    }
  }
}
    8000489c:	70e2                	ld	ra,56(sp)
    8000489e:	7442                	ld	s0,48(sp)
    800048a0:	74a2                	ld	s1,40(sp)
    800048a2:	7902                	ld	s2,32(sp)
    800048a4:	69e2                	ld	s3,24(sp)
    800048a6:	6a42                	ld	s4,16(sp)
    800048a8:	6aa2                	ld	s5,8(sp)
    800048aa:	6121                	addi	sp,sp,64
    800048ac:	8082                	ret

00000000800048ae <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(int dev)
{
    800048ae:	715d                	addi	sp,sp,-80
    800048b0:	e486                	sd	ra,72(sp)
    800048b2:	e0a2                	sd	s0,64(sp)
    800048b4:	fc26                	sd	s1,56(sp)
    800048b6:	f84a                	sd	s2,48(sp)
    800048b8:	f44e                	sd	s3,40(sp)
    800048ba:	f052                	sd	s4,32(sp)
    800048bc:	ec56                	sd	s5,24(sp)
    800048be:	e85a                	sd	s6,16(sp)
    800048c0:	e45e                	sd	s7,8(sp)
    800048c2:	e062                	sd	s8,0(sp)
    800048c4:	0880                	addi	s0,sp,80
    800048c6:	892a                	mv	s2,a0
  int do_commit = 0;

  acquire(&log[dev].lock);
    800048c8:	00151493          	slli	s1,a0,0x1
    800048cc:	94aa                	add	s1,s1,a0
    800048ce:	00649793          	slli	a5,s1,0x6
    800048d2:	00022497          	auipc	s1,0x22
    800048d6:	14648493          	addi	s1,s1,326 # 80026a18 <log>
    800048da:	94be                	add	s1,s1,a5
    800048dc:	8526                	mv	a0,s1
    800048de:	ffffc097          	auipc	ra,0xffffc
    800048e2:	452080e7          	jalr	1106(ra) # 80000d30 <acquire>
  log[dev].outstanding -= 1;
    800048e6:	5c9c                	lw	a5,56(s1)
    800048e8:	37fd                	addiw	a5,a5,-1
    800048ea:	0007899b          	sext.w	s3,a5
    800048ee:	dc9c                	sw	a5,56(s1)
  if(log[dev].committing)
    800048f0:	5cdc                	lw	a5,60(s1)
    800048f2:	e3b5                	bnez	a5,80004956 <end_op+0xa8>
    panic("log[dev].committing");
  if(log[dev].outstanding == 0){
    800048f4:	06099963          	bnez	s3,80004966 <end_op+0xb8>
    do_commit = 1;
    log[dev].committing = 1;
    800048f8:	00191793          	slli	a5,s2,0x1
    800048fc:	97ca                	add	a5,a5,s2
    800048fe:	079a                	slli	a5,a5,0x6
    80004900:	00022a17          	auipc	s4,0x22
    80004904:	118a0a13          	addi	s4,s4,280 # 80026a18 <log>
    80004908:	9a3e                	add	s4,s4,a5
    8000490a:	4785                	li	a5,1
    8000490c:	02fa2e23          	sw	a5,60(s4)
    // begin_op() may be waiting for log space,
    // and decrementing log[dev].outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log[dev].lock);
    80004910:	8526                	mv	a0,s1
    80004912:	ffffc097          	auipc	ra,0xffffc
    80004916:	66a080e7          	jalr	1642(ra) # 80000f7c <release>
}

static void
commit(int dev)
{
  if (log[dev].lh.n > 0) {
    8000491a:	044a2783          	lw	a5,68(s4)
    8000491e:	06f04d63          	bgtz	a5,80004998 <end_op+0xea>
    acquire(&log[dev].lock);
    80004922:	8526                	mv	a0,s1
    80004924:	ffffc097          	auipc	ra,0xffffc
    80004928:	40c080e7          	jalr	1036(ra) # 80000d30 <acquire>
    log[dev].committing = 0;
    8000492c:	00022517          	auipc	a0,0x22
    80004930:	0ec50513          	addi	a0,a0,236 # 80026a18 <log>
    80004934:	00191793          	slli	a5,s2,0x1
    80004938:	993e                	add	s2,s2,a5
    8000493a:	091a                	slli	s2,s2,0x6
    8000493c:	992a                	add	s2,s2,a0
    8000493e:	02092e23          	sw	zero,60(s2)
    wakeup(&log);
    80004942:	ffffe097          	auipc	ra,0xffffe
    80004946:	038080e7          	jalr	56(ra) # 8000297a <wakeup>
    release(&log[dev].lock);
    8000494a:	8526                	mv	a0,s1
    8000494c:	ffffc097          	auipc	ra,0xffffc
    80004950:	630080e7          	jalr	1584(ra) # 80000f7c <release>
}
    80004954:	a035                	j	80004980 <end_op+0xd2>
    panic("log[dev].committing");
    80004956:	00004517          	auipc	a0,0x4
    8000495a:	25250513          	addi	a0,a0,594 # 80008ba8 <userret+0xb18>
    8000495e:	ffffc097          	auipc	ra,0xffffc
    80004962:	e68080e7          	jalr	-408(ra) # 800007c6 <panic>
    wakeup(&log);
    80004966:	00022517          	auipc	a0,0x22
    8000496a:	0b250513          	addi	a0,a0,178 # 80026a18 <log>
    8000496e:	ffffe097          	auipc	ra,0xffffe
    80004972:	00c080e7          	jalr	12(ra) # 8000297a <wakeup>
  release(&log[dev].lock);
    80004976:	8526                	mv	a0,s1
    80004978:	ffffc097          	auipc	ra,0xffffc
    8000497c:	604080e7          	jalr	1540(ra) # 80000f7c <release>
}
    80004980:	60a6                	ld	ra,72(sp)
    80004982:	6406                	ld	s0,64(sp)
    80004984:	74e2                	ld	s1,56(sp)
    80004986:	7942                	ld	s2,48(sp)
    80004988:	79a2                	ld	s3,40(sp)
    8000498a:	7a02                	ld	s4,32(sp)
    8000498c:	6ae2                	ld	s5,24(sp)
    8000498e:	6b42                	ld	s6,16(sp)
    80004990:	6ba2                	ld	s7,8(sp)
    80004992:	6c02                	ld	s8,0(sp)
    80004994:	6161                	addi	sp,sp,80
    80004996:	8082                	ret
    80004998:	8aa6                	mv	s5,s1
    struct buf *to = bread(dev, log[dev].start+tail+1); // log block
    8000499a:	00090c1b          	sext.w	s8,s2
    8000499e:	00191b93          	slli	s7,s2,0x1
    800049a2:	9bca                	add	s7,s7,s2
    800049a4:	006b9793          	slli	a5,s7,0x6
    800049a8:	00022b97          	auipc	s7,0x22
    800049ac:	070b8b93          	addi	s7,s7,112 # 80026a18 <log>
    800049b0:	9bbe                	add	s7,s7,a5
    800049b2:	030ba583          	lw	a1,48(s7)
    800049b6:	013585bb          	addw	a1,a1,s3
    800049ba:	2585                	addiw	a1,a1,1
    800049bc:	8562                	mv	a0,s8
    800049be:	fffff097          	auipc	ra,0xfffff
    800049c2:	c1e080e7          	jalr	-994(ra) # 800035dc <bread>
    800049c6:	8a2a                	mv	s4,a0
    struct buf *from = bread(dev, log[dev].lh.block[tail]); // cache block
    800049c8:	048aa583          	lw	a1,72(s5)
    800049cc:	8562                	mv	a0,s8
    800049ce:	fffff097          	auipc	ra,0xfffff
    800049d2:	c0e080e7          	jalr	-1010(ra) # 800035dc <bread>
    800049d6:	8b2a                	mv	s6,a0
    memmove(to->data, from->data, BSIZE);
    800049d8:	40000613          	li	a2,1024
    800049dc:	07050593          	addi	a1,a0,112
    800049e0:	070a0513          	addi	a0,s4,112
    800049e4:	ffffd097          	auipc	ra,0xffffd
    800049e8:	82c080e7          	jalr	-2004(ra) # 80001210 <memmove>
    bwrite(to);  // write the log
    800049ec:	8552                	mv	a0,s4
    800049ee:	fffff097          	auipc	ra,0xfffff
    800049f2:	cf4080e7          	jalr	-780(ra) # 800036e2 <bwrite>
    brelse(from);
    800049f6:	855a                	mv	a0,s6
    800049f8:	fffff097          	auipc	ra,0xfffff
    800049fc:	d2a080e7          	jalr	-726(ra) # 80003722 <brelse>
    brelse(to);
    80004a00:	8552                	mv	a0,s4
    80004a02:	fffff097          	auipc	ra,0xfffff
    80004a06:	d20080e7          	jalr	-736(ra) # 80003722 <brelse>
  for (tail = 0; tail < log[dev].lh.n; tail++) {
    80004a0a:	2985                	addiw	s3,s3,1
    80004a0c:	0a91                	addi	s5,s5,4
    80004a0e:	044ba783          	lw	a5,68(s7)
    80004a12:	faf9c0e3          	blt	s3,a5,800049b2 <end_op+0x104>
    write_log(dev);     // Write modified blocks from cache to log
    write_head(dev);    // Write header to disk -- the real commit
    80004a16:	854a                	mv	a0,s2
    80004a18:	00000097          	auipc	ra,0x0
    80004a1c:	bde080e7          	jalr	-1058(ra) # 800045f6 <write_head>
    install_trans(dev); // Now install writes to home locations
    80004a20:	854a                	mv	a0,s2
    80004a22:	00000097          	auipc	ra,0x0
    80004a26:	c4e080e7          	jalr	-946(ra) # 80004670 <install_trans>
    log[dev].lh.n = 0;
    80004a2a:	00191793          	slli	a5,s2,0x1
    80004a2e:	97ca                	add	a5,a5,s2
    80004a30:	079a                	slli	a5,a5,0x6
    80004a32:	00022717          	auipc	a4,0x22
    80004a36:	fe670713          	addi	a4,a4,-26 # 80026a18 <log>
    80004a3a:	97ba                	add	a5,a5,a4
    80004a3c:	0407a223          	sw	zero,68(a5)
    write_head(dev);    // Erase the transaction from the log
    80004a40:	854a                	mv	a0,s2
    80004a42:	00000097          	auipc	ra,0x0
    80004a46:	bb4080e7          	jalr	-1100(ra) # 800045f6 <write_head>
    80004a4a:	bde1                	j	80004922 <end_op+0x74>

0000000080004a4c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80004a4c:	7179                	addi	sp,sp,-48
    80004a4e:	f406                	sd	ra,40(sp)
    80004a50:	f022                	sd	s0,32(sp)
    80004a52:	ec26                	sd	s1,24(sp)
    80004a54:	e84a                	sd	s2,16(sp)
    80004a56:	e44e                	sd	s3,8(sp)
    80004a58:	1800                	addi	s0,sp,48
  int i;

  int dev = b->dev;
    80004a5a:	4504                	lw	s1,8(a0)
  if (log[dev].lh.n >= LOGSIZE || log[dev].lh.n >= log[dev].size - 1)
    80004a5c:	00149793          	slli	a5,s1,0x1
    80004a60:	97a6                	add	a5,a5,s1
    80004a62:	079a                	slli	a5,a5,0x6
    80004a64:	00022717          	auipc	a4,0x22
    80004a68:	fb470713          	addi	a4,a4,-76 # 80026a18 <log>
    80004a6c:	97ba                	add	a5,a5,a4
    80004a6e:	43f4                	lw	a3,68(a5)
    80004a70:	47f5                	li	a5,29
    80004a72:	0ad7c363          	blt	a5,a3,80004b18 <log_write+0xcc>
    80004a76:	89aa                	mv	s3,a0
    80004a78:	00149793          	slli	a5,s1,0x1
    80004a7c:	97a6                	add	a5,a5,s1
    80004a7e:	079a                	slli	a5,a5,0x6
    80004a80:	97ba                	add	a5,a5,a4
    80004a82:	5bdc                	lw	a5,52(a5)
    80004a84:	37fd                	addiw	a5,a5,-1
    80004a86:	08f6d963          	ble	a5,a3,80004b18 <log_write+0xcc>
    panic("too big a transaction");
  if (log[dev].outstanding < 1)
    80004a8a:	00149793          	slli	a5,s1,0x1
    80004a8e:	97a6                	add	a5,a5,s1
    80004a90:	079a                	slli	a5,a5,0x6
    80004a92:	00022717          	auipc	a4,0x22
    80004a96:	f8670713          	addi	a4,a4,-122 # 80026a18 <log>
    80004a9a:	97ba                	add	a5,a5,a4
    80004a9c:	5f9c                	lw	a5,56(a5)
    80004a9e:	08f05563          	blez	a5,80004b28 <log_write+0xdc>
    panic("log_write outside of trans");

  acquire(&log[dev].lock);
    80004aa2:	00149913          	slli	s2,s1,0x1
    80004aa6:	9926                	add	s2,s2,s1
    80004aa8:	00691793          	slli	a5,s2,0x6
    80004aac:	00022917          	auipc	s2,0x22
    80004ab0:	f6c90913          	addi	s2,s2,-148 # 80026a18 <log>
    80004ab4:	993e                	add	s2,s2,a5
    80004ab6:	854a                	mv	a0,s2
    80004ab8:	ffffc097          	auipc	ra,0xffffc
    80004abc:	278080e7          	jalr	632(ra) # 80000d30 <acquire>
  for (i = 0; i < log[dev].lh.n; i++) {
    80004ac0:	04492603          	lw	a2,68(s2)
    80004ac4:	0ac05c63          	blez	a2,80004b7c <log_write+0x130>
    if (log[dev].lh.block[i] == b->blockno)   // log absorbtion
    80004ac8:	00c9a583          	lw	a1,12(s3)
    80004acc:	04892783          	lw	a5,72(s2)
    80004ad0:	0cb78463          	beq	a5,a1,80004b98 <log_write+0x14c>
    80004ad4:	874a                	mv	a4,s2
  for (i = 0; i < log[dev].lh.n; i++) {
    80004ad6:	4781                	li	a5,0
    80004ad8:	2785                	addiw	a5,a5,1
    80004ada:	04c78f63          	beq	a5,a2,80004b38 <log_write+0xec>
    if (log[dev].lh.block[i] == b->blockno)   // log absorbtion
    80004ade:	4774                	lw	a3,76(a4)
    80004ae0:	0711                	addi	a4,a4,4
    80004ae2:	feb69be3          	bne	a3,a1,80004ad8 <log_write+0x8c>
      break;
  }
  log[dev].lh.block[i] = b->blockno;
    80004ae6:	00149713          	slli	a4,s1,0x1
    80004aea:	94ba                	add	s1,s1,a4
    80004aec:	0492                	slli	s1,s1,0x4
    80004aee:	97a6                	add	a5,a5,s1
    80004af0:	07c1                	addi	a5,a5,16
    80004af2:	078a                	slli	a5,a5,0x2
    80004af4:	00022717          	auipc	a4,0x22
    80004af8:	f2470713          	addi	a4,a4,-220 # 80026a18 <log>
    80004afc:	97ba                	add	a5,a5,a4
    80004afe:	c78c                	sw	a1,8(a5)
  if (i == log[dev].lh.n) {  // Add new block to log?
    bpin(b);
    log[dev].lh.n++;
  }
  release(&log[dev].lock);
    80004b00:	854a                	mv	a0,s2
    80004b02:	ffffc097          	auipc	ra,0xffffc
    80004b06:	47a080e7          	jalr	1146(ra) # 80000f7c <release>
}
    80004b0a:	70a2                	ld	ra,40(sp)
    80004b0c:	7402                	ld	s0,32(sp)
    80004b0e:	64e2                	ld	s1,24(sp)
    80004b10:	6942                	ld	s2,16(sp)
    80004b12:	69a2                	ld	s3,8(sp)
    80004b14:	6145                	addi	sp,sp,48
    80004b16:	8082                	ret
    panic("too big a transaction");
    80004b18:	00004517          	auipc	a0,0x4
    80004b1c:	0a850513          	addi	a0,a0,168 # 80008bc0 <userret+0xb30>
    80004b20:	ffffc097          	auipc	ra,0xffffc
    80004b24:	ca6080e7          	jalr	-858(ra) # 800007c6 <panic>
    panic("log_write outside of trans");
    80004b28:	00004517          	auipc	a0,0x4
    80004b2c:	0b050513          	addi	a0,a0,176 # 80008bd8 <userret+0xb48>
    80004b30:	ffffc097          	auipc	ra,0xffffc
    80004b34:	c96080e7          	jalr	-874(ra) # 800007c6 <panic>
  log[dev].lh.block[i] = b->blockno;
    80004b38:	00149793          	slli	a5,s1,0x1
    80004b3c:	97a6                	add	a5,a5,s1
    80004b3e:	0792                	slli	a5,a5,0x4
    80004b40:	97b2                	add	a5,a5,a2
    80004b42:	07c1                	addi	a5,a5,16
    80004b44:	078a                	slli	a5,a5,0x2
    80004b46:	00022717          	auipc	a4,0x22
    80004b4a:	ed270713          	addi	a4,a4,-302 # 80026a18 <log>
    80004b4e:	97ba                	add	a5,a5,a4
    80004b50:	00c9a703          	lw	a4,12(s3)
    80004b54:	c798                	sw	a4,8(a5)
    bpin(b);
    80004b56:	854e                	mv	a0,s3
    80004b58:	fffff097          	auipc	ra,0xfffff
    80004b5c:	c68080e7          	jalr	-920(ra) # 800037c0 <bpin>
    log[dev].lh.n++;
    80004b60:	00022697          	auipc	a3,0x22
    80004b64:	eb868693          	addi	a3,a3,-328 # 80026a18 <log>
    80004b68:	00149793          	slli	a5,s1,0x1
    80004b6c:	00978733          	add	a4,a5,s1
    80004b70:	071a                	slli	a4,a4,0x6
    80004b72:	9736                	add	a4,a4,a3
    80004b74:	437c                	lw	a5,68(a4)
    80004b76:	2785                	addiw	a5,a5,1
    80004b78:	c37c                	sw	a5,68(a4)
    80004b7a:	b759                	j	80004b00 <log_write+0xb4>
  log[dev].lh.block[i] = b->blockno;
    80004b7c:	00149793          	slli	a5,s1,0x1
    80004b80:	97a6                	add	a5,a5,s1
    80004b82:	079a                	slli	a5,a5,0x6
    80004b84:	00022717          	auipc	a4,0x22
    80004b88:	e9470713          	addi	a4,a4,-364 # 80026a18 <log>
    80004b8c:	97ba                	add	a5,a5,a4
    80004b8e:	00c9a703          	lw	a4,12(s3)
    80004b92:	c7b8                	sw	a4,72(a5)
  if (i == log[dev].lh.n) {  // Add new block to log?
    80004b94:	f635                	bnez	a2,80004b00 <log_write+0xb4>
    80004b96:	b7c1                	j	80004b56 <log_write+0x10a>
  for (i = 0; i < log[dev].lh.n; i++) {
    80004b98:	4781                	li	a5,0
    80004b9a:	b7b1                	j	80004ae6 <log_write+0x9a>

0000000080004b9c <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004b9c:	1101                	addi	sp,sp,-32
    80004b9e:	ec06                	sd	ra,24(sp)
    80004ba0:	e822                	sd	s0,16(sp)
    80004ba2:	e426                	sd	s1,8(sp)
    80004ba4:	e04a                	sd	s2,0(sp)
    80004ba6:	1000                	addi	s0,sp,32
    80004ba8:	84aa                	mv	s1,a0
    80004baa:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004bac:	00004597          	auipc	a1,0x4
    80004bb0:	04c58593          	addi	a1,a1,76 # 80008bf8 <userret+0xb68>
    80004bb4:	0521                	addi	a0,a0,8
    80004bb6:	ffffc097          	auipc	ra,0xffffc
    80004bba:	00c080e7          	jalr	12(ra) # 80000bc2 <initlock>
  lk->name = name;
    80004bbe:	0324bc23          	sd	s2,56(s1)
  lk->locked = 0;
    80004bc2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004bc6:	0404a023          	sw	zero,64(s1)
}
    80004bca:	60e2                	ld	ra,24(sp)
    80004bcc:	6442                	ld	s0,16(sp)
    80004bce:	64a2                	ld	s1,8(sp)
    80004bd0:	6902                	ld	s2,0(sp)
    80004bd2:	6105                	addi	sp,sp,32
    80004bd4:	8082                	ret

0000000080004bd6 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004bd6:	1101                	addi	sp,sp,-32
    80004bd8:	ec06                	sd	ra,24(sp)
    80004bda:	e822                	sd	s0,16(sp)
    80004bdc:	e426                	sd	s1,8(sp)
    80004bde:	e04a                	sd	s2,0(sp)
    80004be0:	1000                	addi	s0,sp,32
    80004be2:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004be4:	00850913          	addi	s2,a0,8
    80004be8:	854a                	mv	a0,s2
    80004bea:	ffffc097          	auipc	ra,0xffffc
    80004bee:	146080e7          	jalr	326(ra) # 80000d30 <acquire>
  while (lk->locked) {
    80004bf2:	409c                	lw	a5,0(s1)
    80004bf4:	cb89                	beqz	a5,80004c06 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004bf6:	85ca                	mv	a1,s2
    80004bf8:	8526                	mv	a0,s1
    80004bfa:	ffffe097          	auipc	ra,0xffffe
    80004bfe:	bfa080e7          	jalr	-1030(ra) # 800027f4 <sleep>
  while (lk->locked) {
    80004c02:	409c                	lw	a5,0(s1)
    80004c04:	fbed                	bnez	a5,80004bf6 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004c06:	4785                	li	a5,1
    80004c08:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80004c0a:	ffffd097          	auipc	ra,0xffffd
    80004c0e:	3f0080e7          	jalr	1008(ra) # 80001ffa <myproc>
    80004c12:	493c                	lw	a5,80(a0)
    80004c14:	c0bc                	sw	a5,64(s1)
  release(&lk->lk);
    80004c16:	854a                	mv	a0,s2
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	364080e7          	jalr	868(ra) # 80000f7c <release>
}
    80004c20:	60e2                	ld	ra,24(sp)
    80004c22:	6442                	ld	s0,16(sp)
    80004c24:	64a2                	ld	s1,8(sp)
    80004c26:	6902                	ld	s2,0(sp)
    80004c28:	6105                	addi	sp,sp,32
    80004c2a:	8082                	ret

0000000080004c2c <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004c2c:	1101                	addi	sp,sp,-32
    80004c2e:	ec06                	sd	ra,24(sp)
    80004c30:	e822                	sd	s0,16(sp)
    80004c32:	e426                	sd	s1,8(sp)
    80004c34:	e04a                	sd	s2,0(sp)
    80004c36:	1000                	addi	s0,sp,32
    80004c38:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004c3a:	00850913          	addi	s2,a0,8
    80004c3e:	854a                	mv	a0,s2
    80004c40:	ffffc097          	auipc	ra,0xffffc
    80004c44:	0f0080e7          	jalr	240(ra) # 80000d30 <acquire>
  lk->locked = 0;
    80004c48:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004c4c:	0404a023          	sw	zero,64(s1)
  wakeup(lk);
    80004c50:	8526                	mv	a0,s1
    80004c52:	ffffe097          	auipc	ra,0xffffe
    80004c56:	d28080e7          	jalr	-728(ra) # 8000297a <wakeup>
  release(&lk->lk);
    80004c5a:	854a                	mv	a0,s2
    80004c5c:	ffffc097          	auipc	ra,0xffffc
    80004c60:	320080e7          	jalr	800(ra) # 80000f7c <release>
}
    80004c64:	60e2                	ld	ra,24(sp)
    80004c66:	6442                	ld	s0,16(sp)
    80004c68:	64a2                	ld	s1,8(sp)
    80004c6a:	6902                	ld	s2,0(sp)
    80004c6c:	6105                	addi	sp,sp,32
    80004c6e:	8082                	ret

0000000080004c70 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004c70:	7179                	addi	sp,sp,-48
    80004c72:	f406                	sd	ra,40(sp)
    80004c74:	f022                	sd	s0,32(sp)
    80004c76:	ec26                	sd	s1,24(sp)
    80004c78:	e84a                	sd	s2,16(sp)
    80004c7a:	e44e                	sd	s3,8(sp)
    80004c7c:	1800                	addi	s0,sp,48
    80004c7e:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004c80:	00850913          	addi	s2,a0,8
    80004c84:	854a                	mv	a0,s2
    80004c86:	ffffc097          	auipc	ra,0xffffc
    80004c8a:	0aa080e7          	jalr	170(ra) # 80000d30 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80004c8e:	409c                	lw	a5,0(s1)
    80004c90:	ef99                	bnez	a5,80004cae <holdingsleep+0x3e>
    80004c92:	4481                	li	s1,0
  release(&lk->lk);
    80004c94:	854a                	mv	a0,s2
    80004c96:	ffffc097          	auipc	ra,0xffffc
    80004c9a:	2e6080e7          	jalr	742(ra) # 80000f7c <release>
  return r;
}
    80004c9e:	8526                	mv	a0,s1
    80004ca0:	70a2                	ld	ra,40(sp)
    80004ca2:	7402                	ld	s0,32(sp)
    80004ca4:	64e2                	ld	s1,24(sp)
    80004ca6:	6942                	ld	s2,16(sp)
    80004ca8:	69a2                	ld	s3,8(sp)
    80004caa:	6145                	addi	sp,sp,48
    80004cac:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80004cae:	0404a983          	lw	s3,64(s1)
    80004cb2:	ffffd097          	auipc	ra,0xffffd
    80004cb6:	348080e7          	jalr	840(ra) # 80001ffa <myproc>
    80004cba:	4924                	lw	s1,80(a0)
    80004cbc:	413484b3          	sub	s1,s1,s3
    80004cc0:	0014b493          	seqz	s1,s1
    80004cc4:	bfc1                	j	80004c94 <holdingsleep+0x24>

0000000080004cc6 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004cc6:	1141                	addi	sp,sp,-16
    80004cc8:	e406                	sd	ra,8(sp)
    80004cca:	e022                	sd	s0,0(sp)
    80004ccc:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004cce:	00004597          	auipc	a1,0x4
    80004cd2:	f3a58593          	addi	a1,a1,-198 # 80008c08 <userret+0xb78>
    80004cd6:	00022517          	auipc	a0,0x22
    80004cda:	f6250513          	addi	a0,a0,-158 # 80026c38 <ftable>
    80004cde:	ffffc097          	auipc	ra,0xffffc
    80004ce2:	ee4080e7          	jalr	-284(ra) # 80000bc2 <initlock>
}
    80004ce6:	60a2                	ld	ra,8(sp)
    80004ce8:	6402                	ld	s0,0(sp)
    80004cea:	0141                	addi	sp,sp,16
    80004cec:	8082                	ret

0000000080004cee <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004cee:	1101                	addi	sp,sp,-32
    80004cf0:	ec06                	sd	ra,24(sp)
    80004cf2:	e822                	sd	s0,16(sp)
    80004cf4:	e426                	sd	s1,8(sp)
    80004cf6:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80004cf8:	00022517          	auipc	a0,0x22
    80004cfc:	f4050513          	addi	a0,a0,-192 # 80026c38 <ftable>
    80004d00:	ffffc097          	auipc	ra,0xffffc
    80004d04:	030080e7          	jalr	48(ra) # 80000d30 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    80004d08:	00022797          	auipc	a5,0x22
    80004d0c:	f3078793          	addi	a5,a5,-208 # 80026c38 <ftable>
    80004d10:	5bdc                	lw	a5,52(a5)
    80004d12:	cb8d                	beqz	a5,80004d44 <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004d14:	00022497          	auipc	s1,0x22
    80004d18:	f7c48493          	addi	s1,s1,-132 # 80026c90 <ftable+0x58>
    80004d1c:	00023717          	auipc	a4,0x23
    80004d20:	eec70713          	addi	a4,a4,-276 # 80027c08 <ftable+0xfd0>
    if(f->ref == 0){
    80004d24:	40dc                	lw	a5,4(s1)
    80004d26:	c39d                	beqz	a5,80004d4c <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004d28:	02848493          	addi	s1,s1,40
    80004d2c:	fee49ce3          	bne	s1,a4,80004d24 <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004d30:	00022517          	auipc	a0,0x22
    80004d34:	f0850513          	addi	a0,a0,-248 # 80026c38 <ftable>
    80004d38:	ffffc097          	auipc	ra,0xffffc
    80004d3c:	244080e7          	jalr	580(ra) # 80000f7c <release>
  return 0;
    80004d40:	4481                	li	s1,0
    80004d42:	a839                	j	80004d60 <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004d44:	00022497          	auipc	s1,0x22
    80004d48:	f2448493          	addi	s1,s1,-220 # 80026c68 <ftable+0x30>
      f->ref = 1;
    80004d4c:	4785                	li	a5,1
    80004d4e:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80004d50:	00022517          	auipc	a0,0x22
    80004d54:	ee850513          	addi	a0,a0,-280 # 80026c38 <ftable>
    80004d58:	ffffc097          	auipc	ra,0xffffc
    80004d5c:	224080e7          	jalr	548(ra) # 80000f7c <release>
}
    80004d60:	8526                	mv	a0,s1
    80004d62:	60e2                	ld	ra,24(sp)
    80004d64:	6442                	ld	s0,16(sp)
    80004d66:	64a2                	ld	s1,8(sp)
    80004d68:	6105                	addi	sp,sp,32
    80004d6a:	8082                	ret

0000000080004d6c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004d6c:	1101                	addi	sp,sp,-32
    80004d6e:	ec06                	sd	ra,24(sp)
    80004d70:	e822                	sd	s0,16(sp)
    80004d72:	e426                	sd	s1,8(sp)
    80004d74:	1000                	addi	s0,sp,32
    80004d76:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80004d78:	00022517          	auipc	a0,0x22
    80004d7c:	ec050513          	addi	a0,a0,-320 # 80026c38 <ftable>
    80004d80:	ffffc097          	auipc	ra,0xffffc
    80004d84:	fb0080e7          	jalr	-80(ra) # 80000d30 <acquire>
  if(f->ref < 1)
    80004d88:	40dc                	lw	a5,4(s1)
    80004d8a:	02f05263          	blez	a5,80004dae <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004d8e:	2785                	addiw	a5,a5,1
    80004d90:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004d92:	00022517          	auipc	a0,0x22
    80004d96:	ea650513          	addi	a0,a0,-346 # 80026c38 <ftable>
    80004d9a:	ffffc097          	auipc	ra,0xffffc
    80004d9e:	1e2080e7          	jalr	482(ra) # 80000f7c <release>
  return f;
}
    80004da2:	8526                	mv	a0,s1
    80004da4:	60e2                	ld	ra,24(sp)
    80004da6:	6442                	ld	s0,16(sp)
    80004da8:	64a2                	ld	s1,8(sp)
    80004daa:	6105                	addi	sp,sp,32
    80004dac:	8082                	ret
    panic("filedup");
    80004dae:	00004517          	auipc	a0,0x4
    80004db2:	e6250513          	addi	a0,a0,-414 # 80008c10 <userret+0xb80>
    80004db6:	ffffc097          	auipc	ra,0xffffc
    80004dba:	a10080e7          	jalr	-1520(ra) # 800007c6 <panic>

0000000080004dbe <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004dbe:	7139                	addi	sp,sp,-64
    80004dc0:	fc06                	sd	ra,56(sp)
    80004dc2:	f822                	sd	s0,48(sp)
    80004dc4:	f426                	sd	s1,40(sp)
    80004dc6:	f04a                	sd	s2,32(sp)
    80004dc8:	ec4e                	sd	s3,24(sp)
    80004dca:	e852                	sd	s4,16(sp)
    80004dcc:	e456                	sd	s5,8(sp)
    80004dce:	0080                	addi	s0,sp,64
    80004dd0:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004dd2:	00022517          	auipc	a0,0x22
    80004dd6:	e6650513          	addi	a0,a0,-410 # 80026c38 <ftable>
    80004dda:	ffffc097          	auipc	ra,0xffffc
    80004dde:	f56080e7          	jalr	-170(ra) # 80000d30 <acquire>
  if(f->ref < 1)
    80004de2:	40dc                	lw	a5,4(s1)
    80004de4:	06f05563          	blez	a5,80004e4e <fileclose+0x90>
    panic("fileclose");
  if(--f->ref > 0){
    80004de8:	37fd                	addiw	a5,a5,-1
    80004dea:	0007871b          	sext.w	a4,a5
    80004dee:	c0dc                	sw	a5,4(s1)
    80004df0:	06e04763          	bgtz	a4,80004e5e <fileclose+0xa0>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004df4:	0004a903          	lw	s2,0(s1)
    80004df8:	0094ca83          	lbu	s5,9(s1)
    80004dfc:	0104ba03          	ld	s4,16(s1)
    80004e00:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004e04:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004e08:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004e0c:	00022517          	auipc	a0,0x22
    80004e10:	e2c50513          	addi	a0,a0,-468 # 80026c38 <ftable>
    80004e14:	ffffc097          	auipc	ra,0xffffc
    80004e18:	168080e7          	jalr	360(ra) # 80000f7c <release>

  if(ff.type == FD_PIPE){
    80004e1c:	4785                	li	a5,1
    80004e1e:	06f90163          	beq	s2,a5,80004e80 <fileclose+0xc2>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004e22:	3979                	addiw	s2,s2,-2
    80004e24:	4785                	li	a5,1
    80004e26:	0527e463          	bltu	a5,s2,80004e6e <fileclose+0xb0>
    begin_op(ff.ip->dev);
    80004e2a:	0009a503          	lw	a0,0(s3)
    80004e2e:	00000097          	auipc	ra,0x0
    80004e32:	9d4080e7          	jalr	-1580(ra) # 80004802 <begin_op>
    iput(ff.ip);
    80004e36:	854e                	mv	a0,s3
    80004e38:	fffff097          	auipc	ra,0xfffff
    80004e3c:	100080e7          	jalr	256(ra) # 80003f38 <iput>
    end_op(ff.ip->dev);
    80004e40:	0009a503          	lw	a0,0(s3)
    80004e44:	00000097          	auipc	ra,0x0
    80004e48:	a6a080e7          	jalr	-1430(ra) # 800048ae <end_op>
    80004e4c:	a00d                	j	80004e6e <fileclose+0xb0>
    panic("fileclose");
    80004e4e:	00004517          	auipc	a0,0x4
    80004e52:	dca50513          	addi	a0,a0,-566 # 80008c18 <userret+0xb88>
    80004e56:	ffffc097          	auipc	ra,0xffffc
    80004e5a:	970080e7          	jalr	-1680(ra) # 800007c6 <panic>
    release(&ftable.lock);
    80004e5e:	00022517          	auipc	a0,0x22
    80004e62:	dda50513          	addi	a0,a0,-550 # 80026c38 <ftable>
    80004e66:	ffffc097          	auipc	ra,0xffffc
    80004e6a:	116080e7          	jalr	278(ra) # 80000f7c <release>
  }
}
    80004e6e:	70e2                	ld	ra,56(sp)
    80004e70:	7442                	ld	s0,48(sp)
    80004e72:	74a2                	ld	s1,40(sp)
    80004e74:	7902                	ld	s2,32(sp)
    80004e76:	69e2                	ld	s3,24(sp)
    80004e78:	6a42                	ld	s4,16(sp)
    80004e7a:	6aa2                	ld	s5,8(sp)
    80004e7c:	6121                	addi	sp,sp,64
    80004e7e:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004e80:	85d6                	mv	a1,s5
    80004e82:	8552                	mv	a0,s4
    80004e84:	00000097          	auipc	ra,0x0
    80004e88:	376080e7          	jalr	886(ra) # 800051fa <pipeclose>
    80004e8c:	b7cd                	j	80004e6e <fileclose+0xb0>

0000000080004e8e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004e8e:	715d                	addi	sp,sp,-80
    80004e90:	e486                	sd	ra,72(sp)
    80004e92:	e0a2                	sd	s0,64(sp)
    80004e94:	fc26                	sd	s1,56(sp)
    80004e96:	f84a                	sd	s2,48(sp)
    80004e98:	f44e                	sd	s3,40(sp)
    80004e9a:	0880                	addi	s0,sp,80
    80004e9c:	84aa                	mv	s1,a0
    80004e9e:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004ea0:	ffffd097          	auipc	ra,0xffffd
    80004ea4:	15a080e7          	jalr	346(ra) # 80001ffa <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004ea8:	409c                	lw	a5,0(s1)
    80004eaa:	37f9                	addiw	a5,a5,-2
    80004eac:	4705                	li	a4,1
    80004eae:	04f76763          	bltu	a4,a5,80004efc <filestat+0x6e>
    80004eb2:	892a                	mv	s2,a0
    ilock(f->ip);
    80004eb4:	6c88                	ld	a0,24(s1)
    80004eb6:	fffff097          	auipc	ra,0xfffff
    80004eba:	f72080e7          	jalr	-142(ra) # 80003e28 <ilock>
    stati(f->ip, &st);
    80004ebe:	fb840593          	addi	a1,s0,-72
    80004ec2:	6c88                	ld	a0,24(s1)
    80004ec4:	fffff097          	auipc	ra,0xfffff
    80004ec8:	1cc080e7          	jalr	460(ra) # 80004090 <stati>
    iunlock(f->ip);
    80004ecc:	6c88                	ld	a0,24(s1)
    80004ece:	fffff097          	auipc	ra,0xfffff
    80004ed2:	01e080e7          	jalr	30(ra) # 80003eec <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004ed6:	46e1                	li	a3,24
    80004ed8:	fb840613          	addi	a2,s0,-72
    80004edc:	85ce                	mv	a1,s3
    80004ede:	06893503          	ld	a0,104(s2)
    80004ee2:	ffffd097          	auipc	ra,0xffffd
    80004ee6:	dc2080e7          	jalr	-574(ra) # 80001ca4 <copyout>
    80004eea:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004eee:	60a6                	ld	ra,72(sp)
    80004ef0:	6406                	ld	s0,64(sp)
    80004ef2:	74e2                	ld	s1,56(sp)
    80004ef4:	7942                	ld	s2,48(sp)
    80004ef6:	79a2                	ld	s3,40(sp)
    80004ef8:	6161                	addi	sp,sp,80
    80004efa:	8082                	ret
  return -1;
    80004efc:	557d                	li	a0,-1
    80004efe:	bfc5                	j	80004eee <filestat+0x60>

0000000080004f00 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004f00:	7179                	addi	sp,sp,-48
    80004f02:	f406                	sd	ra,40(sp)
    80004f04:	f022                	sd	s0,32(sp)
    80004f06:	ec26                	sd	s1,24(sp)
    80004f08:	e84a                	sd	s2,16(sp)
    80004f0a:	e44e                	sd	s3,8(sp)
    80004f0c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004f0e:	00854783          	lbu	a5,8(a0)
    80004f12:	c7c5                	beqz	a5,80004fba <fileread+0xba>
    80004f14:	89b2                	mv	s3,a2
    80004f16:	892e                	mv	s2,a1
    80004f18:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80004f1a:	411c                	lw	a5,0(a0)
    80004f1c:	4705                	li	a4,1
    80004f1e:	04e78963          	beq	a5,a4,80004f70 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004f22:	470d                	li	a4,3
    80004f24:	04e78d63          	beq	a5,a4,80004f7e <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(f, 1, addr, n);
  } else if(f->type == FD_INODE){
    80004f28:	4709                	li	a4,2
    80004f2a:	08e79063          	bne	a5,a4,80004faa <fileread+0xaa>
    ilock(f->ip);
    80004f2e:	6d08                	ld	a0,24(a0)
    80004f30:	fffff097          	auipc	ra,0xfffff
    80004f34:	ef8080e7          	jalr	-264(ra) # 80003e28 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004f38:	874e                	mv	a4,s3
    80004f3a:	5094                	lw	a3,32(s1)
    80004f3c:	864a                	mv	a2,s2
    80004f3e:	4585                	li	a1,1
    80004f40:	6c88                	ld	a0,24(s1)
    80004f42:	fffff097          	auipc	ra,0xfffff
    80004f46:	178080e7          	jalr	376(ra) # 800040ba <readi>
    80004f4a:	892a                	mv	s2,a0
    80004f4c:	00a05563          	blez	a0,80004f56 <fileread+0x56>
      f->off += r;
    80004f50:	509c                	lw	a5,32(s1)
    80004f52:	9fa9                	addw	a5,a5,a0
    80004f54:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004f56:	6c88                	ld	a0,24(s1)
    80004f58:	fffff097          	auipc	ra,0xfffff
    80004f5c:	f94080e7          	jalr	-108(ra) # 80003eec <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004f60:	854a                	mv	a0,s2
    80004f62:	70a2                	ld	ra,40(sp)
    80004f64:	7402                	ld	s0,32(sp)
    80004f66:	64e2                	ld	s1,24(sp)
    80004f68:	6942                	ld	s2,16(sp)
    80004f6a:	69a2                	ld	s3,8(sp)
    80004f6c:	6145                	addi	sp,sp,48
    80004f6e:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004f70:	6908                	ld	a0,16(a0)
    80004f72:	00000097          	auipc	ra,0x0
    80004f76:	412080e7          	jalr	1042(ra) # 80005384 <piperead>
    80004f7a:	892a                	mv	s2,a0
    80004f7c:	b7d5                	j	80004f60 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004f7e:	02451783          	lh	a5,36(a0)
    80004f82:	03079693          	slli	a3,a5,0x30
    80004f86:	92c1                	srli	a3,a3,0x30
    80004f88:	4725                	li	a4,9
    80004f8a:	02d76a63          	bltu	a4,a3,80004fbe <fileread+0xbe>
    80004f8e:	0792                	slli	a5,a5,0x4
    80004f90:	00022717          	auipc	a4,0x22
    80004f94:	c0870713          	addi	a4,a4,-1016 # 80026b98 <devsw>
    80004f98:	97ba                	add	a5,a5,a4
    80004f9a:	639c                	ld	a5,0(a5)
    80004f9c:	c39d                	beqz	a5,80004fc2 <fileread+0xc2>
    r = devsw[f->major].read(f, 1, addr, n);
    80004f9e:	86b2                	mv	a3,a2
    80004fa0:	862e                	mv	a2,a1
    80004fa2:	4585                	li	a1,1
    80004fa4:	9782                	jalr	a5
    80004fa6:	892a                	mv	s2,a0
    80004fa8:	bf65                	j	80004f60 <fileread+0x60>
    panic("fileread");
    80004faa:	00004517          	auipc	a0,0x4
    80004fae:	c7e50513          	addi	a0,a0,-898 # 80008c28 <userret+0xb98>
    80004fb2:	ffffc097          	auipc	ra,0xffffc
    80004fb6:	814080e7          	jalr	-2028(ra) # 800007c6 <panic>
    return -1;
    80004fba:	597d                	li	s2,-1
    80004fbc:	b755                	j	80004f60 <fileread+0x60>
      return -1;
    80004fbe:	597d                	li	s2,-1
    80004fc0:	b745                	j	80004f60 <fileread+0x60>
    80004fc2:	597d                	li	s2,-1
    80004fc4:	bf71                	j	80004f60 <fileread+0x60>

0000000080004fc6 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80004fc6:	00954783          	lbu	a5,9(a0)
    80004fca:	14078663          	beqz	a5,80005116 <filewrite+0x150>
{
    80004fce:	715d                	addi	sp,sp,-80
    80004fd0:	e486                	sd	ra,72(sp)
    80004fd2:	e0a2                	sd	s0,64(sp)
    80004fd4:	fc26                	sd	s1,56(sp)
    80004fd6:	f84a                	sd	s2,48(sp)
    80004fd8:	f44e                	sd	s3,40(sp)
    80004fda:	f052                	sd	s4,32(sp)
    80004fdc:	ec56                	sd	s5,24(sp)
    80004fde:	e85a                	sd	s6,16(sp)
    80004fe0:	e45e                	sd	s7,8(sp)
    80004fe2:	e062                	sd	s8,0(sp)
    80004fe4:	0880                	addi	s0,sp,80
    80004fe6:	8ab2                	mv	s5,a2
    80004fe8:	8b2e                	mv	s6,a1
    80004fea:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80004fec:	411c                	lw	a5,0(a0)
    80004fee:	4705                	li	a4,1
    80004ff0:	02e78263          	beq	a5,a4,80005014 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004ff4:	470d                	li	a4,3
    80004ff6:	02e78563          	beq	a5,a4,80005020 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(f, 1, addr, n);
  } else if(f->type == FD_INODE){
    80004ffa:	4709                	li	a4,2
    80004ffc:	10e79563          	bne	a5,a4,80005106 <filewrite+0x140>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80005000:	0ec05f63          	blez	a2,800050fe <filewrite+0x138>
    int i = 0;
    80005004:	4901                	li	s2,0
    80005006:	6b85                	lui	s7,0x1
    80005008:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    8000500c:	6c05                	lui	s8,0x1
    8000500e:	c00c0c1b          	addiw	s8,s8,-1024
    80005012:	a851                	j	800050a6 <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80005014:	6908                	ld	a0,16(a0)
    80005016:	00000097          	auipc	ra,0x0
    8000501a:	254080e7          	jalr	596(ra) # 8000526a <pipewrite>
    8000501e:	a865                	j	800050d6 <filewrite+0x110>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80005020:	02451783          	lh	a5,36(a0)
    80005024:	03079693          	slli	a3,a5,0x30
    80005028:	92c1                	srli	a3,a3,0x30
    8000502a:	4725                	li	a4,9
    8000502c:	0ed76763          	bltu	a4,a3,8000511a <filewrite+0x154>
    80005030:	0792                	slli	a5,a5,0x4
    80005032:	00022717          	auipc	a4,0x22
    80005036:	b6670713          	addi	a4,a4,-1178 # 80026b98 <devsw>
    8000503a:	97ba                	add	a5,a5,a4
    8000503c:	679c                	ld	a5,8(a5)
    8000503e:	c3e5                	beqz	a5,8000511e <filewrite+0x158>
    ret = devsw[f->major].write(f, 1, addr, n);
    80005040:	86b2                	mv	a3,a2
    80005042:	862e                	mv	a2,a1
    80005044:	4585                	li	a1,1
    80005046:	9782                	jalr	a5
    80005048:	a079                	j	800050d6 <filewrite+0x110>
    8000504a:	00098a1b          	sext.w	s4,s3
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op(f->ip->dev);
    8000504e:	6c9c                	ld	a5,24(s1)
    80005050:	4388                	lw	a0,0(a5)
    80005052:	fffff097          	auipc	ra,0xfffff
    80005056:	7b0080e7          	jalr	1968(ra) # 80004802 <begin_op>
      ilock(f->ip);
    8000505a:	6c88                	ld	a0,24(s1)
    8000505c:	fffff097          	auipc	ra,0xfffff
    80005060:	dcc080e7          	jalr	-564(ra) # 80003e28 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80005064:	8752                	mv	a4,s4
    80005066:	5094                	lw	a3,32(s1)
    80005068:	01690633          	add	a2,s2,s6
    8000506c:	4585                	li	a1,1
    8000506e:	6c88                	ld	a0,24(s1)
    80005070:	fffff097          	auipc	ra,0xfffff
    80005074:	13e080e7          	jalr	318(ra) # 800041ae <writei>
    80005078:	89aa                	mv	s3,a0
    8000507a:	02a05e63          	blez	a0,800050b6 <filewrite+0xf0>
        f->off += r;
    8000507e:	509c                	lw	a5,32(s1)
    80005080:	9fa9                	addw	a5,a5,a0
    80005082:	d09c                	sw	a5,32(s1)
      iunlock(f->ip);
    80005084:	6c88                	ld	a0,24(s1)
    80005086:	fffff097          	auipc	ra,0xfffff
    8000508a:	e66080e7          	jalr	-410(ra) # 80003eec <iunlock>
      end_op(f->ip->dev);
    8000508e:	6c9c                	ld	a5,24(s1)
    80005090:	4388                	lw	a0,0(a5)
    80005092:	00000097          	auipc	ra,0x0
    80005096:	81c080e7          	jalr	-2020(ra) # 800048ae <end_op>

      if(r < 0)
        break;
      if(r != n1)
    8000509a:	05499a63          	bne	s3,s4,800050ee <filewrite+0x128>
        panic("short filewrite");
      i += r;
    8000509e:	012a093b          	addw	s2,s4,s2
    while(i < n){
    800050a2:	03595763          	ble	s5,s2,800050d0 <filewrite+0x10a>
      int n1 = n - i;
    800050a6:	412a87bb          	subw	a5,s5,s2
      if(n1 > max)
    800050aa:	89be                	mv	s3,a5
    800050ac:	2781                	sext.w	a5,a5
    800050ae:	f8fbdee3          	ble	a5,s7,8000504a <filewrite+0x84>
    800050b2:	89e2                	mv	s3,s8
    800050b4:	bf59                	j	8000504a <filewrite+0x84>
      iunlock(f->ip);
    800050b6:	6c88                	ld	a0,24(s1)
    800050b8:	fffff097          	auipc	ra,0xfffff
    800050bc:	e34080e7          	jalr	-460(ra) # 80003eec <iunlock>
      end_op(f->ip->dev);
    800050c0:	6c9c                	ld	a5,24(s1)
    800050c2:	4388                	lw	a0,0(a5)
    800050c4:	fffff097          	auipc	ra,0xfffff
    800050c8:	7ea080e7          	jalr	2026(ra) # 800048ae <end_op>
      if(r < 0)
    800050cc:	fc09d7e3          	bgez	s3,8000509a <filewrite+0xd4>
    }
    ret = (i == n ? n : -1);
    800050d0:	8556                	mv	a0,s5
    800050d2:	032a9863          	bne	s5,s2,80005102 <filewrite+0x13c>
  } else {
    panic("filewrite");
  }

  return ret;
}
    800050d6:	60a6                	ld	ra,72(sp)
    800050d8:	6406                	ld	s0,64(sp)
    800050da:	74e2                	ld	s1,56(sp)
    800050dc:	7942                	ld	s2,48(sp)
    800050de:	79a2                	ld	s3,40(sp)
    800050e0:	7a02                	ld	s4,32(sp)
    800050e2:	6ae2                	ld	s5,24(sp)
    800050e4:	6b42                	ld	s6,16(sp)
    800050e6:	6ba2                	ld	s7,8(sp)
    800050e8:	6c02                	ld	s8,0(sp)
    800050ea:	6161                	addi	sp,sp,80
    800050ec:	8082                	ret
        panic("short filewrite");
    800050ee:	00004517          	auipc	a0,0x4
    800050f2:	b4a50513          	addi	a0,a0,-1206 # 80008c38 <userret+0xba8>
    800050f6:	ffffb097          	auipc	ra,0xffffb
    800050fa:	6d0080e7          	jalr	1744(ra) # 800007c6 <panic>
    int i = 0;
    800050fe:	4901                	li	s2,0
    80005100:	bfc1                	j	800050d0 <filewrite+0x10a>
    ret = (i == n ? n : -1);
    80005102:	557d                	li	a0,-1
    80005104:	bfc9                	j	800050d6 <filewrite+0x110>
    panic("filewrite");
    80005106:	00004517          	auipc	a0,0x4
    8000510a:	b4250513          	addi	a0,a0,-1214 # 80008c48 <userret+0xbb8>
    8000510e:	ffffb097          	auipc	ra,0xffffb
    80005112:	6b8080e7          	jalr	1720(ra) # 800007c6 <panic>
    return -1;
    80005116:	557d                	li	a0,-1
}
    80005118:	8082                	ret
      return -1;
    8000511a:	557d                	li	a0,-1
    8000511c:	bf6d                	j	800050d6 <filewrite+0x110>
    8000511e:	557d                	li	a0,-1
    80005120:	bf5d                	j	800050d6 <filewrite+0x110>

0000000080005122 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80005122:	7179                	addi	sp,sp,-48
    80005124:	f406                	sd	ra,40(sp)
    80005126:	f022                	sd	s0,32(sp)
    80005128:	ec26                	sd	s1,24(sp)
    8000512a:	e84a                	sd	s2,16(sp)
    8000512c:	e44e                	sd	s3,8(sp)
    8000512e:	e052                	sd	s4,0(sp)
    80005130:	1800                	addi	s0,sp,48
    80005132:	84aa                	mv	s1,a0
    80005134:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80005136:	0005b023          	sd	zero,0(a1)
    8000513a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    8000513e:	00000097          	auipc	ra,0x0
    80005142:	bb0080e7          	jalr	-1104(ra) # 80004cee <filealloc>
    80005146:	e088                	sd	a0,0(s1)
    80005148:	c549                	beqz	a0,800051d2 <pipealloc+0xb0>
    8000514a:	00000097          	auipc	ra,0x0
    8000514e:	ba4080e7          	jalr	-1116(ra) # 80004cee <filealloc>
    80005152:	00a93023          	sd	a0,0(s2)
    80005156:	c925                	beqz	a0,800051c6 <pipealloc+0xa4>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80005158:	ffffc097          	auipc	ra,0xffffc
    8000515c:	a50080e7          	jalr	-1456(ra) # 80000ba8 <kalloc>
    80005160:	89aa                	mv	s3,a0
    80005162:	cd39                	beqz	a0,800051c0 <pipealloc+0x9e>
    goto bad;
  pi->readopen = 1;
    80005164:	4a05                	li	s4,1
    80005166:	23452c23          	sw	s4,568(a0)
  pi->writeopen = 1;
    8000516a:	23452e23          	sw	s4,572(a0)
  pi->nwrite = 0;
    8000516e:	22052a23          	sw	zero,564(a0)
  pi->nread = 0;
    80005172:	22052823          	sw	zero,560(a0)
  memset(&pi->lock, 0, sizeof(pi->lock));
    80005176:	03000613          	li	a2,48
    8000517a:	4581                	li	a1,0
    8000517c:	ffffc097          	auipc	ra,0xffffc
    80005180:	028080e7          	jalr	40(ra) # 800011a4 <memset>
  (*f0)->type = FD_PIPE;
    80005184:	609c                	ld	a5,0(s1)
    80005186:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    8000518a:	609c                	ld	a5,0(s1)
    8000518c:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    80005190:	609c                	ld	a5,0(s1)
    80005192:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80005196:	609c                	ld	a5,0(s1)
    80005198:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    8000519c:	00093783          	ld	a5,0(s2)
    800051a0:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    800051a4:	00093783          	ld	a5,0(s2)
    800051a8:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800051ac:	00093783          	ld	a5,0(s2)
    800051b0:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    800051b4:	00093783          	ld	a5,0(s2)
    800051b8:	0137b823          	sd	s3,16(a5)
  return 0;
    800051bc:	4501                	li	a0,0
    800051be:	a025                	j	800051e6 <pipealloc+0xc4>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    800051c0:	6088                	ld	a0,0(s1)
    800051c2:	e501                	bnez	a0,800051ca <pipealloc+0xa8>
    800051c4:	a039                	j	800051d2 <pipealloc+0xb0>
    800051c6:	6088                	ld	a0,0(s1)
    800051c8:	c51d                	beqz	a0,800051f6 <pipealloc+0xd4>
    fileclose(*f0);
    800051ca:	00000097          	auipc	ra,0x0
    800051ce:	bf4080e7          	jalr	-1036(ra) # 80004dbe <fileclose>
  if(*f1)
    800051d2:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    800051d6:	557d                	li	a0,-1
  if(*f1)
    800051d8:	c799                	beqz	a5,800051e6 <pipealloc+0xc4>
    fileclose(*f1);
    800051da:	853e                	mv	a0,a5
    800051dc:	00000097          	auipc	ra,0x0
    800051e0:	be2080e7          	jalr	-1054(ra) # 80004dbe <fileclose>
  return -1;
    800051e4:	557d                	li	a0,-1
}
    800051e6:	70a2                	ld	ra,40(sp)
    800051e8:	7402                	ld	s0,32(sp)
    800051ea:	64e2                	ld	s1,24(sp)
    800051ec:	6942                	ld	s2,16(sp)
    800051ee:	69a2                	ld	s3,8(sp)
    800051f0:	6a02                	ld	s4,0(sp)
    800051f2:	6145                	addi	sp,sp,48
    800051f4:	8082                	ret
  return -1;
    800051f6:	557d                	li	a0,-1
    800051f8:	b7fd                	j	800051e6 <pipealloc+0xc4>

00000000800051fa <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800051fa:	1101                	addi	sp,sp,-32
    800051fc:	ec06                	sd	ra,24(sp)
    800051fe:	e822                	sd	s0,16(sp)
    80005200:	e426                	sd	s1,8(sp)
    80005202:	e04a                	sd	s2,0(sp)
    80005204:	1000                	addi	s0,sp,32
    80005206:	84aa                	mv	s1,a0
    80005208:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000520a:	ffffc097          	auipc	ra,0xffffc
    8000520e:	b26080e7          	jalr	-1242(ra) # 80000d30 <acquire>
  if(writable){
    80005212:	02090d63          	beqz	s2,8000524c <pipeclose+0x52>
    pi->writeopen = 0;
    80005216:	2204ae23          	sw	zero,572(s1)
    wakeup(&pi->nread);
    8000521a:	23048513          	addi	a0,s1,560
    8000521e:	ffffd097          	auipc	ra,0xffffd
    80005222:	75c080e7          	jalr	1884(ra) # 8000297a <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80005226:	2384b783          	ld	a5,568(s1)
    8000522a:	eb95                	bnez	a5,8000525e <pipeclose+0x64>
    release(&pi->lock);
    8000522c:	8526                	mv	a0,s1
    8000522e:	ffffc097          	auipc	ra,0xffffc
    80005232:	d4e080e7          	jalr	-690(ra) # 80000f7c <release>
    kfree((char*)pi);
    80005236:	8526                	mv	a0,s1
    80005238:	ffffc097          	auipc	ra,0xffffc
    8000523c:	958080e7          	jalr	-1704(ra) # 80000b90 <kfree>
  } else
    release(&pi->lock);
}
    80005240:	60e2                	ld	ra,24(sp)
    80005242:	6442                	ld	s0,16(sp)
    80005244:	64a2                	ld	s1,8(sp)
    80005246:	6902                	ld	s2,0(sp)
    80005248:	6105                	addi	sp,sp,32
    8000524a:	8082                	ret
    pi->readopen = 0;
    8000524c:	2204ac23          	sw	zero,568(s1)
    wakeup(&pi->nwrite);
    80005250:	23448513          	addi	a0,s1,564
    80005254:	ffffd097          	auipc	ra,0xffffd
    80005258:	726080e7          	jalr	1830(ra) # 8000297a <wakeup>
    8000525c:	b7e9                	j	80005226 <pipeclose+0x2c>
    release(&pi->lock);
    8000525e:	8526                	mv	a0,s1
    80005260:	ffffc097          	auipc	ra,0xffffc
    80005264:	d1c080e7          	jalr	-740(ra) # 80000f7c <release>
}
    80005268:	bfe1                	j	80005240 <pipeclose+0x46>

000000008000526a <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000526a:	7159                	addi	sp,sp,-112
    8000526c:	f486                	sd	ra,104(sp)
    8000526e:	f0a2                	sd	s0,96(sp)
    80005270:	eca6                	sd	s1,88(sp)
    80005272:	e8ca                	sd	s2,80(sp)
    80005274:	e4ce                	sd	s3,72(sp)
    80005276:	e0d2                	sd	s4,64(sp)
    80005278:	fc56                	sd	s5,56(sp)
    8000527a:	f85a                	sd	s6,48(sp)
    8000527c:	f45e                	sd	s7,40(sp)
    8000527e:	f062                	sd	s8,32(sp)
    80005280:	ec66                	sd	s9,24(sp)
    80005282:	1880                	addi	s0,sp,112
    80005284:	84aa                	mv	s1,a0
    80005286:	8bae                	mv	s7,a1
    80005288:	8b32                	mv	s6,a2
  int i;
  char ch;
  struct proc *pr = myproc();
    8000528a:	ffffd097          	auipc	ra,0xffffd
    8000528e:	d70080e7          	jalr	-656(ra) # 80001ffa <myproc>
    80005292:	8c2a                	mv	s8,a0

  acquire(&pi->lock);
    80005294:	8526                	mv	a0,s1
    80005296:	ffffc097          	auipc	ra,0xffffc
    8000529a:	a9a080e7          	jalr	-1382(ra) # 80000d30 <acquire>
  for(i = 0; i < n; i++){
    8000529e:	0d605663          	blez	s6,8000536a <pipewrite+0x100>
    800052a2:	8926                	mv	s2,s1
    800052a4:	fffb0a9b          	addiw	s5,s6,-1
    800052a8:	1a82                	slli	s5,s5,0x20
    800052aa:	020ada93          	srli	s5,s5,0x20
    800052ae:	001b8793          	addi	a5,s7,1
    800052b2:	9abe                	add	s5,s5,a5
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
      if(pi->readopen == 0 || myproc()->killed){
        release(&pi->lock);
        return -1;
      }
      wakeup(&pi->nread);
    800052b4:	23048a13          	addi	s4,s1,560
      sleep(&pi->nwrite, &pi->lock);
    800052b8:	23448993          	addi	s3,s1,564
    }
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800052bc:	5cfd                	li	s9,-1
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    800052be:	2304a783          	lw	a5,560(s1)
    800052c2:	2344a703          	lw	a4,564(s1)
    800052c6:	2007879b          	addiw	a5,a5,512
    800052ca:	06f71463          	bne	a4,a5,80005332 <pipewrite+0xc8>
      if(pi->readopen == 0 || myproc()->killed){
    800052ce:	2384a783          	lw	a5,568(s1)
    800052d2:	cf8d                	beqz	a5,8000530c <pipewrite+0xa2>
    800052d4:	ffffd097          	auipc	ra,0xffffd
    800052d8:	d26080e7          	jalr	-730(ra) # 80001ffa <myproc>
    800052dc:	453c                	lw	a5,72(a0)
    800052de:	e79d                	bnez	a5,8000530c <pipewrite+0xa2>
      wakeup(&pi->nread);
    800052e0:	8552                	mv	a0,s4
    800052e2:	ffffd097          	auipc	ra,0xffffd
    800052e6:	698080e7          	jalr	1688(ra) # 8000297a <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800052ea:	85ca                	mv	a1,s2
    800052ec:	854e                	mv	a0,s3
    800052ee:	ffffd097          	auipc	ra,0xffffd
    800052f2:	506080e7          	jalr	1286(ra) # 800027f4 <sleep>
    while(pi->nwrite == pi->nread + PIPESIZE){  //DOC: pipewrite-full
    800052f6:	2304a783          	lw	a5,560(s1)
    800052fa:	2344a703          	lw	a4,564(s1)
    800052fe:	2007879b          	addiw	a5,a5,512
    80005302:	02f71863          	bne	a4,a5,80005332 <pipewrite+0xc8>
      if(pi->readopen == 0 || myproc()->killed){
    80005306:	2384a783          	lw	a5,568(s1)
    8000530a:	f7e9                	bnez	a5,800052d4 <pipewrite+0x6a>
        release(&pi->lock);
    8000530c:	8526                	mv	a0,s1
    8000530e:	ffffc097          	auipc	ra,0xffffc
    80005312:	c6e080e7          	jalr	-914(ra) # 80000f7c <release>
        return -1;
    80005316:	557d                	li	a0,-1
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
  }
  wakeup(&pi->nread);
  release(&pi->lock);
  return n;
}
    80005318:	70a6                	ld	ra,104(sp)
    8000531a:	7406                	ld	s0,96(sp)
    8000531c:	64e6                	ld	s1,88(sp)
    8000531e:	6946                	ld	s2,80(sp)
    80005320:	69a6                	ld	s3,72(sp)
    80005322:	6a06                	ld	s4,64(sp)
    80005324:	7ae2                	ld	s5,56(sp)
    80005326:	7b42                	ld	s6,48(sp)
    80005328:	7ba2                	ld	s7,40(sp)
    8000532a:	7c02                	ld	s8,32(sp)
    8000532c:	6ce2                	ld	s9,24(sp)
    8000532e:	6165                	addi	sp,sp,112
    80005330:	8082                	ret
    if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80005332:	4685                	li	a3,1
    80005334:	865e                	mv	a2,s7
    80005336:	f9f40593          	addi	a1,s0,-97
    8000533a:	068c3503          	ld	a0,104(s8) # 1068 <_entry-0x7fffef98>
    8000533e:	ffffd097          	auipc	ra,0xffffd
    80005342:	9f2080e7          	jalr	-1550(ra) # 80001d30 <copyin>
    80005346:	03950263          	beq	a0,s9,8000536a <pipewrite+0x100>
    pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000534a:	2344a783          	lw	a5,564(s1)
    8000534e:	0017871b          	addiw	a4,a5,1
    80005352:	22e4aa23          	sw	a4,564(s1)
    80005356:	1ff7f793          	andi	a5,a5,511
    8000535a:	97a6                	add	a5,a5,s1
    8000535c:	f9f44703          	lbu	a4,-97(s0)
    80005360:	02e78823          	sb	a4,48(a5)
  for(i = 0; i < n; i++){
    80005364:	0b85                	addi	s7,s7,1
    80005366:	f55b9ce3          	bne	s7,s5,800052be <pipewrite+0x54>
  wakeup(&pi->nread);
    8000536a:	23048513          	addi	a0,s1,560
    8000536e:	ffffd097          	auipc	ra,0xffffd
    80005372:	60c080e7          	jalr	1548(ra) # 8000297a <wakeup>
  release(&pi->lock);
    80005376:	8526                	mv	a0,s1
    80005378:	ffffc097          	auipc	ra,0xffffc
    8000537c:	c04080e7          	jalr	-1020(ra) # 80000f7c <release>
  return n;
    80005380:	855a                	mv	a0,s6
    80005382:	bf59                	j	80005318 <pipewrite+0xae>

0000000080005384 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80005384:	715d                	addi	sp,sp,-80
    80005386:	e486                	sd	ra,72(sp)
    80005388:	e0a2                	sd	s0,64(sp)
    8000538a:	fc26                	sd	s1,56(sp)
    8000538c:	f84a                	sd	s2,48(sp)
    8000538e:	f44e                	sd	s3,40(sp)
    80005390:	f052                	sd	s4,32(sp)
    80005392:	ec56                	sd	s5,24(sp)
    80005394:	e85a                	sd	s6,16(sp)
    80005396:	0880                	addi	s0,sp,80
    80005398:	84aa                	mv	s1,a0
    8000539a:	89ae                	mv	s3,a1
    8000539c:	8a32                	mv	s4,a2
  int i;
  struct proc *pr = myproc();
    8000539e:	ffffd097          	auipc	ra,0xffffd
    800053a2:	c5c080e7          	jalr	-932(ra) # 80001ffa <myproc>
    800053a6:	8aaa                	mv	s5,a0
  char ch;

  acquire(&pi->lock);
    800053a8:	8526                	mv	a0,s1
    800053aa:	ffffc097          	auipc	ra,0xffffc
    800053ae:	986080e7          	jalr	-1658(ra) # 80000d30 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800053b2:	2304a703          	lw	a4,560(s1)
    800053b6:	2344a783          	lw	a5,564(s1)
    800053ba:	06f71b63          	bne	a4,a5,80005430 <piperead+0xac>
    800053be:	8926                	mv	s2,s1
    800053c0:	23c4a783          	lw	a5,572(s1)
    800053c4:	cb85                	beqz	a5,800053f4 <piperead+0x70>
    if(myproc()->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800053c6:	23048b13          	addi	s6,s1,560
    if(myproc()->killed){
    800053ca:	ffffd097          	auipc	ra,0xffffd
    800053ce:	c30080e7          	jalr	-976(ra) # 80001ffa <myproc>
    800053d2:	453c                	lw	a5,72(a0)
    800053d4:	e7b9                	bnez	a5,80005422 <piperead+0x9e>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800053d6:	85ca                	mv	a1,s2
    800053d8:	855a                	mv	a0,s6
    800053da:	ffffd097          	auipc	ra,0xffffd
    800053de:	41a080e7          	jalr	1050(ra) # 800027f4 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800053e2:	2304a703          	lw	a4,560(s1)
    800053e6:	2344a783          	lw	a5,564(s1)
    800053ea:	04f71363          	bne	a4,a5,80005430 <piperead+0xac>
    800053ee:	23c4a783          	lw	a5,572(s1)
    800053f2:	ffe1                	bnez	a5,800053ca <piperead+0x46>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    800053f4:	4901                	li	s2,0
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800053f6:	23448513          	addi	a0,s1,564
    800053fa:	ffffd097          	auipc	ra,0xffffd
    800053fe:	580080e7          	jalr	1408(ra) # 8000297a <wakeup>
  release(&pi->lock);
    80005402:	8526                	mv	a0,s1
    80005404:	ffffc097          	auipc	ra,0xffffc
    80005408:	b78080e7          	jalr	-1160(ra) # 80000f7c <release>
  return i;
}
    8000540c:	854a                	mv	a0,s2
    8000540e:	60a6                	ld	ra,72(sp)
    80005410:	6406                	ld	s0,64(sp)
    80005412:	74e2                	ld	s1,56(sp)
    80005414:	7942                	ld	s2,48(sp)
    80005416:	79a2                	ld	s3,40(sp)
    80005418:	7a02                	ld	s4,32(sp)
    8000541a:	6ae2                	ld	s5,24(sp)
    8000541c:	6b42                	ld	s6,16(sp)
    8000541e:	6161                	addi	sp,sp,80
    80005420:	8082                	ret
      release(&pi->lock);
    80005422:	8526                	mv	a0,s1
    80005424:	ffffc097          	auipc	ra,0xffffc
    80005428:	b58080e7          	jalr	-1192(ra) # 80000f7c <release>
      return -1;
    8000542c:	597d                	li	s2,-1
    8000542e:	bff9                	j	8000540c <piperead+0x88>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80005430:	4901                	li	s2,0
    80005432:	fd4052e3          	blez	s4,800053f6 <piperead+0x72>
    if(pi->nread == pi->nwrite)
    80005436:	2304a783          	lw	a5,560(s1)
    8000543a:	4901                	li	s2,0
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000543c:	5b7d                	li	s6,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000543e:	0017871b          	addiw	a4,a5,1
    80005442:	22e4a823          	sw	a4,560(s1)
    80005446:	1ff7f793          	andi	a5,a5,511
    8000544a:	97a6                	add	a5,a5,s1
    8000544c:	0307c783          	lbu	a5,48(a5)
    80005450:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80005454:	4685                	li	a3,1
    80005456:	fbf40613          	addi	a2,s0,-65
    8000545a:	85ce                	mv	a1,s3
    8000545c:	068ab503          	ld	a0,104(s5)
    80005460:	ffffd097          	auipc	ra,0xffffd
    80005464:	844080e7          	jalr	-1980(ra) # 80001ca4 <copyout>
    80005468:	f96507e3          	beq	a0,s6,800053f6 <piperead+0x72>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000546c:	2905                	addiw	s2,s2,1
    8000546e:	f92a04e3          	beq	s4,s2,800053f6 <piperead+0x72>
    if(pi->nread == pi->nwrite)
    80005472:	2304a783          	lw	a5,560(s1)
    80005476:	0985                	addi	s3,s3,1
    80005478:	2344a703          	lw	a4,564(s1)
    8000547c:	fcf711e3          	bne	a4,a5,8000543e <piperead+0xba>
    80005480:	bf9d                	j	800053f6 <piperead+0x72>

0000000080005482 <exec>:



int
exec(char *path, char **argv)
{
    80005482:	de010113          	addi	sp,sp,-544
    80005486:	20113c23          	sd	ra,536(sp)
    8000548a:	20813823          	sd	s0,528(sp)
    8000548e:	20913423          	sd	s1,520(sp)
    80005492:	21213023          	sd	s2,512(sp)
    80005496:	ffce                	sd	s3,504(sp)
    80005498:	fbd2                	sd	s4,496(sp)
    8000549a:	f7d6                	sd	s5,488(sp)
    8000549c:	f3da                	sd	s6,480(sp)
    8000549e:	efde                	sd	s7,472(sp)
    800054a0:	ebe2                	sd	s8,464(sp)
    800054a2:	e7e6                	sd	s9,456(sp)
    800054a4:	e3ea                	sd	s10,448(sp)
    800054a6:	ff6e                	sd	s11,440(sp)
    800054a8:	1400                	addi	s0,sp,544
    800054aa:	892a                	mv	s2,a0
    800054ac:	dea43823          	sd	a0,-528(s0)
    800054b0:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800054b4:	ffffd097          	auipc	ra,0xffffd
    800054b8:	b46080e7          	jalr	-1210(ra) # 80001ffa <myproc>
    800054bc:	84aa                	mv	s1,a0

  begin_op(ROOTDEV);
    800054be:	4501                	li	a0,0
    800054c0:	fffff097          	auipc	ra,0xfffff
    800054c4:	342080e7          	jalr	834(ra) # 80004802 <begin_op>

  if((ip = namei(path)) == 0){
    800054c8:	854a                	mv	a0,s2
    800054ca:	fffff097          	auipc	ra,0xfffff
    800054ce:	0f2080e7          	jalr	242(ra) # 800045bc <namei>
    800054d2:	cd25                	beqz	a0,8000554a <exec+0xc8>
    800054d4:	892a                	mv	s2,a0
    end_op(ROOTDEV);
    return -1;
  }
  ilock(ip);
    800054d6:	fffff097          	auipc	ra,0xfffff
    800054da:	952080e7          	jalr	-1710(ra) # 80003e28 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800054de:	04000713          	li	a4,64
    800054e2:	4681                	li	a3,0
    800054e4:	e4840613          	addi	a2,s0,-440
    800054e8:	4581                	li	a1,0
    800054ea:	854a                	mv	a0,s2
    800054ec:	fffff097          	auipc	ra,0xfffff
    800054f0:	bce080e7          	jalr	-1074(ra) # 800040ba <readi>
    800054f4:	04000793          	li	a5,64
    800054f8:	00f51a63          	bne	a0,a5,8000550c <exec+0x8a>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800054fc:	e4842703          	lw	a4,-440(s0)
    80005500:	464c47b7          	lui	a5,0x464c4
    80005504:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80005508:	04f70863          	beq	a4,a5,80005558 <exec+0xd6>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000550c:	854a                	mv	a0,s2
    8000550e:	fffff097          	auipc	ra,0xfffff
    80005512:	b5a080e7          	jalr	-1190(ra) # 80004068 <iunlockput>
    end_op(ROOTDEV);
    80005516:	4501                	li	a0,0
    80005518:	fffff097          	auipc	ra,0xfffff
    8000551c:	396080e7          	jalr	918(ra) # 800048ae <end_op>
  }
  return -1;
    80005520:	557d                	li	a0,-1
}
    80005522:	21813083          	ld	ra,536(sp)
    80005526:	21013403          	ld	s0,528(sp)
    8000552a:	20813483          	ld	s1,520(sp)
    8000552e:	20013903          	ld	s2,512(sp)
    80005532:	79fe                	ld	s3,504(sp)
    80005534:	7a5e                	ld	s4,496(sp)
    80005536:	7abe                	ld	s5,488(sp)
    80005538:	7b1e                	ld	s6,480(sp)
    8000553a:	6bfe                	ld	s7,472(sp)
    8000553c:	6c5e                	ld	s8,464(sp)
    8000553e:	6cbe                	ld	s9,456(sp)
    80005540:	6d1e                	ld	s10,448(sp)
    80005542:	7dfa                	ld	s11,440(sp)
    80005544:	22010113          	addi	sp,sp,544
    80005548:	8082                	ret
    end_op(ROOTDEV);
    8000554a:	4501                	li	a0,0
    8000554c:	fffff097          	auipc	ra,0xfffff
    80005550:	362080e7          	jalr	866(ra) # 800048ae <end_op>
    return -1;
    80005554:	557d                	li	a0,-1
    80005556:	b7f1                	j	80005522 <exec+0xa0>
  if((pagetable = proc_pagetable(p)) == 0)
    80005558:	8526                	mv	a0,s1
    8000555a:	ffffd097          	auipc	ra,0xffffd
    8000555e:	b66080e7          	jalr	-1178(ra) # 800020c0 <proc_pagetable>
    80005562:	e0a43423          	sd	a0,-504(s0)
    80005566:	d15d                	beqz	a0,8000550c <exec+0x8a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005568:	e6842983          	lw	s3,-408(s0)
    8000556c:	e8045783          	lhu	a5,-384(s0)
    80005570:	cbed                	beqz	a5,80005662 <exec+0x1e0>
  sz = 0;
    80005572:	e0043023          	sd	zero,-512(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005576:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    80005578:	6c05                	lui	s8,0x1
    8000557a:	fffc0793          	addi	a5,s8,-1 # fff <_entry-0x7ffff001>
    8000557e:	def43423          	sd	a5,-536(s0)
  uint64 pa;

  if((va % PGSIZE) != 0)
    panic("loadseg: va must be page aligned");

  for(i = 0; i < sz; i += PGSIZE){
    80005582:	6d05                	lui	s10,0x1
    80005584:	a0a5                	j	800055ec <exec+0x16a>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80005586:	00003517          	auipc	a0,0x3
    8000558a:	6d250513          	addi	a0,a0,1746 # 80008c58 <userret+0xbc8>
    8000558e:	ffffb097          	auipc	ra,0xffffb
    80005592:	238080e7          	jalr	568(ra) # 800007c6 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80005596:	8756                	mv	a4,s5
    80005598:	009d86bb          	addw	a3,s11,s1
    8000559c:	4581                	li	a1,0
    8000559e:	854a                	mv	a0,s2
    800055a0:	fffff097          	auipc	ra,0xfffff
    800055a4:	b1a080e7          	jalr	-1254(ra) # 800040ba <readi>
    800055a8:	2501                	sext.w	a0,a0
    800055aa:	10aa9563          	bne	s5,a0,800056b4 <exec+0x232>
  for(i = 0; i < sz; i += PGSIZE){
    800055ae:	009d04bb          	addw	s1,s10,s1
    800055b2:	77fd                	lui	a5,0xfffff
    800055b4:	01478a3b          	addw	s4,a5,s4
    800055b8:	0374f363          	bleu	s7,s1,800055de <exec+0x15c>
    pa = walkaddr(pagetable, va + i);
    800055bc:	02049593          	slli	a1,s1,0x20
    800055c0:	9181                	srli	a1,a1,0x20
    800055c2:	95e6                	add	a1,a1,s9
    800055c4:	e0843503          	ld	a0,-504(s0)
    800055c8:	ffffc097          	auipc	ra,0xffffc
    800055cc:	0f8080e7          	jalr	248(ra) # 800016c0 <walkaddr>
    800055d0:	862a                	mv	a2,a0
    if(pa == 0)
    800055d2:	d955                	beqz	a0,80005586 <exec+0x104>
      n = PGSIZE;
    800055d4:	8ae2                	mv	s5,s8
    if(sz - i < PGSIZE)
    800055d6:	fd8a70e3          	bleu	s8,s4,80005596 <exec+0x114>
      n = sz - i;
    800055da:	8ad2                	mv	s5,s4
    800055dc:	bf6d                	j	80005596 <exec+0x114>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800055de:	2b05                	addiw	s6,s6,1
    800055e0:	0389899b          	addiw	s3,s3,56
    800055e4:	e8045783          	lhu	a5,-384(s0)
    800055e8:	06fb5f63          	ble	a5,s6,80005666 <exec+0x1e4>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800055ec:	2981                	sext.w	s3,s3
    800055ee:	03800713          	li	a4,56
    800055f2:	86ce                	mv	a3,s3
    800055f4:	e1040613          	addi	a2,s0,-496
    800055f8:	4581                	li	a1,0
    800055fa:	854a                	mv	a0,s2
    800055fc:	fffff097          	auipc	ra,0xfffff
    80005600:	abe080e7          	jalr	-1346(ra) # 800040ba <readi>
    80005604:	03800793          	li	a5,56
    80005608:	0af51663          	bne	a0,a5,800056b4 <exec+0x232>
    if(ph.type != ELF_PROG_LOAD)
    8000560c:	e1042783          	lw	a5,-496(s0)
    80005610:	4705                	li	a4,1
    80005612:	fce796e3          	bne	a5,a4,800055de <exec+0x15c>
    if(ph.memsz < ph.filesz)
    80005616:	e3843603          	ld	a2,-456(s0)
    8000561a:	e3043783          	ld	a5,-464(s0)
    8000561e:	08f66b63          	bltu	a2,a5,800056b4 <exec+0x232>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80005622:	e2043783          	ld	a5,-480(s0)
    80005626:	963e                	add	a2,a2,a5
    80005628:	08f66663          	bltu	a2,a5,800056b4 <exec+0x232>
    if((sz = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000562c:	e0043583          	ld	a1,-512(s0)
    80005630:	e0843503          	ld	a0,-504(s0)
    80005634:	ffffc097          	auipc	ra,0xffffc
    80005638:	496080e7          	jalr	1174(ra) # 80001aca <uvmalloc>
    8000563c:	e0a43023          	sd	a0,-512(s0)
    80005640:	c935                	beqz	a0,800056b4 <exec+0x232>
    if(ph.vaddr % PGSIZE != 0)
    80005642:	e2043c83          	ld	s9,-480(s0)
    80005646:	de843783          	ld	a5,-536(s0)
    8000564a:	00fcf7b3          	and	a5,s9,a5
    8000564e:	e3bd                	bnez	a5,800056b4 <exec+0x232>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80005650:	e1842d83          	lw	s11,-488(s0)
    80005654:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005658:	f80b83e3          	beqz	s7,800055de <exec+0x15c>
    8000565c:	8a5e                	mv	s4,s7
    8000565e:	4481                	li	s1,0
    80005660:	bfb1                	j	800055bc <exec+0x13a>
  sz = 0;
    80005662:	e0043023          	sd	zero,-512(s0)
  iunlockput(ip);
    80005666:	854a                	mv	a0,s2
    80005668:	fffff097          	auipc	ra,0xfffff
    8000566c:	a00080e7          	jalr	-1536(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    80005670:	4501                	li	a0,0
    80005672:	fffff097          	auipc	ra,0xfffff
    80005676:	23c080e7          	jalr	572(ra) # 800048ae <end_op>
  p = myproc();
    8000567a:	ffffd097          	auipc	ra,0xffffd
    8000567e:	980080e7          	jalr	-1664(ra) # 80001ffa <myproc>
    80005682:	8caa                	mv	s9,a0
  uint64 oldsz = p->sz;
    80005684:	06053d83          	ld	s11,96(a0)
  sz = PGROUNDUP(sz);
    80005688:	6585                	lui	a1,0x1
    8000568a:	15fd                	addi	a1,a1,-1
    8000568c:	e0043783          	ld	a5,-512(s0)
    80005690:	00b78d33          	add	s10,a5,a1
    80005694:	75fd                	lui	a1,0xfffff
    80005696:	00bd75b3          	and	a1,s10,a1
  if((sz = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    8000569a:	6609                	lui	a2,0x2
    8000569c:	962e                	add	a2,a2,a1
    8000569e:	e0843483          	ld	s1,-504(s0)
    800056a2:	8526                	mv	a0,s1
    800056a4:	ffffc097          	auipc	ra,0xffffc
    800056a8:	426080e7          	jalr	1062(ra) # 80001aca <uvmalloc>
    800056ac:	e0a43023          	sd	a0,-512(s0)
  ip = 0;
    800056b0:	4901                	li	s2,0
  if((sz = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800056b2:	ed09                	bnez	a0,800056cc <exec+0x24a>
    proc_freepagetable(pagetable, sz);
    800056b4:	e0043583          	ld	a1,-512(s0)
    800056b8:	e0843503          	ld	a0,-504(s0)
    800056bc:	ffffd097          	auipc	ra,0xffffd
    800056c0:	b08080e7          	jalr	-1272(ra) # 800021c4 <proc_freepagetable>
  if(ip){
    800056c4:	e40914e3          	bnez	s2,8000550c <exec+0x8a>
  return -1;
    800056c8:	557d                	li	a0,-1
    800056ca:	bda1                	j	80005522 <exec+0xa0>
  uvmclear(pagetable, sz-2*PGSIZE);
    800056cc:	75f9                	lui	a1,0xffffe
    800056ce:	892a                	mv	s2,a0
    800056d0:	95aa                	add	a1,a1,a0
    800056d2:	8526                	mv	a0,s1
    800056d4:	ffffc097          	auipc	ra,0xffffc
    800056d8:	59e080e7          	jalr	1438(ra) # 80001c72 <uvmclear>
  stackbase = sp - PGSIZE;
    800056dc:	7b7d                	lui	s6,0xfffff
    800056de:	9b4a                	add	s6,s6,s2
  for(argc = 0; argv[argc]; argc++) {
    800056e0:	df843983          	ld	s3,-520(s0)
    800056e4:	0009b503          	ld	a0,0(s3)
    800056e8:	c125                	beqz	a0,80005748 <exec+0x2c6>
    800056ea:	e8840a13          	addi	s4,s0,-376
    800056ee:	f8840b93          	addi	s7,s0,-120
    800056f2:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800056f4:	ffffc097          	auipc	ra,0xffffc
    800056f8:	c5a080e7          	jalr	-934(ra) # 8000134e <strlen>
    800056fc:	2505                	addiw	a0,a0,1
    800056fe:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80005702:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80005706:	11696963          	bltu	s2,s6,80005818 <exec+0x396>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000570a:	0009ba83          	ld	s5,0(s3)
    8000570e:	8556                	mv	a0,s5
    80005710:	ffffc097          	auipc	ra,0xffffc
    80005714:	c3e080e7          	jalr	-962(ra) # 8000134e <strlen>
    80005718:	0015069b          	addiw	a3,a0,1
    8000571c:	8656                	mv	a2,s5
    8000571e:	85ca                	mv	a1,s2
    80005720:	e0843503          	ld	a0,-504(s0)
    80005724:	ffffc097          	auipc	ra,0xffffc
    80005728:	580080e7          	jalr	1408(ra) # 80001ca4 <copyout>
    8000572c:	0e054863          	bltz	a0,8000581c <exec+0x39a>
    ustack[argc] = sp;
    80005730:	012a3023          	sd	s2,0(s4)
  for(argc = 0; argv[argc]; argc++) {
    80005734:	0485                	addi	s1,s1,1
    80005736:	09a1                	addi	s3,s3,8
    80005738:	0009b503          	ld	a0,0(s3)
    8000573c:	c909                	beqz	a0,8000574e <exec+0x2cc>
    if(argc >= MAXARG)
    8000573e:	0a21                	addi	s4,s4,8
    80005740:	fb7a1ae3          	bne	s4,s7,800056f4 <exec+0x272>
  ip = 0;
    80005744:	4901                	li	s2,0
    80005746:	b7bd                	j	800056b4 <exec+0x232>
  sp = sz;
    80005748:	e0043903          	ld	s2,-512(s0)
  for(argc = 0; argv[argc]; argc++) {
    8000574c:	4481                	li	s1,0
  ustack[argc] = 0;
    8000574e:	00349793          	slli	a5,s1,0x3
    80005752:	f9040713          	addi	a4,s0,-112
    80005756:	97ba                	add	a5,a5,a4
    80005758:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <end+0xffffffff7ffd0e4c>
  sp -= (argc+1) * sizeof(uint64);
    8000575c:	00148693          	addi	a3,s1,1
    80005760:	068e                	slli	a3,a3,0x3
    80005762:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80005766:	ff097993          	andi	s3,s2,-16
  ip = 0;
    8000576a:	4901                	li	s2,0
  if(sp < stackbase)
    8000576c:	f569e4e3          	bltu	s3,s6,800056b4 <exec+0x232>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80005770:	e8840613          	addi	a2,s0,-376
    80005774:	85ce                	mv	a1,s3
    80005776:	e0843503          	ld	a0,-504(s0)
    8000577a:	ffffc097          	auipc	ra,0xffffc
    8000577e:	52a080e7          	jalr	1322(ra) # 80001ca4 <copyout>
    80005782:	08054f63          	bltz	a0,80005820 <exec+0x39e>
  p->tf->a1 = sp;
    80005786:	070cb783          	ld	a5,112(s9) # 2070 <_entry-0x7fffdf90>
    8000578a:	0737bc23          	sd	s3,120(a5)
  for(last=s=path; *s; s++)
    8000578e:	df043783          	ld	a5,-528(s0)
    80005792:	0007c703          	lbu	a4,0(a5)
    80005796:	cf11                	beqz	a4,800057b2 <exec+0x330>
    80005798:	0785                	addi	a5,a5,1
    if(*s == '/')
    8000579a:	02f00693          	li	a3,47
    8000579e:	a029                	j	800057a8 <exec+0x326>
  for(last=s=path; *s; s++)
    800057a0:	0785                	addi	a5,a5,1
    800057a2:	fff7c703          	lbu	a4,-1(a5)
    800057a6:	c711                	beqz	a4,800057b2 <exec+0x330>
    if(*s == '/')
    800057a8:	fed71ce3          	bne	a4,a3,800057a0 <exec+0x31e>
      last = s+1;
    800057ac:	def43823          	sd	a5,-528(s0)
    800057b0:	bfc5                	j	800057a0 <exec+0x31e>
  safestrcpy(p->name, last, sizeof(p->name));
    800057b2:	4641                	li	a2,16
    800057b4:	df043583          	ld	a1,-528(s0)
    800057b8:	170c8513          	addi	a0,s9,368
    800057bc:	ffffc097          	auipc	ra,0xffffc
    800057c0:	b60080e7          	jalr	-1184(ra) # 8000131c <safestrcpy>
  if(p->cmd) bd_free(p->cmd);
    800057c4:	180cb503          	ld	a0,384(s9)
    800057c8:	c509                	beqz	a0,800057d2 <exec+0x350>
    800057ca:	00002097          	auipc	ra,0x2
    800057ce:	9c2080e7          	jalr	-1598(ra) # 8000718c <bd_free>
  p->cmd = strjoin(argv);
    800057d2:	df843503          	ld	a0,-520(s0)
    800057d6:	ffffc097          	auipc	ra,0xffffc
    800057da:	ba2080e7          	jalr	-1118(ra) # 80001378 <strjoin>
    800057de:	18acb023          	sd	a0,384(s9)
  oldpagetable = p->pagetable;
    800057e2:	068cb503          	ld	a0,104(s9)
  p->pagetable = pagetable;
    800057e6:	e0843783          	ld	a5,-504(s0)
    800057ea:	06fcb423          	sd	a5,104(s9)
  p->sz = sz;
    800057ee:	e0043783          	ld	a5,-512(s0)
    800057f2:	06fcb023          	sd	a5,96(s9)
  p->tf->epc = elf.entry;  // initial program counter = main
    800057f6:	070cb783          	ld	a5,112(s9)
    800057fa:	e6043703          	ld	a4,-416(s0)
    800057fe:	ef98                	sd	a4,24(a5)
  p->tf->sp = sp; // initial stack pointer
    80005800:	070cb783          	ld	a5,112(s9)
    80005804:	0337b823          	sd	s3,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80005808:	85ee                	mv	a1,s11
    8000580a:	ffffd097          	auipc	ra,0xffffd
    8000580e:	9ba080e7          	jalr	-1606(ra) # 800021c4 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005812:	0004851b          	sext.w	a0,s1
    80005816:	b331                	j	80005522 <exec+0xa0>
  ip = 0;
    80005818:	4901                	li	s2,0
    8000581a:	bd69                	j	800056b4 <exec+0x232>
    8000581c:	4901                	li	s2,0
    8000581e:	bd59                	j	800056b4 <exec+0x232>
    80005820:	4901                	li	s2,0
    80005822:	bd49                	j	800056b4 <exec+0x232>

0000000080005824 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80005824:	7179                	addi	sp,sp,-48
    80005826:	f406                	sd	ra,40(sp)
    80005828:	f022                	sd	s0,32(sp)
    8000582a:	ec26                	sd	s1,24(sp)
    8000582c:	e84a                	sd	s2,16(sp)
    8000582e:	1800                	addi	s0,sp,48
    80005830:	892e                	mv	s2,a1
    80005832:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80005834:	fdc40593          	addi	a1,s0,-36
    80005838:	ffffe097          	auipc	ra,0xffffe
    8000583c:	a1e080e7          	jalr	-1506(ra) # 80003256 <argint>
    80005840:	04054063          	bltz	a0,80005880 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005844:	fdc42703          	lw	a4,-36(s0)
    80005848:	47bd                	li	a5,15
    8000584a:	02e7ed63          	bltu	a5,a4,80005884 <argfd+0x60>
    8000584e:	ffffc097          	auipc	ra,0xffffc
    80005852:	7ac080e7          	jalr	1964(ra) # 80001ffa <myproc>
    80005856:	fdc42703          	lw	a4,-36(s0)
    8000585a:	01c70793          	addi	a5,a4,28
    8000585e:	078e                	slli	a5,a5,0x3
    80005860:	953e                	add	a0,a0,a5
    80005862:	651c                	ld	a5,8(a0)
    80005864:	c395                	beqz	a5,80005888 <argfd+0x64>
    return -1;
  if(pfd)
    80005866:	00090463          	beqz	s2,8000586e <argfd+0x4a>
    *pfd = fd;
    8000586a:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000586e:	4501                	li	a0,0
  if(pf)
    80005870:	c091                	beqz	s1,80005874 <argfd+0x50>
    *pf = f;
    80005872:	e09c                	sd	a5,0(s1)
}
    80005874:	70a2                	ld	ra,40(sp)
    80005876:	7402                	ld	s0,32(sp)
    80005878:	64e2                	ld	s1,24(sp)
    8000587a:	6942                	ld	s2,16(sp)
    8000587c:	6145                	addi	sp,sp,48
    8000587e:	8082                	ret
    return -1;
    80005880:	557d                	li	a0,-1
    80005882:	bfcd                	j	80005874 <argfd+0x50>
    return -1;
    80005884:	557d                	li	a0,-1
    80005886:	b7fd                	j	80005874 <argfd+0x50>
    80005888:	557d                	li	a0,-1
    8000588a:	b7ed                	j	80005874 <argfd+0x50>

000000008000588c <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000588c:	1101                	addi	sp,sp,-32
    8000588e:	ec06                	sd	ra,24(sp)
    80005890:	e822                	sd	s0,16(sp)
    80005892:	e426                	sd	s1,8(sp)
    80005894:	1000                	addi	s0,sp,32
    80005896:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005898:	ffffc097          	auipc	ra,0xffffc
    8000589c:	762080e7          	jalr	1890(ra) # 80001ffa <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
    800058a0:	757c                	ld	a5,232(a0)
    800058a2:	c395                	beqz	a5,800058c6 <fdalloc+0x3a>
    800058a4:	0f050713          	addi	a4,a0,240
  for(fd = 0; fd < NOFILE; fd++){
    800058a8:	4785                	li	a5,1
    800058aa:	4641                	li	a2,16
    if(p->ofile[fd] == 0){
    800058ac:	6314                	ld	a3,0(a4)
    800058ae:	ce89                	beqz	a3,800058c8 <fdalloc+0x3c>
  for(fd = 0; fd < NOFILE; fd++){
    800058b0:	2785                	addiw	a5,a5,1
    800058b2:	0721                	addi	a4,a4,8
    800058b4:	fec79ce3          	bne	a5,a2,800058ac <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800058b8:	57fd                	li	a5,-1
}
    800058ba:	853e                	mv	a0,a5
    800058bc:	60e2                	ld	ra,24(sp)
    800058be:	6442                	ld	s0,16(sp)
    800058c0:	64a2                	ld	s1,8(sp)
    800058c2:	6105                	addi	sp,sp,32
    800058c4:	8082                	ret
  for(fd = 0; fd < NOFILE; fd++){
    800058c6:	4781                	li	a5,0
      p->ofile[fd] = f;
    800058c8:	01c78713          	addi	a4,a5,28
    800058cc:	070e                	slli	a4,a4,0x3
    800058ce:	953a                	add	a0,a0,a4
    800058d0:	e504                	sd	s1,8(a0)
      return fd;
    800058d2:	b7e5                	j	800058ba <fdalloc+0x2e>

00000000800058d4 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800058d4:	715d                	addi	sp,sp,-80
    800058d6:	e486                	sd	ra,72(sp)
    800058d8:	e0a2                	sd	s0,64(sp)
    800058da:	fc26                	sd	s1,56(sp)
    800058dc:	f84a                	sd	s2,48(sp)
    800058de:	f44e                	sd	s3,40(sp)
    800058e0:	f052                	sd	s4,32(sp)
    800058e2:	ec56                	sd	s5,24(sp)
    800058e4:	0880                	addi	s0,sp,80
    800058e6:	89ae                	mv	s3,a1
    800058e8:	8ab2                	mv	s5,a2
    800058ea:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800058ec:	fb040593          	addi	a1,s0,-80
    800058f0:	fffff097          	auipc	ra,0xfffff
    800058f4:	cea080e7          	jalr	-790(ra) # 800045da <nameiparent>
    800058f8:	892a                	mv	s2,a0
    800058fa:	12050f63          	beqz	a0,80005a38 <create+0x164>
    return 0;

  ilock(dp);
    800058fe:	ffffe097          	auipc	ra,0xffffe
    80005902:	52a080e7          	jalr	1322(ra) # 80003e28 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80005906:	4601                	li	a2,0
    80005908:	fb040593          	addi	a1,s0,-80
    8000590c:	854a                	mv	a0,s2
    8000590e:	fffff097          	auipc	ra,0xfffff
    80005912:	9d4080e7          	jalr	-1580(ra) # 800042e2 <dirlookup>
    80005916:	84aa                	mv	s1,a0
    80005918:	c921                	beqz	a0,80005968 <create+0x94>
    iunlockput(dp);
    8000591a:	854a                	mv	a0,s2
    8000591c:	ffffe097          	auipc	ra,0xffffe
    80005920:	74c080e7          	jalr	1868(ra) # 80004068 <iunlockput>
    ilock(ip);
    80005924:	8526                	mv	a0,s1
    80005926:	ffffe097          	auipc	ra,0xffffe
    8000592a:	502080e7          	jalr	1282(ra) # 80003e28 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000592e:	2981                	sext.w	s3,s3
    80005930:	4789                	li	a5,2
    80005932:	02f99463          	bne	s3,a5,8000595a <create+0x86>
    80005936:	05c4d783          	lhu	a5,92(s1)
    8000593a:	37f9                	addiw	a5,a5,-2
    8000593c:	17c2                	slli	a5,a5,0x30
    8000593e:	93c1                	srli	a5,a5,0x30
    80005940:	4705                	li	a4,1
    80005942:	00f76c63          	bltu	a4,a5,8000595a <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80005946:	8526                	mv	a0,s1
    80005948:	60a6                	ld	ra,72(sp)
    8000594a:	6406                	ld	s0,64(sp)
    8000594c:	74e2                	ld	s1,56(sp)
    8000594e:	7942                	ld	s2,48(sp)
    80005950:	79a2                	ld	s3,40(sp)
    80005952:	7a02                	ld	s4,32(sp)
    80005954:	6ae2                	ld	s5,24(sp)
    80005956:	6161                	addi	sp,sp,80
    80005958:	8082                	ret
    iunlockput(ip);
    8000595a:	8526                	mv	a0,s1
    8000595c:	ffffe097          	auipc	ra,0xffffe
    80005960:	70c080e7          	jalr	1804(ra) # 80004068 <iunlockput>
    return 0;
    80005964:	4481                	li	s1,0
    80005966:	b7c5                	j	80005946 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    80005968:	85ce                	mv	a1,s3
    8000596a:	00092503          	lw	a0,0(s2)
    8000596e:	ffffe097          	auipc	ra,0xffffe
    80005972:	31e080e7          	jalr	798(ra) # 80003c8c <ialloc>
    80005976:	84aa                	mv	s1,a0
    80005978:	c529                	beqz	a0,800059c2 <create+0xee>
  ilock(ip);
    8000597a:	ffffe097          	auipc	ra,0xffffe
    8000597e:	4ae080e7          	jalr	1198(ra) # 80003e28 <ilock>
  ip->major = major;
    80005982:	05549f23          	sh	s5,94(s1)
  ip->minor = minor;
    80005986:	07449023          	sh	s4,96(s1)
  ip->nlink = 1;
    8000598a:	4785                	li	a5,1
    8000598c:	06f49123          	sh	a5,98(s1)
  iupdate(ip);
    80005990:	8526                	mv	a0,s1
    80005992:	ffffe097          	auipc	ra,0xffffe
    80005996:	3ca080e7          	jalr	970(ra) # 80003d5c <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000599a:	2981                	sext.w	s3,s3
    8000599c:	4785                	li	a5,1
    8000599e:	02f98a63          	beq	s3,a5,800059d2 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    800059a2:	40d0                	lw	a2,4(s1)
    800059a4:	fb040593          	addi	a1,s0,-80
    800059a8:	854a                	mv	a0,s2
    800059aa:	fffff097          	auipc	ra,0xfffff
    800059ae:	b50080e7          	jalr	-1200(ra) # 800044fa <dirlink>
    800059b2:	06054b63          	bltz	a0,80005a28 <create+0x154>
  iunlockput(dp);
    800059b6:	854a                	mv	a0,s2
    800059b8:	ffffe097          	auipc	ra,0xffffe
    800059bc:	6b0080e7          	jalr	1712(ra) # 80004068 <iunlockput>
  return ip;
    800059c0:	b759                	j	80005946 <create+0x72>
    panic("create: ialloc");
    800059c2:	00003517          	auipc	a0,0x3
    800059c6:	2b650513          	addi	a0,a0,694 # 80008c78 <userret+0xbe8>
    800059ca:	ffffb097          	auipc	ra,0xffffb
    800059ce:	dfc080e7          	jalr	-516(ra) # 800007c6 <panic>
    dp->nlink++;  // for ".."
    800059d2:	06295783          	lhu	a5,98(s2)
    800059d6:	2785                	addiw	a5,a5,1
    800059d8:	06f91123          	sh	a5,98(s2)
    iupdate(dp);
    800059dc:	854a                	mv	a0,s2
    800059de:	ffffe097          	auipc	ra,0xffffe
    800059e2:	37e080e7          	jalr	894(ra) # 80003d5c <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800059e6:	40d0                	lw	a2,4(s1)
    800059e8:	00003597          	auipc	a1,0x3
    800059ec:	2a058593          	addi	a1,a1,672 # 80008c88 <userret+0xbf8>
    800059f0:	8526                	mv	a0,s1
    800059f2:	fffff097          	auipc	ra,0xfffff
    800059f6:	b08080e7          	jalr	-1272(ra) # 800044fa <dirlink>
    800059fa:	00054f63          	bltz	a0,80005a18 <create+0x144>
    800059fe:	00492603          	lw	a2,4(s2)
    80005a02:	00003597          	auipc	a1,0x3
    80005a06:	28e58593          	addi	a1,a1,654 # 80008c90 <userret+0xc00>
    80005a0a:	8526                	mv	a0,s1
    80005a0c:	fffff097          	auipc	ra,0xfffff
    80005a10:	aee080e7          	jalr	-1298(ra) # 800044fa <dirlink>
    80005a14:	f80557e3          	bgez	a0,800059a2 <create+0xce>
      panic("create dots");
    80005a18:	00003517          	auipc	a0,0x3
    80005a1c:	28050513          	addi	a0,a0,640 # 80008c98 <userret+0xc08>
    80005a20:	ffffb097          	auipc	ra,0xffffb
    80005a24:	da6080e7          	jalr	-602(ra) # 800007c6 <panic>
    panic("create: dirlink");
    80005a28:	00003517          	auipc	a0,0x3
    80005a2c:	28050513          	addi	a0,a0,640 # 80008ca8 <userret+0xc18>
    80005a30:	ffffb097          	auipc	ra,0xffffb
    80005a34:	d96080e7          	jalr	-618(ra) # 800007c6 <panic>
    return 0;
    80005a38:	84aa                	mv	s1,a0
    80005a3a:	b731                	j	80005946 <create+0x72>

0000000080005a3c <sys_dup>:
{
    80005a3c:	7179                	addi	sp,sp,-48
    80005a3e:	f406                	sd	ra,40(sp)
    80005a40:	f022                	sd	s0,32(sp)
    80005a42:	ec26                	sd	s1,24(sp)
    80005a44:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80005a46:	fd840613          	addi	a2,s0,-40
    80005a4a:	4581                	li	a1,0
    80005a4c:	4501                	li	a0,0
    80005a4e:	00000097          	auipc	ra,0x0
    80005a52:	dd6080e7          	jalr	-554(ra) # 80005824 <argfd>
    return -1;
    80005a56:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005a58:	02054363          	bltz	a0,80005a7e <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80005a5c:	fd843503          	ld	a0,-40(s0)
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	e2c080e7          	jalr	-468(ra) # 8000588c <fdalloc>
    80005a68:	84aa                	mv	s1,a0
    return -1;
    80005a6a:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005a6c:	00054963          	bltz	a0,80005a7e <sys_dup+0x42>
  filedup(f);
    80005a70:	fd843503          	ld	a0,-40(s0)
    80005a74:	fffff097          	auipc	ra,0xfffff
    80005a78:	2f8080e7          	jalr	760(ra) # 80004d6c <filedup>
  return fd;
    80005a7c:	87a6                	mv	a5,s1
}
    80005a7e:	853e                	mv	a0,a5
    80005a80:	70a2                	ld	ra,40(sp)
    80005a82:	7402                	ld	s0,32(sp)
    80005a84:	64e2                	ld	s1,24(sp)
    80005a86:	6145                	addi	sp,sp,48
    80005a88:	8082                	ret

0000000080005a8a <sys_read>:
{
    80005a8a:	7179                	addi	sp,sp,-48
    80005a8c:	f406                	sd	ra,40(sp)
    80005a8e:	f022                	sd	s0,32(sp)
    80005a90:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005a92:	fe840613          	addi	a2,s0,-24
    80005a96:	4581                	li	a1,0
    80005a98:	4501                	li	a0,0
    80005a9a:	00000097          	auipc	ra,0x0
    80005a9e:	d8a080e7          	jalr	-630(ra) # 80005824 <argfd>
    return -1;
    80005aa2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005aa4:	04054163          	bltz	a0,80005ae6 <sys_read+0x5c>
    80005aa8:	fe440593          	addi	a1,s0,-28
    80005aac:	4509                	li	a0,2
    80005aae:	ffffd097          	auipc	ra,0xffffd
    80005ab2:	7a8080e7          	jalr	1960(ra) # 80003256 <argint>
    return -1;
    80005ab6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005ab8:	02054763          	bltz	a0,80005ae6 <sys_read+0x5c>
    80005abc:	fd840593          	addi	a1,s0,-40
    80005ac0:	4505                	li	a0,1
    80005ac2:	ffffd097          	auipc	ra,0xffffd
    80005ac6:	7b6080e7          	jalr	1974(ra) # 80003278 <argaddr>
    return -1;
    80005aca:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005acc:	00054d63          	bltz	a0,80005ae6 <sys_read+0x5c>
  return fileread(f, p, n);
    80005ad0:	fe442603          	lw	a2,-28(s0)
    80005ad4:	fd843583          	ld	a1,-40(s0)
    80005ad8:	fe843503          	ld	a0,-24(s0)
    80005adc:	fffff097          	auipc	ra,0xfffff
    80005ae0:	424080e7          	jalr	1060(ra) # 80004f00 <fileread>
    80005ae4:	87aa                	mv	a5,a0
}
    80005ae6:	853e                	mv	a0,a5
    80005ae8:	70a2                	ld	ra,40(sp)
    80005aea:	7402                	ld	s0,32(sp)
    80005aec:	6145                	addi	sp,sp,48
    80005aee:	8082                	ret

0000000080005af0 <sys_write>:
{
    80005af0:	7179                	addi	sp,sp,-48
    80005af2:	f406                	sd	ra,40(sp)
    80005af4:	f022                	sd	s0,32(sp)
    80005af6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005af8:	fe840613          	addi	a2,s0,-24
    80005afc:	4581                	li	a1,0
    80005afe:	4501                	li	a0,0
    80005b00:	00000097          	auipc	ra,0x0
    80005b04:	d24080e7          	jalr	-732(ra) # 80005824 <argfd>
    return -1;
    80005b08:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005b0a:	04054163          	bltz	a0,80005b4c <sys_write+0x5c>
    80005b0e:	fe440593          	addi	a1,s0,-28
    80005b12:	4509                	li	a0,2
    80005b14:	ffffd097          	auipc	ra,0xffffd
    80005b18:	742080e7          	jalr	1858(ra) # 80003256 <argint>
    return -1;
    80005b1c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005b1e:	02054763          	bltz	a0,80005b4c <sys_write+0x5c>
    80005b22:	fd840593          	addi	a1,s0,-40
    80005b26:	4505                	li	a0,1
    80005b28:	ffffd097          	auipc	ra,0xffffd
    80005b2c:	750080e7          	jalr	1872(ra) # 80003278 <argaddr>
    return -1;
    80005b30:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005b32:	00054d63          	bltz	a0,80005b4c <sys_write+0x5c>
  return filewrite(f, p, n);
    80005b36:	fe442603          	lw	a2,-28(s0)
    80005b3a:	fd843583          	ld	a1,-40(s0)
    80005b3e:	fe843503          	ld	a0,-24(s0)
    80005b42:	fffff097          	auipc	ra,0xfffff
    80005b46:	484080e7          	jalr	1156(ra) # 80004fc6 <filewrite>
    80005b4a:	87aa                	mv	a5,a0
}
    80005b4c:	853e                	mv	a0,a5
    80005b4e:	70a2                	ld	ra,40(sp)
    80005b50:	7402                	ld	s0,32(sp)
    80005b52:	6145                	addi	sp,sp,48
    80005b54:	8082                	ret

0000000080005b56 <sys_close>:
{
    80005b56:	1101                	addi	sp,sp,-32
    80005b58:	ec06                	sd	ra,24(sp)
    80005b5a:	e822                	sd	s0,16(sp)
    80005b5c:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80005b5e:	fe040613          	addi	a2,s0,-32
    80005b62:	fec40593          	addi	a1,s0,-20
    80005b66:	4501                	li	a0,0
    80005b68:	00000097          	auipc	ra,0x0
    80005b6c:	cbc080e7          	jalr	-836(ra) # 80005824 <argfd>
    return -1;
    80005b70:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005b72:	02054463          	bltz	a0,80005b9a <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005b76:	ffffc097          	auipc	ra,0xffffc
    80005b7a:	484080e7          	jalr	1156(ra) # 80001ffa <myproc>
    80005b7e:	fec42783          	lw	a5,-20(s0)
    80005b82:	07f1                	addi	a5,a5,28
    80005b84:	078e                	slli	a5,a5,0x3
    80005b86:	953e                	add	a0,a0,a5
    80005b88:	00053423          	sd	zero,8(a0)
  fileclose(f);
    80005b8c:	fe043503          	ld	a0,-32(s0)
    80005b90:	fffff097          	auipc	ra,0xfffff
    80005b94:	22e080e7          	jalr	558(ra) # 80004dbe <fileclose>
  return 0;
    80005b98:	4781                	li	a5,0
}
    80005b9a:	853e                	mv	a0,a5
    80005b9c:	60e2                	ld	ra,24(sp)
    80005b9e:	6442                	ld	s0,16(sp)
    80005ba0:	6105                	addi	sp,sp,32
    80005ba2:	8082                	ret

0000000080005ba4 <sys_fstat>:
{
    80005ba4:	1101                	addi	sp,sp,-32
    80005ba6:	ec06                	sd	ra,24(sp)
    80005ba8:	e822                	sd	s0,16(sp)
    80005baa:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005bac:	fe840613          	addi	a2,s0,-24
    80005bb0:	4581                	li	a1,0
    80005bb2:	4501                	li	a0,0
    80005bb4:	00000097          	auipc	ra,0x0
    80005bb8:	c70080e7          	jalr	-912(ra) # 80005824 <argfd>
    return -1;
    80005bbc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005bbe:	02054563          	bltz	a0,80005be8 <sys_fstat+0x44>
    80005bc2:	fe040593          	addi	a1,s0,-32
    80005bc6:	4505                	li	a0,1
    80005bc8:	ffffd097          	auipc	ra,0xffffd
    80005bcc:	6b0080e7          	jalr	1712(ra) # 80003278 <argaddr>
    return -1;
    80005bd0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005bd2:	00054b63          	bltz	a0,80005be8 <sys_fstat+0x44>
  return filestat(f, st);
    80005bd6:	fe043583          	ld	a1,-32(s0)
    80005bda:	fe843503          	ld	a0,-24(s0)
    80005bde:	fffff097          	auipc	ra,0xfffff
    80005be2:	2b0080e7          	jalr	688(ra) # 80004e8e <filestat>
    80005be6:	87aa                	mv	a5,a0
}
    80005be8:	853e                	mv	a0,a5
    80005bea:	60e2                	ld	ra,24(sp)
    80005bec:	6442                	ld	s0,16(sp)
    80005bee:	6105                	addi	sp,sp,32
    80005bf0:	8082                	ret

0000000080005bf2 <sys_link>:
{
    80005bf2:	7169                	addi	sp,sp,-304
    80005bf4:	f606                	sd	ra,296(sp)
    80005bf6:	f222                	sd	s0,288(sp)
    80005bf8:	ee26                	sd	s1,280(sp)
    80005bfa:	ea4a                	sd	s2,272(sp)
    80005bfc:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005bfe:	08000613          	li	a2,128
    80005c02:	ed040593          	addi	a1,s0,-304
    80005c06:	4501                	li	a0,0
    80005c08:	ffffd097          	auipc	ra,0xffffd
    80005c0c:	692080e7          	jalr	1682(ra) # 8000329a <argstr>
    return -1;
    80005c10:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005c12:	12054363          	bltz	a0,80005d38 <sys_link+0x146>
    80005c16:	08000613          	li	a2,128
    80005c1a:	f5040593          	addi	a1,s0,-176
    80005c1e:	4505                	li	a0,1
    80005c20:	ffffd097          	auipc	ra,0xffffd
    80005c24:	67a080e7          	jalr	1658(ra) # 8000329a <argstr>
    return -1;
    80005c28:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005c2a:	10054763          	bltz	a0,80005d38 <sys_link+0x146>
  begin_op(ROOTDEV);
    80005c2e:	4501                	li	a0,0
    80005c30:	fffff097          	auipc	ra,0xfffff
    80005c34:	bd2080e7          	jalr	-1070(ra) # 80004802 <begin_op>
  if((ip = namei(old)) == 0){
    80005c38:	ed040513          	addi	a0,s0,-304
    80005c3c:	fffff097          	auipc	ra,0xfffff
    80005c40:	980080e7          	jalr	-1664(ra) # 800045bc <namei>
    80005c44:	84aa                	mv	s1,a0
    80005c46:	c559                	beqz	a0,80005cd4 <sys_link+0xe2>
  ilock(ip);
    80005c48:	ffffe097          	auipc	ra,0xffffe
    80005c4c:	1e0080e7          	jalr	480(ra) # 80003e28 <ilock>
  if(ip->type == T_DIR){
    80005c50:	05c49703          	lh	a4,92(s1)
    80005c54:	4785                	li	a5,1
    80005c56:	08f70663          	beq	a4,a5,80005ce2 <sys_link+0xf0>
  ip->nlink++;
    80005c5a:	0624d783          	lhu	a5,98(s1)
    80005c5e:	2785                	addiw	a5,a5,1
    80005c60:	06f49123          	sh	a5,98(s1)
  iupdate(ip);
    80005c64:	8526                	mv	a0,s1
    80005c66:	ffffe097          	auipc	ra,0xffffe
    80005c6a:	0f6080e7          	jalr	246(ra) # 80003d5c <iupdate>
  iunlock(ip);
    80005c6e:	8526                	mv	a0,s1
    80005c70:	ffffe097          	auipc	ra,0xffffe
    80005c74:	27c080e7          	jalr	636(ra) # 80003eec <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005c78:	fd040593          	addi	a1,s0,-48
    80005c7c:	f5040513          	addi	a0,s0,-176
    80005c80:	fffff097          	auipc	ra,0xfffff
    80005c84:	95a080e7          	jalr	-1702(ra) # 800045da <nameiparent>
    80005c88:	892a                	mv	s2,a0
    80005c8a:	cd2d                	beqz	a0,80005d04 <sys_link+0x112>
  ilock(dp);
    80005c8c:	ffffe097          	auipc	ra,0xffffe
    80005c90:	19c080e7          	jalr	412(ra) # 80003e28 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005c94:	00092703          	lw	a4,0(s2)
    80005c98:	409c                	lw	a5,0(s1)
    80005c9a:	06f71063          	bne	a4,a5,80005cfa <sys_link+0x108>
    80005c9e:	40d0                	lw	a2,4(s1)
    80005ca0:	fd040593          	addi	a1,s0,-48
    80005ca4:	854a                	mv	a0,s2
    80005ca6:	fffff097          	auipc	ra,0xfffff
    80005caa:	854080e7          	jalr	-1964(ra) # 800044fa <dirlink>
    80005cae:	04054663          	bltz	a0,80005cfa <sys_link+0x108>
  iunlockput(dp);
    80005cb2:	854a                	mv	a0,s2
    80005cb4:	ffffe097          	auipc	ra,0xffffe
    80005cb8:	3b4080e7          	jalr	948(ra) # 80004068 <iunlockput>
  iput(ip);
    80005cbc:	8526                	mv	a0,s1
    80005cbe:	ffffe097          	auipc	ra,0xffffe
    80005cc2:	27a080e7          	jalr	634(ra) # 80003f38 <iput>
  end_op(ROOTDEV);
    80005cc6:	4501                	li	a0,0
    80005cc8:	fffff097          	auipc	ra,0xfffff
    80005ccc:	be6080e7          	jalr	-1050(ra) # 800048ae <end_op>
  return 0;
    80005cd0:	4781                	li	a5,0
    80005cd2:	a09d                	j	80005d38 <sys_link+0x146>
    end_op(ROOTDEV);
    80005cd4:	4501                	li	a0,0
    80005cd6:	fffff097          	auipc	ra,0xfffff
    80005cda:	bd8080e7          	jalr	-1064(ra) # 800048ae <end_op>
    return -1;
    80005cde:	57fd                	li	a5,-1
    80005ce0:	a8a1                	j	80005d38 <sys_link+0x146>
    iunlockput(ip);
    80005ce2:	8526                	mv	a0,s1
    80005ce4:	ffffe097          	auipc	ra,0xffffe
    80005ce8:	384080e7          	jalr	900(ra) # 80004068 <iunlockput>
    end_op(ROOTDEV);
    80005cec:	4501                	li	a0,0
    80005cee:	fffff097          	auipc	ra,0xfffff
    80005cf2:	bc0080e7          	jalr	-1088(ra) # 800048ae <end_op>
    return -1;
    80005cf6:	57fd                	li	a5,-1
    80005cf8:	a081                	j	80005d38 <sys_link+0x146>
    iunlockput(dp);
    80005cfa:	854a                	mv	a0,s2
    80005cfc:	ffffe097          	auipc	ra,0xffffe
    80005d00:	36c080e7          	jalr	876(ra) # 80004068 <iunlockput>
  ilock(ip);
    80005d04:	8526                	mv	a0,s1
    80005d06:	ffffe097          	auipc	ra,0xffffe
    80005d0a:	122080e7          	jalr	290(ra) # 80003e28 <ilock>
  ip->nlink--;
    80005d0e:	0624d783          	lhu	a5,98(s1)
    80005d12:	37fd                	addiw	a5,a5,-1
    80005d14:	06f49123          	sh	a5,98(s1)
  iupdate(ip);
    80005d18:	8526                	mv	a0,s1
    80005d1a:	ffffe097          	auipc	ra,0xffffe
    80005d1e:	042080e7          	jalr	66(ra) # 80003d5c <iupdate>
  iunlockput(ip);
    80005d22:	8526                	mv	a0,s1
    80005d24:	ffffe097          	auipc	ra,0xffffe
    80005d28:	344080e7          	jalr	836(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    80005d2c:	4501                	li	a0,0
    80005d2e:	fffff097          	auipc	ra,0xfffff
    80005d32:	b80080e7          	jalr	-1152(ra) # 800048ae <end_op>
  return -1;
    80005d36:	57fd                	li	a5,-1
}
    80005d38:	853e                	mv	a0,a5
    80005d3a:	70b2                	ld	ra,296(sp)
    80005d3c:	7412                	ld	s0,288(sp)
    80005d3e:	64f2                	ld	s1,280(sp)
    80005d40:	6952                	ld	s2,272(sp)
    80005d42:	6155                	addi	sp,sp,304
    80005d44:	8082                	ret

0000000080005d46 <sys_unlink>:
{
    80005d46:	7151                	addi	sp,sp,-240
    80005d48:	f586                	sd	ra,232(sp)
    80005d4a:	f1a2                	sd	s0,224(sp)
    80005d4c:	eda6                	sd	s1,216(sp)
    80005d4e:	e9ca                	sd	s2,208(sp)
    80005d50:	e5ce                	sd	s3,200(sp)
    80005d52:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005d54:	08000613          	li	a2,128
    80005d58:	f3040593          	addi	a1,s0,-208
    80005d5c:	4501                	li	a0,0
    80005d5e:	ffffd097          	auipc	ra,0xffffd
    80005d62:	53c080e7          	jalr	1340(ra) # 8000329a <argstr>
    80005d66:	18054263          	bltz	a0,80005eea <sys_unlink+0x1a4>
  begin_op(ROOTDEV);
    80005d6a:	4501                	li	a0,0
    80005d6c:	fffff097          	auipc	ra,0xfffff
    80005d70:	a96080e7          	jalr	-1386(ra) # 80004802 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80005d74:	fb040593          	addi	a1,s0,-80
    80005d78:	f3040513          	addi	a0,s0,-208
    80005d7c:	fffff097          	auipc	ra,0xfffff
    80005d80:	85e080e7          	jalr	-1954(ra) # 800045da <nameiparent>
    80005d84:	89aa                	mv	s3,a0
    80005d86:	cd61                	beqz	a0,80005e5e <sys_unlink+0x118>
  ilock(dp);
    80005d88:	ffffe097          	auipc	ra,0xffffe
    80005d8c:	0a0080e7          	jalr	160(ra) # 80003e28 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005d90:	00003597          	auipc	a1,0x3
    80005d94:	ef858593          	addi	a1,a1,-264 # 80008c88 <userret+0xbf8>
    80005d98:	fb040513          	addi	a0,s0,-80
    80005d9c:	ffffe097          	auipc	ra,0xffffe
    80005da0:	52c080e7          	jalr	1324(ra) # 800042c8 <namecmp>
    80005da4:	14050a63          	beqz	a0,80005ef8 <sys_unlink+0x1b2>
    80005da8:	00003597          	auipc	a1,0x3
    80005dac:	ee858593          	addi	a1,a1,-280 # 80008c90 <userret+0xc00>
    80005db0:	fb040513          	addi	a0,s0,-80
    80005db4:	ffffe097          	auipc	ra,0xffffe
    80005db8:	514080e7          	jalr	1300(ra) # 800042c8 <namecmp>
    80005dbc:	12050e63          	beqz	a0,80005ef8 <sys_unlink+0x1b2>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80005dc0:	f2c40613          	addi	a2,s0,-212
    80005dc4:	fb040593          	addi	a1,s0,-80
    80005dc8:	854e                	mv	a0,s3
    80005dca:	ffffe097          	auipc	ra,0xffffe
    80005dce:	518080e7          	jalr	1304(ra) # 800042e2 <dirlookup>
    80005dd2:	84aa                	mv	s1,a0
    80005dd4:	12050263          	beqz	a0,80005ef8 <sys_unlink+0x1b2>
  ilock(ip);
    80005dd8:	ffffe097          	auipc	ra,0xffffe
    80005ddc:	050080e7          	jalr	80(ra) # 80003e28 <ilock>
  if(ip->nlink < 1)
    80005de0:	06249783          	lh	a5,98(s1)
    80005de4:	08f05463          	blez	a5,80005e6c <sys_unlink+0x126>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005de8:	05c49703          	lh	a4,92(s1)
    80005dec:	4785                	li	a5,1
    80005dee:	08f70763          	beq	a4,a5,80005e7c <sys_unlink+0x136>
  memset(&de, 0, sizeof(de));
    80005df2:	4641                	li	a2,16
    80005df4:	4581                	li	a1,0
    80005df6:	fc040513          	addi	a0,s0,-64
    80005dfa:	ffffb097          	auipc	ra,0xffffb
    80005dfe:	3aa080e7          	jalr	938(ra) # 800011a4 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e02:	4741                	li	a4,16
    80005e04:	f2c42683          	lw	a3,-212(s0)
    80005e08:	fc040613          	addi	a2,s0,-64
    80005e0c:	4581                	li	a1,0
    80005e0e:	854e                	mv	a0,s3
    80005e10:	ffffe097          	auipc	ra,0xffffe
    80005e14:	39e080e7          	jalr	926(ra) # 800041ae <writei>
    80005e18:	47c1                	li	a5,16
    80005e1a:	0af51563          	bne	a0,a5,80005ec4 <sys_unlink+0x17e>
  if(ip->type == T_DIR){
    80005e1e:	05c49703          	lh	a4,92(s1)
    80005e22:	4785                	li	a5,1
    80005e24:	0af70863          	beq	a4,a5,80005ed4 <sys_unlink+0x18e>
  iunlockput(dp);
    80005e28:	854e                	mv	a0,s3
    80005e2a:	ffffe097          	auipc	ra,0xffffe
    80005e2e:	23e080e7          	jalr	574(ra) # 80004068 <iunlockput>
  ip->nlink--;
    80005e32:	0624d783          	lhu	a5,98(s1)
    80005e36:	37fd                	addiw	a5,a5,-1
    80005e38:	06f49123          	sh	a5,98(s1)
  iupdate(ip);
    80005e3c:	8526                	mv	a0,s1
    80005e3e:	ffffe097          	auipc	ra,0xffffe
    80005e42:	f1e080e7          	jalr	-226(ra) # 80003d5c <iupdate>
  iunlockput(ip);
    80005e46:	8526                	mv	a0,s1
    80005e48:	ffffe097          	auipc	ra,0xffffe
    80005e4c:	220080e7          	jalr	544(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    80005e50:	4501                	li	a0,0
    80005e52:	fffff097          	auipc	ra,0xfffff
    80005e56:	a5c080e7          	jalr	-1444(ra) # 800048ae <end_op>
  return 0;
    80005e5a:	4501                	li	a0,0
    80005e5c:	a84d                	j	80005f0e <sys_unlink+0x1c8>
    end_op(ROOTDEV);
    80005e5e:	4501                	li	a0,0
    80005e60:	fffff097          	auipc	ra,0xfffff
    80005e64:	a4e080e7          	jalr	-1458(ra) # 800048ae <end_op>
    return -1;
    80005e68:	557d                	li	a0,-1
    80005e6a:	a055                	j	80005f0e <sys_unlink+0x1c8>
    panic("unlink: nlink < 1");
    80005e6c:	00003517          	auipc	a0,0x3
    80005e70:	e4c50513          	addi	a0,a0,-436 # 80008cb8 <userret+0xc28>
    80005e74:	ffffb097          	auipc	ra,0xffffb
    80005e78:	952080e7          	jalr	-1710(ra) # 800007c6 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005e7c:	50f8                	lw	a4,100(s1)
    80005e7e:	02000793          	li	a5,32
    80005e82:	f6e7f8e3          	bleu	a4,a5,80005df2 <sys_unlink+0xac>
    80005e86:	02000913          	li	s2,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e8a:	4741                	li	a4,16
    80005e8c:	86ca                	mv	a3,s2
    80005e8e:	f1840613          	addi	a2,s0,-232
    80005e92:	4581                	li	a1,0
    80005e94:	8526                	mv	a0,s1
    80005e96:	ffffe097          	auipc	ra,0xffffe
    80005e9a:	224080e7          	jalr	548(ra) # 800040ba <readi>
    80005e9e:	47c1                	li	a5,16
    80005ea0:	00f51a63          	bne	a0,a5,80005eb4 <sys_unlink+0x16e>
    if(de.inum != 0)
    80005ea4:	f1845783          	lhu	a5,-232(s0)
    80005ea8:	e3b9                	bnez	a5,80005eee <sys_unlink+0x1a8>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005eaa:	2941                	addiw	s2,s2,16
    80005eac:	50fc                	lw	a5,100(s1)
    80005eae:	fcf96ee3          	bltu	s2,a5,80005e8a <sys_unlink+0x144>
    80005eb2:	b781                	j	80005df2 <sys_unlink+0xac>
      panic("isdirempty: readi");
    80005eb4:	00003517          	auipc	a0,0x3
    80005eb8:	e1c50513          	addi	a0,a0,-484 # 80008cd0 <userret+0xc40>
    80005ebc:	ffffb097          	auipc	ra,0xffffb
    80005ec0:	90a080e7          	jalr	-1782(ra) # 800007c6 <panic>
    panic("unlink: writei");
    80005ec4:	00003517          	auipc	a0,0x3
    80005ec8:	e2450513          	addi	a0,a0,-476 # 80008ce8 <userret+0xc58>
    80005ecc:	ffffb097          	auipc	ra,0xffffb
    80005ed0:	8fa080e7          	jalr	-1798(ra) # 800007c6 <panic>
    dp->nlink--;
    80005ed4:	0629d783          	lhu	a5,98(s3)
    80005ed8:	37fd                	addiw	a5,a5,-1
    80005eda:	06f99123          	sh	a5,98(s3)
    iupdate(dp);
    80005ede:	854e                	mv	a0,s3
    80005ee0:	ffffe097          	auipc	ra,0xffffe
    80005ee4:	e7c080e7          	jalr	-388(ra) # 80003d5c <iupdate>
    80005ee8:	b781                	j	80005e28 <sys_unlink+0xe2>
    return -1;
    80005eea:	557d                	li	a0,-1
    80005eec:	a00d                	j	80005f0e <sys_unlink+0x1c8>
    iunlockput(ip);
    80005eee:	8526                	mv	a0,s1
    80005ef0:	ffffe097          	auipc	ra,0xffffe
    80005ef4:	178080e7          	jalr	376(ra) # 80004068 <iunlockput>
  iunlockput(dp);
    80005ef8:	854e                	mv	a0,s3
    80005efa:	ffffe097          	auipc	ra,0xffffe
    80005efe:	16e080e7          	jalr	366(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    80005f02:	4501                	li	a0,0
    80005f04:	fffff097          	auipc	ra,0xfffff
    80005f08:	9aa080e7          	jalr	-1622(ra) # 800048ae <end_op>
  return -1;
    80005f0c:	557d                	li	a0,-1
}
    80005f0e:	70ae                	ld	ra,232(sp)
    80005f10:	740e                	ld	s0,224(sp)
    80005f12:	64ee                	ld	s1,216(sp)
    80005f14:	694e                	ld	s2,208(sp)
    80005f16:	69ae                	ld	s3,200(sp)
    80005f18:	616d                	addi	sp,sp,240
    80005f1a:	8082                	ret

0000000080005f1c <sys_open>:

uint64
sys_open(void)
{
    80005f1c:	7131                	addi	sp,sp,-192
    80005f1e:	fd06                	sd	ra,184(sp)
    80005f20:	f922                	sd	s0,176(sp)
    80005f22:	f526                	sd	s1,168(sp)
    80005f24:	f14a                	sd	s2,160(sp)
    80005f26:	ed4e                	sd	s3,152(sp)
    80005f28:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005f2a:	08000613          	li	a2,128
    80005f2e:	f5040593          	addi	a1,s0,-176
    80005f32:	4501                	li	a0,0
    80005f34:	ffffd097          	auipc	ra,0xffffd
    80005f38:	366080e7          	jalr	870(ra) # 8000329a <argstr>
    return -1;
    80005f3c:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80005f3e:	0a054963          	bltz	a0,80005ff0 <sys_open+0xd4>
    80005f42:	f4c40593          	addi	a1,s0,-180
    80005f46:	4505                	li	a0,1
    80005f48:	ffffd097          	auipc	ra,0xffffd
    80005f4c:	30e080e7          	jalr	782(ra) # 80003256 <argint>
    80005f50:	0a054063          	bltz	a0,80005ff0 <sys_open+0xd4>

  begin_op(ROOTDEV);
    80005f54:	4501                	li	a0,0
    80005f56:	fffff097          	auipc	ra,0xfffff
    80005f5a:	8ac080e7          	jalr	-1876(ra) # 80004802 <begin_op>

  if(omode & O_CREATE){
    80005f5e:	f4c42783          	lw	a5,-180(s0)
    80005f62:	2007f793          	andi	a5,a5,512
    80005f66:	c3dd                	beqz	a5,8000600c <sys_open+0xf0>
    ip = create(path, T_FILE, 0, 0);
    80005f68:	4681                	li	a3,0
    80005f6a:	4601                	li	a2,0
    80005f6c:	4589                	li	a1,2
    80005f6e:	f5040513          	addi	a0,s0,-176
    80005f72:	00000097          	auipc	ra,0x0
    80005f76:	962080e7          	jalr	-1694(ra) # 800058d4 <create>
    80005f7a:	892a                	mv	s2,a0
    if(ip == 0){
    80005f7c:	c151                	beqz	a0,80006000 <sys_open+0xe4>
      end_op(ROOTDEV);
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005f7e:	05c91703          	lh	a4,92(s2)
    80005f82:	478d                	li	a5,3
    80005f84:	00f71763          	bne	a4,a5,80005f92 <sys_open+0x76>
    80005f88:	05e95703          	lhu	a4,94(s2)
    80005f8c:	47a5                	li	a5,9
    80005f8e:	0ce7e663          	bltu	a5,a4,8000605a <sys_open+0x13e>
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005f92:	fffff097          	auipc	ra,0xfffff
    80005f96:	d5c080e7          	jalr	-676(ra) # 80004cee <filealloc>
    80005f9a:	89aa                	mv	s3,a0
    80005f9c:	c97d                	beqz	a0,80006092 <sys_open+0x176>
    80005f9e:	00000097          	auipc	ra,0x0
    80005fa2:	8ee080e7          	jalr	-1810(ra) # 8000588c <fdalloc>
    80005fa6:	84aa                	mv	s1,a0
    80005fa8:	0e054063          	bltz	a0,80006088 <sys_open+0x16c>
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005fac:	05c91703          	lh	a4,92(s2)
    80005fb0:	478d                	li	a5,3
    80005fb2:	0cf70063          	beq	a4,a5,80006072 <sys_open+0x156>
    f->type = FD_DEVICE;
    f->major = ip->major;
    f->minor = ip->minor;
  } else {
    f->type = FD_INODE;
    80005fb6:	4789                	li	a5,2
    80005fb8:	00f9a023          	sw	a5,0(s3)
  }
  f->ip = ip;
    80005fbc:	0129bc23          	sd	s2,24(s3)
  f->off = 0;
    80005fc0:	0209a023          	sw	zero,32(s3)
  f->readable = !(omode & O_WRONLY);
    80005fc4:	f4c42783          	lw	a5,-180(s0)
    80005fc8:	0017c713          	xori	a4,a5,1
    80005fcc:	8b05                	andi	a4,a4,1
    80005fce:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005fd2:	8b8d                	andi	a5,a5,3
    80005fd4:	00f037b3          	snez	a5,a5
    80005fd8:	00f984a3          	sb	a5,9(s3)

  iunlock(ip);
    80005fdc:	854a                	mv	a0,s2
    80005fde:	ffffe097          	auipc	ra,0xffffe
    80005fe2:	f0e080e7          	jalr	-242(ra) # 80003eec <iunlock>
  end_op(ROOTDEV);
    80005fe6:	4501                	li	a0,0
    80005fe8:	fffff097          	auipc	ra,0xfffff
    80005fec:	8c6080e7          	jalr	-1850(ra) # 800048ae <end_op>

  return fd;
}
    80005ff0:	8526                	mv	a0,s1
    80005ff2:	70ea                	ld	ra,184(sp)
    80005ff4:	744a                	ld	s0,176(sp)
    80005ff6:	74aa                	ld	s1,168(sp)
    80005ff8:	790a                	ld	s2,160(sp)
    80005ffa:	69ea                	ld	s3,152(sp)
    80005ffc:	6129                	addi	sp,sp,192
    80005ffe:	8082                	ret
      end_op(ROOTDEV);
    80006000:	4501                	li	a0,0
    80006002:	fffff097          	auipc	ra,0xfffff
    80006006:	8ac080e7          	jalr	-1876(ra) # 800048ae <end_op>
      return -1;
    8000600a:	b7dd                	j	80005ff0 <sys_open+0xd4>
    if((ip = namei(path)) == 0){
    8000600c:	f5040513          	addi	a0,s0,-176
    80006010:	ffffe097          	auipc	ra,0xffffe
    80006014:	5ac080e7          	jalr	1452(ra) # 800045bc <namei>
    80006018:	892a                	mv	s2,a0
    8000601a:	c90d                	beqz	a0,8000604c <sys_open+0x130>
    ilock(ip);
    8000601c:	ffffe097          	auipc	ra,0xffffe
    80006020:	e0c080e7          	jalr	-500(ra) # 80003e28 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80006024:	05c91703          	lh	a4,92(s2)
    80006028:	4785                	li	a5,1
    8000602a:	f4f71ae3          	bne	a4,a5,80005f7e <sys_open+0x62>
    8000602e:	f4c42783          	lw	a5,-180(s0)
    80006032:	d3a5                	beqz	a5,80005f92 <sys_open+0x76>
      iunlockput(ip);
    80006034:	854a                	mv	a0,s2
    80006036:	ffffe097          	auipc	ra,0xffffe
    8000603a:	032080e7          	jalr	50(ra) # 80004068 <iunlockput>
      end_op(ROOTDEV);
    8000603e:	4501                	li	a0,0
    80006040:	fffff097          	auipc	ra,0xfffff
    80006044:	86e080e7          	jalr	-1938(ra) # 800048ae <end_op>
      return -1;
    80006048:	54fd                	li	s1,-1
    8000604a:	b75d                	j	80005ff0 <sys_open+0xd4>
      end_op(ROOTDEV);
    8000604c:	4501                	li	a0,0
    8000604e:	fffff097          	auipc	ra,0xfffff
    80006052:	860080e7          	jalr	-1952(ra) # 800048ae <end_op>
      return -1;
    80006056:	54fd                	li	s1,-1
    80006058:	bf61                	j	80005ff0 <sys_open+0xd4>
    iunlockput(ip);
    8000605a:	854a                	mv	a0,s2
    8000605c:	ffffe097          	auipc	ra,0xffffe
    80006060:	00c080e7          	jalr	12(ra) # 80004068 <iunlockput>
    end_op(ROOTDEV);
    80006064:	4501                	li	a0,0
    80006066:	fffff097          	auipc	ra,0xfffff
    8000606a:	848080e7          	jalr	-1976(ra) # 800048ae <end_op>
    return -1;
    8000606e:	54fd                	li	s1,-1
    80006070:	b741                	j	80005ff0 <sys_open+0xd4>
    f->type = FD_DEVICE;
    80006072:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80006076:	05e91783          	lh	a5,94(s2)
    8000607a:	02f99223          	sh	a5,36(s3)
    f->minor = ip->minor;
    8000607e:	06091783          	lh	a5,96(s2)
    80006082:	02f99323          	sh	a5,38(s3)
    80006086:	bf1d                	j	80005fbc <sys_open+0xa0>
      fileclose(f);
    80006088:	854e                	mv	a0,s3
    8000608a:	fffff097          	auipc	ra,0xfffff
    8000608e:	d34080e7          	jalr	-716(ra) # 80004dbe <fileclose>
    iunlockput(ip);
    80006092:	854a                	mv	a0,s2
    80006094:	ffffe097          	auipc	ra,0xffffe
    80006098:	fd4080e7          	jalr	-44(ra) # 80004068 <iunlockput>
    end_op(ROOTDEV);
    8000609c:	4501                	li	a0,0
    8000609e:	fffff097          	auipc	ra,0xfffff
    800060a2:	810080e7          	jalr	-2032(ra) # 800048ae <end_op>
    return -1;
    800060a6:	54fd                	li	s1,-1
    800060a8:	b7a1                	j	80005ff0 <sys_open+0xd4>

00000000800060aa <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800060aa:	7175                	addi	sp,sp,-144
    800060ac:	e506                	sd	ra,136(sp)
    800060ae:	e122                	sd	s0,128(sp)
    800060b0:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op(ROOTDEV);
    800060b2:	4501                	li	a0,0
    800060b4:	ffffe097          	auipc	ra,0xffffe
    800060b8:	74e080e7          	jalr	1870(ra) # 80004802 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800060bc:	08000613          	li	a2,128
    800060c0:	f7040593          	addi	a1,s0,-144
    800060c4:	4501                	li	a0,0
    800060c6:	ffffd097          	auipc	ra,0xffffd
    800060ca:	1d4080e7          	jalr	468(ra) # 8000329a <argstr>
    800060ce:	02054a63          	bltz	a0,80006102 <sys_mkdir+0x58>
    800060d2:	4681                	li	a3,0
    800060d4:	4601                	li	a2,0
    800060d6:	4585                	li	a1,1
    800060d8:	f7040513          	addi	a0,s0,-144
    800060dc:	fffff097          	auipc	ra,0xfffff
    800060e0:	7f8080e7          	jalr	2040(ra) # 800058d4 <create>
    800060e4:	cd19                	beqz	a0,80006102 <sys_mkdir+0x58>
    end_op(ROOTDEV);
    return -1;
  }
  iunlockput(ip);
    800060e6:	ffffe097          	auipc	ra,0xffffe
    800060ea:	f82080e7          	jalr	-126(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    800060ee:	4501                	li	a0,0
    800060f0:	ffffe097          	auipc	ra,0xffffe
    800060f4:	7be080e7          	jalr	1982(ra) # 800048ae <end_op>
  return 0;
    800060f8:	4501                	li	a0,0
}
    800060fa:	60aa                	ld	ra,136(sp)
    800060fc:	640a                	ld	s0,128(sp)
    800060fe:	6149                	addi	sp,sp,144
    80006100:	8082                	ret
    end_op(ROOTDEV);
    80006102:	4501                	li	a0,0
    80006104:	ffffe097          	auipc	ra,0xffffe
    80006108:	7aa080e7          	jalr	1962(ra) # 800048ae <end_op>
    return -1;
    8000610c:	557d                	li	a0,-1
    8000610e:	b7f5                	j	800060fa <sys_mkdir+0x50>

0000000080006110 <sys_mknod>:

uint64
sys_mknod(void)
{
    80006110:	7135                	addi	sp,sp,-160
    80006112:	ed06                	sd	ra,152(sp)
    80006114:	e922                	sd	s0,144(sp)
    80006116:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op(ROOTDEV);
    80006118:	4501                	li	a0,0
    8000611a:	ffffe097          	auipc	ra,0xffffe
    8000611e:	6e8080e7          	jalr	1768(ra) # 80004802 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80006122:	08000613          	li	a2,128
    80006126:	f7040593          	addi	a1,s0,-144
    8000612a:	4501                	li	a0,0
    8000612c:	ffffd097          	auipc	ra,0xffffd
    80006130:	16e080e7          	jalr	366(ra) # 8000329a <argstr>
    80006134:	04054b63          	bltz	a0,8000618a <sys_mknod+0x7a>
     argint(1, &major) < 0 ||
    80006138:	f6c40593          	addi	a1,s0,-148
    8000613c:	4505                	li	a0,1
    8000613e:	ffffd097          	auipc	ra,0xffffd
    80006142:	118080e7          	jalr	280(ra) # 80003256 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80006146:	04054263          	bltz	a0,8000618a <sys_mknod+0x7a>
     argint(2, &minor) < 0 ||
    8000614a:	f6840593          	addi	a1,s0,-152
    8000614e:	4509                	li	a0,2
    80006150:	ffffd097          	auipc	ra,0xffffd
    80006154:	106080e7          	jalr	262(ra) # 80003256 <argint>
     argint(1, &major) < 0 ||
    80006158:	02054963          	bltz	a0,8000618a <sys_mknod+0x7a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000615c:	f6841683          	lh	a3,-152(s0)
    80006160:	f6c41603          	lh	a2,-148(s0)
    80006164:	458d                	li	a1,3
    80006166:	f7040513          	addi	a0,s0,-144
    8000616a:	fffff097          	auipc	ra,0xfffff
    8000616e:	76a080e7          	jalr	1898(ra) # 800058d4 <create>
     argint(2, &minor) < 0 ||
    80006172:	cd01                	beqz	a0,8000618a <sys_mknod+0x7a>
    end_op(ROOTDEV);
    return -1;
  }
  iunlockput(ip);
    80006174:	ffffe097          	auipc	ra,0xffffe
    80006178:	ef4080e7          	jalr	-268(ra) # 80004068 <iunlockput>
  end_op(ROOTDEV);
    8000617c:	4501                	li	a0,0
    8000617e:	ffffe097          	auipc	ra,0xffffe
    80006182:	730080e7          	jalr	1840(ra) # 800048ae <end_op>
  return 0;
    80006186:	4501                	li	a0,0
    80006188:	a039                	j	80006196 <sys_mknod+0x86>
    end_op(ROOTDEV);
    8000618a:	4501                	li	a0,0
    8000618c:	ffffe097          	auipc	ra,0xffffe
    80006190:	722080e7          	jalr	1826(ra) # 800048ae <end_op>
    return -1;
    80006194:	557d                	li	a0,-1
}
    80006196:	60ea                	ld	ra,152(sp)
    80006198:	644a                	ld	s0,144(sp)
    8000619a:	610d                	addi	sp,sp,160
    8000619c:	8082                	ret

000000008000619e <sys_chdir>:

uint64
sys_chdir(void)
{
    8000619e:	7135                	addi	sp,sp,-160
    800061a0:	ed06                	sd	ra,152(sp)
    800061a2:	e922                	sd	s0,144(sp)
    800061a4:	e526                	sd	s1,136(sp)
    800061a6:	e14a                	sd	s2,128(sp)
    800061a8:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800061aa:	ffffc097          	auipc	ra,0xffffc
    800061ae:	e50080e7          	jalr	-432(ra) # 80001ffa <myproc>
    800061b2:	892a                	mv	s2,a0
  
  begin_op(ROOTDEV);
    800061b4:	4501                	li	a0,0
    800061b6:	ffffe097          	auipc	ra,0xffffe
    800061ba:	64c080e7          	jalr	1612(ra) # 80004802 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800061be:	08000613          	li	a2,128
    800061c2:	f6040593          	addi	a1,s0,-160
    800061c6:	4501                	li	a0,0
    800061c8:	ffffd097          	auipc	ra,0xffffd
    800061cc:	0d2080e7          	jalr	210(ra) # 8000329a <argstr>
    800061d0:	04054c63          	bltz	a0,80006228 <sys_chdir+0x8a>
    800061d4:	f6040513          	addi	a0,s0,-160
    800061d8:	ffffe097          	auipc	ra,0xffffe
    800061dc:	3e4080e7          	jalr	996(ra) # 800045bc <namei>
    800061e0:	84aa                	mv	s1,a0
    800061e2:	c139                	beqz	a0,80006228 <sys_chdir+0x8a>
    end_op(ROOTDEV);
    return -1;
  }
  ilock(ip);
    800061e4:	ffffe097          	auipc	ra,0xffffe
    800061e8:	c44080e7          	jalr	-956(ra) # 80003e28 <ilock>
  if(ip->type != T_DIR){
    800061ec:	05c49703          	lh	a4,92(s1)
    800061f0:	4785                	li	a5,1
    800061f2:	04f71263          	bne	a4,a5,80006236 <sys_chdir+0x98>
    iunlockput(ip);
    end_op(ROOTDEV);
    return -1;
  }
  iunlock(ip);
    800061f6:	8526                	mv	a0,s1
    800061f8:	ffffe097          	auipc	ra,0xffffe
    800061fc:	cf4080e7          	jalr	-780(ra) # 80003eec <iunlock>
  iput(p->cwd);
    80006200:	16893503          	ld	a0,360(s2)
    80006204:	ffffe097          	auipc	ra,0xffffe
    80006208:	d34080e7          	jalr	-716(ra) # 80003f38 <iput>
  end_op(ROOTDEV);
    8000620c:	4501                	li	a0,0
    8000620e:	ffffe097          	auipc	ra,0xffffe
    80006212:	6a0080e7          	jalr	1696(ra) # 800048ae <end_op>
  p->cwd = ip;
    80006216:	16993423          	sd	s1,360(s2)
  return 0;
    8000621a:	4501                	li	a0,0
}
    8000621c:	60ea                	ld	ra,152(sp)
    8000621e:	644a                	ld	s0,144(sp)
    80006220:	64aa                	ld	s1,136(sp)
    80006222:	690a                	ld	s2,128(sp)
    80006224:	610d                	addi	sp,sp,160
    80006226:	8082                	ret
    end_op(ROOTDEV);
    80006228:	4501                	li	a0,0
    8000622a:	ffffe097          	auipc	ra,0xffffe
    8000622e:	684080e7          	jalr	1668(ra) # 800048ae <end_op>
    return -1;
    80006232:	557d                	li	a0,-1
    80006234:	b7e5                	j	8000621c <sys_chdir+0x7e>
    iunlockput(ip);
    80006236:	8526                	mv	a0,s1
    80006238:	ffffe097          	auipc	ra,0xffffe
    8000623c:	e30080e7          	jalr	-464(ra) # 80004068 <iunlockput>
    end_op(ROOTDEV);
    80006240:	4501                	li	a0,0
    80006242:	ffffe097          	auipc	ra,0xffffe
    80006246:	66c080e7          	jalr	1644(ra) # 800048ae <end_op>
    return -1;
    8000624a:	557d                	li	a0,-1
    8000624c:	bfc1                	j	8000621c <sys_chdir+0x7e>

000000008000624e <sys_exec>:

uint64
sys_exec(void)
{
    8000624e:	7145                	addi	sp,sp,-464
    80006250:	e786                	sd	ra,456(sp)
    80006252:	e3a2                	sd	s0,448(sp)
    80006254:	ff26                	sd	s1,440(sp)
    80006256:	fb4a                	sd	s2,432(sp)
    80006258:	f74e                	sd	s3,424(sp)
    8000625a:	f352                	sd	s4,416(sp)
    8000625c:	ef56                	sd	s5,408(sp)
    8000625e:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80006260:	08000613          	li	a2,128
    80006264:	f4040593          	addi	a1,s0,-192
    80006268:	4501                	li	a0,0
    8000626a:	ffffd097          	auipc	ra,0xffffd
    8000626e:	030080e7          	jalr	48(ra) # 8000329a <argstr>
    80006272:	10054763          	bltz	a0,80006380 <sys_exec+0x132>
    80006276:	e3840593          	addi	a1,s0,-456
    8000627a:	4505                	li	a0,1
    8000627c:	ffffd097          	auipc	ra,0xffffd
    80006280:	ffc080e7          	jalr	-4(ra) # 80003278 <argaddr>
    80006284:	10054863          	bltz	a0,80006394 <sys_exec+0x146>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
    80006288:	e4040913          	addi	s2,s0,-448
    8000628c:	10000613          	li	a2,256
    80006290:	4581                	li	a1,0
    80006292:	854a                	mv	a0,s2
    80006294:	ffffb097          	auipc	ra,0xffffb
    80006298:	f10080e7          	jalr	-240(ra) # 800011a4 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000629c:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    8000629e:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    800062a0:	02000a93          	li	s5,32
    800062a4:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800062a8:	00349513          	slli	a0,s1,0x3
    800062ac:	e3040593          	addi	a1,s0,-464
    800062b0:	e3843783          	ld	a5,-456(s0)
    800062b4:	953e                	add	a0,a0,a5
    800062b6:	ffffd097          	auipc	ra,0xffffd
    800062ba:	f04080e7          	jalr	-252(ra) # 800031ba <fetchaddr>
    800062be:	02054a63          	bltz	a0,800062f2 <sys_exec+0xa4>
      goto bad;
    }
    if(uarg == 0){
    800062c2:	e3043783          	ld	a5,-464(s0)
    800062c6:	cfa1                	beqz	a5,8000631e <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800062c8:	ffffb097          	auipc	ra,0xffffb
    800062cc:	8e0080e7          	jalr	-1824(ra) # 80000ba8 <kalloc>
    800062d0:	85aa                	mv	a1,a0
    800062d2:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    800062d6:	c949                	beqz	a0,80006368 <sys_exec+0x11a>
      panic("sys_exec kalloc");
    if(fetchstr(uarg, argv[i], PGSIZE) < 0){
    800062d8:	6605                	lui	a2,0x1
    800062da:	e3043503          	ld	a0,-464(s0)
    800062de:	ffffd097          	auipc	ra,0xffffd
    800062e2:	f30080e7          	jalr	-208(ra) # 8000320e <fetchstr>
    800062e6:	00054663          	bltz	a0,800062f2 <sys_exec+0xa4>
    if(i >= NELEM(argv)){
    800062ea:	0485                	addi	s1,s1,1
    800062ec:	0921                	addi	s2,s2,8
    800062ee:	fb549be3          	bne	s1,s5,800062a4 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800062f2:	e4043503          	ld	a0,-448(s0)
    800062f6:	c149                	beqz	a0,80006378 <sys_exec+0x12a>
    kfree(argv[i]);
    800062f8:	ffffb097          	auipc	ra,0xffffb
    800062fc:	898080e7          	jalr	-1896(ra) # 80000b90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006300:	e4840493          	addi	s1,s0,-440
    80006304:	10098993          	addi	s3,s3,256
    80006308:	6088                	ld	a0,0(s1)
    8000630a:	c92d                	beqz	a0,8000637c <sys_exec+0x12e>
    kfree(argv[i]);
    8000630c:	ffffb097          	auipc	ra,0xffffb
    80006310:	884080e7          	jalr	-1916(ra) # 80000b90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006314:	04a1                	addi	s1,s1,8
    80006316:	ff3499e3          	bne	s1,s3,80006308 <sys_exec+0xba>
  return -1;
    8000631a:	557d                	li	a0,-1
    8000631c:	a09d                	j	80006382 <sys_exec+0x134>
      argv[i] = 0;
    8000631e:	0a0e                	slli	s4,s4,0x3
    80006320:	fc040793          	addi	a5,s0,-64
    80006324:	9a3e                	add	s4,s4,a5
    80006326:	e80a3023          	sd	zero,-384(s4)
  int ret = exec(path, argv);
    8000632a:	e4040593          	addi	a1,s0,-448
    8000632e:	f4040513          	addi	a0,s0,-192
    80006332:	fffff097          	auipc	ra,0xfffff
    80006336:	150080e7          	jalr	336(ra) # 80005482 <exec>
    8000633a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000633c:	e4043503          	ld	a0,-448(s0)
    80006340:	c115                	beqz	a0,80006364 <sys_exec+0x116>
    kfree(argv[i]);
    80006342:	ffffb097          	auipc	ra,0xffffb
    80006346:	84e080e7          	jalr	-1970(ra) # 80000b90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000634a:	e4840493          	addi	s1,s0,-440
    8000634e:	10098993          	addi	s3,s3,256
    80006352:	6088                	ld	a0,0(s1)
    80006354:	c901                	beqz	a0,80006364 <sys_exec+0x116>
    kfree(argv[i]);
    80006356:	ffffb097          	auipc	ra,0xffffb
    8000635a:	83a080e7          	jalr	-1990(ra) # 80000b90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000635e:	04a1                	addi	s1,s1,8
    80006360:	ff3499e3          	bne	s1,s3,80006352 <sys_exec+0x104>
  return ret;
    80006364:	854a                	mv	a0,s2
    80006366:	a831                	j	80006382 <sys_exec+0x134>
      panic("sys_exec kalloc");
    80006368:	00003517          	auipc	a0,0x3
    8000636c:	99050513          	addi	a0,a0,-1648 # 80008cf8 <userret+0xc68>
    80006370:	ffffa097          	auipc	ra,0xffffa
    80006374:	456080e7          	jalr	1110(ra) # 800007c6 <panic>
  return -1;
    80006378:	557d                	li	a0,-1
    8000637a:	a021                	j	80006382 <sys_exec+0x134>
    8000637c:	557d                	li	a0,-1
    8000637e:	a011                	j	80006382 <sys_exec+0x134>
    return -1;
    80006380:	557d                	li	a0,-1
}
    80006382:	60be                	ld	ra,456(sp)
    80006384:	641e                	ld	s0,448(sp)
    80006386:	74fa                	ld	s1,440(sp)
    80006388:	795a                	ld	s2,432(sp)
    8000638a:	79ba                	ld	s3,424(sp)
    8000638c:	7a1a                	ld	s4,416(sp)
    8000638e:	6afa                	ld	s5,408(sp)
    80006390:	6179                	addi	sp,sp,464
    80006392:	8082                	ret
    return -1;
    80006394:	557d                	li	a0,-1
    80006396:	b7f5                	j	80006382 <sys_exec+0x134>

0000000080006398 <sys_pipe>:

uint64
sys_pipe(void)
{
    80006398:	7139                	addi	sp,sp,-64
    8000639a:	fc06                	sd	ra,56(sp)
    8000639c:	f822                	sd	s0,48(sp)
    8000639e:	f426                	sd	s1,40(sp)
    800063a0:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800063a2:	ffffc097          	auipc	ra,0xffffc
    800063a6:	c58080e7          	jalr	-936(ra) # 80001ffa <myproc>
    800063aa:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800063ac:	fd840593          	addi	a1,s0,-40
    800063b0:	4501                	li	a0,0
    800063b2:	ffffd097          	auipc	ra,0xffffd
    800063b6:	ec6080e7          	jalr	-314(ra) # 80003278 <argaddr>
    return -1;
    800063ba:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800063bc:	0c054f63          	bltz	a0,8000649a <sys_pipe+0x102>
  if(pipealloc(&rf, &wf) < 0)
    800063c0:	fc840593          	addi	a1,s0,-56
    800063c4:	fd040513          	addi	a0,s0,-48
    800063c8:	fffff097          	auipc	ra,0xfffff
    800063cc:	d5a080e7          	jalr	-678(ra) # 80005122 <pipealloc>
    return -1;
    800063d0:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800063d2:	0c054463          	bltz	a0,8000649a <sys_pipe+0x102>
  fd0 = -1;
    800063d6:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800063da:	fd043503          	ld	a0,-48(s0)
    800063de:	fffff097          	auipc	ra,0xfffff
    800063e2:	4ae080e7          	jalr	1198(ra) # 8000588c <fdalloc>
    800063e6:	fca42223          	sw	a0,-60(s0)
    800063ea:	08054b63          	bltz	a0,80006480 <sys_pipe+0xe8>
    800063ee:	fc843503          	ld	a0,-56(s0)
    800063f2:	fffff097          	auipc	ra,0xfffff
    800063f6:	49a080e7          	jalr	1178(ra) # 8000588c <fdalloc>
    800063fa:	fca42023          	sw	a0,-64(s0)
    800063fe:	06054863          	bltz	a0,8000646e <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006402:	4691                	li	a3,4
    80006404:	fc440613          	addi	a2,s0,-60
    80006408:	fd843583          	ld	a1,-40(s0)
    8000640c:	74a8                	ld	a0,104(s1)
    8000640e:	ffffc097          	auipc	ra,0xffffc
    80006412:	896080e7          	jalr	-1898(ra) # 80001ca4 <copyout>
    80006416:	02054063          	bltz	a0,80006436 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000641a:	4691                	li	a3,4
    8000641c:	fc040613          	addi	a2,s0,-64
    80006420:	fd843583          	ld	a1,-40(s0)
    80006424:	0591                	addi	a1,a1,4
    80006426:	74a8                	ld	a0,104(s1)
    80006428:	ffffc097          	auipc	ra,0xffffc
    8000642c:	87c080e7          	jalr	-1924(ra) # 80001ca4 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80006430:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006432:	06055463          	bgez	a0,8000649a <sys_pipe+0x102>
    p->ofile[fd0] = 0;
    80006436:	fc442783          	lw	a5,-60(s0)
    8000643a:	07f1                	addi	a5,a5,28
    8000643c:	078e                	slli	a5,a5,0x3
    8000643e:	97a6                	add	a5,a5,s1
    80006440:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80006444:	fc042783          	lw	a5,-64(s0)
    80006448:	07f1                	addi	a5,a5,28
    8000644a:	078e                	slli	a5,a5,0x3
    8000644c:	94be                	add	s1,s1,a5
    8000644e:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80006452:	fd043503          	ld	a0,-48(s0)
    80006456:	fffff097          	auipc	ra,0xfffff
    8000645a:	968080e7          	jalr	-1688(ra) # 80004dbe <fileclose>
    fileclose(wf);
    8000645e:	fc843503          	ld	a0,-56(s0)
    80006462:	fffff097          	auipc	ra,0xfffff
    80006466:	95c080e7          	jalr	-1700(ra) # 80004dbe <fileclose>
    return -1;
    8000646a:	57fd                	li	a5,-1
    8000646c:	a03d                	j	8000649a <sys_pipe+0x102>
    if(fd0 >= 0)
    8000646e:	fc442783          	lw	a5,-60(s0)
    80006472:	0007c763          	bltz	a5,80006480 <sys_pipe+0xe8>
      p->ofile[fd0] = 0;
    80006476:	07f1                	addi	a5,a5,28
    80006478:	078e                	slli	a5,a5,0x3
    8000647a:	94be                	add	s1,s1,a5
    8000647c:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80006480:	fd043503          	ld	a0,-48(s0)
    80006484:	fffff097          	auipc	ra,0xfffff
    80006488:	93a080e7          	jalr	-1734(ra) # 80004dbe <fileclose>
    fileclose(wf);
    8000648c:	fc843503          	ld	a0,-56(s0)
    80006490:	fffff097          	auipc	ra,0xfffff
    80006494:	92e080e7          	jalr	-1746(ra) # 80004dbe <fileclose>
    return -1;
    80006498:	57fd                	li	a5,-1
}
    8000649a:	853e                	mv	a0,a5
    8000649c:	70e2                	ld	ra,56(sp)
    8000649e:	7442                	ld	s0,48(sp)
    800064a0:	74a2                	ld	s1,40(sp)
    800064a2:	6121                	addi	sp,sp,64
    800064a4:	8082                	ret

00000000800064a6 <sys_create_mutex>:

uint64
sys_create_mutex(void)
{
    800064a6:	1141                	addi	sp,sp,-16
    800064a8:	e422                	sd	s0,8(sp)
    800064aa:	0800                	addi	s0,sp,16
  return -1;
}
    800064ac:	557d                	li	a0,-1
    800064ae:	6422                	ld	s0,8(sp)
    800064b0:	0141                	addi	sp,sp,16
    800064b2:	8082                	ret

00000000800064b4 <sys_acquire_mutex>:

uint64
sys_acquire_mutex(void)
{
    800064b4:	1141                	addi	sp,sp,-16
    800064b6:	e422                	sd	s0,8(sp)
    800064b8:	0800                	addi	s0,sp,16
  return 0;
}
    800064ba:	4501                	li	a0,0
    800064bc:	6422                	ld	s0,8(sp)
    800064be:	0141                	addi	sp,sp,16
    800064c0:	8082                	ret

00000000800064c2 <sys_release_mutex>:

uint64
sys_release_mutex(void)
{
    800064c2:	1141                	addi	sp,sp,-16
    800064c4:	e422                	sd	s0,8(sp)
    800064c6:	0800                	addi	s0,sp,16

  return 0;
}
    800064c8:	4501                	li	a0,0
    800064ca:	6422                	ld	s0,8(sp)
    800064cc:	0141                	addi	sp,sp,16
    800064ce:	8082                	ret

00000000800064d0 <kernelvec>:
    800064d0:	7111                	addi	sp,sp,-256
    800064d2:	e006                	sd	ra,0(sp)
    800064d4:	e40a                	sd	sp,8(sp)
    800064d6:	e80e                	sd	gp,16(sp)
    800064d8:	ec12                	sd	tp,24(sp)
    800064da:	f016                	sd	t0,32(sp)
    800064dc:	f41a                	sd	t1,40(sp)
    800064de:	f81e                	sd	t2,48(sp)
    800064e0:	fc22                	sd	s0,56(sp)
    800064e2:	e0a6                	sd	s1,64(sp)
    800064e4:	e4aa                	sd	a0,72(sp)
    800064e6:	e8ae                	sd	a1,80(sp)
    800064e8:	ecb2                	sd	a2,88(sp)
    800064ea:	f0b6                	sd	a3,96(sp)
    800064ec:	f4ba                	sd	a4,104(sp)
    800064ee:	f8be                	sd	a5,112(sp)
    800064f0:	fcc2                	sd	a6,120(sp)
    800064f2:	e146                	sd	a7,128(sp)
    800064f4:	e54a                	sd	s2,136(sp)
    800064f6:	e94e                	sd	s3,144(sp)
    800064f8:	ed52                	sd	s4,152(sp)
    800064fa:	f156                	sd	s5,160(sp)
    800064fc:	f55a                	sd	s6,168(sp)
    800064fe:	f95e                	sd	s7,176(sp)
    80006500:	fd62                	sd	s8,184(sp)
    80006502:	e1e6                	sd	s9,192(sp)
    80006504:	e5ea                	sd	s10,200(sp)
    80006506:	e9ee                	sd	s11,208(sp)
    80006508:	edf2                	sd	t3,216(sp)
    8000650a:	f1f6                	sd	t4,224(sp)
    8000650c:	f5fa                	sd	t5,232(sp)
    8000650e:	f9fe                	sd	t6,240(sp)
    80006510:	b57fc0ef          	jal	ra,80003066 <kerneltrap>
    80006514:	6082                	ld	ra,0(sp)
    80006516:	6122                	ld	sp,8(sp)
    80006518:	61c2                	ld	gp,16(sp)
    8000651a:	7282                	ld	t0,32(sp)
    8000651c:	7322                	ld	t1,40(sp)
    8000651e:	73c2                	ld	t2,48(sp)
    80006520:	7462                	ld	s0,56(sp)
    80006522:	6486                	ld	s1,64(sp)
    80006524:	6526                	ld	a0,72(sp)
    80006526:	65c6                	ld	a1,80(sp)
    80006528:	6666                	ld	a2,88(sp)
    8000652a:	7686                	ld	a3,96(sp)
    8000652c:	7726                	ld	a4,104(sp)
    8000652e:	77c6                	ld	a5,112(sp)
    80006530:	7866                	ld	a6,120(sp)
    80006532:	688a                	ld	a7,128(sp)
    80006534:	692a                	ld	s2,136(sp)
    80006536:	69ca                	ld	s3,144(sp)
    80006538:	6a6a                	ld	s4,152(sp)
    8000653a:	7a8a                	ld	s5,160(sp)
    8000653c:	7b2a                	ld	s6,168(sp)
    8000653e:	7bca                	ld	s7,176(sp)
    80006540:	7c6a                	ld	s8,184(sp)
    80006542:	6c8e                	ld	s9,192(sp)
    80006544:	6d2e                	ld	s10,200(sp)
    80006546:	6dce                	ld	s11,208(sp)
    80006548:	6e6e                	ld	t3,216(sp)
    8000654a:	7e8e                	ld	t4,224(sp)
    8000654c:	7f2e                	ld	t5,232(sp)
    8000654e:	7fce                	ld	t6,240(sp)
    80006550:	6111                	addi	sp,sp,256
    80006552:	10200073          	sret
    80006556:	00000013          	nop
    8000655a:	00000013          	nop
    8000655e:	0001                	nop

0000000080006560 <timervec>:
    80006560:	34051573          	csrrw	a0,mscratch,a0
    80006564:	e10c                	sd	a1,0(a0)
    80006566:	e510                	sd	a2,8(a0)
    80006568:	e914                	sd	a3,16(a0)
    8000656a:	710c                	ld	a1,32(a0)
    8000656c:	7510                	ld	a2,40(a0)
    8000656e:	6194                	ld	a3,0(a1)
    80006570:	96b2                	add	a3,a3,a2
    80006572:	e194                	sd	a3,0(a1)
    80006574:	4589                	li	a1,2
    80006576:	14459073          	csrw	sip,a1
    8000657a:	6914                	ld	a3,16(a0)
    8000657c:	6510                	ld	a2,8(a0)
    8000657e:	610c                	ld	a1,0(a0)
    80006580:	34051573          	csrrw	a0,mscratch,a0
    80006584:	30200073          	mret
	...

000000008000658a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000658a:	1141                	addi	sp,sp,-16
    8000658c:	e422                	sd	s0,8(sp)
    8000658e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80006590:	0c0007b7          	lui	a5,0xc000
    80006594:	4705                	li	a4,1
    80006596:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80006598:	c3d8                	sw	a4,4(a5)
}
    8000659a:	6422                	ld	s0,8(sp)
    8000659c:	0141                	addi	sp,sp,16
    8000659e:	8082                	ret

00000000800065a0 <plicinithart>:

void
plicinithart(void)
{
    800065a0:	1141                	addi	sp,sp,-16
    800065a2:	e406                	sd	ra,8(sp)
    800065a4:	e022                	sd	s0,0(sp)
    800065a6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800065a8:	ffffc097          	auipc	ra,0xffffc
    800065ac:	a26080e7          	jalr	-1498(ra) # 80001fce <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800065b0:	0085171b          	slliw	a4,a0,0x8
    800065b4:	0c0027b7          	lui	a5,0xc002
    800065b8:	97ba                	add	a5,a5,a4
    800065ba:	40200713          	li	a4,1026
    800065be:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800065c2:	00d5151b          	slliw	a0,a0,0xd
    800065c6:	0c2017b7          	lui	a5,0xc201
    800065ca:	953e                	add	a0,a0,a5
    800065cc:	00052023          	sw	zero,0(a0)
}
    800065d0:	60a2                	ld	ra,8(sp)
    800065d2:	6402                	ld	s0,0(sp)
    800065d4:	0141                	addi	sp,sp,16
    800065d6:	8082                	ret

00000000800065d8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800065d8:	1141                	addi	sp,sp,-16
    800065da:	e406                	sd	ra,8(sp)
    800065dc:	e022                	sd	s0,0(sp)
    800065de:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800065e0:	ffffc097          	auipc	ra,0xffffc
    800065e4:	9ee080e7          	jalr	-1554(ra) # 80001fce <cpuid>
  //int irq = *(uint32*)(PLIC + 0x201004);
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800065e8:	00d5151b          	slliw	a0,a0,0xd
    800065ec:	0c2017b7          	lui	a5,0xc201
    800065f0:	97aa                	add	a5,a5,a0
  return irq;
}
    800065f2:	43c8                	lw	a0,4(a5)
    800065f4:	60a2                	ld	ra,8(sp)
    800065f6:	6402                	ld	s0,0(sp)
    800065f8:	0141                	addi	sp,sp,16
    800065fa:	8082                	ret

00000000800065fc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800065fc:	1101                	addi	sp,sp,-32
    800065fe:	ec06                	sd	ra,24(sp)
    80006600:	e822                	sd	s0,16(sp)
    80006602:	e426                	sd	s1,8(sp)
    80006604:	1000                	addi	s0,sp,32
    80006606:	84aa                	mv	s1,a0
  int hart = cpuid();
    80006608:	ffffc097          	auipc	ra,0xffffc
    8000660c:	9c6080e7          	jalr	-1594(ra) # 80001fce <cpuid>
  //*(uint32*)(PLIC + 0x201004) = irq;
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80006610:	00d5151b          	slliw	a0,a0,0xd
    80006614:	0c2017b7          	lui	a5,0xc201
    80006618:	97aa                	add	a5,a5,a0
    8000661a:	c3c4                	sw	s1,4(a5)
}
    8000661c:	60e2                	ld	ra,24(sp)
    8000661e:	6442                	ld	s0,16(sp)
    80006620:	64a2                	ld	s1,8(sp)
    80006622:	6105                	addi	sp,sp,32
    80006624:	8082                	ret

0000000080006626 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int n, int i)
{
    80006626:	1141                	addi	sp,sp,-16
    80006628:	e406                	sd	ra,8(sp)
    8000662a:	e022                	sd	s0,0(sp)
    8000662c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000662e:	479d                	li	a5,7
    80006630:	06b7c863          	blt	a5,a1,800066a0 <free_desc+0x7a>
    panic("virtio_disk_intr 1");
  if(disk[n].free[i])
    80006634:	00151713          	slli	a4,a0,0x1
    80006638:	972a                	add	a4,a4,a0
    8000663a:	00c71693          	slli	a3,a4,0xc
    8000663e:	00022717          	auipc	a4,0x22
    80006642:	9c270713          	addi	a4,a4,-1598 # 80028000 <disk>
    80006646:	9736                	add	a4,a4,a3
    80006648:	972e                	add	a4,a4,a1
    8000664a:	6789                	lui	a5,0x2
    8000664c:	973e                	add	a4,a4,a5
    8000664e:	01874783          	lbu	a5,24(a4)
    80006652:	efb9                	bnez	a5,800066b0 <free_desc+0x8a>
    panic("virtio_disk_intr 2");
  disk[n].desc[i].addr = 0;
    80006654:	00022817          	auipc	a6,0x22
    80006658:	9ac80813          	addi	a6,a6,-1620 # 80028000 <disk>
    8000665c:	00151713          	slli	a4,a0,0x1
    80006660:	00a707b3          	add	a5,a4,a0
    80006664:	07b2                	slli	a5,a5,0xc
    80006666:	97c2                	add	a5,a5,a6
    80006668:	6689                	lui	a3,0x2
    8000666a:	00f68633          	add	a2,a3,a5
    8000666e:	6210                	ld	a2,0(a2)
    80006670:	00459893          	slli	a7,a1,0x4
    80006674:	9646                	add	a2,a2,a7
    80006676:	00063023          	sd	zero,0(a2) # 1000 <_entry-0x7ffff000>
  disk[n].free[i] = 1;
    8000667a:	97ae                	add	a5,a5,a1
    8000667c:	97b6                	add	a5,a5,a3
    8000667e:	4605                	li	a2,1
    80006680:	00c78c23          	sb	a2,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk[n].free[0]);
    80006684:	972a                	add	a4,a4,a0
    80006686:	0732                	slli	a4,a4,0xc
    80006688:	06e1                	addi	a3,a3,24
    8000668a:	9736                	add	a4,a4,a3
    8000668c:	00e80533          	add	a0,a6,a4
    80006690:	ffffc097          	auipc	ra,0xffffc
    80006694:	2ea080e7          	jalr	746(ra) # 8000297a <wakeup>
}
    80006698:	60a2                	ld	ra,8(sp)
    8000669a:	6402                	ld	s0,0(sp)
    8000669c:	0141                	addi	sp,sp,16
    8000669e:	8082                	ret
    panic("virtio_disk_intr 1");
    800066a0:	00002517          	auipc	a0,0x2
    800066a4:	66850513          	addi	a0,a0,1640 # 80008d08 <userret+0xc78>
    800066a8:	ffffa097          	auipc	ra,0xffffa
    800066ac:	11e080e7          	jalr	286(ra) # 800007c6 <panic>
    panic("virtio_disk_intr 2");
    800066b0:	00002517          	auipc	a0,0x2
    800066b4:	67050513          	addi	a0,a0,1648 # 80008d20 <userret+0xc90>
    800066b8:	ffffa097          	auipc	ra,0xffffa
    800066bc:	10e080e7          	jalr	270(ra) # 800007c6 <panic>

00000000800066c0 <virtio_disk_init>:
  __sync_synchronize();
    800066c0:	0ff0000f          	fence
  if(disk[n].init)
    800066c4:	00151793          	slli	a5,a0,0x1
    800066c8:	97aa                	add	a5,a5,a0
    800066ca:	07b2                	slli	a5,a5,0xc
    800066cc:	00022717          	auipc	a4,0x22
    800066d0:	93470713          	addi	a4,a4,-1740 # 80028000 <disk>
    800066d4:	973e                	add	a4,a4,a5
    800066d6:	6789                	lui	a5,0x2
    800066d8:	97ba                	add	a5,a5,a4
    800066da:	0a87a783          	lw	a5,168(a5) # 20a8 <_entry-0x7fffdf58>
    800066de:	c391                	beqz	a5,800066e2 <virtio_disk_init+0x22>
    800066e0:	8082                	ret
{
    800066e2:	7139                	addi	sp,sp,-64
    800066e4:	fc06                	sd	ra,56(sp)
    800066e6:	f822                	sd	s0,48(sp)
    800066e8:	f426                	sd	s1,40(sp)
    800066ea:	f04a                	sd	s2,32(sp)
    800066ec:	ec4e                	sd	s3,24(sp)
    800066ee:	e852                	sd	s4,16(sp)
    800066f0:	e456                	sd	s5,8(sp)
    800066f2:	0080                	addi	s0,sp,64
    800066f4:	892a                	mv	s2,a0
  printf("virtio disk init %d\n", n);
    800066f6:	85aa                	mv	a1,a0
    800066f8:	00002517          	auipc	a0,0x2
    800066fc:	64050513          	addi	a0,a0,1600 # 80008d38 <userret+0xca8>
    80006700:	ffffa097          	auipc	ra,0xffffa
    80006704:	2de080e7          	jalr	734(ra) # 800009de <printf>
  initlock(&disk[n].vdisk_lock, "virtio_disk");
    80006708:	00191993          	slli	s3,s2,0x1
    8000670c:	99ca                	add	s3,s3,s2
    8000670e:	09b2                	slli	s3,s3,0xc
    80006710:	6789                	lui	a5,0x2
    80006712:	0b078793          	addi	a5,a5,176 # 20b0 <_entry-0x7fffdf50>
    80006716:	97ce                	add	a5,a5,s3
    80006718:	00002597          	auipc	a1,0x2
    8000671c:	63858593          	addi	a1,a1,1592 # 80008d50 <userret+0xcc0>
    80006720:	00022517          	auipc	a0,0x22
    80006724:	8e050513          	addi	a0,a0,-1824 # 80028000 <disk>
    80006728:	953e                	add	a0,a0,a5
    8000672a:	ffffa097          	auipc	ra,0xffffa
    8000672e:	498080e7          	jalr	1176(ra) # 80000bc2 <initlock>
  if(*R(n, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006732:	0019049b          	addiw	s1,s2,1
    80006736:	00c4949b          	slliw	s1,s1,0xc
    8000673a:	100007b7          	lui	a5,0x10000
    8000673e:	97a6                	add	a5,a5,s1
    80006740:	4398                	lw	a4,0(a5)
    80006742:	2701                	sext.w	a4,a4
    80006744:	747277b7          	lui	a5,0x74727
    80006748:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000674c:	12f71763          	bne	a4,a5,8000687a <virtio_disk_init+0x1ba>
     *R(n, VIRTIO_MMIO_VERSION) != 1 ||
    80006750:	100007b7          	lui	a5,0x10000
    80006754:	0791                	addi	a5,a5,4
    80006756:	97a6                	add	a5,a5,s1
    80006758:	439c                	lw	a5,0(a5)
    8000675a:	2781                	sext.w	a5,a5
  if(*R(n, VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000675c:	4705                	li	a4,1
    8000675e:	10e79e63          	bne	a5,a4,8000687a <virtio_disk_init+0x1ba>
     *R(n, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006762:	100007b7          	lui	a5,0x10000
    80006766:	07a1                	addi	a5,a5,8
    80006768:	97a6                	add	a5,a5,s1
    8000676a:	439c                	lw	a5,0(a5)
    8000676c:	2781                	sext.w	a5,a5
     *R(n, VIRTIO_MMIO_VERSION) != 1 ||
    8000676e:	4709                	li	a4,2
    80006770:	10e79563          	bne	a5,a4,8000687a <virtio_disk_init+0x1ba>
     *R(n, VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80006774:	100007b7          	lui	a5,0x10000
    80006778:	07b1                	addi	a5,a5,12
    8000677a:	97a6                	add	a5,a5,s1
    8000677c:	4398                	lw	a4,0(a5)
    8000677e:	2701                	sext.w	a4,a4
     *R(n, VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006780:	554d47b7          	lui	a5,0x554d4
    80006784:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80006788:	0ef71963          	bne	a4,a5,8000687a <virtio_disk_init+0x1ba>
  *R(n, VIRTIO_MMIO_STATUS) = status;
    8000678c:	100007b7          	lui	a5,0x10000
    80006790:	07078693          	addi	a3,a5,112 # 10000070 <_entry-0x6fffff90>
    80006794:	96a6                	add	a3,a3,s1
    80006796:	4705                	li	a4,1
    80006798:	c298                	sw	a4,0(a3)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    8000679a:	470d                	li	a4,3
    8000679c:	c298                	sw	a4,0(a3)
  uint64 features = *R(n, VIRTIO_MMIO_DEVICE_FEATURES);
    8000679e:	01078713          	addi	a4,a5,16
    800067a2:	9726                	add	a4,a4,s1
    800067a4:	430c                	lw	a1,0(a4)
  *R(n, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800067a6:	02078613          	addi	a2,a5,32
    800067aa:	9626                	add	a2,a2,s1
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800067ac:	c7ffe737          	lui	a4,0xc7ffe
    800067b0:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd06b3>
    800067b4:	8f6d                	and	a4,a4,a1
  *R(n, VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800067b6:	2701                	sext.w	a4,a4
    800067b8:	c218                	sw	a4,0(a2)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    800067ba:	472d                	li	a4,11
    800067bc:	c298                	sw	a4,0(a3)
  *R(n, VIRTIO_MMIO_STATUS) = status;
    800067be:	473d                	li	a4,15
    800067c0:	c298                	sw	a4,0(a3)
  *R(n, VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800067c2:	02878713          	addi	a4,a5,40
    800067c6:	9726                	add	a4,a4,s1
    800067c8:	6685                	lui	a3,0x1
    800067ca:	c314                	sw	a3,0(a4)
  *R(n, VIRTIO_MMIO_QUEUE_SEL) = 0;
    800067cc:	03078713          	addi	a4,a5,48
    800067d0:	9726                	add	a4,a4,s1
    800067d2:	00072023          	sw	zero,0(a4)
  uint32 max = *R(n, VIRTIO_MMIO_QUEUE_NUM_MAX);
    800067d6:	03478793          	addi	a5,a5,52
    800067da:	97a6                	add	a5,a5,s1
    800067dc:	439c                	lw	a5,0(a5)
    800067de:	2781                	sext.w	a5,a5
  if(max == 0)
    800067e0:	c7cd                	beqz	a5,8000688a <virtio_disk_init+0x1ca>
  if(max < NUM)
    800067e2:	471d                	li	a4,7
    800067e4:	0af77b63          	bleu	a5,a4,8000689a <virtio_disk_init+0x1da>
  *R(n, VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800067e8:	10000ab7          	lui	s5,0x10000
    800067ec:	038a8793          	addi	a5,s5,56 # 10000038 <_entry-0x6fffffc8>
    800067f0:	97a6                	add	a5,a5,s1
    800067f2:	4721                	li	a4,8
    800067f4:	c398                	sw	a4,0(a5)
  memset(disk[n].pages, 0, sizeof(disk[n].pages));
    800067f6:	00022a17          	auipc	s4,0x22
    800067fa:	80aa0a13          	addi	s4,s4,-2038 # 80028000 <disk>
    800067fe:	99d2                	add	s3,s3,s4
    80006800:	6609                	lui	a2,0x2
    80006802:	4581                	li	a1,0
    80006804:	854e                	mv	a0,s3
    80006806:	ffffb097          	auipc	ra,0xffffb
    8000680a:	99e080e7          	jalr	-1634(ra) # 800011a4 <memset>
  *R(n, VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk[n].pages) >> PGSHIFT;
    8000680e:	040a8a93          	addi	s5,s5,64
    80006812:	94d6                	add	s1,s1,s5
    80006814:	00c9d793          	srli	a5,s3,0xc
    80006818:	2781                	sext.w	a5,a5
    8000681a:	c09c                	sw	a5,0(s1)
  disk[n].desc = (struct VRingDesc *) disk[n].pages;
    8000681c:	00191513          	slli	a0,s2,0x1
    80006820:	012507b3          	add	a5,a0,s2
    80006824:	07b2                	slli	a5,a5,0xc
    80006826:	97d2                	add	a5,a5,s4
    80006828:	6689                	lui	a3,0x2
    8000682a:	97b6                	add	a5,a5,a3
    8000682c:	0137b023          	sd	s3,0(a5)
  disk[n].avail = (uint16*)(((char*)disk[n].desc) + NUM*sizeof(struct VRingDesc));
    80006830:	08098713          	addi	a4,s3,128
    80006834:	e798                	sd	a4,8(a5)
  disk[n].used = (struct UsedArea *) (disk[n].pages + PGSIZE);
    80006836:	6705                	lui	a4,0x1
    80006838:	99ba                	add	s3,s3,a4
    8000683a:	0137b823          	sd	s3,16(a5)
    disk[n].free[i] = 1;
    8000683e:	4705                	li	a4,1
    80006840:	00e78c23          	sb	a4,24(a5)
    80006844:	00e78ca3          	sb	a4,25(a5)
    80006848:	00e78d23          	sb	a4,26(a5)
    8000684c:	00e78da3          	sb	a4,27(a5)
    80006850:	00e78e23          	sb	a4,28(a5)
    80006854:	00e78ea3          	sb	a4,29(a5)
    80006858:	00e78f23          	sb	a4,30(a5)
    8000685c:	00e78fa3          	sb	a4,31(a5)
  disk[n].init = 1;
    80006860:	853e                	mv	a0,a5
    80006862:	4785                	li	a5,1
    80006864:	0af52423          	sw	a5,168(a0)
}
    80006868:	70e2                	ld	ra,56(sp)
    8000686a:	7442                	ld	s0,48(sp)
    8000686c:	74a2                	ld	s1,40(sp)
    8000686e:	7902                	ld	s2,32(sp)
    80006870:	69e2                	ld	s3,24(sp)
    80006872:	6a42                	ld	s4,16(sp)
    80006874:	6aa2                	ld	s5,8(sp)
    80006876:	6121                	addi	sp,sp,64
    80006878:	8082                	ret
    panic("could not find virtio disk");
    8000687a:	00002517          	auipc	a0,0x2
    8000687e:	4e650513          	addi	a0,a0,1254 # 80008d60 <userret+0xcd0>
    80006882:	ffffa097          	auipc	ra,0xffffa
    80006886:	f44080e7          	jalr	-188(ra) # 800007c6 <panic>
    panic("virtio disk has no queue 0");
    8000688a:	00002517          	auipc	a0,0x2
    8000688e:	4f650513          	addi	a0,a0,1270 # 80008d80 <userret+0xcf0>
    80006892:	ffffa097          	auipc	ra,0xffffa
    80006896:	f34080e7          	jalr	-204(ra) # 800007c6 <panic>
    panic("virtio disk max queue too short");
    8000689a:	00002517          	auipc	a0,0x2
    8000689e:	50650513          	addi	a0,a0,1286 # 80008da0 <userret+0xd10>
    800068a2:	ffffa097          	auipc	ra,0xffffa
    800068a6:	f24080e7          	jalr	-220(ra) # 800007c6 <panic>

00000000800068aa <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(int n, struct buf *b, int write)
{
    800068aa:	7175                	addi	sp,sp,-144
    800068ac:	e506                	sd	ra,136(sp)
    800068ae:	e122                	sd	s0,128(sp)
    800068b0:	fca6                	sd	s1,120(sp)
    800068b2:	f8ca                	sd	s2,112(sp)
    800068b4:	f4ce                	sd	s3,104(sp)
    800068b6:	f0d2                	sd	s4,96(sp)
    800068b8:	ecd6                	sd	s5,88(sp)
    800068ba:	e8da                	sd	s6,80(sp)
    800068bc:	e4de                	sd	s7,72(sp)
    800068be:	e0e2                	sd	s8,64(sp)
    800068c0:	fc66                	sd	s9,56(sp)
    800068c2:	f86a                	sd	s10,48(sp)
    800068c4:	f46e                	sd	s11,40(sp)
    800068c6:	0900                	addi	s0,sp,144
    800068c8:	892a                	mv	s2,a0
    800068ca:	8a2e                	mv	s4,a1
    800068cc:	8db2                	mv	s11,a2
  uint64 sector = b->blockno * (BSIZE / 512);
    800068ce:	00c5ad03          	lw	s10,12(a1)
    800068d2:	001d1d1b          	slliw	s10,s10,0x1
    800068d6:	1d02                	slli	s10,s10,0x20
    800068d8:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk[n].vdisk_lock);
    800068dc:	00151493          	slli	s1,a0,0x1
    800068e0:	94aa                	add	s1,s1,a0
    800068e2:	04b2                	slli	s1,s1,0xc
    800068e4:	6a89                	lui	s5,0x2
    800068e6:	0b0a8993          	addi	s3,s5,176 # 20b0 <_entry-0x7fffdf50>
    800068ea:	99a6                	add	s3,s3,s1
    800068ec:	00021c17          	auipc	s8,0x21
    800068f0:	714c0c13          	addi	s8,s8,1812 # 80028000 <disk>
    800068f4:	99e2                	add	s3,s3,s8
    800068f6:	854e                	mv	a0,s3
    800068f8:	ffffa097          	auipc	ra,0xffffa
    800068fc:	438080e7          	jalr	1080(ra) # 80000d30 <acquire>
  int idx[3];
  while(1){
    if(alloc3_desc(n, idx) == 0) {
      break;
    }
    sleep(&disk[n].free[0], &disk[n].vdisk_lock);
    80006900:	018a8b93          	addi	s7,s5,24
    80006904:	9ba6                	add	s7,s7,s1
    80006906:	9be2                	add	s7,s7,s8
    80006908:	0ae5                	addi	s5,s5,25
    8000690a:	94d6                	add	s1,s1,s5
    8000690c:	01848ab3          	add	s5,s1,s8
    if(disk[n].free[i]){
    80006910:	00191b13          	slli	s6,s2,0x1
    80006914:	9b4a                	add	s6,s6,s2
    80006916:	00cb1793          	slli	a5,s6,0xc
    8000691a:	00fc0b33          	add	s6,s8,a5
    8000691e:	6c89                	lui	s9,0x2
    80006920:	016c8c33          	add	s8,s9,s6
    80006924:	a049                	j	800069a6 <virtio_disk_rw+0xfc>
      disk[n].free[i] = 0;
    80006926:	00fb06b3          	add	a3,s6,a5
    8000692a:	96e6                	add	a3,a3,s9
    8000692c:	00068c23          	sb	zero,24(a3) # 2018 <_entry-0x7fffdfe8>
    idx[i] = alloc_desc(n);
    80006930:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80006932:	0207c763          	bltz	a5,80006960 <virtio_disk_rw+0xb6>
  for(int i = 0; i < 3; i++){
    80006936:	2485                	addiw	s1,s1,1
    80006938:	0711                	addi	a4,a4,4
    8000693a:	28b48063          	beq	s1,a1,80006bba <virtio_disk_rw+0x310>
    idx[i] = alloc_desc(n);
    8000693e:	863a                	mv	a2,a4
    if(disk[n].free[i]){
    80006940:	018c4783          	lbu	a5,24(s8)
    80006944:	28079063          	bnez	a5,80006bc4 <virtio_disk_rw+0x31a>
    80006948:	86d6                	mv	a3,s5
  for(int i = 0; i < NUM; i++){
    8000694a:	87c2                	mv	a5,a6
    if(disk[n].free[i]){
    8000694c:	0006c883          	lbu	a7,0(a3)
    80006950:	fc089be3          	bnez	a7,80006926 <virtio_disk_rw+0x7c>
  for(int i = 0; i < NUM; i++){
    80006954:	2785                	addiw	a5,a5,1
    80006956:	0685                	addi	a3,a3,1
    80006958:	fea79ae3          	bne	a5,a0,8000694c <virtio_disk_rw+0xa2>
    idx[i] = alloc_desc(n);
    8000695c:	57fd                	li	a5,-1
    8000695e:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    80006960:	02905d63          	blez	s1,8000699a <virtio_disk_rw+0xf0>
        free_desc(n, idx[j]);
    80006964:	f8042583          	lw	a1,-128(s0)
    80006968:	854a                	mv	a0,s2
    8000696a:	00000097          	auipc	ra,0x0
    8000696e:	cbc080e7          	jalr	-836(ra) # 80006626 <free_desc>
      for(int j = 0; j < i; j++)
    80006972:	4785                	li	a5,1
    80006974:	0297d363          	ble	s1,a5,8000699a <virtio_disk_rw+0xf0>
        free_desc(n, idx[j]);
    80006978:	f8442583          	lw	a1,-124(s0)
    8000697c:	854a                	mv	a0,s2
    8000697e:	00000097          	auipc	ra,0x0
    80006982:	ca8080e7          	jalr	-856(ra) # 80006626 <free_desc>
      for(int j = 0; j < i; j++)
    80006986:	4789                	li	a5,2
    80006988:	0097d963          	ble	s1,a5,8000699a <virtio_disk_rw+0xf0>
        free_desc(n, idx[j]);
    8000698c:	f8842583          	lw	a1,-120(s0)
    80006990:	854a                	mv	a0,s2
    80006992:	00000097          	auipc	ra,0x0
    80006996:	c94080e7          	jalr	-876(ra) # 80006626 <free_desc>
    sleep(&disk[n].free[0], &disk[n].vdisk_lock);
    8000699a:	85ce                	mv	a1,s3
    8000699c:	855e                	mv	a0,s7
    8000699e:	ffffc097          	auipc	ra,0xffffc
    800069a2:	e56080e7          	jalr	-426(ra) # 800027f4 <sleep>
  for(int i = 0; i < 3; i++){
    800069a6:	f8040713          	addi	a4,s0,-128
    800069aa:	4481                	li	s1,0
  for(int i = 0; i < NUM; i++){
    800069ac:	4805                	li	a6,1
    800069ae:	4521                	li	a0,8
  for(int i = 0; i < 3; i++){
    800069b0:	458d                	li	a1,3
    800069b2:	b771                	j	8000693e <virtio_disk_rw+0x94>
    uint32 reserved;
    uint64 sector;
  } buf0;

  if(write)
    buf0.type = VIRTIO_BLK_T_OUT; // write the disk
    800069b4:	4785                	li	a5,1
    800069b6:	f6f42823          	sw	a5,-144(s0)
  else
    buf0.type = VIRTIO_BLK_T_IN; // read the disk
  buf0.reserved = 0;
    800069ba:	f6042a23          	sw	zero,-140(s0)
  buf0.sector = sector;
    800069be:	f7a43c23          	sd	s10,-136(s0)

  // buf0 is on a kernel stack, which is not direct mapped,
  // thus the call to kvmpa().
  disk[n].desc[idx[0]].addr = (uint64) kvmpa((uint64) &buf0);
    800069c2:	f8042483          	lw	s1,-128(s0)
    800069c6:	00449b13          	slli	s6,s1,0x4
    800069ca:	00191793          	slli	a5,s2,0x1
    800069ce:	97ca                	add	a5,a5,s2
    800069d0:	07b2                	slli	a5,a5,0xc
    800069d2:	00021a97          	auipc	s5,0x21
    800069d6:	62ea8a93          	addi	s5,s5,1582 # 80028000 <disk>
    800069da:	97d6                	add	a5,a5,s5
    800069dc:	6a89                	lui	s5,0x2
    800069de:	9abe                	add	s5,s5,a5
    800069e0:	000abb83          	ld	s7,0(s5) # 2000 <_entry-0x7fffe000>
    800069e4:	9bda                	add	s7,s7,s6
    800069e6:	f7040513          	addi	a0,s0,-144
    800069ea:	ffffb097          	auipc	ra,0xffffb
    800069ee:	d18080e7          	jalr	-744(ra) # 80001702 <kvmpa>
    800069f2:	00abb023          	sd	a0,0(s7)
  disk[n].desc[idx[0]].len = sizeof(buf0);
    800069f6:	000ab783          	ld	a5,0(s5)
    800069fa:	97da                	add	a5,a5,s6
    800069fc:	4741                	li	a4,16
    800069fe:	c798                	sw	a4,8(a5)
  disk[n].desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80006a00:	000ab783          	ld	a5,0(s5)
    80006a04:	97da                	add	a5,a5,s6
    80006a06:	4705                	li	a4,1
    80006a08:	00e79623          	sh	a4,12(a5)
  disk[n].desc[idx[0]].next = idx[1];
    80006a0c:	f8442603          	lw	a2,-124(s0)
    80006a10:	000ab783          	ld	a5,0(s5)
    80006a14:	9b3e                	add	s6,s6,a5
    80006a16:	00cb1723          	sh	a2,14(s6) # fffffffffffff00e <end+0xffffffff7ffd0f62>

  disk[n].desc[idx[1]].addr = (uint64) b->data;
    80006a1a:	0612                	slli	a2,a2,0x4
    80006a1c:	000ab783          	ld	a5,0(s5)
    80006a20:	97b2                	add	a5,a5,a2
    80006a22:	070a0713          	addi	a4,s4,112
    80006a26:	e398                	sd	a4,0(a5)
  disk[n].desc[idx[1]].len = BSIZE;
    80006a28:	000ab783          	ld	a5,0(s5)
    80006a2c:	97b2                	add	a5,a5,a2
    80006a2e:	40000713          	li	a4,1024
    80006a32:	c798                	sw	a4,8(a5)
  if(write)
    80006a34:	120d8e63          	beqz	s11,80006b70 <virtio_disk_rw+0x2c6>
    disk[n].desc[idx[1]].flags = 0; // device reads b->data
    80006a38:	000ab783          	ld	a5,0(s5)
    80006a3c:	97b2                	add	a5,a5,a2
    80006a3e:	00079623          	sh	zero,12(a5)
  else
    disk[n].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk[n].desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006a42:	00021517          	auipc	a0,0x21
    80006a46:	5be50513          	addi	a0,a0,1470 # 80028000 <disk>
    80006a4a:	00191793          	slli	a5,s2,0x1
    80006a4e:	012786b3          	add	a3,a5,s2
    80006a52:	06b2                	slli	a3,a3,0xc
    80006a54:	96aa                	add	a3,a3,a0
    80006a56:	6709                	lui	a4,0x2
    80006a58:	96ba                	add	a3,a3,a4
    80006a5a:	628c                	ld	a1,0(a3)
    80006a5c:	95b2                	add	a1,a1,a2
    80006a5e:	00c5d703          	lhu	a4,12(a1)
    80006a62:	00176713          	ori	a4,a4,1
    80006a66:	00e59623          	sh	a4,12(a1)
  disk[n].desc[idx[1]].next = idx[2];
    80006a6a:	f8842583          	lw	a1,-120(s0)
    80006a6e:	6298                	ld	a4,0(a3)
    80006a70:	963a                	add	a2,a2,a4
    80006a72:	00b61723          	sh	a1,14(a2) # 200e <_entry-0x7fffdff2>

  disk[n].info[idx[0]].status = 0;
    80006a76:	97ca                	add	a5,a5,s2
    80006a78:	07a2                	slli	a5,a5,0x8
    80006a7a:	97a6                	add	a5,a5,s1
    80006a7c:	20078793          	addi	a5,a5,512
    80006a80:	0792                	slli	a5,a5,0x4
    80006a82:	97aa                	add	a5,a5,a0
    80006a84:	02078823          	sb	zero,48(a5)
  disk[n].desc[idx[2]].addr = (uint64) &disk[n].info[idx[0]].status;
    80006a88:	00459613          	slli	a2,a1,0x4
    80006a8c:	628c                	ld	a1,0(a3)
    80006a8e:	95b2                	add	a1,a1,a2
    80006a90:	00191713          	slli	a4,s2,0x1
    80006a94:	974a                	add	a4,a4,s2
    80006a96:	0722                	slli	a4,a4,0x8
    80006a98:	20348813          	addi	a6,s1,515
    80006a9c:	9742                	add	a4,a4,a6
    80006a9e:	0712                	slli	a4,a4,0x4
    80006aa0:	972a                	add	a4,a4,a0
    80006aa2:	e198                	sd	a4,0(a1)
  disk[n].desc[idx[2]].len = 1;
    80006aa4:	6298                	ld	a4,0(a3)
    80006aa6:	9732                	add	a4,a4,a2
    80006aa8:	4585                	li	a1,1
    80006aaa:	c70c                	sw	a1,8(a4)
  disk[n].desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006aac:	6298                	ld	a4,0(a3)
    80006aae:	9732                	add	a4,a4,a2
    80006ab0:	4509                	li	a0,2
    80006ab2:	00a71623          	sh	a0,12(a4) # 200c <_entry-0x7fffdff4>
  disk[n].desc[idx[2]].next = 0;
    80006ab6:	6298                	ld	a4,0(a3)
    80006ab8:	963a                	add	a2,a2,a4
    80006aba:	00061723          	sh	zero,14(a2)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80006abe:	00ba2223          	sw	a1,4(s4)
  disk[n].info[idx[0]].b = b;
    80006ac2:	0347b423          	sd	s4,40(a5)

  // avail[0] is flags
  // avail[1] tells the device how far to look in avail[2...].
  // avail[2...] are desc[] indices the device should process.
  // we only tell device the first index in our chain of descriptors.
  disk[n].avail[2 + (disk[n].avail[1] % NUM)] = idx[0];
    80006ac6:	6698                	ld	a4,8(a3)
    80006ac8:	00275783          	lhu	a5,2(a4)
    80006acc:	8b9d                	andi	a5,a5,7
    80006ace:	2789                	addiw	a5,a5,2
    80006ad0:	0786                	slli	a5,a5,0x1
    80006ad2:	97ba                	add	a5,a5,a4
    80006ad4:	00979023          	sh	s1,0(a5)
  __sync_synchronize();
    80006ad8:	0ff0000f          	fence
  disk[n].avail[1] = disk[n].avail[1] + 1;
    80006adc:	6698                	ld	a4,8(a3)
    80006ade:	00275783          	lhu	a5,2(a4)
    80006ae2:	2785                	addiw	a5,a5,1
    80006ae4:	00f71123          	sh	a5,2(a4)

  *R(n, VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006ae8:	0019079b          	addiw	a5,s2,1
    80006aec:	00c7979b          	slliw	a5,a5,0xc
    80006af0:	10000737          	lui	a4,0x10000
    80006af4:	05070713          	addi	a4,a4,80 # 10000050 <_entry-0x6fffffb0>
    80006af8:	97ba                	add	a5,a5,a4
    80006afa:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006afe:	004a2703          	lw	a4,4(s4)
    80006b02:	4785                	li	a5,1
    80006b04:	00f71d63          	bne	a4,a5,80006b1e <virtio_disk_rw+0x274>
    80006b08:	4485                	li	s1,1
    sleep(b, &disk[n].vdisk_lock);
    80006b0a:	85ce                	mv	a1,s3
    80006b0c:	8552                	mv	a0,s4
    80006b0e:	ffffc097          	auipc	ra,0xffffc
    80006b12:	ce6080e7          	jalr	-794(ra) # 800027f4 <sleep>
  while(b->disk == 1) {
    80006b16:	004a2783          	lw	a5,4(s4)
    80006b1a:	fe9788e3          	beq	a5,s1,80006b0a <virtio_disk_rw+0x260>
  }

  disk[n].info[idx[0]].b = 0;
    80006b1e:	f8042483          	lw	s1,-128(s0)
    80006b22:	00191793          	slli	a5,s2,0x1
    80006b26:	97ca                	add	a5,a5,s2
    80006b28:	07a2                	slli	a5,a5,0x8
    80006b2a:	97a6                	add	a5,a5,s1
    80006b2c:	20078793          	addi	a5,a5,512
    80006b30:	0792                	slli	a5,a5,0x4
    80006b32:	00021717          	auipc	a4,0x21
    80006b36:	4ce70713          	addi	a4,a4,1230 # 80028000 <disk>
    80006b3a:	97ba                	add	a5,a5,a4
    80006b3c:	0207b423          	sd	zero,40(a5)
    if(disk[n].desc[i].flags & VRING_DESC_F_NEXT)
    80006b40:	00191793          	slli	a5,s2,0x1
    80006b44:	97ca                	add	a5,a5,s2
    80006b46:	07b2                	slli	a5,a5,0xc
    80006b48:	97ba                	add	a5,a5,a4
    80006b4a:	6a09                	lui	s4,0x2
    80006b4c:	9a3e                	add	s4,s4,a5
    free_desc(n, i);
    80006b4e:	85a6                	mv	a1,s1
    80006b50:	854a                	mv	a0,s2
    80006b52:	00000097          	auipc	ra,0x0
    80006b56:	ad4080e7          	jalr	-1324(ra) # 80006626 <free_desc>
    if(disk[n].desc[i].flags & VRING_DESC_F_NEXT)
    80006b5a:	0492                	slli	s1,s1,0x4
    80006b5c:	000a3783          	ld	a5,0(s4) # 2000 <_entry-0x7fffe000>
    80006b60:	94be                	add	s1,s1,a5
    80006b62:	00c4d783          	lhu	a5,12(s1)
    80006b66:	8b85                	andi	a5,a5,1
    80006b68:	c78d                	beqz	a5,80006b92 <virtio_disk_rw+0x2e8>
      i = disk[n].desc[i].next;
    80006b6a:	00e4d483          	lhu	s1,14(s1)
  while(1){
    80006b6e:	b7c5                	j	80006b4e <virtio_disk_rw+0x2a4>
    disk[n].desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80006b70:	00191793          	slli	a5,s2,0x1
    80006b74:	97ca                	add	a5,a5,s2
    80006b76:	07b2                	slli	a5,a5,0xc
    80006b78:	00021717          	auipc	a4,0x21
    80006b7c:	48870713          	addi	a4,a4,1160 # 80028000 <disk>
    80006b80:	973e                	add	a4,a4,a5
    80006b82:	6789                	lui	a5,0x2
    80006b84:	97ba                	add	a5,a5,a4
    80006b86:	639c                	ld	a5,0(a5)
    80006b88:	97b2                	add	a5,a5,a2
    80006b8a:	4709                	li	a4,2
    80006b8c:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80006b90:	bd4d                	j	80006a42 <virtio_disk_rw+0x198>
  free_chain(n, idx[0]);

  release(&disk[n].vdisk_lock);
    80006b92:	854e                	mv	a0,s3
    80006b94:	ffffa097          	auipc	ra,0xffffa
    80006b98:	3e8080e7          	jalr	1000(ra) # 80000f7c <release>
}
    80006b9c:	60aa                	ld	ra,136(sp)
    80006b9e:	640a                	ld	s0,128(sp)
    80006ba0:	74e6                	ld	s1,120(sp)
    80006ba2:	7946                	ld	s2,112(sp)
    80006ba4:	79a6                	ld	s3,104(sp)
    80006ba6:	7a06                	ld	s4,96(sp)
    80006ba8:	6ae6                	ld	s5,88(sp)
    80006baa:	6b46                	ld	s6,80(sp)
    80006bac:	6ba6                	ld	s7,72(sp)
    80006bae:	6c06                	ld	s8,64(sp)
    80006bb0:	7ce2                	ld	s9,56(sp)
    80006bb2:	7d42                	ld	s10,48(sp)
    80006bb4:	7da2                	ld	s11,40(sp)
    80006bb6:	6149                	addi	sp,sp,144
    80006bb8:	8082                	ret
  if(write)
    80006bba:	de0d9de3          	bnez	s11,800069b4 <virtio_disk_rw+0x10a>
    buf0.type = VIRTIO_BLK_T_IN; // read the disk
    80006bbe:	f6042823          	sw	zero,-144(s0)
    80006bc2:	bbe5                	j	800069ba <virtio_disk_rw+0x110>
      disk[n].free[i] = 0;
    80006bc4:	000c0c23          	sb	zero,24(s8)
    idx[i] = alloc_desc(n);
    80006bc8:	00072023          	sw	zero,0(a4)
    if(idx[i] < 0){
    80006bcc:	b3ad                	j	80006936 <virtio_disk_rw+0x8c>

0000000080006bce <virtio_disk_intr>:

void
virtio_disk_intr(int n)
{
    80006bce:	7139                	addi	sp,sp,-64
    80006bd0:	fc06                	sd	ra,56(sp)
    80006bd2:	f822                	sd	s0,48(sp)
    80006bd4:	f426                	sd	s1,40(sp)
    80006bd6:	f04a                	sd	s2,32(sp)
    80006bd8:	ec4e                	sd	s3,24(sp)
    80006bda:	e852                	sd	s4,16(sp)
    80006bdc:	e456                	sd	s5,8(sp)
    80006bde:	0080                	addi	s0,sp,64
    80006be0:	84aa                	mv	s1,a0
  acquire(&disk[n].vdisk_lock);
    80006be2:	00151913          	slli	s2,a0,0x1
    80006be6:	00a90a33          	add	s4,s2,a0
    80006bea:	0a32                	slli	s4,s4,0xc
    80006bec:	6989                	lui	s3,0x2
    80006bee:	0b098793          	addi	a5,s3,176 # 20b0 <_entry-0x7fffdf50>
    80006bf2:	9a3e                	add	s4,s4,a5
    80006bf4:	00021a97          	auipc	s5,0x21
    80006bf8:	40ca8a93          	addi	s5,s5,1036 # 80028000 <disk>
    80006bfc:	9a56                	add	s4,s4,s5
    80006bfe:	8552                	mv	a0,s4
    80006c00:	ffffa097          	auipc	ra,0xffffa
    80006c04:	130080e7          	jalr	304(ra) # 80000d30 <acquire>

  while((disk[n].used_idx % NUM) != (disk[n].used->id % NUM)){
    80006c08:	9926                	add	s2,s2,s1
    80006c0a:	0932                	slli	s2,s2,0xc
    80006c0c:	9956                	add	s2,s2,s5
    80006c0e:	99ca                	add	s3,s3,s2
    80006c10:	0209d683          	lhu	a3,32(s3)
    80006c14:	0109b703          	ld	a4,16(s3)
    80006c18:	00275783          	lhu	a5,2(a4)
    80006c1c:	8fb5                	xor	a5,a5,a3
    80006c1e:	8b9d                	andi	a5,a5,7
    80006c20:	cbd1                	beqz	a5,80006cb4 <virtio_disk_intr+0xe6>
    int id = disk[n].used->elems[disk[n].used_idx].id;
    80006c22:	068e                	slli	a3,a3,0x3
    80006c24:	9736                	add	a4,a4,a3
    80006c26:	435c                	lw	a5,4(a4)

    if(disk[n].info[id].status != 0)
    80006c28:	00149713          	slli	a4,s1,0x1
    80006c2c:	9726                	add	a4,a4,s1
    80006c2e:	0722                	slli	a4,a4,0x8
    80006c30:	973e                	add	a4,a4,a5
    80006c32:	20070713          	addi	a4,a4,512
    80006c36:	0712                	slli	a4,a4,0x4
    80006c38:	9756                	add	a4,a4,s5
    80006c3a:	03074703          	lbu	a4,48(a4)
    80006c3e:	e33d                	bnez	a4,80006ca4 <virtio_disk_intr+0xd6>
      panic("virtio_disk_intr status");
    
    disk[n].info[id].b->disk = 0;   // disk is done with buf
    80006c40:	8956                	mv	s2,s5
    80006c42:	00149713          	slli	a4,s1,0x1
    80006c46:	9726                	add	a4,a4,s1
    80006c48:	00871993          	slli	s3,a4,0x8
    wakeup(disk[n].info[id].b);

    disk[n].used_idx = (disk[n].used_idx + 1) % NUM;
    80006c4c:	0732                	slli	a4,a4,0xc
    80006c4e:	9756                	add	a4,a4,s5
    80006c50:	6489                	lui	s1,0x2
    80006c52:	94ba                	add	s1,s1,a4
    disk[n].info[id].b->disk = 0;   // disk is done with buf
    80006c54:	97ce                	add	a5,a5,s3
    80006c56:	20078793          	addi	a5,a5,512
    80006c5a:	0792                	slli	a5,a5,0x4
    80006c5c:	97ca                	add	a5,a5,s2
    80006c5e:	7798                	ld	a4,40(a5)
    80006c60:	00072223          	sw	zero,4(a4)
    wakeup(disk[n].info[id].b);
    80006c64:	7788                	ld	a0,40(a5)
    80006c66:	ffffc097          	auipc	ra,0xffffc
    80006c6a:	d14080e7          	jalr	-748(ra) # 8000297a <wakeup>
    disk[n].used_idx = (disk[n].used_idx + 1) % NUM;
    80006c6e:	0204d783          	lhu	a5,32(s1) # 2020 <_entry-0x7fffdfe0>
    80006c72:	2785                	addiw	a5,a5,1
    80006c74:	8b9d                	andi	a5,a5,7
    80006c76:	03079613          	slli	a2,a5,0x30
    80006c7a:	9241                	srli	a2,a2,0x30
    80006c7c:	02c49023          	sh	a2,32(s1)
  while((disk[n].used_idx % NUM) != (disk[n].used->id % NUM)){
    80006c80:	6898                	ld	a4,16(s1)
    80006c82:	00275683          	lhu	a3,2(a4)
    80006c86:	8a9d                	andi	a3,a3,7
    80006c88:	02c68663          	beq	a3,a2,80006cb4 <virtio_disk_intr+0xe6>
    int id = disk[n].used->elems[disk[n].used_idx].id;
    80006c8c:	078e                	slli	a5,a5,0x3
    80006c8e:	97ba                	add	a5,a5,a4
    80006c90:	43dc                	lw	a5,4(a5)
    if(disk[n].info[id].status != 0)
    80006c92:	00f98733          	add	a4,s3,a5
    80006c96:	20070713          	addi	a4,a4,512
    80006c9a:	0712                	slli	a4,a4,0x4
    80006c9c:	974a                	add	a4,a4,s2
    80006c9e:	03074703          	lbu	a4,48(a4)
    80006ca2:	db4d                	beqz	a4,80006c54 <virtio_disk_intr+0x86>
      panic("virtio_disk_intr status");
    80006ca4:	00002517          	auipc	a0,0x2
    80006ca8:	11c50513          	addi	a0,a0,284 # 80008dc0 <userret+0xd30>
    80006cac:	ffffa097          	auipc	ra,0xffffa
    80006cb0:	b1a080e7          	jalr	-1254(ra) # 800007c6 <panic>
  }

  release(&disk[n].vdisk_lock);
    80006cb4:	8552                	mv	a0,s4
    80006cb6:	ffffa097          	auipc	ra,0xffffa
    80006cba:	2c6080e7          	jalr	710(ra) # 80000f7c <release>
}
    80006cbe:	70e2                	ld	ra,56(sp)
    80006cc0:	7442                	ld	s0,48(sp)
    80006cc2:	74a2                	ld	s1,40(sp)
    80006cc4:	7902                	ld	s2,32(sp)
    80006cc6:	69e2                	ld	s3,24(sp)
    80006cc8:	6a42                	ld	s4,16(sp)
    80006cca:	6aa2                	ld	s5,8(sp)
    80006ccc:	6121                	addi	sp,sp,64
    80006cce:	8082                	ret

0000000080006cd0 <bit_isset>:
static Sz_info *bd_sizes; 
static void *bd_base;   // start address of memory managed by the buddy allocator
static struct spinlock lock;

// Return 1 if bit at position index in array is set to 1
int bit_isset(char *array, int index) {
    80006cd0:	1141                	addi	sp,sp,-16
    80006cd2:	e422                	sd	s0,8(sp)
    80006cd4:	0800                	addi	s0,sp,16
  char b = array[index/8];
  char m = (1 << (index % 8));
    80006cd6:	41f5d79b          	sraiw	a5,a1,0x1f
    80006cda:	01d7d79b          	srliw	a5,a5,0x1d
    80006cde:	9dbd                	addw	a1,a1,a5
    80006ce0:	0075f713          	andi	a4,a1,7
    80006ce4:	9f1d                	subw	a4,a4,a5
    80006ce6:	4785                	li	a5,1
    80006ce8:	00e797bb          	sllw	a5,a5,a4
    80006cec:	0ff7f793          	andi	a5,a5,255
  char b = array[index/8];
    80006cf0:	4035d59b          	sraiw	a1,a1,0x3
    80006cf4:	95aa                	add	a1,a1,a0
  return (b & m) == m;
    80006cf6:	0005c503          	lbu	a0,0(a1)
    80006cfa:	8d7d                	and	a0,a0,a5
    80006cfc:	8d1d                	sub	a0,a0,a5
}
    80006cfe:	00153513          	seqz	a0,a0
    80006d02:	6422                	ld	s0,8(sp)
    80006d04:	0141                	addi	sp,sp,16
    80006d06:	8082                	ret

0000000080006d08 <bit_set>:

// Set bit at position index in array to 1
void bit_set(char *array, int index) {
    80006d08:	1141                	addi	sp,sp,-16
    80006d0a:	e422                	sd	s0,8(sp)
    80006d0c:	0800                	addi	s0,sp,16
  char b = array[index/8];
    80006d0e:	41f5d71b          	sraiw	a4,a1,0x1f
    80006d12:	01d7571b          	srliw	a4,a4,0x1d
    80006d16:	9db9                	addw	a1,a1,a4
    80006d18:	4035d79b          	sraiw	a5,a1,0x3
    80006d1c:	953e                	add	a0,a0,a5
  char m = (1 << (index % 8));
    80006d1e:	899d                	andi	a1,a1,7
    80006d20:	9d99                	subw	a1,a1,a4
  array[index/8] = (b | m);
    80006d22:	4785                	li	a5,1
    80006d24:	00b795bb          	sllw	a1,a5,a1
    80006d28:	00054783          	lbu	a5,0(a0)
    80006d2c:	8ddd                	or	a1,a1,a5
    80006d2e:	00b50023          	sb	a1,0(a0)
}
    80006d32:	6422                	ld	s0,8(sp)
    80006d34:	0141                	addi	sp,sp,16
    80006d36:	8082                	ret

0000000080006d38 <bit_clear>:

// Clear bit at position index in array
void bit_clear(char *array, int index) {
    80006d38:	1141                	addi	sp,sp,-16
    80006d3a:	e422                	sd	s0,8(sp)
    80006d3c:	0800                	addi	s0,sp,16
  char b = array[index/8];
    80006d3e:	41f5d71b          	sraiw	a4,a1,0x1f
    80006d42:	01d7571b          	srliw	a4,a4,0x1d
    80006d46:	9db9                	addw	a1,a1,a4
    80006d48:	4035d79b          	sraiw	a5,a1,0x3
    80006d4c:	953e                	add	a0,a0,a5
  char m = (1 << (index % 8));
    80006d4e:	899d                	andi	a1,a1,7
    80006d50:	9d99                	subw	a1,a1,a4
  array[index/8] = (b & ~m);
    80006d52:	4785                	li	a5,1
    80006d54:	00b795bb          	sllw	a1,a5,a1
    80006d58:	fff5c593          	not	a1,a1
    80006d5c:	00054783          	lbu	a5,0(a0)
    80006d60:	8dfd                	and	a1,a1,a5
    80006d62:	00b50023          	sb	a1,0(a0)
}
    80006d66:	6422                	ld	s0,8(sp)
    80006d68:	0141                	addi	sp,sp,16
    80006d6a:	8082                	ret

0000000080006d6c <bd_print_vector>:

// Print a bit vector as a list of ranges of 1 bits
void
bd_print_vector(char *vector, int len) {
    80006d6c:	715d                	addi	sp,sp,-80
    80006d6e:	e486                	sd	ra,72(sp)
    80006d70:	e0a2                	sd	s0,64(sp)
    80006d72:	fc26                	sd	s1,56(sp)
    80006d74:	f84a                	sd	s2,48(sp)
    80006d76:	f44e                	sd	s3,40(sp)
    80006d78:	f052                	sd	s4,32(sp)
    80006d7a:	ec56                	sd	s5,24(sp)
    80006d7c:	e85a                	sd	s6,16(sp)
    80006d7e:	e45e                	sd	s7,8(sp)
    80006d80:	0880                	addi	s0,sp,80
    80006d82:	8a2e                	mv	s4,a1
  int last, lb;
  
  last = 1;
  lb = 0;
  for (int b = 0; b < len; b++) {
    80006d84:	08b05b63          	blez	a1,80006e1a <bd_print_vector+0xae>
    80006d88:	89aa                	mv	s3,a0
    80006d8a:	4481                	li	s1,0
  lb = 0;
    80006d8c:	4a81                	li	s5,0
  last = 1;
    80006d8e:	4905                	li	s2,1
    if (last == bit_isset(vector, b))
      continue;
    if(last == 1)
    80006d90:	4b05                	li	s6,1
      printf(" [%d, %d)", lb, b);
    80006d92:	00002b97          	auipc	s7,0x2
    80006d96:	046b8b93          	addi	s7,s7,70 # 80008dd8 <userret+0xd48>
    80006d9a:	a01d                	j	80006dc0 <bd_print_vector+0x54>
    80006d9c:	8626                	mv	a2,s1
    80006d9e:	85d6                	mv	a1,s5
    80006da0:	855e                	mv	a0,s7
    80006da2:	ffffa097          	auipc	ra,0xffffa
    80006da6:	c3c080e7          	jalr	-964(ra) # 800009de <printf>
    lb = b;
    last = bit_isset(vector, b);
    80006daa:	85a6                	mv	a1,s1
    80006dac:	854e                	mv	a0,s3
    80006dae:	00000097          	auipc	ra,0x0
    80006db2:	f22080e7          	jalr	-222(ra) # 80006cd0 <bit_isset>
    80006db6:	892a                	mv	s2,a0
    80006db8:	8aa6                	mv	s5,s1
  for (int b = 0; b < len; b++) {
    80006dba:	2485                	addiw	s1,s1,1
    80006dbc:	009a0d63          	beq	s4,s1,80006dd6 <bd_print_vector+0x6a>
    if (last == bit_isset(vector, b))
    80006dc0:	85a6                	mv	a1,s1
    80006dc2:	854e                	mv	a0,s3
    80006dc4:	00000097          	auipc	ra,0x0
    80006dc8:	f0c080e7          	jalr	-244(ra) # 80006cd0 <bit_isset>
    80006dcc:	ff2507e3          	beq	a0,s2,80006dba <bd_print_vector+0x4e>
    if(last == 1)
    80006dd0:	fd691de3          	bne	s2,s6,80006daa <bd_print_vector+0x3e>
    80006dd4:	b7e1                	j	80006d9c <bd_print_vector+0x30>
  }
  if(lb == 0 || last == 1) {
    80006dd6:	000a8563          	beqz	s5,80006de0 <bd_print_vector+0x74>
    80006dda:	4785                	li	a5,1
    80006ddc:	00f91c63          	bne	s2,a5,80006df4 <bd_print_vector+0x88>
    printf(" [%d, %d)", lb, len);
    80006de0:	8652                	mv	a2,s4
    80006de2:	85d6                	mv	a1,s5
    80006de4:	00002517          	auipc	a0,0x2
    80006de8:	ff450513          	addi	a0,a0,-12 # 80008dd8 <userret+0xd48>
    80006dec:	ffffa097          	auipc	ra,0xffffa
    80006df0:	bf2080e7          	jalr	-1038(ra) # 800009de <printf>
  }
  printf("\n");
    80006df4:	00002517          	auipc	a0,0x2
    80006df8:	87450513          	addi	a0,a0,-1932 # 80008668 <userret+0x5d8>
    80006dfc:	ffffa097          	auipc	ra,0xffffa
    80006e00:	be2080e7          	jalr	-1054(ra) # 800009de <printf>
}
    80006e04:	60a6                	ld	ra,72(sp)
    80006e06:	6406                	ld	s0,64(sp)
    80006e08:	74e2                	ld	s1,56(sp)
    80006e0a:	7942                	ld	s2,48(sp)
    80006e0c:	79a2                	ld	s3,40(sp)
    80006e0e:	7a02                	ld	s4,32(sp)
    80006e10:	6ae2                	ld	s5,24(sp)
    80006e12:	6b42                	ld	s6,16(sp)
    80006e14:	6ba2                	ld	s7,8(sp)
    80006e16:	6161                	addi	sp,sp,80
    80006e18:	8082                	ret
  lb = 0;
    80006e1a:	4a81                	li	s5,0
    80006e1c:	b7d1                	j	80006de0 <bd_print_vector+0x74>

0000000080006e1e <bd_print>:

// Print buddy's data structures
void
bd_print() {
  for (int k = 0; k < nsizes; k++) {
    80006e1e:	00027797          	auipc	a5,0x27
    80006e22:	28278793          	addi	a5,a5,642 # 8002e0a0 <nsizes>
    80006e26:	4394                	lw	a3,0(a5)
    80006e28:	0ed05b63          	blez	a3,80006f1e <bd_print+0x100>
bd_print() {
    80006e2c:	711d                	addi	sp,sp,-96
    80006e2e:	ec86                	sd	ra,88(sp)
    80006e30:	e8a2                	sd	s0,80(sp)
    80006e32:	e4a6                	sd	s1,72(sp)
    80006e34:	e0ca                	sd	s2,64(sp)
    80006e36:	fc4e                	sd	s3,56(sp)
    80006e38:	f852                	sd	s4,48(sp)
    80006e3a:	f456                	sd	s5,40(sp)
    80006e3c:	f05a                	sd	s6,32(sp)
    80006e3e:	ec5e                	sd	s7,24(sp)
    80006e40:	e862                	sd	s8,16(sp)
    80006e42:	e466                	sd	s9,8(sp)
    80006e44:	e06a                	sd	s10,0(sp)
    80006e46:	1080                	addi	s0,sp,96
  for (int k = 0; k < nsizes; k++) {
    80006e48:	4901                	li	s2,0
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    80006e4a:	4a85                	li	s5,1
    80006e4c:	4c41                	li	s8,16
    80006e4e:	00002b97          	auipc	s7,0x2
    80006e52:	f9ab8b93          	addi	s7,s7,-102 # 80008de8 <userret+0xd58>
    lst_print(&bd_sizes[k].free);
    80006e56:	00027a17          	auipc	s4,0x27
    80006e5a:	242a0a13          	addi	s4,s4,578 # 8002e098 <bd_sizes>
    printf("  alloc:");
    80006e5e:	00002b17          	auipc	s6,0x2
    80006e62:	fb2b0b13          	addi	s6,s6,-78 # 80008e10 <userret+0xd80>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80006e66:	89be                	mv	s3,a5
    if(k > 0) {
      printf("  split:");
    80006e68:	00002c97          	auipc	s9,0x2
    80006e6c:	fb8c8c93          	addi	s9,s9,-72 # 80008e20 <userret+0xd90>
    80006e70:	a801                	j	80006e80 <bd_print+0x62>
  for (int k = 0; k < nsizes; k++) {
    80006e72:	0009a683          	lw	a3,0(s3)
    80006e76:	0905                	addi	s2,s2,1
    80006e78:	0009079b          	sext.w	a5,s2
    80006e7c:	08d7d363          	ble	a3,a5,80006f02 <bd_print+0xe4>
    80006e80:	0009049b          	sext.w	s1,s2
    printf("size %d (blksz %d nblk %d): free list: ", k, BLK_SIZE(k), NBLK(k));
    80006e84:	36fd                	addiw	a3,a3,-1
    80006e86:	9e85                	subw	a3,a3,s1
    80006e88:	00da96bb          	sllw	a3,s5,a3
    80006e8c:	009c1633          	sll	a2,s8,s1
    80006e90:	85a6                	mv	a1,s1
    80006e92:	855e                	mv	a0,s7
    80006e94:	ffffa097          	auipc	ra,0xffffa
    80006e98:	b4a080e7          	jalr	-1206(ra) # 800009de <printf>
    lst_print(&bd_sizes[k].free);
    80006e9c:	00591d13          	slli	s10,s2,0x5
    80006ea0:	000a3503          	ld	a0,0(s4)
    80006ea4:	956a                	add	a0,a0,s10
    80006ea6:	00001097          	auipc	ra,0x1
    80006eaa:	a80080e7          	jalr	-1408(ra) # 80007926 <lst_print>
    printf("  alloc:");
    80006eae:	855a                	mv	a0,s6
    80006eb0:	ffffa097          	auipc	ra,0xffffa
    80006eb4:	b2e080e7          	jalr	-1234(ra) # 800009de <printf>
    bd_print_vector(bd_sizes[k].alloc, NBLK(k));
    80006eb8:	0009a583          	lw	a1,0(s3)
    80006ebc:	35fd                	addiw	a1,a1,-1
    80006ebe:	9d85                	subw	a1,a1,s1
    80006ec0:	000a3783          	ld	a5,0(s4)
    80006ec4:	97ea                	add	a5,a5,s10
    80006ec6:	00ba95bb          	sllw	a1,s5,a1
    80006eca:	6b88                	ld	a0,16(a5)
    80006ecc:	00000097          	auipc	ra,0x0
    80006ed0:	ea0080e7          	jalr	-352(ra) # 80006d6c <bd_print_vector>
    if(k > 0) {
    80006ed4:	f8905fe3          	blez	s1,80006e72 <bd_print+0x54>
      printf("  split:");
    80006ed8:	8566                	mv	a0,s9
    80006eda:	ffffa097          	auipc	ra,0xffffa
    80006ede:	b04080e7          	jalr	-1276(ra) # 800009de <printf>
      bd_print_vector(bd_sizes[k].split, NBLK(k));
    80006ee2:	0009a583          	lw	a1,0(s3)
    80006ee6:	35fd                	addiw	a1,a1,-1
    80006ee8:	9d85                	subw	a1,a1,s1
    80006eea:	000a3783          	ld	a5,0(s4)
    80006eee:	9d3e                	add	s10,s10,a5
    80006ef0:	00ba95bb          	sllw	a1,s5,a1
    80006ef4:	018d3503          	ld	a0,24(s10) # 1018 <_entry-0x7fffefe8>
    80006ef8:	00000097          	auipc	ra,0x0
    80006efc:	e74080e7          	jalr	-396(ra) # 80006d6c <bd_print_vector>
    80006f00:	bf8d                	j	80006e72 <bd_print+0x54>
    }
  }
}
    80006f02:	60e6                	ld	ra,88(sp)
    80006f04:	6446                	ld	s0,80(sp)
    80006f06:	64a6                	ld	s1,72(sp)
    80006f08:	6906                	ld	s2,64(sp)
    80006f0a:	79e2                	ld	s3,56(sp)
    80006f0c:	7a42                	ld	s4,48(sp)
    80006f0e:	7aa2                	ld	s5,40(sp)
    80006f10:	7b02                	ld	s6,32(sp)
    80006f12:	6be2                	ld	s7,24(sp)
    80006f14:	6c42                	ld	s8,16(sp)
    80006f16:	6ca2                	ld	s9,8(sp)
    80006f18:	6d02                	ld	s10,0(sp)
    80006f1a:	6125                	addi	sp,sp,96
    80006f1c:	8082                	ret
    80006f1e:	8082                	ret

0000000080006f20 <firstk>:

// What is the first k such that 2^k >= n?
int
firstk(uint64 n) {
    80006f20:	1141                	addi	sp,sp,-16
    80006f22:	e422                	sd	s0,8(sp)
    80006f24:	0800                	addi	s0,sp,16
  int k = 0;
  uint64 size = LEAF_SIZE;

  while (size < n) {
    80006f26:	47c1                	li	a5,16
    80006f28:	00a7fb63          	bleu	a0,a5,80006f3e <firstk+0x1e>
  int k = 0;
    80006f2c:	4701                	li	a4,0
    k++;
    80006f2e:	2705                	addiw	a4,a4,1
    size *= 2;
    80006f30:	0786                	slli	a5,a5,0x1
  while (size < n) {
    80006f32:	fea7eee3          	bltu	a5,a0,80006f2e <firstk+0xe>
  }
  return k;
}
    80006f36:	853a                	mv	a0,a4
    80006f38:	6422                	ld	s0,8(sp)
    80006f3a:	0141                	addi	sp,sp,16
    80006f3c:	8082                	ret
  int k = 0;
    80006f3e:	4701                	li	a4,0
    80006f40:	bfdd                	j	80006f36 <firstk+0x16>

0000000080006f42 <blk_index>:

// Compute the block index for address p at size k
int
blk_index(int k, char *p) {
    80006f42:	1141                	addi	sp,sp,-16
    80006f44:	e422                	sd	s0,8(sp)
    80006f46:	0800                	addi	s0,sp,16
  int n = p - (char *) bd_base;
    80006f48:	00027797          	auipc	a5,0x27
    80006f4c:	14878793          	addi	a5,a5,328 # 8002e090 <bd_base>
    80006f50:	639c                	ld	a5,0(a5)
  return n / BLK_SIZE(k);
    80006f52:	9d9d                	subw	a1,a1,a5
    80006f54:	47c1                	li	a5,16
    80006f56:	00a79533          	sll	a0,a5,a0
    80006f5a:	02a5c533          	div	a0,a1,a0
}
    80006f5e:	2501                	sext.w	a0,a0
    80006f60:	6422                	ld	s0,8(sp)
    80006f62:	0141                	addi	sp,sp,16
    80006f64:	8082                	ret

0000000080006f66 <addr>:

// Convert a block index at size k back into an address
void *addr(int k, int bi) {
    80006f66:	1141                	addi	sp,sp,-16
    80006f68:	e422                	sd	s0,8(sp)
    80006f6a:	0800                	addi	s0,sp,16
  int n = bi * BLK_SIZE(k);
    80006f6c:	47c1                	li	a5,16
    80006f6e:	00a79533          	sll	a0,a5,a0
  return (char *) bd_base + n;
    80006f72:	02a5853b          	mulw	a0,a1,a0
    80006f76:	00027797          	auipc	a5,0x27
    80006f7a:	11a78793          	addi	a5,a5,282 # 8002e090 <bd_base>
    80006f7e:	639c                	ld	a5,0(a5)
}
    80006f80:	953e                	add	a0,a0,a5
    80006f82:	6422                	ld	s0,8(sp)
    80006f84:	0141                	addi	sp,sp,16
    80006f86:	8082                	ret

0000000080006f88 <bd_malloc>:

// allocate nbytes, but malloc won't return anything smaller than LEAF_SIZE
void *
bd_malloc(uint64 nbytes)
{
    80006f88:	7159                	addi	sp,sp,-112
    80006f8a:	f486                	sd	ra,104(sp)
    80006f8c:	f0a2                	sd	s0,96(sp)
    80006f8e:	eca6                	sd	s1,88(sp)
    80006f90:	e8ca                	sd	s2,80(sp)
    80006f92:	e4ce                	sd	s3,72(sp)
    80006f94:	e0d2                	sd	s4,64(sp)
    80006f96:	fc56                	sd	s5,56(sp)
    80006f98:	f85a                	sd	s6,48(sp)
    80006f9a:	f45e                	sd	s7,40(sp)
    80006f9c:	f062                	sd	s8,32(sp)
    80006f9e:	ec66                	sd	s9,24(sp)
    80006fa0:	e86a                	sd	s10,16(sp)
    80006fa2:	e46e                	sd	s11,8(sp)
    80006fa4:	1880                	addi	s0,sp,112
    80006fa6:	84aa                	mv	s1,a0
  int fk, k;

  acquire(&lock);
    80006fa8:	00027517          	auipc	a0,0x27
    80006fac:	05850513          	addi	a0,a0,88 # 8002e000 <lock>
    80006fb0:	ffffa097          	auipc	ra,0xffffa
    80006fb4:	d80080e7          	jalr	-640(ra) # 80000d30 <acquire>

  // Find a free block >= nbytes, starting with smallest k possible
  fk = firstk(nbytes);
    80006fb8:	8526                	mv	a0,s1
    80006fba:	00000097          	auipc	ra,0x0
    80006fbe:	f66080e7          	jalr	-154(ra) # 80006f20 <firstk>
  for (k = fk; k < nsizes; k++) {
    80006fc2:	00027797          	auipc	a5,0x27
    80006fc6:	0de78793          	addi	a5,a5,222 # 8002e0a0 <nsizes>
    80006fca:	439c                	lw	a5,0(a5)
    80006fcc:	02f55d63          	ble	a5,a0,80007006 <bd_malloc+0x7e>
    80006fd0:	8d2a                	mv	s10,a0
    80006fd2:	00551913          	slli	s2,a0,0x5
    80006fd6:	84aa                	mv	s1,a0
    if(!lst_empty(&bd_sizes[k].free))
    80006fd8:	00027997          	auipc	s3,0x27
    80006fdc:	0c098993          	addi	s3,s3,192 # 8002e098 <bd_sizes>
  for (k = fk; k < nsizes; k++) {
    80006fe0:	00027a17          	auipc	s4,0x27
    80006fe4:	0c0a0a13          	addi	s4,s4,192 # 8002e0a0 <nsizes>
    if(!lst_empty(&bd_sizes[k].free))
    80006fe8:	0009b503          	ld	a0,0(s3)
    80006fec:	954a                	add	a0,a0,s2
    80006fee:	00001097          	auipc	ra,0x1
    80006ff2:	8be080e7          	jalr	-1858(ra) # 800078ac <lst_empty>
    80006ff6:	c115                	beqz	a0,8000701a <bd_malloc+0x92>
  for (k = fk; k < nsizes; k++) {
    80006ff8:	2485                	addiw	s1,s1,1
    80006ffa:	02090913          	addi	s2,s2,32
    80006ffe:	000a2783          	lw	a5,0(s4)
    80007002:	fef4c3e3          	blt	s1,a5,80006fe8 <bd_malloc+0x60>
      break;
  }
  if(k >= nsizes) { // No free blocks?
    release(&lock);
    80007006:	00027517          	auipc	a0,0x27
    8000700a:	ffa50513          	addi	a0,a0,-6 # 8002e000 <lock>
    8000700e:	ffffa097          	auipc	ra,0xffffa
    80007012:	f6e080e7          	jalr	-146(ra) # 80000f7c <release>
    return 0;
    80007016:	4b81                	li	s7,0
    80007018:	a8d1                	j	800070ec <bd_malloc+0x164>
  if(k >= nsizes) { // No free blocks?
    8000701a:	00027797          	auipc	a5,0x27
    8000701e:	08678793          	addi	a5,a5,134 # 8002e0a0 <nsizes>
    80007022:	439c                	lw	a5,0(a5)
    80007024:	fef4d1e3          	ble	a5,s1,80007006 <bd_malloc+0x7e>
  }

  // Found a block; pop it and potentially split it.
  char *p = lst_pop(&bd_sizes[k].free);
    80007028:	00549993          	slli	s3,s1,0x5
    8000702c:	00027917          	auipc	s2,0x27
    80007030:	06c90913          	addi	s2,s2,108 # 8002e098 <bd_sizes>
    80007034:	00093503          	ld	a0,0(s2)
    80007038:	954e                	add	a0,a0,s3
    8000703a:	00001097          	auipc	ra,0x1
    8000703e:	89e080e7          	jalr	-1890(ra) # 800078d8 <lst_pop>
    80007042:	8baa                	mv	s7,a0
  int n = p - (char *) bd_base;
    80007044:	00027797          	auipc	a5,0x27
    80007048:	04c78793          	addi	a5,a5,76 # 8002e090 <bd_base>
    8000704c:	638c                	ld	a1,0(a5)
  return n / BLK_SIZE(k);
    8000704e:	40b505bb          	subw	a1,a0,a1
    80007052:	47c1                	li	a5,16
    80007054:	009797b3          	sll	a5,a5,s1
    80007058:	02f5c5b3          	div	a1,a1,a5
  bit_set(bd_sizes[k].alloc, blk_index(k, p));
    8000705c:	00093783          	ld	a5,0(s2)
    80007060:	97ce                	add	a5,a5,s3
    80007062:	2581                	sext.w	a1,a1
    80007064:	6b88                	ld	a0,16(a5)
    80007066:	00000097          	auipc	ra,0x0
    8000706a:	ca2080e7          	jalr	-862(ra) # 80006d08 <bit_set>
  for(; k > fk; k--) {
    8000706e:	069d5763          	ble	s1,s10,800070dc <bd_malloc+0x154>
    // split a block at size k and mark one half allocated at size k-1
    // and put the buddy on the free list at size k-1
    char *q = p + BLK_SIZE(k-1);   // p's buddy
    80007072:	4c41                	li	s8,16
  int n = p - (char *) bd_base;
    80007074:	00027d97          	auipc	s11,0x27
    80007078:	01cd8d93          	addi	s11,s11,28 # 8002e090 <bd_base>
    char *q = p + BLK_SIZE(k-1);   // p's buddy
    8000707c:	fff48a9b          	addiw	s5,s1,-1
    80007080:	015c1b33          	sll	s6,s8,s5
    80007084:	016b8cb3          	add	s9,s7,s6
    bit_set(bd_sizes[k].split, blk_index(k, p));
    80007088:	00027797          	auipc	a5,0x27
    8000708c:	01078793          	addi	a5,a5,16 # 8002e098 <bd_sizes>
    80007090:	0007ba03          	ld	s4,0(a5)
  int n = p - (char *) bd_base;
    80007094:	000db903          	ld	s2,0(s11)
  return n / BLK_SIZE(k);
    80007098:	412b893b          	subw	s2,s7,s2
    8000709c:	009c15b3          	sll	a1,s8,s1
    800070a0:	02b945b3          	div	a1,s2,a1
    bit_set(bd_sizes[k].split, blk_index(k, p));
    800070a4:	013a07b3          	add	a5,s4,s3
    800070a8:	2581                	sext.w	a1,a1
    800070aa:	6f88                	ld	a0,24(a5)
    800070ac:	00000097          	auipc	ra,0x0
    800070b0:	c5c080e7          	jalr	-932(ra) # 80006d08 <bit_set>
    bit_set(bd_sizes[k-1].alloc, blk_index(k-1, p));
    800070b4:	1981                	addi	s3,s3,-32
    800070b6:	9a4e                	add	s4,s4,s3
  return n / BLK_SIZE(k);
    800070b8:	036945b3          	div	a1,s2,s6
    bit_set(bd_sizes[k-1].alloc, blk_index(k-1, p));
    800070bc:	2581                	sext.w	a1,a1
    800070be:	010a3503          	ld	a0,16(s4)
    800070c2:	00000097          	auipc	ra,0x0
    800070c6:	c46080e7          	jalr	-954(ra) # 80006d08 <bit_set>
    lst_push(&bd_sizes[k-1].free, q);
    800070ca:	85e6                	mv	a1,s9
    800070cc:	8552                	mv	a0,s4
    800070ce:	00001097          	auipc	ra,0x1
    800070d2:	840080e7          	jalr	-1984(ra) # 8000790e <lst_push>
  for(; k > fk; k--) {
    800070d6:	84d6                	mv	s1,s5
    800070d8:	fbaa92e3          	bne	s5,s10,8000707c <bd_malloc+0xf4>
  }
  release(&lock);
    800070dc:	00027517          	auipc	a0,0x27
    800070e0:	f2450513          	addi	a0,a0,-220 # 8002e000 <lock>
    800070e4:	ffffa097          	auipc	ra,0xffffa
    800070e8:	e98080e7          	jalr	-360(ra) # 80000f7c <release>

  return p;
}
    800070ec:	855e                	mv	a0,s7
    800070ee:	70a6                	ld	ra,104(sp)
    800070f0:	7406                	ld	s0,96(sp)
    800070f2:	64e6                	ld	s1,88(sp)
    800070f4:	6946                	ld	s2,80(sp)
    800070f6:	69a6                	ld	s3,72(sp)
    800070f8:	6a06                	ld	s4,64(sp)
    800070fa:	7ae2                	ld	s5,56(sp)
    800070fc:	7b42                	ld	s6,48(sp)
    800070fe:	7ba2                	ld	s7,40(sp)
    80007100:	7c02                	ld	s8,32(sp)
    80007102:	6ce2                	ld	s9,24(sp)
    80007104:	6d42                	ld	s10,16(sp)
    80007106:	6da2                	ld	s11,8(sp)
    80007108:	6165                	addi	sp,sp,112
    8000710a:	8082                	ret

000000008000710c <size>:

// Find the size of the block that p points to.
int
size(char *p) {
    8000710c:	7139                	addi	sp,sp,-64
    8000710e:	fc06                	sd	ra,56(sp)
    80007110:	f822                	sd	s0,48(sp)
    80007112:	f426                	sd	s1,40(sp)
    80007114:	f04a                	sd	s2,32(sp)
    80007116:	ec4e                	sd	s3,24(sp)
    80007118:	e852                	sd	s4,16(sp)
    8000711a:	e456                	sd	s5,8(sp)
    8000711c:	e05a                	sd	s6,0(sp)
    8000711e:	0080                	addi	s0,sp,64
  for (int k = 0; k < nsizes; k++) {
    80007120:	00027797          	auipc	a5,0x27
    80007124:	f8078793          	addi	a5,a5,-128 # 8002e0a0 <nsizes>
    80007128:	0007aa83          	lw	s5,0(a5)
  int n = p - (char *) bd_base;
    8000712c:	00027797          	auipc	a5,0x27
    80007130:	f6478793          	addi	a5,a5,-156 # 8002e090 <bd_base>
    80007134:	0007ba03          	ld	s4,0(a5)
  return n / BLK_SIZE(k);
    80007138:	41450a3b          	subw	s4,a0,s4
    if(bit_isset(bd_sizes[k+1].split, blk_index(k+1, p))) {
    8000713c:	00027797          	auipc	a5,0x27
    80007140:	f5c78793          	addi	a5,a5,-164 # 8002e098 <bd_sizes>
    80007144:	6384                	ld	s1,0(a5)
    80007146:	03848493          	addi	s1,s1,56
  for (int k = 0; k < nsizes; k++) {
    8000714a:	4901                	li	s2,0
  return n / BLK_SIZE(k);
    8000714c:	4b41                	li	s6,16
  for (int k = 0; k < nsizes; k++) {
    8000714e:	03595363          	ble	s5,s2,80007174 <size+0x68>
    if(bit_isset(bd_sizes[k+1].split, blk_index(k+1, p))) {
    80007152:	0019099b          	addiw	s3,s2,1
  return n / BLK_SIZE(k);
    80007156:	013b15b3          	sll	a1,s6,s3
    8000715a:	02ba45b3          	div	a1,s4,a1
    if(bit_isset(bd_sizes[k+1].split, blk_index(k+1, p))) {
    8000715e:	2581                	sext.w	a1,a1
    80007160:	6088                	ld	a0,0(s1)
    80007162:	00000097          	auipc	ra,0x0
    80007166:	b6e080e7          	jalr	-1170(ra) # 80006cd0 <bit_isset>
    8000716a:	02048493          	addi	s1,s1,32
    8000716e:	e501                	bnez	a0,80007176 <size+0x6a>
  for (int k = 0; k < nsizes; k++) {
    80007170:	894e                	mv	s2,s3
    80007172:	bff1                	j	8000714e <size+0x42>
      return k;
    }
  }
  return 0;
    80007174:	4901                	li	s2,0
}
    80007176:	854a                	mv	a0,s2
    80007178:	70e2                	ld	ra,56(sp)
    8000717a:	7442                	ld	s0,48(sp)
    8000717c:	74a2                	ld	s1,40(sp)
    8000717e:	7902                	ld	s2,32(sp)
    80007180:	69e2                	ld	s3,24(sp)
    80007182:	6a42                	ld	s4,16(sp)
    80007184:	6aa2                	ld	s5,8(sp)
    80007186:	6b02                	ld	s6,0(sp)
    80007188:	6121                	addi	sp,sp,64
    8000718a:	8082                	ret

000000008000718c <bd_free>:

// Free memory pointed to by p, which was earlier allocated using
// bd_malloc.
void
bd_free(void *p) {
    8000718c:	7159                	addi	sp,sp,-112
    8000718e:	f486                	sd	ra,104(sp)
    80007190:	f0a2                	sd	s0,96(sp)
    80007192:	eca6                	sd	s1,88(sp)
    80007194:	e8ca                	sd	s2,80(sp)
    80007196:	e4ce                	sd	s3,72(sp)
    80007198:	e0d2                	sd	s4,64(sp)
    8000719a:	fc56                	sd	s5,56(sp)
    8000719c:	f85a                	sd	s6,48(sp)
    8000719e:	f45e                	sd	s7,40(sp)
    800071a0:	f062                	sd	s8,32(sp)
    800071a2:	ec66                	sd	s9,24(sp)
    800071a4:	e86a                	sd	s10,16(sp)
    800071a6:	e46e                	sd	s11,8(sp)
    800071a8:	1880                	addi	s0,sp,112
    800071aa:	8b2a                	mv	s6,a0
  void *q;
  int k;

  acquire(&lock);
    800071ac:	00027517          	auipc	a0,0x27
    800071b0:	e5450513          	addi	a0,a0,-428 # 8002e000 <lock>
    800071b4:	ffffa097          	auipc	ra,0xffffa
    800071b8:	b7c080e7          	jalr	-1156(ra) # 80000d30 <acquire>
  for (k = size(p); k < MAXSIZE; k++) {
    800071bc:	855a                	mv	a0,s6
    800071be:	00000097          	auipc	ra,0x0
    800071c2:	f4e080e7          	jalr	-178(ra) # 8000710c <size>
    800071c6:	892a                	mv	s2,a0
    800071c8:	00027797          	auipc	a5,0x27
    800071cc:	ed878793          	addi	a5,a5,-296 # 8002e0a0 <nsizes>
    800071d0:	439c                	lw	a5,0(a5)
    800071d2:	37fd                	addiw	a5,a5,-1
    800071d4:	0af55a63          	ble	a5,a0,80007288 <bd_free+0xfc>
    800071d8:	00551a93          	slli	s5,a0,0x5
  int n = p - (char *) bd_base;
    800071dc:	00027c97          	auipc	s9,0x27
    800071e0:	eb4c8c93          	addi	s9,s9,-332 # 8002e090 <bd_base>
  return n / BLK_SIZE(k);
    800071e4:	4c41                	li	s8,16
    int bi = blk_index(k, p);
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    bit_clear(bd_sizes[k].alloc, bi);  // free p at size k
    800071e6:	00027b97          	auipc	s7,0x27
    800071ea:	eb2b8b93          	addi	s7,s7,-334 # 8002e098 <bd_sizes>
  for (k = size(p); k < MAXSIZE; k++) {
    800071ee:	00027d17          	auipc	s10,0x27
    800071f2:	eb2d0d13          	addi	s10,s10,-334 # 8002e0a0 <nsizes>
    800071f6:	a82d                	j	80007230 <bd_free+0xa4>
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    800071f8:	fff5849b          	addiw	s1,a1,-1
    800071fc:	a881                	j	8000724c <bd_free+0xc0>
    if(buddy % 2 == 0) {
      p = q;
    }
    // at size k+1, mark that the merged buddy pair isn't split
    // anymore
    bit_clear(bd_sizes[k+1].split, blk_index(k+1, p));
    800071fe:	020a8a93          	addi	s5,s5,32
    80007202:	2905                	addiw	s2,s2,1
  int n = p - (char *) bd_base;
    80007204:	000cb583          	ld	a1,0(s9)
  return n / BLK_SIZE(k);
    80007208:	40bb05bb          	subw	a1,s6,a1
    8000720c:	012c17b3          	sll	a5,s8,s2
    80007210:	02f5c5b3          	div	a1,a1,a5
    bit_clear(bd_sizes[k+1].split, blk_index(k+1, p));
    80007214:	000bb783          	ld	a5,0(s7)
    80007218:	97d6                	add	a5,a5,s5
    8000721a:	2581                	sext.w	a1,a1
    8000721c:	6f88                	ld	a0,24(a5)
    8000721e:	00000097          	auipc	ra,0x0
    80007222:	b1a080e7          	jalr	-1254(ra) # 80006d38 <bit_clear>
  for (k = size(p); k < MAXSIZE; k++) {
    80007226:	000d2783          	lw	a5,0(s10)
    8000722a:	37fd                	addiw	a5,a5,-1
    8000722c:	04f95e63          	ble	a5,s2,80007288 <bd_free+0xfc>
  int n = p - (char *) bd_base;
    80007230:	000cb983          	ld	s3,0(s9)
  return n / BLK_SIZE(k);
    80007234:	012c1a33          	sll	s4,s8,s2
    80007238:	413b07bb          	subw	a5,s6,s3
    8000723c:	0347c7b3          	div	a5,a5,s4
    80007240:	0007859b          	sext.w	a1,a5
    int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    80007244:	8b85                	andi	a5,a5,1
    80007246:	fbcd                	bnez	a5,800071f8 <bd_free+0x6c>
    80007248:	0015849b          	addiw	s1,a1,1
    bit_clear(bd_sizes[k].alloc, bi);  // free p at size k
    8000724c:	000bbd83          	ld	s11,0(s7)
    80007250:	9dd6                	add	s11,s11,s5
    80007252:	010db503          	ld	a0,16(s11)
    80007256:	00000097          	auipc	ra,0x0
    8000725a:	ae2080e7          	jalr	-1310(ra) # 80006d38 <bit_clear>
    if (bit_isset(bd_sizes[k].alloc, buddy)) {  // is buddy allocated?
    8000725e:	85a6                	mv	a1,s1
    80007260:	010db503          	ld	a0,16(s11)
    80007264:	00000097          	auipc	ra,0x0
    80007268:	a6c080e7          	jalr	-1428(ra) # 80006cd0 <bit_isset>
    8000726c:	ed11                	bnez	a0,80007288 <bd_free+0xfc>
  int n = bi * BLK_SIZE(k);
    8000726e:	2481                	sext.w	s1,s1
  return (char *) bd_base + n;
    80007270:	029a0a3b          	mulw	s4,s4,s1
    80007274:	99d2                	add	s3,s3,s4
    lst_remove(q);    // remove buddy from free list
    80007276:	854e                	mv	a0,s3
    80007278:	00000097          	auipc	ra,0x0
    8000727c:	64a080e7          	jalr	1610(ra) # 800078c2 <lst_remove>
    if(buddy % 2 == 0) {
    80007280:	8885                	andi	s1,s1,1
    80007282:	fcb5                	bnez	s1,800071fe <bd_free+0x72>
      p = q;
    80007284:	8b4e                	mv	s6,s3
    80007286:	bfa5                	j	800071fe <bd_free+0x72>
  }
  lst_push(&bd_sizes[k].free, p);
    80007288:	0916                	slli	s2,s2,0x5
    8000728a:	00027797          	auipc	a5,0x27
    8000728e:	e0e78793          	addi	a5,a5,-498 # 8002e098 <bd_sizes>
    80007292:	6388                	ld	a0,0(a5)
    80007294:	85da                	mv	a1,s6
    80007296:	954a                	add	a0,a0,s2
    80007298:	00000097          	auipc	ra,0x0
    8000729c:	676080e7          	jalr	1654(ra) # 8000790e <lst_push>
  release(&lock);
    800072a0:	00027517          	auipc	a0,0x27
    800072a4:	d6050513          	addi	a0,a0,-672 # 8002e000 <lock>
    800072a8:	ffffa097          	auipc	ra,0xffffa
    800072ac:	cd4080e7          	jalr	-812(ra) # 80000f7c <release>
}
    800072b0:	70a6                	ld	ra,104(sp)
    800072b2:	7406                	ld	s0,96(sp)
    800072b4:	64e6                	ld	s1,88(sp)
    800072b6:	6946                	ld	s2,80(sp)
    800072b8:	69a6                	ld	s3,72(sp)
    800072ba:	6a06                	ld	s4,64(sp)
    800072bc:	7ae2                	ld	s5,56(sp)
    800072be:	7b42                	ld	s6,48(sp)
    800072c0:	7ba2                	ld	s7,40(sp)
    800072c2:	7c02                	ld	s8,32(sp)
    800072c4:	6ce2                	ld	s9,24(sp)
    800072c6:	6d42                	ld	s10,16(sp)
    800072c8:	6da2                	ld	s11,8(sp)
    800072ca:	6165                	addi	sp,sp,112
    800072cc:	8082                	ret

00000000800072ce <blk_index_next>:

// Compute the first block at size k that doesn't contain p
int
blk_index_next(int k, char *p) {
    800072ce:	1141                	addi	sp,sp,-16
    800072d0:	e422                	sd	s0,8(sp)
    800072d2:	0800                	addi	s0,sp,16
  int n = (p - (char *) bd_base) / BLK_SIZE(k);
    800072d4:	00027797          	auipc	a5,0x27
    800072d8:	dbc78793          	addi	a5,a5,-580 # 8002e090 <bd_base>
    800072dc:	639c                	ld	a5,0(a5)
    800072de:	8d9d                	sub	a1,a1,a5
    800072e0:	47c1                	li	a5,16
    800072e2:	00a797b3          	sll	a5,a5,a0
    800072e6:	02f5c533          	div	a0,a1,a5
    800072ea:	2501                	sext.w	a0,a0
  if((p - (char*) bd_base) % BLK_SIZE(k) != 0)
    800072ec:	02f5e5b3          	rem	a1,a1,a5
    800072f0:	c191                	beqz	a1,800072f4 <blk_index_next+0x26>
      n++;
    800072f2:	2505                	addiw	a0,a0,1
  return n ;
}
    800072f4:	6422                	ld	s0,8(sp)
    800072f6:	0141                	addi	sp,sp,16
    800072f8:	8082                	ret

00000000800072fa <log2>:

int
log2(uint64 n) {
    800072fa:	1141                	addi	sp,sp,-16
    800072fc:	e422                	sd	s0,8(sp)
    800072fe:	0800                	addi	s0,sp,16
  int k = 0;
  while (n > 1) {
    80007300:	4705                	li	a4,1
    80007302:	00a77b63          	bleu	a0,a4,80007318 <log2+0x1e>
    80007306:	87aa                	mv	a5,a0
  int k = 0;
    80007308:	4501                	li	a0,0
    k++;
    8000730a:	2505                	addiw	a0,a0,1
    n = n >> 1;
    8000730c:	8385                	srli	a5,a5,0x1
  while (n > 1) {
    8000730e:	fef76ee3          	bltu	a4,a5,8000730a <log2+0x10>
  }
  return k;
}
    80007312:	6422                	ld	s0,8(sp)
    80007314:	0141                	addi	sp,sp,16
    80007316:	8082                	ret
  int k = 0;
    80007318:	4501                	li	a0,0
    8000731a:	bfe5                	j	80007312 <log2+0x18>

000000008000731c <bd_mark>:

// Mark memory from [start, stop), starting at size 0, as allocated. 
void
bd_mark(void *start, void *stop)
{
    8000731c:	711d                	addi	sp,sp,-96
    8000731e:	ec86                	sd	ra,88(sp)
    80007320:	e8a2                	sd	s0,80(sp)
    80007322:	e4a6                	sd	s1,72(sp)
    80007324:	e0ca                	sd	s2,64(sp)
    80007326:	fc4e                	sd	s3,56(sp)
    80007328:	f852                	sd	s4,48(sp)
    8000732a:	f456                	sd	s5,40(sp)
    8000732c:	f05a                	sd	s6,32(sp)
    8000732e:	ec5e                	sd	s7,24(sp)
    80007330:	e862                	sd	s8,16(sp)
    80007332:	e466                	sd	s9,8(sp)
    80007334:	e06a                	sd	s10,0(sp)
    80007336:	1080                	addi	s0,sp,96
  int bi, bj;

  if (((uint64) start % LEAF_SIZE != 0) || ((uint64) stop % LEAF_SIZE != 0))
    80007338:	00b56933          	or	s2,a0,a1
    8000733c:	00f97913          	andi	s2,s2,15
    80007340:	04091463          	bnez	s2,80007388 <bd_mark+0x6c>
    80007344:	8baa                	mv	s7,a0
    80007346:	8c2e                	mv	s8,a1
    panic("bd_mark");

  for (int k = 0; k < nsizes; k++) {
    80007348:	00027797          	auipc	a5,0x27
    8000734c:	d5878793          	addi	a5,a5,-680 # 8002e0a0 <nsizes>
    80007350:	0007ab03          	lw	s6,0(a5)
    80007354:	4981                	li	s3,0
  int n = p - (char *) bd_base;
    80007356:	00027d17          	auipc	s10,0x27
    8000735a:	d3ad0d13          	addi	s10,s10,-710 # 8002e090 <bd_base>
  return n / BLK_SIZE(k);
    8000735e:	4cc1                	li	s9,16
    bi = blk_index(k, start);
    bj = blk_index_next(k, stop);
    for(; bi < bj; bi++) {
      if(k > 0) {
        // if a block is allocated at size k, mark it as split too.
        bit_set(bd_sizes[k].split, bi);
    80007360:	00027a17          	auipc	s4,0x27
    80007364:	d38a0a13          	addi	s4,s4,-712 # 8002e098 <bd_sizes>
  for (int k = 0; k < nsizes; k++) {
    80007368:	07604563          	bgtz	s6,800073d2 <bd_mark+0xb6>
      }
      bit_set(bd_sizes[k].alloc, bi);
    }
  }
}
    8000736c:	60e6                	ld	ra,88(sp)
    8000736e:	6446                	ld	s0,80(sp)
    80007370:	64a6                	ld	s1,72(sp)
    80007372:	6906                	ld	s2,64(sp)
    80007374:	79e2                	ld	s3,56(sp)
    80007376:	7a42                	ld	s4,48(sp)
    80007378:	7aa2                	ld	s5,40(sp)
    8000737a:	7b02                	ld	s6,32(sp)
    8000737c:	6be2                	ld	s7,24(sp)
    8000737e:	6c42                	ld	s8,16(sp)
    80007380:	6ca2                	ld	s9,8(sp)
    80007382:	6d02                	ld	s10,0(sp)
    80007384:	6125                	addi	sp,sp,96
    80007386:	8082                	ret
    panic("bd_mark");
    80007388:	00002517          	auipc	a0,0x2
    8000738c:	aa850513          	addi	a0,a0,-1368 # 80008e30 <userret+0xda0>
    80007390:	ffff9097          	auipc	ra,0xffff9
    80007394:	436080e7          	jalr	1078(ra) # 800007c6 <panic>
      bit_set(bd_sizes[k].alloc, bi);
    80007398:	000a3783          	ld	a5,0(s4)
    8000739c:	97ca                	add	a5,a5,s2
    8000739e:	85a6                	mv	a1,s1
    800073a0:	6b88                	ld	a0,16(a5)
    800073a2:	00000097          	auipc	ra,0x0
    800073a6:	966080e7          	jalr	-1690(ra) # 80006d08 <bit_set>
    for(; bi < bj; bi++) {
    800073aa:	2485                	addiw	s1,s1,1
    800073ac:	009a8e63          	beq	s5,s1,800073c8 <bd_mark+0xac>
      if(k > 0) {
    800073b0:	ff3054e3          	blez	s3,80007398 <bd_mark+0x7c>
        bit_set(bd_sizes[k].split, bi);
    800073b4:	000a3783          	ld	a5,0(s4)
    800073b8:	97ca                	add	a5,a5,s2
    800073ba:	85a6                	mv	a1,s1
    800073bc:	6f88                	ld	a0,24(a5)
    800073be:	00000097          	auipc	ra,0x0
    800073c2:	94a080e7          	jalr	-1718(ra) # 80006d08 <bit_set>
    800073c6:	bfc9                	j	80007398 <bd_mark+0x7c>
  for (int k = 0; k < nsizes; k++) {
    800073c8:	2985                	addiw	s3,s3,1
    800073ca:	02090913          	addi	s2,s2,32
    800073ce:	f9698fe3          	beq	s3,s6,8000736c <bd_mark+0x50>
  int n = p - (char *) bd_base;
    800073d2:	000d3483          	ld	s1,0(s10)
  return n / BLK_SIZE(k);
    800073d6:	409b84bb          	subw	s1,s7,s1
    800073da:	013c97b3          	sll	a5,s9,s3
    800073de:	02f4c4b3          	div	s1,s1,a5
    800073e2:	2481                	sext.w	s1,s1
    bj = blk_index_next(k, stop);
    800073e4:	85e2                	mv	a1,s8
    800073e6:	854e                	mv	a0,s3
    800073e8:	00000097          	auipc	ra,0x0
    800073ec:	ee6080e7          	jalr	-282(ra) # 800072ce <blk_index_next>
    800073f0:	8aaa                	mv	s5,a0
    for(; bi < bj; bi++) {
    800073f2:	faa4cfe3          	blt	s1,a0,800073b0 <bd_mark+0x94>
    800073f6:	bfc9                	j	800073c8 <bd_mark+0xac>

00000000800073f8 <bd_initfree_pair>:

// If a block is marked as allocated and the buddy is free, put the
// buddy on the free list at size k.
int
bd_initfree_pair(int k, int bi) {
    800073f8:	7139                	addi	sp,sp,-64
    800073fa:	fc06                	sd	ra,56(sp)
    800073fc:	f822                	sd	s0,48(sp)
    800073fe:	f426                	sd	s1,40(sp)
    80007400:	f04a                	sd	s2,32(sp)
    80007402:	ec4e                	sd	s3,24(sp)
    80007404:	e852                	sd	s4,16(sp)
    80007406:	e456                	sd	s5,8(sp)
    80007408:	e05a                	sd	s6,0(sp)
    8000740a:	0080                	addi	s0,sp,64
    8000740c:	8b2a                	mv	s6,a0
  int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    8000740e:	00058a1b          	sext.w	s4,a1
    80007412:	001a7793          	andi	a5,s4,1
    80007416:	ebbd                	bnez	a5,8000748c <bd_initfree_pair+0x94>
    80007418:	00158a9b          	addiw	s5,a1,1
  int free = 0;
  if(bit_isset(bd_sizes[k].alloc, bi) !=  bit_isset(bd_sizes[k].alloc, buddy)) {
    8000741c:	005b1493          	slli	s1,s6,0x5
    80007420:	00027797          	auipc	a5,0x27
    80007424:	c7878793          	addi	a5,a5,-904 # 8002e098 <bd_sizes>
    80007428:	639c                	ld	a5,0(a5)
    8000742a:	94be                	add	s1,s1,a5
    8000742c:	0104b903          	ld	s2,16(s1)
    80007430:	854a                	mv	a0,s2
    80007432:	00000097          	auipc	ra,0x0
    80007436:	89e080e7          	jalr	-1890(ra) # 80006cd0 <bit_isset>
    8000743a:	89aa                	mv	s3,a0
    8000743c:	85d6                	mv	a1,s5
    8000743e:	854a                	mv	a0,s2
    80007440:	00000097          	auipc	ra,0x0
    80007444:	890080e7          	jalr	-1904(ra) # 80006cd0 <bit_isset>
  int free = 0;
    80007448:	4901                	li	s2,0
  if(bit_isset(bd_sizes[k].alloc, bi) !=  bit_isset(bd_sizes[k].alloc, buddy)) {
    8000744a:	02a98663          	beq	s3,a0,80007476 <bd_initfree_pair+0x7e>
    // one of the pair is free
    free = BLK_SIZE(k);
    8000744e:	45c1                	li	a1,16
    80007450:	016595b3          	sll	a1,a1,s6
    80007454:	0005891b          	sext.w	s2,a1
    if(bit_isset(bd_sizes[k].alloc, bi))
    80007458:	02098d63          	beqz	s3,80007492 <bd_initfree_pair+0x9a>
  return (char *) bd_base + n;
    8000745c:	035585bb          	mulw	a1,a1,s5
    80007460:	00027797          	auipc	a5,0x27
    80007464:	c3078793          	addi	a5,a5,-976 # 8002e090 <bd_base>
    80007468:	639c                	ld	a5,0(a5)
      lst_push(&bd_sizes[k].free, addr(k, buddy));   // put buddy on free list
    8000746a:	95be                	add	a1,a1,a5
    8000746c:	8526                	mv	a0,s1
    8000746e:	00000097          	auipc	ra,0x0
    80007472:	4a0080e7          	jalr	1184(ra) # 8000790e <lst_push>
    else
      lst_push(&bd_sizes[k].free, addr(k, bi));      // put bi on free list
  }
  return free;
}
    80007476:	854a                	mv	a0,s2
    80007478:	70e2                	ld	ra,56(sp)
    8000747a:	7442                	ld	s0,48(sp)
    8000747c:	74a2                	ld	s1,40(sp)
    8000747e:	7902                	ld	s2,32(sp)
    80007480:	69e2                	ld	s3,24(sp)
    80007482:	6a42                	ld	s4,16(sp)
    80007484:	6aa2                	ld	s5,8(sp)
    80007486:	6b02                	ld	s6,0(sp)
    80007488:	6121                	addi	sp,sp,64
    8000748a:	8082                	ret
  int buddy = (bi % 2 == 0) ? bi+1 : bi-1;
    8000748c:	fff58a9b          	addiw	s5,a1,-1
    80007490:	b771                	j	8000741c <bd_initfree_pair+0x24>
  return (char *) bd_base + n;
    80007492:	034585bb          	mulw	a1,a1,s4
    80007496:	00027797          	auipc	a5,0x27
    8000749a:	bfa78793          	addi	a5,a5,-1030 # 8002e090 <bd_base>
    8000749e:	639c                	ld	a5,0(a5)
      lst_push(&bd_sizes[k].free, addr(k, bi));      // put bi on free list
    800074a0:	95be                	add	a1,a1,a5
    800074a2:	8526                	mv	a0,s1
    800074a4:	00000097          	auipc	ra,0x0
    800074a8:	46a080e7          	jalr	1130(ra) # 8000790e <lst_push>
    800074ac:	b7e9                	j	80007476 <bd_initfree_pair+0x7e>

00000000800074ae <bd_initfree>:
  
// Initialize the free lists for each size k.  For each size k, there
// are only two pairs that may have a buddy that should be on free list:
// bd_left and bd_right.
int
bd_initfree(void *bd_left, void *bd_right) {
    800074ae:	711d                	addi	sp,sp,-96
    800074b0:	ec86                	sd	ra,88(sp)
    800074b2:	e8a2                	sd	s0,80(sp)
    800074b4:	e4a6                	sd	s1,72(sp)
    800074b6:	e0ca                	sd	s2,64(sp)
    800074b8:	fc4e                	sd	s3,56(sp)
    800074ba:	f852                	sd	s4,48(sp)
    800074bc:	f456                	sd	s5,40(sp)
    800074be:	f05a                	sd	s6,32(sp)
    800074c0:	ec5e                	sd	s7,24(sp)
    800074c2:	e862                	sd	s8,16(sp)
    800074c4:	e466                	sd	s9,8(sp)
    800074c6:	e06a                	sd	s10,0(sp)
    800074c8:	1080                	addi	s0,sp,96
  int free = 0;

  for (int k = 0; k < MAXSIZE; k++) {   // skip max size
    800074ca:	00027797          	auipc	a5,0x27
    800074ce:	bd678793          	addi	a5,a5,-1066 # 8002e0a0 <nsizes>
    800074d2:	4398                	lw	a4,0(a5)
    800074d4:	4785                	li	a5,1
    800074d6:	06e7db63          	ble	a4,a5,8000754c <bd_initfree+0x9e>
    800074da:	8b2e                	mv	s6,a1
    800074dc:	8aaa                	mv	s5,a0
    800074de:	4901                	li	s2,0
  int free = 0;
    800074e0:	4a01                	li	s4,0
  int n = p - (char *) bd_base;
    800074e2:	00027c97          	auipc	s9,0x27
    800074e6:	baec8c93          	addi	s9,s9,-1106 # 8002e090 <bd_base>
  return n / BLK_SIZE(k);
    800074ea:	4c41                	li	s8,16
  for (int k = 0; k < MAXSIZE; k++) {   // skip max size
    800074ec:	00027b97          	auipc	s7,0x27
    800074f0:	bb4b8b93          	addi	s7,s7,-1100 # 8002e0a0 <nsizes>
    800074f4:	a039                	j	80007502 <bd_initfree+0x54>
    800074f6:	2905                	addiw	s2,s2,1
    800074f8:	000ba783          	lw	a5,0(s7)
    800074fc:	37fd                	addiw	a5,a5,-1
    800074fe:	04f95863          	ble	a5,s2,8000754e <bd_initfree+0xa0>
    int left = blk_index_next(k, bd_left);
    80007502:	85d6                	mv	a1,s5
    80007504:	854a                	mv	a0,s2
    80007506:	00000097          	auipc	ra,0x0
    8000750a:	dc8080e7          	jalr	-568(ra) # 800072ce <blk_index_next>
    8000750e:	89aa                	mv	s3,a0
  int n = p - (char *) bd_base;
    80007510:	000cb483          	ld	s1,0(s9)
  return n / BLK_SIZE(k);
    80007514:	409b04bb          	subw	s1,s6,s1
    80007518:	012c17b3          	sll	a5,s8,s2
    8000751c:	02f4c4b3          	div	s1,s1,a5
    80007520:	2481                	sext.w	s1,s1
    int right = blk_index(k, bd_right);
    free += bd_initfree_pair(k, left);
    80007522:	85aa                	mv	a1,a0
    80007524:	854a                	mv	a0,s2
    80007526:	00000097          	auipc	ra,0x0
    8000752a:	ed2080e7          	jalr	-302(ra) # 800073f8 <bd_initfree_pair>
    8000752e:	01450d3b          	addw	s10,a0,s4
    80007532:	000d0a1b          	sext.w	s4,s10
    if(right <= left)
    80007536:	fc99d0e3          	ble	s1,s3,800074f6 <bd_initfree+0x48>
      continue;
    free += bd_initfree_pair(k, right);
    8000753a:	85a6                	mv	a1,s1
    8000753c:	854a                	mv	a0,s2
    8000753e:	00000097          	auipc	ra,0x0
    80007542:	eba080e7          	jalr	-326(ra) # 800073f8 <bd_initfree_pair>
    80007546:	00ad0a3b          	addw	s4,s10,a0
    8000754a:	b775                	j	800074f6 <bd_initfree+0x48>
  int free = 0;
    8000754c:	4a01                	li	s4,0
  }
  return free;
}
    8000754e:	8552                	mv	a0,s4
    80007550:	60e6                	ld	ra,88(sp)
    80007552:	6446                	ld	s0,80(sp)
    80007554:	64a6                	ld	s1,72(sp)
    80007556:	6906                	ld	s2,64(sp)
    80007558:	79e2                	ld	s3,56(sp)
    8000755a:	7a42                	ld	s4,48(sp)
    8000755c:	7aa2                	ld	s5,40(sp)
    8000755e:	7b02                	ld	s6,32(sp)
    80007560:	6be2                	ld	s7,24(sp)
    80007562:	6c42                	ld	s8,16(sp)
    80007564:	6ca2                	ld	s9,8(sp)
    80007566:	6d02                	ld	s10,0(sp)
    80007568:	6125                	addi	sp,sp,96
    8000756a:	8082                	ret

000000008000756c <bd_mark_data_structures>:

// Mark the range [bd_base,p) as allocated
int
bd_mark_data_structures(char *p) {
    8000756c:	7179                	addi	sp,sp,-48
    8000756e:	f406                	sd	ra,40(sp)
    80007570:	f022                	sd	s0,32(sp)
    80007572:	ec26                	sd	s1,24(sp)
    80007574:	e84a                	sd	s2,16(sp)
    80007576:	e44e                	sd	s3,8(sp)
    80007578:	1800                	addi	s0,sp,48
    8000757a:	89aa                	mv	s3,a0
  int meta = p - (char*)bd_base;
    8000757c:	00027917          	auipc	s2,0x27
    80007580:	b1490913          	addi	s2,s2,-1260 # 8002e090 <bd_base>
    80007584:	00093483          	ld	s1,0(s2)
    80007588:	409504bb          	subw	s1,a0,s1
  printf("bd: %d meta bytes for managing %d bytes of memory\n", meta, BLK_SIZE(MAXSIZE));
    8000758c:	00027797          	auipc	a5,0x27
    80007590:	b1478793          	addi	a5,a5,-1260 # 8002e0a0 <nsizes>
    80007594:	439c                	lw	a5,0(a5)
    80007596:	37fd                	addiw	a5,a5,-1
    80007598:	4641                	li	a2,16
    8000759a:	00f61633          	sll	a2,a2,a5
    8000759e:	85a6                	mv	a1,s1
    800075a0:	00002517          	auipc	a0,0x2
    800075a4:	89850513          	addi	a0,a0,-1896 # 80008e38 <userret+0xda8>
    800075a8:	ffff9097          	auipc	ra,0xffff9
    800075ac:	436080e7          	jalr	1078(ra) # 800009de <printf>
  bd_mark(bd_base, p);
    800075b0:	85ce                	mv	a1,s3
    800075b2:	00093503          	ld	a0,0(s2)
    800075b6:	00000097          	auipc	ra,0x0
    800075ba:	d66080e7          	jalr	-666(ra) # 8000731c <bd_mark>
  return meta;
}
    800075be:	8526                	mv	a0,s1
    800075c0:	70a2                	ld	ra,40(sp)
    800075c2:	7402                	ld	s0,32(sp)
    800075c4:	64e2                	ld	s1,24(sp)
    800075c6:	6942                	ld	s2,16(sp)
    800075c8:	69a2                	ld	s3,8(sp)
    800075ca:	6145                	addi	sp,sp,48
    800075cc:	8082                	ret

00000000800075ce <bd_mark_unavailable>:

// Mark the range [end, HEAPSIZE) as allocated
int
bd_mark_unavailable(void *end, void *left) {
    800075ce:	1101                	addi	sp,sp,-32
    800075d0:	ec06                	sd	ra,24(sp)
    800075d2:	e822                	sd	s0,16(sp)
    800075d4:	e426                	sd	s1,8(sp)
    800075d6:	1000                	addi	s0,sp,32
  int unavailable = BLK_SIZE(MAXSIZE)-(end-bd_base);
    800075d8:	00027797          	auipc	a5,0x27
    800075dc:	ac878793          	addi	a5,a5,-1336 # 8002e0a0 <nsizes>
    800075e0:	4384                	lw	s1,0(a5)
    800075e2:	fff4879b          	addiw	a5,s1,-1
    800075e6:	44c1                	li	s1,16
    800075e8:	00f494b3          	sll	s1,s1,a5
    800075ec:	00027797          	auipc	a5,0x27
    800075f0:	aa478793          	addi	a5,a5,-1372 # 8002e090 <bd_base>
    800075f4:	639c                	ld	a5,0(a5)
    800075f6:	8d1d                	sub	a0,a0,a5
    800075f8:	40a4853b          	subw	a0,s1,a0
    800075fc:	0005049b          	sext.w	s1,a0
  if(unavailable > 0)
    80007600:	00905a63          	blez	s1,80007614 <bd_mark_unavailable+0x46>
    unavailable = ROUNDUP(unavailable, LEAF_SIZE);
    80007604:	357d                	addiw	a0,a0,-1
    80007606:	41f5549b          	sraiw	s1,a0,0x1f
    8000760a:	01c4d49b          	srliw	s1,s1,0x1c
    8000760e:	9ca9                	addw	s1,s1,a0
    80007610:	98c1                	andi	s1,s1,-16
    80007612:	24c1                	addiw	s1,s1,16
  printf("bd: 0x%x bytes unavailable\n", unavailable);
    80007614:	85a6                	mv	a1,s1
    80007616:	00002517          	auipc	a0,0x2
    8000761a:	85a50513          	addi	a0,a0,-1958 # 80008e70 <userret+0xde0>
    8000761e:	ffff9097          	auipc	ra,0xffff9
    80007622:	3c0080e7          	jalr	960(ra) # 800009de <printf>

  void *bd_end = bd_base+BLK_SIZE(MAXSIZE)-unavailable;
    80007626:	00027797          	auipc	a5,0x27
    8000762a:	a6a78793          	addi	a5,a5,-1430 # 8002e090 <bd_base>
    8000762e:	6398                	ld	a4,0(a5)
    80007630:	00027797          	auipc	a5,0x27
    80007634:	a7078793          	addi	a5,a5,-1424 # 8002e0a0 <nsizes>
    80007638:	438c                	lw	a1,0(a5)
    8000763a:	fff5879b          	addiw	a5,a1,-1
    8000763e:	45c1                	li	a1,16
    80007640:	00f595b3          	sll	a1,a1,a5
    80007644:	40958533          	sub	a0,a1,s1
  bd_mark(bd_end, bd_base+BLK_SIZE(MAXSIZE));
    80007648:	95ba                	add	a1,a1,a4
    8000764a:	953a                	add	a0,a0,a4
    8000764c:	00000097          	auipc	ra,0x0
    80007650:	cd0080e7          	jalr	-816(ra) # 8000731c <bd_mark>
  return unavailable;
}
    80007654:	8526                	mv	a0,s1
    80007656:	60e2                	ld	ra,24(sp)
    80007658:	6442                	ld	s0,16(sp)
    8000765a:	64a2                	ld	s1,8(sp)
    8000765c:	6105                	addi	sp,sp,32
    8000765e:	8082                	ret

0000000080007660 <bd_init>:

// Initialize the buddy allocator: it manages memory from [base, end).
void
bd_init(void *base, void *end) {
    80007660:	715d                	addi	sp,sp,-80
    80007662:	e486                	sd	ra,72(sp)
    80007664:	e0a2                	sd	s0,64(sp)
    80007666:	fc26                	sd	s1,56(sp)
    80007668:	f84a                	sd	s2,48(sp)
    8000766a:	f44e                	sd	s3,40(sp)
    8000766c:	f052                	sd	s4,32(sp)
    8000766e:	ec56                	sd	s5,24(sp)
    80007670:	e85a                	sd	s6,16(sp)
    80007672:	e45e                	sd	s7,8(sp)
    80007674:	e062                	sd	s8,0(sp)
    80007676:	0880                	addi	s0,sp,80
    80007678:	8c2e                	mv	s8,a1
  char *p = (char *) ROUNDUP((uint64)base, LEAF_SIZE);
    8000767a:	fff50493          	addi	s1,a0,-1
    8000767e:	98c1                	andi	s1,s1,-16
    80007680:	04c1                	addi	s1,s1,16
  int sz;

  initlock(&lock, "buddy");
    80007682:	00002597          	auipc	a1,0x2
    80007686:	80e58593          	addi	a1,a1,-2034 # 80008e90 <userret+0xe00>
    8000768a:	00027517          	auipc	a0,0x27
    8000768e:	97650513          	addi	a0,a0,-1674 # 8002e000 <lock>
    80007692:	ffff9097          	auipc	ra,0xffff9
    80007696:	530080e7          	jalr	1328(ra) # 80000bc2 <initlock>
  bd_base = (void *) p;
    8000769a:	00027797          	auipc	a5,0x27
    8000769e:	9e97bb23          	sd	s1,-1546(a5) # 8002e090 <bd_base>

  // compute the number of sizes we need to manage [base, end)
  nsizes = log2(((char *)end-p)/LEAF_SIZE) + 1;
    800076a2:	409c0933          	sub	s2,s8,s1
    800076a6:	43f95513          	srai	a0,s2,0x3f
    800076aa:	893d                	andi	a0,a0,15
    800076ac:	954a                	add	a0,a0,s2
    800076ae:	8511                	srai	a0,a0,0x4
    800076b0:	00000097          	auipc	ra,0x0
    800076b4:	c4a080e7          	jalr	-950(ra) # 800072fa <log2>
  if((char*)end-p > BLK_SIZE(MAXSIZE)) {
    800076b8:	47c1                	li	a5,16
    800076ba:	00a797b3          	sll	a5,a5,a0
    800076be:	1b27c863          	blt	a5,s2,8000786e <bd_init+0x20e>
  nsizes = log2(((char *)end-p)/LEAF_SIZE) + 1;
    800076c2:	2505                	addiw	a0,a0,1
    800076c4:	00027797          	auipc	a5,0x27
    800076c8:	9ca7ae23          	sw	a0,-1572(a5) # 8002e0a0 <nsizes>
    nsizes++;  // round up to the next power of 2
  }

  printf("bd: memory sz is %d bytes; allocate an size array of length %d\n",
    800076cc:	00027997          	auipc	s3,0x27
    800076d0:	9d498993          	addi	s3,s3,-1580 # 8002e0a0 <nsizes>
    800076d4:	0009a603          	lw	a2,0(s3)
    800076d8:	85ca                	mv	a1,s2
    800076da:	00001517          	auipc	a0,0x1
    800076de:	7be50513          	addi	a0,a0,1982 # 80008e98 <userret+0xe08>
    800076e2:	ffff9097          	auipc	ra,0xffff9
    800076e6:	2fc080e7          	jalr	764(ra) # 800009de <printf>
         (char*) end - p, nsizes);

  // allocate bd_sizes array
  bd_sizes = (Sz_info *) p;
    800076ea:	00027797          	auipc	a5,0x27
    800076ee:	9a97b723          	sd	s1,-1618(a5) # 8002e098 <bd_sizes>
  p += sizeof(Sz_info) * nsizes;
    800076f2:	0009a603          	lw	a2,0(s3)
    800076f6:	00561913          	slli	s2,a2,0x5
    800076fa:	9926                	add	s2,s2,s1
  memset(bd_sizes, 0, sizeof(Sz_info) * nsizes);
    800076fc:	0056161b          	slliw	a2,a2,0x5
    80007700:	4581                	li	a1,0
    80007702:	8526                	mv	a0,s1
    80007704:	ffffa097          	auipc	ra,0xffffa
    80007708:	aa0080e7          	jalr	-1376(ra) # 800011a4 <memset>

  // initialize free list and allocate the alloc array for each size k
  for (int k = 0; k < nsizes; k++) {
    8000770c:	0009a783          	lw	a5,0(s3)
    80007710:	06f05a63          	blez	a5,80007784 <bd_init+0x124>
    80007714:	4981                	li	s3,0
    lst_init(&bd_sizes[k].free);
    80007716:	00027a97          	auipc	s5,0x27
    8000771a:	982a8a93          	addi	s5,s5,-1662 # 8002e098 <bd_sizes>
    sz = sizeof(char)* ROUNDUP(NBLK(k), 8)/8;
    8000771e:	00027a17          	auipc	s4,0x27
    80007722:	982a0a13          	addi	s4,s4,-1662 # 8002e0a0 <nsizes>
    80007726:	4b05                	li	s6,1
    lst_init(&bd_sizes[k].free);
    80007728:	00599b93          	slli	s7,s3,0x5
    8000772c:	000ab503          	ld	a0,0(s5)
    80007730:	955e                	add	a0,a0,s7
    80007732:	00000097          	auipc	ra,0x0
    80007736:	16a080e7          	jalr	362(ra) # 8000789c <lst_init>
    sz = sizeof(char)* ROUNDUP(NBLK(k), 8)/8;
    8000773a:	000a2483          	lw	s1,0(s4)
    8000773e:	34fd                	addiw	s1,s1,-1
    80007740:	413484bb          	subw	s1,s1,s3
    80007744:	009b14bb          	sllw	s1,s6,s1
    80007748:	fff4879b          	addiw	a5,s1,-1
    8000774c:	41f7d49b          	sraiw	s1,a5,0x1f
    80007750:	01d4d49b          	srliw	s1,s1,0x1d
    80007754:	9cbd                	addw	s1,s1,a5
    80007756:	98e1                	andi	s1,s1,-8
    80007758:	24a1                	addiw	s1,s1,8
    bd_sizes[k].alloc = p;
    8000775a:	000ab783          	ld	a5,0(s5)
    8000775e:	9bbe                	add	s7,s7,a5
    80007760:	012bb823          	sd	s2,16(s7)
    memset(bd_sizes[k].alloc, 0, sz);
    80007764:	848d                	srai	s1,s1,0x3
    80007766:	8626                	mv	a2,s1
    80007768:	4581                	li	a1,0
    8000776a:	854a                	mv	a0,s2
    8000776c:	ffffa097          	auipc	ra,0xffffa
    80007770:	a38080e7          	jalr	-1480(ra) # 800011a4 <memset>
    p += sz;
    80007774:	9926                	add	s2,s2,s1
  for (int k = 0; k < nsizes; k++) {
    80007776:	0985                	addi	s3,s3,1
    80007778:	000a2703          	lw	a4,0(s4)
    8000777c:	0009879b          	sext.w	a5,s3
    80007780:	fae7c4e3          	blt	a5,a4,80007728 <bd_init+0xc8>
  }

  // allocate the split array for each size k, except for k = 0, since
  // we will not split blocks of size k = 0, the smallest size.
  for (int k = 1; k < nsizes; k++) {
    80007784:	00027797          	auipc	a5,0x27
    80007788:	91c78793          	addi	a5,a5,-1764 # 8002e0a0 <nsizes>
    8000778c:	439c                	lw	a5,0(a5)
    8000778e:	4705                	li	a4,1
    80007790:	06f75163          	ble	a5,a4,800077f2 <bd_init+0x192>
    80007794:	02000a13          	li	s4,32
    80007798:	4985                	li	s3,1
    sz = sizeof(char)* (ROUNDUP(NBLK(k), 8))/8;
    8000779a:	4b85                	li	s7,1
    bd_sizes[k].split = p;
    8000779c:	00027b17          	auipc	s6,0x27
    800077a0:	8fcb0b13          	addi	s6,s6,-1796 # 8002e098 <bd_sizes>
  for (int k = 1; k < nsizes; k++) {
    800077a4:	00027a97          	auipc	s5,0x27
    800077a8:	8fca8a93          	addi	s5,s5,-1796 # 8002e0a0 <nsizes>
    sz = sizeof(char)* (ROUNDUP(NBLK(k), 8))/8;
    800077ac:	37fd                	addiw	a5,a5,-1
    800077ae:	413787bb          	subw	a5,a5,s3
    800077b2:	00fb94bb          	sllw	s1,s7,a5
    800077b6:	fff4879b          	addiw	a5,s1,-1
    800077ba:	41f7d49b          	sraiw	s1,a5,0x1f
    800077be:	01d4d49b          	srliw	s1,s1,0x1d
    800077c2:	9cbd                	addw	s1,s1,a5
    800077c4:	98e1                	andi	s1,s1,-8
    800077c6:	24a1                	addiw	s1,s1,8
    bd_sizes[k].split = p;
    800077c8:	000b3783          	ld	a5,0(s6)
    800077cc:	97d2                	add	a5,a5,s4
    800077ce:	0127bc23          	sd	s2,24(a5)
    memset(bd_sizes[k].split, 0, sz);
    800077d2:	848d                	srai	s1,s1,0x3
    800077d4:	8626                	mv	a2,s1
    800077d6:	4581                	li	a1,0
    800077d8:	854a                	mv	a0,s2
    800077da:	ffffa097          	auipc	ra,0xffffa
    800077de:	9ca080e7          	jalr	-1590(ra) # 800011a4 <memset>
    p += sz;
    800077e2:	9926                	add	s2,s2,s1
  for (int k = 1; k < nsizes; k++) {
    800077e4:	2985                	addiw	s3,s3,1
    800077e6:	000aa783          	lw	a5,0(s5)
    800077ea:	020a0a13          	addi	s4,s4,32
    800077ee:	faf9cfe3          	blt	s3,a5,800077ac <bd_init+0x14c>
  }
  p = (char *) ROUNDUP((uint64) p, LEAF_SIZE);
    800077f2:	197d                	addi	s2,s2,-1
    800077f4:	ff097913          	andi	s2,s2,-16
    800077f8:	0941                	addi	s2,s2,16

  // done allocating; mark the memory range [base, p) as allocated, so
  // that buddy will not hand out that memory.
  int meta = bd_mark_data_structures(p);
    800077fa:	854a                	mv	a0,s2
    800077fc:	00000097          	auipc	ra,0x0
    80007800:	d70080e7          	jalr	-656(ra) # 8000756c <bd_mark_data_structures>
    80007804:	8a2a                	mv	s4,a0
  
  // mark the unavailable memory range [end, HEAP_SIZE) as allocated,
  // so that buddy will not hand out that memory.
  int unavailable = bd_mark_unavailable(end, p);
    80007806:	85ca                	mv	a1,s2
    80007808:	8562                	mv	a0,s8
    8000780a:	00000097          	auipc	ra,0x0
    8000780e:	dc4080e7          	jalr	-572(ra) # 800075ce <bd_mark_unavailable>
    80007812:	89aa                	mv	s3,a0
  void *bd_end = bd_base+BLK_SIZE(MAXSIZE)-unavailable;
    80007814:	00027a97          	auipc	s5,0x27
    80007818:	88ca8a93          	addi	s5,s5,-1908 # 8002e0a0 <nsizes>
    8000781c:	000aa783          	lw	a5,0(s5)
    80007820:	37fd                	addiw	a5,a5,-1
    80007822:	44c1                	li	s1,16
    80007824:	00f497b3          	sll	a5,s1,a5
    80007828:	8f89                	sub	a5,a5,a0
    8000782a:	00027717          	auipc	a4,0x27
    8000782e:	86670713          	addi	a4,a4,-1946 # 8002e090 <bd_base>
    80007832:	630c                	ld	a1,0(a4)
  
  // initialize free lists for each size k
  int free = bd_initfree(p, bd_end);
    80007834:	95be                	add	a1,a1,a5
    80007836:	854a                	mv	a0,s2
    80007838:	00000097          	auipc	ra,0x0
    8000783c:	c76080e7          	jalr	-906(ra) # 800074ae <bd_initfree>

  // check if the amount that is free is what we expect
  if(free != BLK_SIZE(MAXSIZE)-meta-unavailable) {
    80007840:	000aa603          	lw	a2,0(s5)
    80007844:	367d                	addiw	a2,a2,-1
    80007846:	00c49633          	sll	a2,s1,a2
    8000784a:	41460633          	sub	a2,a2,s4
    8000784e:	41360633          	sub	a2,a2,s3
    80007852:	02c51463          	bne	a0,a2,8000787a <bd_init+0x21a>
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE)-meta-unavailable);
    panic("bd_init: free mem");
  }
}
    80007856:	60a6                	ld	ra,72(sp)
    80007858:	6406                	ld	s0,64(sp)
    8000785a:	74e2                	ld	s1,56(sp)
    8000785c:	7942                	ld	s2,48(sp)
    8000785e:	79a2                	ld	s3,40(sp)
    80007860:	7a02                	ld	s4,32(sp)
    80007862:	6ae2                	ld	s5,24(sp)
    80007864:	6b42                	ld	s6,16(sp)
    80007866:	6ba2                	ld	s7,8(sp)
    80007868:	6c02                	ld	s8,0(sp)
    8000786a:	6161                	addi	sp,sp,80
    8000786c:	8082                	ret
    nsizes++;  // round up to the next power of 2
    8000786e:	2509                	addiw	a0,a0,2
    80007870:	00027797          	auipc	a5,0x27
    80007874:	82a7a823          	sw	a0,-2000(a5) # 8002e0a0 <nsizes>
    80007878:	bd91                	j	800076cc <bd_init+0x6c>
    printf("free %d %d\n", free, BLK_SIZE(MAXSIZE)-meta-unavailable);
    8000787a:	85aa                	mv	a1,a0
    8000787c:	00001517          	auipc	a0,0x1
    80007880:	65c50513          	addi	a0,a0,1628 # 80008ed8 <userret+0xe48>
    80007884:	ffff9097          	auipc	ra,0xffff9
    80007888:	15a080e7          	jalr	346(ra) # 800009de <printf>
    panic("bd_init: free mem");
    8000788c:	00001517          	auipc	a0,0x1
    80007890:	65c50513          	addi	a0,a0,1628 # 80008ee8 <userret+0xe58>
    80007894:	ffff9097          	auipc	ra,0xffff9
    80007898:	f32080e7          	jalr	-206(ra) # 800007c6 <panic>

000000008000789c <lst_init>:
// fast. circular simplifies code, because don't have to check for
// empty list in insert and remove.

void
lst_init(struct list *lst)
{
    8000789c:	1141                	addi	sp,sp,-16
    8000789e:	e422                	sd	s0,8(sp)
    800078a0:	0800                	addi	s0,sp,16
  lst->next = lst;
    800078a2:	e108                	sd	a0,0(a0)
  lst->prev = lst;
    800078a4:	e508                	sd	a0,8(a0)
}
    800078a6:	6422                	ld	s0,8(sp)
    800078a8:	0141                	addi	sp,sp,16
    800078aa:	8082                	ret

00000000800078ac <lst_empty>:

int
lst_empty(struct list *lst) {
    800078ac:	1141                	addi	sp,sp,-16
    800078ae:	e422                	sd	s0,8(sp)
    800078b0:	0800                	addi	s0,sp,16
  return lst->next == lst;
    800078b2:	611c                	ld	a5,0(a0)
    800078b4:	40a78533          	sub	a0,a5,a0
}
    800078b8:	00153513          	seqz	a0,a0
    800078bc:	6422                	ld	s0,8(sp)
    800078be:	0141                	addi	sp,sp,16
    800078c0:	8082                	ret

00000000800078c2 <lst_remove>:

void
lst_remove(struct list *e) {
    800078c2:	1141                	addi	sp,sp,-16
    800078c4:	e422                	sd	s0,8(sp)
    800078c6:	0800                	addi	s0,sp,16
  e->prev->next = e->next;
    800078c8:	6518                	ld	a4,8(a0)
    800078ca:	611c                	ld	a5,0(a0)
    800078cc:	e31c                	sd	a5,0(a4)
  e->next->prev = e->prev;
    800078ce:	6518                	ld	a4,8(a0)
    800078d0:	e798                	sd	a4,8(a5)
}
    800078d2:	6422                	ld	s0,8(sp)
    800078d4:	0141                	addi	sp,sp,16
    800078d6:	8082                	ret

00000000800078d8 <lst_pop>:

void*
lst_pop(struct list *lst) {
    800078d8:	1101                	addi	sp,sp,-32
    800078da:	ec06                	sd	ra,24(sp)
    800078dc:	e822                	sd	s0,16(sp)
    800078de:	e426                	sd	s1,8(sp)
    800078e0:	1000                	addi	s0,sp,32
  if(lst->next == lst)
    800078e2:	6104                	ld	s1,0(a0)
    800078e4:	00a48d63          	beq	s1,a0,800078fe <lst_pop+0x26>
    panic("lst_pop");
  struct list *p = lst->next;
  lst_remove(p);
    800078e8:	8526                	mv	a0,s1
    800078ea:	00000097          	auipc	ra,0x0
    800078ee:	fd8080e7          	jalr	-40(ra) # 800078c2 <lst_remove>
  return (void *)p;
}
    800078f2:	8526                	mv	a0,s1
    800078f4:	60e2                	ld	ra,24(sp)
    800078f6:	6442                	ld	s0,16(sp)
    800078f8:	64a2                	ld	s1,8(sp)
    800078fa:	6105                	addi	sp,sp,32
    800078fc:	8082                	ret
    panic("lst_pop");
    800078fe:	00001517          	auipc	a0,0x1
    80007902:	60250513          	addi	a0,a0,1538 # 80008f00 <userret+0xe70>
    80007906:	ffff9097          	auipc	ra,0xffff9
    8000790a:	ec0080e7          	jalr	-320(ra) # 800007c6 <panic>

000000008000790e <lst_push>:

void
lst_push(struct list *lst, void *p)
{
    8000790e:	1141                	addi	sp,sp,-16
    80007910:	e422                	sd	s0,8(sp)
    80007912:	0800                	addi	s0,sp,16
  struct list *e = (struct list *) p;
  e->next = lst->next;
    80007914:	611c                	ld	a5,0(a0)
    80007916:	e19c                	sd	a5,0(a1)
  e->prev = lst;
    80007918:	e588                	sd	a0,8(a1)
  lst->next->prev = p;
    8000791a:	611c                	ld	a5,0(a0)
    8000791c:	e78c                	sd	a1,8(a5)
  lst->next = e;
    8000791e:	e10c                	sd	a1,0(a0)
}
    80007920:	6422                	ld	s0,8(sp)
    80007922:	0141                	addi	sp,sp,16
    80007924:	8082                	ret

0000000080007926 <lst_print>:

void
lst_print(struct list *lst)
{
    80007926:	7179                	addi	sp,sp,-48
    80007928:	f406                	sd	ra,40(sp)
    8000792a:	f022                	sd	s0,32(sp)
    8000792c:	ec26                	sd	s1,24(sp)
    8000792e:	e84a                	sd	s2,16(sp)
    80007930:	e44e                	sd	s3,8(sp)
    80007932:	1800                	addi	s0,sp,48
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80007934:	6104                	ld	s1,0(a0)
    80007936:	02950063          	beq	a0,s1,80007956 <lst_print+0x30>
    8000793a:	892a                	mv	s2,a0
    printf(" %p", p);
    8000793c:	00001997          	auipc	s3,0x1
    80007940:	5cc98993          	addi	s3,s3,1484 # 80008f08 <userret+0xe78>
    80007944:	85a6                	mv	a1,s1
    80007946:	854e                	mv	a0,s3
    80007948:	ffff9097          	auipc	ra,0xffff9
    8000794c:	096080e7          	jalr	150(ra) # 800009de <printf>
  for (struct list *p = lst->next; p != lst; p = p->next) {
    80007950:	6084                	ld	s1,0(s1)
    80007952:	fe9919e3          	bne	s2,s1,80007944 <lst_print+0x1e>
  }
  printf("\n");
    80007956:	00001517          	auipc	a0,0x1
    8000795a:	d1250513          	addi	a0,a0,-750 # 80008668 <userret+0x5d8>
    8000795e:	ffff9097          	auipc	ra,0xffff9
    80007962:	080080e7          	jalr	128(ra) # 800009de <printf>
}
    80007966:	70a2                	ld	ra,40(sp)
    80007968:	7402                	ld	s0,32(sp)
    8000796a:	64e2                	ld	s1,24(sp)
    8000796c:	6942                	ld	s2,16(sp)
    8000796e:	69a2                	ld	s3,8(sp)
    80007970:	6145                	addi	sp,sp,48
    80007972:	8082                	ret

0000000080007974 <watchdogwrite>:
int watchdog_time;
struct spinlock watchdog_lock;

int
watchdogwrite(struct file *f, int user_src, uint64 src, int n)
{
    80007974:	715d                	addi	sp,sp,-80
    80007976:	e486                	sd	ra,72(sp)
    80007978:	e0a2                	sd	s0,64(sp)
    8000797a:	fc26                	sd	s1,56(sp)
    8000797c:	f84a                	sd	s2,48(sp)
    8000797e:	f44e                	sd	s3,40(sp)
    80007980:	f052                	sd	s4,32(sp)
    80007982:	ec56                	sd	s5,24(sp)
    80007984:	0880                	addi	s0,sp,80
    80007986:	8a2e                	mv	s4,a1
    80007988:	84b2                	mv	s1,a2
    8000798a:	89b6                	mv	s3,a3
  acquire(&watchdog_lock);
    8000798c:	00026517          	auipc	a0,0x26
    80007990:	6a450513          	addi	a0,a0,1700 # 8002e030 <watchdog_lock>
    80007994:	ffff9097          	auipc	ra,0xffff9
    80007998:	39c080e7          	jalr	924(ra) # 80000d30 <acquire>

  int time = 0;
  for(int i = 0; i < n; i++){
    8000799c:	09305e63          	blez	s3,80007a38 <watchdogwrite+0xc4>
    800079a0:	00148913          	addi	s2,s1,1
    800079a4:	39fd                	addiw	s3,s3,-1
    800079a6:	1982                	slli	s3,s3,0x20
    800079a8:	0209d993          	srli	s3,s3,0x20
    800079ac:	994e                	add	s2,s2,s3
  int time = 0;
    800079ae:	4981                	li	s3,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800079b0:	5afd                	li	s5,-1
    800079b2:	4685                	li	a3,1
    800079b4:	8626                	mv	a2,s1
    800079b6:	85d2                	mv	a1,s4
    800079b8:	fbf40513          	addi	a0,s0,-65
    800079bc:	ffffb097          	auipc	ra,0xffffb
    800079c0:	0f0080e7          	jalr	240(ra) # 80002aac <either_copyin>
    800079c4:	01550763          	beq	a0,s5,800079d2 <watchdogwrite+0x5e>
      break;
    time = c;
    800079c8:	fbf44983          	lbu	s3,-65(s0)
  for(int i = 0; i < n; i++){
    800079cc:	0485                	addi	s1,s1,1
    800079ce:	ff2492e3          	bne	s1,s2,800079b2 <watchdogwrite+0x3e>
  }

  acquire(&tickslock);
    800079d2:	00014517          	auipc	a0,0x14
    800079d6:	6c650513          	addi	a0,a0,1734 # 8001c098 <tickslock>
    800079da:	ffff9097          	auipc	ra,0xffff9
    800079de:	356080e7          	jalr	854(ra) # 80000d30 <acquire>
  n = ticks - watchdog_value;
    800079e2:	00026797          	auipc	a5,0x26
    800079e6:	6a678793          	addi	a5,a5,1702 # 8002e088 <ticks>
    800079ea:	4398                	lw	a4,0(a5)
    800079ec:	00026797          	auipc	a5,0x26
    800079f0:	6bc78793          	addi	a5,a5,1724 # 8002e0a8 <watchdog_value>
    800079f4:	4384                	lw	s1,0(a5)
    800079f6:	409704bb          	subw	s1,a4,s1
  watchdog_value = ticks;
    800079fa:	c398                	sw	a4,0(a5)
  watchdog_time = time;
    800079fc:	00026797          	auipc	a5,0x26
    80007a00:	6b37a423          	sw	s3,1704(a5) # 8002e0a4 <watchdog_time>
  release(&tickslock);
    80007a04:	00014517          	auipc	a0,0x14
    80007a08:	69450513          	addi	a0,a0,1684 # 8001c098 <tickslock>
    80007a0c:	ffff9097          	auipc	ra,0xffff9
    80007a10:	570080e7          	jalr	1392(ra) # 80000f7c <release>

  release(&watchdog_lock);
    80007a14:	00026517          	auipc	a0,0x26
    80007a18:	61c50513          	addi	a0,a0,1564 # 8002e030 <watchdog_lock>
    80007a1c:	ffff9097          	auipc	ra,0xffff9
    80007a20:	560080e7          	jalr	1376(ra) # 80000f7c <release>
  return n;
}
    80007a24:	8526                	mv	a0,s1
    80007a26:	60a6                	ld	ra,72(sp)
    80007a28:	6406                	ld	s0,64(sp)
    80007a2a:	74e2                	ld	s1,56(sp)
    80007a2c:	7942                	ld	s2,48(sp)
    80007a2e:	79a2                	ld	s3,40(sp)
    80007a30:	7a02                	ld	s4,32(sp)
    80007a32:	6ae2                	ld	s5,24(sp)
    80007a34:	6161                	addi	sp,sp,80
    80007a36:	8082                	ret
  int time = 0;
    80007a38:	4981                	li	s3,0
    80007a3a:	bf61                	j	800079d2 <watchdogwrite+0x5e>

0000000080007a3c <watchdoginit>:

void watchdoginit(){
    80007a3c:	1141                	addi	sp,sp,-16
    80007a3e:	e406                	sd	ra,8(sp)
    80007a40:	e022                	sd	s0,0(sp)
    80007a42:	0800                	addi	s0,sp,16
  initlock(&watchdog_lock, "watchdog_lock");
    80007a44:	00001597          	auipc	a1,0x1
    80007a48:	4cc58593          	addi	a1,a1,1228 # 80008f10 <userret+0xe80>
    80007a4c:	00026517          	auipc	a0,0x26
    80007a50:	5e450513          	addi	a0,a0,1508 # 8002e030 <watchdog_lock>
    80007a54:	ffff9097          	auipc	ra,0xffff9
    80007a58:	16e080e7          	jalr	366(ra) # 80000bc2 <initlock>
  watchdog_time = 0;
    80007a5c:	00026797          	auipc	a5,0x26
    80007a60:	6407a423          	sw	zero,1608(a5) # 8002e0a4 <watchdog_time>


  devsw[WATCHDOG].read = 0;
    80007a64:	0001f797          	auipc	a5,0x1f
    80007a68:	13478793          	addi	a5,a5,308 # 80026b98 <devsw>
    80007a6c:	0207b023          	sd	zero,32(a5)
  devsw[WATCHDOG].write = watchdogwrite;
    80007a70:	00000717          	auipc	a4,0x0
    80007a74:	f0470713          	addi	a4,a4,-252 # 80007974 <watchdogwrite>
    80007a78:	f798                	sd	a4,40(a5)
}
    80007a7a:	60a2                	ld	ra,8(sp)
    80007a7c:	6402                	ld	s0,0(sp)
    80007a7e:	0141                	addi	sp,sp,16
    80007a80:	8082                	ret
	...

0000000080008000 <trampoline>:
    80008000:	14051573          	csrrw	a0,sscratch,a0
    80008004:	02153423          	sd	ra,40(a0)
    80008008:	02253823          	sd	sp,48(a0)
    8000800c:	02353c23          	sd	gp,56(a0)
    80008010:	04453023          	sd	tp,64(a0)
    80008014:	04553423          	sd	t0,72(a0)
    80008018:	04653823          	sd	t1,80(a0)
    8000801c:	04753c23          	sd	t2,88(a0)
    80008020:	f120                	sd	s0,96(a0)
    80008022:	f524                	sd	s1,104(a0)
    80008024:	fd2c                	sd	a1,120(a0)
    80008026:	e150                	sd	a2,128(a0)
    80008028:	e554                	sd	a3,136(a0)
    8000802a:	e958                	sd	a4,144(a0)
    8000802c:	ed5c                	sd	a5,152(a0)
    8000802e:	0b053023          	sd	a6,160(a0)
    80008032:	0b153423          	sd	a7,168(a0)
    80008036:	0b253823          	sd	s2,176(a0)
    8000803a:	0b353c23          	sd	s3,184(a0)
    8000803e:	0d453023          	sd	s4,192(a0)
    80008042:	0d553423          	sd	s5,200(a0)
    80008046:	0d653823          	sd	s6,208(a0)
    8000804a:	0d753c23          	sd	s7,216(a0)
    8000804e:	0f853023          	sd	s8,224(a0)
    80008052:	0f953423          	sd	s9,232(a0)
    80008056:	0fa53823          	sd	s10,240(a0)
    8000805a:	0fb53c23          	sd	s11,248(a0)
    8000805e:	11c53023          	sd	t3,256(a0)
    80008062:	11d53423          	sd	t4,264(a0)
    80008066:	11e53823          	sd	t5,272(a0)
    8000806a:	11f53c23          	sd	t6,280(a0)
    8000806e:	140022f3          	csrr	t0,sscratch
    80008072:	06553823          	sd	t0,112(a0)
    80008076:	00853103          	ld	sp,8(a0)
    8000807a:	02053203          	ld	tp,32(a0)
    8000807e:	01053283          	ld	t0,16(a0)
    80008082:	00053303          	ld	t1,0(a0)
    80008086:	18031073          	csrw	satp,t1
    8000808a:	12000073          	sfence.vma
    8000808e:	8282                	jr	t0

0000000080008090 <userret>:
    80008090:	18059073          	csrw	satp,a1
    80008094:	12000073          	sfence.vma
    80008098:	07053283          	ld	t0,112(a0)
    8000809c:	14029073          	csrw	sscratch,t0
    800080a0:	02853083          	ld	ra,40(a0)
    800080a4:	03053103          	ld	sp,48(a0)
    800080a8:	03853183          	ld	gp,56(a0)
    800080ac:	04053203          	ld	tp,64(a0)
    800080b0:	04853283          	ld	t0,72(a0)
    800080b4:	05053303          	ld	t1,80(a0)
    800080b8:	05853383          	ld	t2,88(a0)
    800080bc:	7120                	ld	s0,96(a0)
    800080be:	7524                	ld	s1,104(a0)
    800080c0:	7d2c                	ld	a1,120(a0)
    800080c2:	6150                	ld	a2,128(a0)
    800080c4:	6554                	ld	a3,136(a0)
    800080c6:	6958                	ld	a4,144(a0)
    800080c8:	6d5c                	ld	a5,152(a0)
    800080ca:	0a053803          	ld	a6,160(a0)
    800080ce:	0a853883          	ld	a7,168(a0)
    800080d2:	0b053903          	ld	s2,176(a0)
    800080d6:	0b853983          	ld	s3,184(a0)
    800080da:	0c053a03          	ld	s4,192(a0)
    800080de:	0c853a83          	ld	s5,200(a0)
    800080e2:	0d053b03          	ld	s6,208(a0)
    800080e6:	0d853b83          	ld	s7,216(a0)
    800080ea:	0e053c03          	ld	s8,224(a0)
    800080ee:	0e853c83          	ld	s9,232(a0)
    800080f2:	0f053d03          	ld	s10,240(a0)
    800080f6:	0f853d83          	ld	s11,248(a0)
    800080fa:	10053e03          	ld	t3,256(a0)
    800080fe:	10853e83          	ld	t4,264(a0)
    80008102:	11053f03          	ld	t5,272(a0)
    80008106:	11853f83          	ld	t6,280(a0)
    8000810a:	14051573          	csrrw	a0,sscratch,a0
    8000810e:	10200073          	sret
