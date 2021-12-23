
user/_print:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	8a2e                	mv	s4,a1
  if(argc < 2){
  12:	4785                	li	a5,1
    printf("print: not enough arguments\n");
    exit(1);
  }
  int i = 0;
  14:	4481                	li	s1,0
  while (1){
    printf("%s %d\n", argv[1], i);
  16:	00001997          	auipc	s3,0x1
  1a:	98298993          	addi	s3,s3,-1662 # 998 <malloc+0x10a>
  1e:	00800937          	lui	s2,0x800
  if(argc < 2){
  22:	02a7c063          	blt	a5,a0,42 <main+0x42>
    printf("print: not enough arguments\n");
  26:	00001517          	auipc	a0,0x1
  2a:	95250513          	addi	a0,a0,-1710 # 978 <malloc+0xea>
  2e:	00000097          	auipc	ra,0x0
  32:	7a0080e7          	jalr	1952(ra) # 7ce <printf>
    exit(1);
  36:	4505                	li	a0,1
  38:	00000097          	auipc	ra,0x0
  3c:	300080e7          	jalr	768(ra) # 338 <exit>
    for(int j = 0; j < (1 << 23); j++);
    i++;
  40:	2485                	addiw	s1,s1,1
    printf("%s %d\n", argv[1], i);
  42:	8626                	mv	a2,s1
  44:	008a3583          	ld	a1,8(s4)
  48:	854e                	mv	a0,s3
  4a:	00000097          	auipc	ra,0x0
  4e:	784080e7          	jalr	1924(ra) # 7ce <printf>
  52:	87ca                	mv	a5,s2
    for(int j = 0; j < (1 << 23); j++);
  54:	37fd                	addiw	a5,a5,-1
  56:	fffd                	bnez	a5,54 <main+0x54>
  58:	b7e5                	j	40 <main+0x40>

000000000000005a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e422                	sd	s0,8(sp)
  5e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  60:	87aa                	mv	a5,a0
  62:	0585                	addi	a1,a1,1
  64:	0785                	addi	a5,a5,1
  66:	fff5c703          	lbu	a4,-1(a1)
  6a:	fee78fa3          	sb	a4,-1(a5)
  6e:	fb75                	bnez	a4,62 <strcpy+0x8>
    ;
  return os;
}
  70:	6422                	ld	s0,8(sp)
  72:	0141                	addi	sp,sp,16
  74:	8082                	ret

0000000000000076 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7c:	00054783          	lbu	a5,0(a0)
  80:	cf91                	beqz	a5,9c <strcmp+0x26>
  82:	0005c703          	lbu	a4,0(a1)
  86:	00f71b63          	bne	a4,a5,9c <strcmp+0x26>
    p++, q++;
  8a:	0505                	addi	a0,a0,1
  8c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	c789                	beqz	a5,9c <strcmp+0x26>
  94:	0005c703          	lbu	a4,0(a1)
  98:	fef709e3          	beq	a4,a5,8a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  9c:	0005c503          	lbu	a0,0(a1)
}
  a0:	40a7853b          	subw	a0,a5,a0
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strlen>:

uint
strlen(const char *s)
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cf91                	beqz	a5,d0 <strlen+0x26>
  b6:	0505                	addi	a0,a0,1
  b8:	87aa                	mv	a5,a0
  ba:	4685                	li	a3,1
  bc:	9e89                	subw	a3,a3,a0
  be:	00f6853b          	addw	a0,a3,a5
  c2:	0785                	addi	a5,a5,1
  c4:	fff7c703          	lbu	a4,-1(a5)
  c8:	fb7d                	bnez	a4,be <strlen+0x14>
    ;
  return n;
}
  ca:	6422                	ld	s0,8(sp)
  cc:	0141                	addi	sp,sp,16
  ce:	8082                	ret
  for(n = 0; s[n]; n++)
  d0:	4501                	li	a0,0
  d2:	bfe5                	j	ca <strlen+0x20>

00000000000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  da:	ce09                	beqz	a2,f4 <memset+0x20>
  dc:	87aa                	mv	a5,a0
  de:	fff6071b          	addiw	a4,a2,-1
  e2:	1702                	slli	a4,a4,0x20
  e4:	9301                	srli	a4,a4,0x20
  e6:	0705                	addi	a4,a4,1
  e8:	972a                	add	a4,a4,a0
    cdst[i] = c;
  ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ee:	0785                	addi	a5,a5,1
  f0:	fee79de3          	bne	a5,a4,ea <memset+0x16>
  }
  return dst;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strchr>:

char*
strchr(const char *s, char c)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cf91                	beqz	a5,120 <strchr+0x26>
    if(*s == c)
 106:	00f58a63          	beq	a1,a5,11a <strchr+0x20>
  for(; *s; s++)
 10a:	0505                	addi	a0,a0,1
 10c:	00054783          	lbu	a5,0(a0)
 110:	c781                	beqz	a5,118 <strchr+0x1e>
    if(*s == c)
 112:	feb79ce3          	bne	a5,a1,10a <strchr+0x10>
 116:	a011                	j	11a <strchr+0x20>
      return (char*)s;
  return 0;
 118:	4501                	li	a0,0
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret
  return 0;
 120:	4501                	li	a0,0
 122:	bfe5                	j	11a <strchr+0x20>

0000000000000124 <gets>:

char*
gets(char *buf, int max)
{
 124:	711d                	addi	sp,sp,-96
 126:	ec86                	sd	ra,88(sp)
 128:	e8a2                	sd	s0,80(sp)
 12a:	e4a6                	sd	s1,72(sp)
 12c:	e0ca                	sd	s2,64(sp)
 12e:	fc4e                	sd	s3,56(sp)
 130:	f852                	sd	s4,48(sp)
 132:	f456                	sd	s5,40(sp)
 134:	f05a                	sd	s6,32(sp)
 136:	ec5e                	sd	s7,24(sp)
 138:	1080                	addi	s0,sp,96
 13a:	8baa                	mv	s7,a0
 13c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13e:	892a                	mv	s2,a0
 140:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 142:	4aa9                	li	s5,10
 144:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 146:	0019849b          	addiw	s1,s3,1
 14a:	0344d863          	ble	s4,s1,17a <gets+0x56>
    cc = read(0, &c, 1);
 14e:	4605                	li	a2,1
 150:	faf40593          	addi	a1,s0,-81
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	1fa080e7          	jalr	506(ra) # 350 <read>
    if(cc < 1)
 15e:	00a05e63          	blez	a0,17a <gets+0x56>
    buf[i++] = c;
 162:	faf44783          	lbu	a5,-81(s0)
 166:	00f90023          	sb	a5,0(s2) # 800000 <__global_pointer$+0x7fee40>
    if(c == '\n' || c == '\r')
 16a:	01578763          	beq	a5,s5,178 <gets+0x54>
 16e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 170:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 172:	fd679ae3          	bne	a5,s6,146 <gets+0x22>
 176:	a011                	j	17a <gets+0x56>
  for(i=0; i+1 < max; ){
 178:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 17a:	99de                	add	s3,s3,s7
 17c:	00098023          	sb	zero,0(s3)
  return buf;
}
 180:	855e                	mv	a0,s7
 182:	60e6                	ld	ra,88(sp)
 184:	6446                	ld	s0,80(sp)
 186:	64a6                	ld	s1,72(sp)
 188:	6906                	ld	s2,64(sp)
 18a:	79e2                	ld	s3,56(sp)
 18c:	7a42                	ld	s4,48(sp)
 18e:	7aa2                	ld	s5,40(sp)
 190:	7b02                	ld	s6,32(sp)
 192:	6be2                	ld	s7,24(sp)
 194:	6125                	addi	sp,sp,96
 196:	8082                	ret

0000000000000198 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 19e:	00054683          	lbu	a3,0(a0)
 1a2:	fd06879b          	addiw	a5,a3,-48
 1a6:	0ff7f793          	andi	a5,a5,255
 1aa:	4725                	li	a4,9
 1ac:	02f76963          	bltu	a4,a5,1de <atoi+0x46>
 1b0:	862a                	mv	a2,a0
  n = 0;
 1b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1b6:	0605                	addi	a2,a2,1
 1b8:	0025179b          	slliw	a5,a0,0x2
 1bc:	9fa9                	addw	a5,a5,a0
 1be:	0017979b          	slliw	a5,a5,0x1
 1c2:	9fb5                	addw	a5,a5,a3
 1c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1c8:	00064683          	lbu	a3,0(a2)
 1cc:	fd06871b          	addiw	a4,a3,-48
 1d0:	0ff77713          	andi	a4,a4,255
 1d4:	fee5f1e3          	bleu	a4,a1,1b6 <atoi+0x1e>
  return n;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret
  n = 0;
 1de:	4501                	li	a0,0
 1e0:	bfe5                	j	1d8 <atoi+0x40>

00000000000001e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e422                	sd	s0,8(sp)
 1e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1e8:	02b57663          	bleu	a1,a0,214 <memmove+0x32>
    while(n-- > 0)
 1ec:	02c05163          	blez	a2,20e <memmove+0x2c>
 1f0:	fff6079b          	addiw	a5,a2,-1
 1f4:	1782                	slli	a5,a5,0x20
 1f6:	9381                	srli	a5,a5,0x20
 1f8:	0785                	addi	a5,a5,1
 1fa:	97aa                	add	a5,a5,a0
  dst = vdst;
 1fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 1fe:	0585                	addi	a1,a1,1
 200:	0705                	addi	a4,a4,1
 202:	fff5c683          	lbu	a3,-1(a1)
 206:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 20a:	fee79ae3          	bne	a5,a4,1fe <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
    dst += n;
 214:	00c50733          	add	a4,a0,a2
    src += n;
 218:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 21a:	fec05ae3          	blez	a2,20e <memmove+0x2c>
 21e:	fff6079b          	addiw	a5,a2,-1
 222:	1782                	slli	a5,a5,0x20
 224:	9381                	srli	a5,a5,0x20
 226:	fff7c793          	not	a5,a5
 22a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 22c:	15fd                	addi	a1,a1,-1
 22e:	177d                	addi	a4,a4,-1
 230:	0005c683          	lbu	a3,0(a1)
 234:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 238:	fef71ae3          	bne	a4,a5,22c <memmove+0x4a>
 23c:	bfc9                	j	20e <memmove+0x2c>

000000000000023e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 244:	ce15                	beqz	a2,280 <memcmp+0x42>
 246:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 24a:	00054783          	lbu	a5,0(a0)
 24e:	0005c703          	lbu	a4,0(a1)
 252:	02e79063          	bne	a5,a4,272 <memcmp+0x34>
 256:	1682                	slli	a3,a3,0x20
 258:	9281                	srli	a3,a3,0x20
 25a:	0685                	addi	a3,a3,1
 25c:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 25e:	0505                	addi	a0,a0,1
    p2++;
 260:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 262:	00d50d63          	beq	a0,a3,27c <memcmp+0x3e>
    if (*p1 != *p2) {
 266:	00054783          	lbu	a5,0(a0)
 26a:	0005c703          	lbu	a4,0(a1)
 26e:	fee788e3          	beq	a5,a4,25e <memcmp+0x20>
      return *p1 - *p2;
 272:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret
  return 0;
 27c:	4501                	li	a0,0
 27e:	bfe5                	j	276 <memcmp+0x38>
 280:	4501                	li	a0,0
 282:	bfd5                	j	276 <memcmp+0x38>

0000000000000284 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 28c:	00000097          	auipc	ra,0x0
 290:	f56080e7          	jalr	-170(ra) # 1e2 <memmove>
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <close>:

int close(int fd){
 29c:	1101                	addi	sp,sp,-32
 29e:	ec06                	sd	ra,24(sp)
 2a0:	e822                	sd	s0,16(sp)
 2a2:	e426                	sd	s1,8(sp)
 2a4:	1000                	addi	s0,sp,32
 2a6:	84aa                	mv	s1,a0
  fflush(fd);
 2a8:	00000097          	auipc	ra,0x0
 2ac:	2da080e7          	jalr	730(ra) # 582 <fflush>
  char* buf = get_putc_buf(fd);
 2b0:	8526                	mv	a0,s1
 2b2:	00000097          	auipc	ra,0x0
 2b6:	14e080e7          	jalr	334(ra) # 400 <get_putc_buf>
  if(buf){
 2ba:	cd11                	beqz	a0,2d6 <close+0x3a>
    free(buf);
 2bc:	00000097          	auipc	ra,0x0
 2c0:	548080e7          	jalr	1352(ra) # 804 <free>
    putc_buf[fd] = 0;
 2c4:	00349713          	slli	a4,s1,0x3
 2c8:	00000797          	auipc	a5,0x0
 2cc:	70078793          	addi	a5,a5,1792 # 9c8 <putc_buf>
 2d0:	97ba                	add	a5,a5,a4
 2d2:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2d6:	8526                	mv	a0,s1
 2d8:	00000097          	auipc	ra,0x0
 2dc:	088080e7          	jalr	136(ra) # 360 <sclose>
}
 2e0:	60e2                	ld	ra,24(sp)
 2e2:	6442                	ld	s0,16(sp)
 2e4:	64a2                	ld	s1,8(sp)
 2e6:	6105                	addi	sp,sp,32
 2e8:	8082                	ret

00000000000002ea <stat>:
{
 2ea:	1101                	addi	sp,sp,-32
 2ec:	ec06                	sd	ra,24(sp)
 2ee:	e822                	sd	s0,16(sp)
 2f0:	e426                	sd	s1,8(sp)
 2f2:	e04a                	sd	s2,0(sp)
 2f4:	1000                	addi	s0,sp,32
 2f6:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 2f8:	4581                	li	a1,0
 2fa:	00000097          	auipc	ra,0x0
 2fe:	07e080e7          	jalr	126(ra) # 378 <open>
  if(fd < 0)
 302:	02054563          	bltz	a0,32c <stat+0x42>
 306:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 308:	85ca                	mv	a1,s2
 30a:	00000097          	auipc	ra,0x0
 30e:	086080e7          	jalr	134(ra) # 390 <fstat>
 312:	892a                	mv	s2,a0
  close(fd);
 314:	8526                	mv	a0,s1
 316:	00000097          	auipc	ra,0x0
 31a:	f86080e7          	jalr	-122(ra) # 29c <close>
}
 31e:	854a                	mv	a0,s2
 320:	60e2                	ld	ra,24(sp)
 322:	6442                	ld	s0,16(sp)
 324:	64a2                	ld	s1,8(sp)
 326:	6902                	ld	s2,0(sp)
 328:	6105                	addi	sp,sp,32
 32a:	8082                	ret
    return -1;
 32c:	597d                	li	s2,-1
 32e:	bfc5                	j	31e <stat+0x34>

0000000000000330 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 330:	4885                	li	a7,1
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <exit>:
.global exit
exit:
 li a7, SYS_exit
 338:	4889                	li	a7,2
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <wait>:
.global wait
wait:
 li a7, SYS_wait
 340:	488d                	li	a7,3
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 348:	4891                	li	a7,4
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <read>:
.global read
read:
 li a7, SYS_read
 350:	4895                	li	a7,5
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <write>:
.global write
write:
 li a7, SYS_write
 358:	48c1                	li	a7,16
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 360:	48d5                	li	a7,21
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <kill>:
.global kill
kill:
 li a7, SYS_kill
 368:	4899                	li	a7,6
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <exec>:
.global exec
exec:
 li a7, SYS_exec
 370:	489d                	li	a7,7
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <open>:
.global open
open:
 li a7, SYS_open
 378:	48bd                	li	a7,15
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 380:	48c5                	li	a7,17
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 388:	48c9                	li	a7,18
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 390:	48a1                	li	a7,8
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <link>:
.global link
link:
 li a7, SYS_link
 398:	48cd                	li	a7,19
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a0:	48d1                	li	a7,20
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a8:	48a5                	li	a7,9
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b0:	48a9                	li	a7,10
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b8:	48ad                	li	a7,11
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c0:	48b1                	li	a7,12
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3c8:	48b5                	li	a7,13
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d0:	48b9                	li	a7,14
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3d8:	48d9                	li	a7,22
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3e0:	48dd                	li	a7,23
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3e8:	48e1                	li	a7,24
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3f0:	48e5                	li	a7,25
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 3f8:	48e9                	li	a7,26
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 400:	1101                	addi	sp,sp,-32
 402:	ec06                	sd	ra,24(sp)
 404:	e822                	sd	s0,16(sp)
 406:	e426                	sd	s1,8(sp)
 408:	1000                	addi	s0,sp,32
 40a:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 40c:	00351693          	slli	a3,a0,0x3
 410:	00000797          	auipc	a5,0x0
 414:	5b878793          	addi	a5,a5,1464 # 9c8 <putc_buf>
 418:	97b6                	add	a5,a5,a3
 41a:	6388                	ld	a0,0(a5)
  if(buf) {
 41c:	c511                	beqz	a0,428 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 41e:	60e2                	ld	ra,24(sp)
 420:	6442                	ld	s0,16(sp)
 422:	64a2                	ld	s1,8(sp)
 424:	6105                	addi	sp,sp,32
 426:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 428:	6505                	lui	a0,0x1
 42a:	00000097          	auipc	ra,0x0
 42e:	464080e7          	jalr	1124(ra) # 88e <malloc>
  putc_buf[fd] = buf;
 432:	00000797          	auipc	a5,0x0
 436:	59678793          	addi	a5,a5,1430 # 9c8 <putc_buf>
 43a:	00349713          	slli	a4,s1,0x3
 43e:	973e                	add	a4,a4,a5
 440:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 442:	00249713          	slli	a4,s1,0x2
 446:	973e                	add	a4,a4,a5
 448:	32072023          	sw	zero,800(a4)
  return buf;
 44c:	bfc9                	j	41e <get_putc_buf+0x1e>

000000000000044e <putc>:

static void
putc(int fd, char c)
{
 44e:	1101                	addi	sp,sp,-32
 450:	ec06                	sd	ra,24(sp)
 452:	e822                	sd	s0,16(sp)
 454:	e426                	sd	s1,8(sp)
 456:	e04a                	sd	s2,0(sp)
 458:	1000                	addi	s0,sp,32
 45a:	84aa                	mv	s1,a0
 45c:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 45e:	00000097          	auipc	ra,0x0
 462:	fa2080e7          	jalr	-94(ra) # 400 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 466:	00249793          	slli	a5,s1,0x2
 46a:	00000717          	auipc	a4,0x0
 46e:	55e70713          	addi	a4,a4,1374 # 9c8 <putc_buf>
 472:	973e                	add	a4,a4,a5
 474:	32072783          	lw	a5,800(a4)
 478:	0017869b          	addiw	a3,a5,1
 47c:	32d72023          	sw	a3,800(a4)
 480:	97aa                	add	a5,a5,a0
 482:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 486:	47a9                	li	a5,10
 488:	02f90463          	beq	s2,a5,4b0 <putc+0x62>
 48c:	00249713          	slli	a4,s1,0x2
 490:	00000797          	auipc	a5,0x0
 494:	53878793          	addi	a5,a5,1336 # 9c8 <putc_buf>
 498:	97ba                	add	a5,a5,a4
 49a:	3207a703          	lw	a4,800(a5)
 49e:	6785                	lui	a5,0x1
 4a0:	00f70863          	beq	a4,a5,4b0 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4a4:	60e2                	ld	ra,24(sp)
 4a6:	6442                	ld	s0,16(sp)
 4a8:	64a2                	ld	s1,8(sp)
 4aa:	6902                	ld	s2,0(sp)
 4ac:	6105                	addi	sp,sp,32
 4ae:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4b0:	00249793          	slli	a5,s1,0x2
 4b4:	00000917          	auipc	s2,0x0
 4b8:	51490913          	addi	s2,s2,1300 # 9c8 <putc_buf>
 4bc:	993e                	add	s2,s2,a5
 4be:	32092603          	lw	a2,800(s2)
 4c2:	85aa                	mv	a1,a0
 4c4:	8526                	mv	a0,s1
 4c6:	00000097          	auipc	ra,0x0
 4ca:	e92080e7          	jalr	-366(ra) # 358 <write>
    putc_index[fd] = 0;
 4ce:	32092023          	sw	zero,800(s2)
}
 4d2:	bfc9                	j	4a4 <putc+0x56>

00000000000004d4 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4d4:	7139                	addi	sp,sp,-64
 4d6:	fc06                	sd	ra,56(sp)
 4d8:	f822                	sd	s0,48(sp)
 4da:	f426                	sd	s1,40(sp)
 4dc:	f04a                	sd	s2,32(sp)
 4de:	ec4e                	sd	s3,24(sp)
 4e0:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e2:	c299                	beqz	a3,4e8 <printint+0x14>
 4e4:	0005cd63          	bltz	a1,4fe <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e8:	2581                	sext.w	a1,a1
  neg = 0;
 4ea:	4301                	li	t1,0
 4ec:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4f0:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4f2:	2601                	sext.w	a2,a2
 4f4:	00000897          	auipc	a7,0x0
 4f8:	4ac88893          	addi	a7,a7,1196 # 9a0 <digits>
 4fc:	a801                	j	50c <printint+0x38>
    x = -xx;
 4fe:	40b005bb          	negw	a1,a1
 502:	2581                	sext.w	a1,a1
    neg = 1;
 504:	4305                	li	t1,1
    x = -xx;
 506:	b7dd                	j	4ec <printint+0x18>
  }while((x /= base) != 0);
 508:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 50a:	8836                	mv	a6,a3
 50c:	0018069b          	addiw	a3,a6,1
 510:	02c5f7bb          	remuw	a5,a1,a2
 514:	1782                	slli	a5,a5,0x20
 516:	9381                	srli	a5,a5,0x20
 518:	97c6                	add	a5,a5,a7
 51a:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x178>
 51e:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 522:	0705                	addi	a4,a4,1
 524:	02c5d7bb          	divuw	a5,a1,a2
 528:	fec5f0e3          	bleu	a2,a1,508 <printint+0x34>
  if(neg)
 52c:	00030b63          	beqz	t1,542 <printint+0x6e>
    buf[i++] = '-';
 530:	fd040793          	addi	a5,s0,-48
 534:	96be                	add	a3,a3,a5
 536:	02d00793          	li	a5,45
 53a:	fef68823          	sb	a5,-16(a3)
 53e:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 542:	02d05963          	blez	a3,574 <printint+0xa0>
 546:	89aa                	mv	s3,a0
 548:	fc040793          	addi	a5,s0,-64
 54c:	00d784b3          	add	s1,a5,a3
 550:	fff78913          	addi	s2,a5,-1
 554:	9936                	add	s2,s2,a3
 556:	36fd                	addiw	a3,a3,-1
 558:	1682                	slli	a3,a3,0x20
 55a:	9281                	srli	a3,a3,0x20
 55c:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 560:	fff4c583          	lbu	a1,-1(s1)
 564:	854e                	mv	a0,s3
 566:	00000097          	auipc	ra,0x0
 56a:	ee8080e7          	jalr	-280(ra) # 44e <putc>
  while(--i >= 0)
 56e:	14fd                	addi	s1,s1,-1
 570:	ff2498e3          	bne	s1,s2,560 <printint+0x8c>
}
 574:	70e2                	ld	ra,56(sp)
 576:	7442                	ld	s0,48(sp)
 578:	74a2                	ld	s1,40(sp)
 57a:	7902                	ld	s2,32(sp)
 57c:	69e2                	ld	s3,24(sp)
 57e:	6121                	addi	sp,sp,64
 580:	8082                	ret

0000000000000582 <fflush>:
void fflush(int fd){
 582:	1101                	addi	sp,sp,-32
 584:	ec06                	sd	ra,24(sp)
 586:	e822                	sd	s0,16(sp)
 588:	e426                	sd	s1,8(sp)
 58a:	e04a                	sd	s2,0(sp)
 58c:	1000                	addi	s0,sp,32
 58e:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 590:	00000097          	auipc	ra,0x0
 594:	e70080e7          	jalr	-400(ra) # 400 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 598:	00291793          	slli	a5,s2,0x2
 59c:	00000497          	auipc	s1,0x0
 5a0:	42c48493          	addi	s1,s1,1068 # 9c8 <putc_buf>
 5a4:	94be                	add	s1,s1,a5
 5a6:	3204a603          	lw	a2,800(s1)
 5aa:	85aa                	mv	a1,a0
 5ac:	854a                	mv	a0,s2
 5ae:	00000097          	auipc	ra,0x0
 5b2:	daa080e7          	jalr	-598(ra) # 358 <write>
  putc_index[fd] = 0;
 5b6:	3204a023          	sw	zero,800(s1)
}
 5ba:	60e2                	ld	ra,24(sp)
 5bc:	6442                	ld	s0,16(sp)
 5be:	64a2                	ld	s1,8(sp)
 5c0:	6902                	ld	s2,0(sp)
 5c2:	6105                	addi	sp,sp,32
 5c4:	8082                	ret

00000000000005c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c6:	7119                	addi	sp,sp,-128
 5c8:	fc86                	sd	ra,120(sp)
 5ca:	f8a2                	sd	s0,112(sp)
 5cc:	f4a6                	sd	s1,104(sp)
 5ce:	f0ca                	sd	s2,96(sp)
 5d0:	ecce                	sd	s3,88(sp)
 5d2:	e8d2                	sd	s4,80(sp)
 5d4:	e4d6                	sd	s5,72(sp)
 5d6:	e0da                	sd	s6,64(sp)
 5d8:	fc5e                	sd	s7,56(sp)
 5da:	f862                	sd	s8,48(sp)
 5dc:	f466                	sd	s9,40(sp)
 5de:	f06a                	sd	s10,32(sp)
 5e0:	ec6e                	sd	s11,24(sp)
 5e2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5e4:	0005c483          	lbu	s1,0(a1)
 5e8:	18048d63          	beqz	s1,782 <vprintf+0x1bc>
 5ec:	8aaa                	mv	s5,a0
 5ee:	8b32                	mv	s6,a2
 5f0:	00158913          	addi	s2,a1,1
  state = 0;
 5f4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f6:	02500a13          	li	s4,37
      if(c == 'd'){
 5fa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5fe:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 602:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 606:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 60a:	00000b97          	auipc	s7,0x0
 60e:	396b8b93          	addi	s7,s7,918 # 9a0 <digits>
 612:	a839                	j	630 <vprintf+0x6a>
        putc(fd, c);
 614:	85a6                	mv	a1,s1
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e36080e7          	jalr	-458(ra) # 44e <putc>
 620:	a019                	j	626 <vprintf+0x60>
    } else if(state == '%'){
 622:	01498f63          	beq	s3,s4,640 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 626:	0905                	addi	s2,s2,1
 628:	fff94483          	lbu	s1,-1(s2)
 62c:	14048b63          	beqz	s1,782 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 630:	0004879b          	sext.w	a5,s1
    if(state == 0){
 634:	fe0997e3          	bnez	s3,622 <vprintf+0x5c>
      if(c == '%'){
 638:	fd479ee3          	bne	a5,s4,614 <vprintf+0x4e>
        state = '%';
 63c:	89be                	mv	s3,a5
 63e:	b7e5                	j	626 <vprintf+0x60>
      if(c == 'd'){
 640:	05878063          	beq	a5,s8,680 <vprintf+0xba>
      } else if(c == 'l') {
 644:	05978c63          	beq	a5,s9,69c <vprintf+0xd6>
      } else if(c == 'x') {
 648:	07a78863          	beq	a5,s10,6b8 <vprintf+0xf2>
      } else if(c == 'p') {
 64c:	09b78463          	beq	a5,s11,6d4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 650:	07300713          	li	a4,115
 654:	0ce78563          	beq	a5,a4,71e <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 658:	06300713          	li	a4,99
 65c:	0ee78c63          	beq	a5,a4,754 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 660:	11478663          	beq	a5,s4,76c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 664:	85d2                	mv	a1,s4
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	de6080e7          	jalr	-538(ra) # 44e <putc>
        putc(fd, c);
 670:	85a6                	mv	a1,s1
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	dda080e7          	jalr	-550(ra) # 44e <putc>
      }
      state = 0;
 67c:	4981                	li	s3,0
 67e:	b765                	j	626 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 680:	008b0493          	addi	s1,s6,8
 684:	4685                	li	a3,1
 686:	4629                	li	a2,10
 688:	000b2583          	lw	a1,0(s6)
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e46080e7          	jalr	-442(ra) # 4d4 <printint>
 696:	8b26                	mv	s6,s1
      state = 0;
 698:	4981                	li	s3,0
 69a:	b771                	j	626 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 69c:	008b0493          	addi	s1,s6,8
 6a0:	4681                	li	a3,0
 6a2:	4629                	li	a2,10
 6a4:	000b2583          	lw	a1,0(s6)
 6a8:	8556                	mv	a0,s5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	e2a080e7          	jalr	-470(ra) # 4d4 <printint>
 6b2:	8b26                	mv	s6,s1
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	bf85                	j	626 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6b8:	008b0493          	addi	s1,s6,8
 6bc:	4681                	li	a3,0
 6be:	4641                	li	a2,16
 6c0:	000b2583          	lw	a1,0(s6)
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e0e080e7          	jalr	-498(ra) # 4d4 <printint>
 6ce:	8b26                	mv	s6,s1
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bf91                	j	626 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6d4:	008b0793          	addi	a5,s6,8
 6d8:	f8f43423          	sd	a5,-120(s0)
 6dc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6e0:	03000593          	li	a1,48
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	d68080e7          	jalr	-664(ra) # 44e <putc>
  putc(fd, 'x');
 6ee:	85ea                	mv	a1,s10
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	d5c080e7          	jalr	-676(ra) # 44e <putc>
 6fa:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fc:	03c9d793          	srli	a5,s3,0x3c
 700:	97de                	add	a5,a5,s7
 702:	0007c583          	lbu	a1,0(a5)
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	d46080e7          	jalr	-698(ra) # 44e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 710:	0992                	slli	s3,s3,0x4
 712:	34fd                	addiw	s1,s1,-1
 714:	f4e5                	bnez	s1,6fc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 716:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b729                	j	626 <vprintf+0x60>
        s = va_arg(ap, char*);
 71e:	008b0993          	addi	s3,s6,8
 722:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 726:	c085                	beqz	s1,746 <vprintf+0x180>
        while(*s != 0){
 728:	0004c583          	lbu	a1,0(s1)
 72c:	c9a1                	beqz	a1,77c <vprintf+0x1b6>
          putc(fd, *s);
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	d1e080e7          	jalr	-738(ra) # 44e <putc>
          s++;
 738:	0485                	addi	s1,s1,1
        while(*s != 0){
 73a:	0004c583          	lbu	a1,0(s1)
 73e:	f9e5                	bnez	a1,72e <vprintf+0x168>
        s = va_arg(ap, char*);
 740:	8b4e                	mv	s6,s3
      state = 0;
 742:	4981                	li	s3,0
 744:	b5cd                	j	626 <vprintf+0x60>
          s = "(null)";
 746:	00000497          	auipc	s1,0x0
 74a:	27248493          	addi	s1,s1,626 # 9b8 <digits+0x18>
        while(*s != 0){
 74e:	02800593          	li	a1,40
 752:	bff1                	j	72e <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 754:	008b0493          	addi	s1,s6,8
 758:	000b4583          	lbu	a1,0(s6)
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	cf0080e7          	jalr	-784(ra) # 44e <putc>
 766:	8b26                	mv	s6,s1
      state = 0;
 768:	4981                	li	s3,0
 76a:	bd75                	j	626 <vprintf+0x60>
        putc(fd, c);
 76c:	85d2                	mv	a1,s4
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	cde080e7          	jalr	-802(ra) # 44e <putc>
      state = 0;
 778:	4981                	li	s3,0
 77a:	b575                	j	626 <vprintf+0x60>
        s = va_arg(ap, char*);
 77c:	8b4e                	mv	s6,s3
      state = 0;
 77e:	4981                	li	s3,0
 780:	b55d                	j	626 <vprintf+0x60>
    }
  }
}
 782:	70e6                	ld	ra,120(sp)
 784:	7446                	ld	s0,112(sp)
 786:	74a6                	ld	s1,104(sp)
 788:	7906                	ld	s2,96(sp)
 78a:	69e6                	ld	s3,88(sp)
 78c:	6a46                	ld	s4,80(sp)
 78e:	6aa6                	ld	s5,72(sp)
 790:	6b06                	ld	s6,64(sp)
 792:	7be2                	ld	s7,56(sp)
 794:	7c42                	ld	s8,48(sp)
 796:	7ca2                	ld	s9,40(sp)
 798:	7d02                	ld	s10,32(sp)
 79a:	6de2                	ld	s11,24(sp)
 79c:	6109                	addi	sp,sp,128
 79e:	8082                	ret

00000000000007a0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a0:	715d                	addi	sp,sp,-80
 7a2:	ec06                	sd	ra,24(sp)
 7a4:	e822                	sd	s0,16(sp)
 7a6:	1000                	addi	s0,sp,32
 7a8:	e010                	sd	a2,0(s0)
 7aa:	e414                	sd	a3,8(s0)
 7ac:	e818                	sd	a4,16(s0)
 7ae:	ec1c                	sd	a5,24(s0)
 7b0:	03043023          	sd	a6,32(s0)
 7b4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7b8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7bc:	8622                	mv	a2,s0
 7be:	00000097          	auipc	ra,0x0
 7c2:	e08080e7          	jalr	-504(ra) # 5c6 <vprintf>
}
 7c6:	60e2                	ld	ra,24(sp)
 7c8:	6442                	ld	s0,16(sp)
 7ca:	6161                	addi	sp,sp,80
 7cc:	8082                	ret

00000000000007ce <printf>:

void
printf(const char *fmt, ...)
{
 7ce:	711d                	addi	sp,sp,-96
 7d0:	ec06                	sd	ra,24(sp)
 7d2:	e822                	sd	s0,16(sp)
 7d4:	1000                	addi	s0,sp,32
 7d6:	e40c                	sd	a1,8(s0)
 7d8:	e810                	sd	a2,16(s0)
 7da:	ec14                	sd	a3,24(s0)
 7dc:	f018                	sd	a4,32(s0)
 7de:	f41c                	sd	a5,40(s0)
 7e0:	03043823          	sd	a6,48(s0)
 7e4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7e8:	00840613          	addi	a2,s0,8
 7ec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f0:	85aa                	mv	a1,a0
 7f2:	4505                	li	a0,1
 7f4:	00000097          	auipc	ra,0x0
 7f8:	dd2080e7          	jalr	-558(ra) # 5c6 <vprintf>
}
 7fc:	60e2                	ld	ra,24(sp)
 7fe:	6442                	ld	s0,16(sp)
 800:	6125                	addi	sp,sp,96
 802:	8082                	ret

0000000000000804 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 804:	1141                	addi	sp,sp,-16
 806:	e422                	sd	s0,8(sp)
 808:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80a:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x168>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80e:	00000797          	auipc	a5,0x0
 812:	1b278793          	addi	a5,a5,434 # 9c0 <__bss_start>
 816:	639c                	ld	a5,0(a5)
 818:	a805                	j	848 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 81a:	4618                	lw	a4,8(a2)
 81c:	9db9                	addw	a1,a1,a4
 81e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 822:	6398                	ld	a4,0(a5)
 824:	6318                	ld	a4,0(a4)
 826:	fee53823          	sd	a4,-16(a0)
 82a:	a091                	j	86e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 82c:	ff852703          	lw	a4,-8(a0)
 830:	9e39                	addw	a2,a2,a4
 832:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 834:	ff053703          	ld	a4,-16(a0)
 838:	e398                	sd	a4,0(a5)
 83a:	a099                	j	880 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	6398                	ld	a4,0(a5)
 83e:	00e7e463          	bltu	a5,a4,846 <free+0x42>
 842:	00e6ea63          	bltu	a3,a4,856 <free+0x52>
{
 846:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 848:	fed7fae3          	bleu	a3,a5,83c <free+0x38>
 84c:	6398                	ld	a4,0(a5)
 84e:	00e6e463          	bltu	a3,a4,856 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 852:	fee7eae3          	bltu	a5,a4,846 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 856:	ff852583          	lw	a1,-8(a0)
 85a:	6390                	ld	a2,0(a5)
 85c:	02059713          	slli	a4,a1,0x20
 860:	9301                	srli	a4,a4,0x20
 862:	0712                	slli	a4,a4,0x4
 864:	9736                	add	a4,a4,a3
 866:	fae60ae3          	beq	a2,a4,81a <free+0x16>
    bp->s.ptr = p->s.ptr;
 86a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 86e:	4790                	lw	a2,8(a5)
 870:	02061713          	slli	a4,a2,0x20
 874:	9301                	srli	a4,a4,0x20
 876:	0712                	slli	a4,a4,0x4
 878:	973e                	add	a4,a4,a5
 87a:	fae689e3          	beq	a3,a4,82c <free+0x28>
  } else
    p->s.ptr = bp;
 87e:	e394                	sd	a3,0(a5)
  freep = p;
 880:	00000717          	auipc	a4,0x0
 884:	14f73023          	sd	a5,320(a4) # 9c0 <__bss_start>
}
 888:	6422                	ld	s0,8(sp)
 88a:	0141                	addi	sp,sp,16
 88c:	8082                	ret

000000000000088e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 88e:	7139                	addi	sp,sp,-64
 890:	fc06                	sd	ra,56(sp)
 892:	f822                	sd	s0,48(sp)
 894:	f426                	sd	s1,40(sp)
 896:	f04a                	sd	s2,32(sp)
 898:	ec4e                	sd	s3,24(sp)
 89a:	e852                	sd	s4,16(sp)
 89c:	e456                	sd	s5,8(sp)
 89e:	e05a                	sd	s6,0(sp)
 8a0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a2:	02051993          	slli	s3,a0,0x20
 8a6:	0209d993          	srli	s3,s3,0x20
 8aa:	09bd                	addi	s3,s3,15
 8ac:	0049d993          	srli	s3,s3,0x4
 8b0:	2985                	addiw	s3,s3,1
 8b2:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8b6:	00000797          	auipc	a5,0x0
 8ba:	10a78793          	addi	a5,a5,266 # 9c0 <__bss_start>
 8be:	6388                	ld	a0,0(a5)
 8c0:	c515                	beqz	a0,8ec <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c4:	4798                	lw	a4,8(a5)
 8c6:	03277f63          	bleu	s2,a4,904 <malloc+0x76>
 8ca:	8a4e                	mv	s4,s3
 8cc:	0009871b          	sext.w	a4,s3
 8d0:	6685                	lui	a3,0x1
 8d2:	00d77363          	bleu	a3,a4,8d8 <malloc+0x4a>
 8d6:	6a05                	lui	s4,0x1
 8d8:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8dc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e0:	00000497          	auipc	s1,0x0
 8e4:	0e048493          	addi	s1,s1,224 # 9c0 <__bss_start>
  if(p == (char*)-1)
 8e8:	5b7d                	li	s6,-1
 8ea:	a885                	j	95a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8ec:	00000797          	auipc	a5,0x0
 8f0:	58c78793          	addi	a5,a5,1420 # e78 <base>
 8f4:	00000717          	auipc	a4,0x0
 8f8:	0cf73623          	sd	a5,204(a4) # 9c0 <__bss_start>
 8fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 902:	b7e1                	j	8ca <malloc+0x3c>
      if(p->s.size == nunits)
 904:	02e90b63          	beq	s2,a4,93a <malloc+0xac>
        p->s.size -= nunits;
 908:	4137073b          	subw	a4,a4,s3
 90c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90e:	1702                	slli	a4,a4,0x20
 910:	9301                	srli	a4,a4,0x20
 912:	0712                	slli	a4,a4,0x4
 914:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 916:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91a:	00000717          	auipc	a4,0x0
 91e:	0aa73323          	sd	a0,166(a4) # 9c0 <__bss_start>
      return (void*)(p + 1);
 922:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 926:	70e2                	ld	ra,56(sp)
 928:	7442                	ld	s0,48(sp)
 92a:	74a2                	ld	s1,40(sp)
 92c:	7902                	ld	s2,32(sp)
 92e:	69e2                	ld	s3,24(sp)
 930:	6a42                	ld	s4,16(sp)
 932:	6aa2                	ld	s5,8(sp)
 934:	6b02                	ld	s6,0(sp)
 936:	6121                	addi	sp,sp,64
 938:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 93a:	6398                	ld	a4,0(a5)
 93c:	e118                	sd	a4,0(a0)
 93e:	bff1                	j	91a <malloc+0x8c>
  hp->s.size = nu;
 940:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 944:	0541                	addi	a0,a0,16
 946:	00000097          	auipc	ra,0x0
 94a:	ebe080e7          	jalr	-322(ra) # 804 <free>
  return freep;
 94e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 950:	d979                	beqz	a0,926 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	fb2777e3          	bleu	s2,a4,904 <malloc+0x76>
    if(p == freep)
 95a:	6098                	ld	a4,0(s1)
 95c:	853e                	mv	a0,a5
 95e:	fef71ae3          	bne	a4,a5,952 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 962:	8552                	mv	a0,s4
 964:	00000097          	auipc	ra,0x0
 968:	a5c080e7          	jalr	-1444(ra) # 3c0 <sbrk>
  if(p == (char*)-1)
 96c:	fd651ae3          	bne	a0,s6,940 <malloc+0xb2>
        return 0;
 970:	4501                	li	a0,0
 972:	bf55                	j	926 <malloc+0x98>
