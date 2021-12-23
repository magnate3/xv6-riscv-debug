
user/_call:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <g>:
#include "kernel/param.h"
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int g(int x) {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  return x+3;
}
   6:	250d                	addiw	a0,a0,3
   8:	6422                	ld	s0,8(sp)
   a:	0141                	addi	sp,sp,16
   c:	8082                	ret

000000000000000e <f>:

int f(int x) {
   e:	1141                	addi	sp,sp,-16
  10:	e422                	sd	s0,8(sp)
  12:	0800                	addi	s0,sp,16
  return g(x);
}
  14:	250d                	addiw	a0,a0,3
  16:	6422                	ld	s0,8(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

000000000000001c <main>:

void main(void) {
  1c:	1141                	addi	sp,sp,-16
  1e:	e406                	sd	ra,8(sp)
  20:	e022                	sd	s0,0(sp)
  22:	0800                	addi	s0,sp,16
  printf("%d %d\n", f(8)+1, 13);
  24:	4635                	li	a2,13
  26:	45b1                	li	a1,12
  28:	00001517          	auipc	a0,0x1
  2c:	93850513          	addi	a0,a0,-1736 # 960 <malloc+0xea>
  30:	00000097          	auipc	ra,0x0
  34:	786080e7          	jalr	1926(ra) # 7b6 <printf>
  exit(0);
  38:	4501                	li	a0,0
  3a:	00000097          	auipc	ra,0x0
  3e:	2e6080e7          	jalr	742(ra) # 320 <exit>

0000000000000042 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  42:	1141                	addi	sp,sp,-16
  44:	e422                	sd	s0,8(sp)
  46:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  48:	87aa                	mv	a5,a0
  4a:	0585                	addi	a1,a1,1
  4c:	0785                	addi	a5,a5,1
  4e:	fff5c703          	lbu	a4,-1(a1)
  52:	fee78fa3          	sb	a4,-1(a5)
  56:	fb75                	bnez	a4,4a <strcpy+0x8>
    ;
  return os;
}
  58:	6422                	ld	s0,8(sp)
  5a:	0141                	addi	sp,sp,16
  5c:	8082                	ret

000000000000005e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	cf91                	beqz	a5,84 <strcmp+0x26>
  6a:	0005c703          	lbu	a4,0(a1)
  6e:	00f71b63          	bne	a4,a5,84 <strcmp+0x26>
    p++, q++;
  72:	0505                	addi	a0,a0,1
  74:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  76:	00054783          	lbu	a5,0(a0)
  7a:	c789                	beqz	a5,84 <strcmp+0x26>
  7c:	0005c703          	lbu	a4,0(a1)
  80:	fef709e3          	beq	a4,a5,72 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  84:	0005c503          	lbu	a0,0(a1)
}
  88:	40a7853b          	subw	a0,a5,a0
  8c:	6422                	ld	s0,8(sp)
  8e:	0141                	addi	sp,sp,16
  90:	8082                	ret

0000000000000092 <strlen>:

uint
strlen(const char *s)
{
  92:	1141                	addi	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  98:	00054783          	lbu	a5,0(a0)
  9c:	cf91                	beqz	a5,b8 <strlen+0x26>
  9e:	0505                	addi	a0,a0,1
  a0:	87aa                	mv	a5,a0
  a2:	4685                	li	a3,1
  a4:	9e89                	subw	a3,a3,a0
  a6:	00f6853b          	addw	a0,a3,a5
  aa:	0785                	addi	a5,a5,1
  ac:	fff7c703          	lbu	a4,-1(a5)
  b0:	fb7d                	bnez	a4,a6 <strlen+0x14>
    ;
  return n;
}
  b2:	6422                	ld	s0,8(sp)
  b4:	0141                	addi	sp,sp,16
  b6:	8082                	ret
  for(n = 0; s[n]; n++)
  b8:	4501                	li	a0,0
  ba:	bfe5                	j	b2 <strlen+0x20>

00000000000000bc <memset>:

void*
memset(void *dst, int c, uint n)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e422                	sd	s0,8(sp)
  c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  c2:	ce09                	beqz	a2,dc <memset+0x20>
  c4:	87aa                	mv	a5,a0
  c6:	fff6071b          	addiw	a4,a2,-1
  ca:	1702                	slli	a4,a4,0x20
  cc:	9301                	srli	a4,a4,0x20
  ce:	0705                	addi	a4,a4,1
  d0:	972a                	add	a4,a4,a0
    cdst[i] = c;
  d2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  d6:	0785                	addi	a5,a5,1
  d8:	fee79de3          	bne	a5,a4,d2 <memset+0x16>
  }
  return dst;
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strchr>:

char*
strchr(const char *s, char c)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  for(; *s; s++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strchr+0x26>
    if(*s == c)
  ee:	00f58a63          	beq	a1,a5,102 <strchr+0x20>
  for(; *s; s++)
  f2:	0505                	addi	a0,a0,1
  f4:	00054783          	lbu	a5,0(a0)
  f8:	c781                	beqz	a5,100 <strchr+0x1e>
    if(*s == c)
  fa:	feb79ce3          	bne	a5,a1,f2 <strchr+0x10>
  fe:	a011                	j	102 <strchr+0x20>
      return (char*)s;
  return 0;
 100:	4501                	li	a0,0
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  return 0;
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strchr+0x20>

000000000000010c <gets>:

char*
gets(char *buf, int max)
{
 10c:	711d                	addi	sp,sp,-96
 10e:	ec86                	sd	ra,88(sp)
 110:	e8a2                	sd	s0,80(sp)
 112:	e4a6                	sd	s1,72(sp)
 114:	e0ca                	sd	s2,64(sp)
 116:	fc4e                	sd	s3,56(sp)
 118:	f852                	sd	s4,48(sp)
 11a:	f456                	sd	s5,40(sp)
 11c:	f05a                	sd	s6,32(sp)
 11e:	ec5e                	sd	s7,24(sp)
 120:	1080                	addi	s0,sp,96
 122:	8baa                	mv	s7,a0
 124:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 126:	892a                	mv	s2,a0
 128:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 12a:	4aa9                	li	s5,10
 12c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 12e:	0019849b          	addiw	s1,s3,1
 132:	0344d863          	ble	s4,s1,162 <gets+0x56>
    cc = read(0, &c, 1);
 136:	4605                	li	a2,1
 138:	faf40593          	addi	a1,s0,-81
 13c:	4501                	li	a0,0
 13e:	00000097          	auipc	ra,0x0
 142:	1fa080e7          	jalr	506(ra) # 338 <read>
    if(cc < 1)
 146:	00a05e63          	blez	a0,162 <gets+0x56>
    buf[i++] = c;
 14a:	faf44783          	lbu	a5,-81(s0)
 14e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 152:	01578763          	beq	a5,s5,160 <gets+0x54>
 156:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 158:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 15a:	fd679ae3          	bne	a5,s6,12e <gets+0x22>
 15e:	a011                	j	162 <gets+0x56>
  for(i=0; i+1 < max; ){
 160:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 162:	99de                	add	s3,s3,s7
 164:	00098023          	sb	zero,0(s3)
  return buf;
}
 168:	855e                	mv	a0,s7
 16a:	60e6                	ld	ra,88(sp)
 16c:	6446                	ld	s0,80(sp)
 16e:	64a6                	ld	s1,72(sp)
 170:	6906                	ld	s2,64(sp)
 172:	79e2                	ld	s3,56(sp)
 174:	7a42                	ld	s4,48(sp)
 176:	7aa2                	ld	s5,40(sp)
 178:	7b02                	ld	s6,32(sp)
 17a:	6be2                	ld	s7,24(sp)
 17c:	6125                	addi	sp,sp,96
 17e:	8082                	ret

0000000000000180 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 180:	1141                	addi	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 186:	00054683          	lbu	a3,0(a0)
 18a:	fd06879b          	addiw	a5,a3,-48
 18e:	0ff7f793          	andi	a5,a5,255
 192:	4725                	li	a4,9
 194:	02f76963          	bltu	a4,a5,1c6 <atoi+0x46>
 198:	862a                	mv	a2,a0
  n = 0;
 19a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 19c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 19e:	0605                	addi	a2,a2,1
 1a0:	0025179b          	slliw	a5,a0,0x2
 1a4:	9fa9                	addw	a5,a5,a0
 1a6:	0017979b          	slliw	a5,a5,0x1
 1aa:	9fb5                	addw	a5,a5,a3
 1ac:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1b0:	00064683          	lbu	a3,0(a2)
 1b4:	fd06871b          	addiw	a4,a3,-48
 1b8:	0ff77713          	andi	a4,a4,255
 1bc:	fee5f1e3          	bleu	a4,a1,19e <atoi+0x1e>
  return n;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret
  n = 0;
 1c6:	4501                	li	a0,0
 1c8:	bfe5                	j	1c0 <atoi+0x40>

00000000000001ca <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1d0:	02b57663          	bleu	a1,a0,1fc <memmove+0x32>
    while(n-- > 0)
 1d4:	02c05163          	blez	a2,1f6 <memmove+0x2c>
 1d8:	fff6079b          	addiw	a5,a2,-1
 1dc:	1782                	slli	a5,a5,0x20
 1de:	9381                	srli	a5,a5,0x20
 1e0:	0785                	addi	a5,a5,1
 1e2:	97aa                	add	a5,a5,a0
  dst = vdst;
 1e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 1e6:	0585                	addi	a1,a1,1
 1e8:	0705                	addi	a4,a4,1
 1ea:	fff5c683          	lbu	a3,-1(a1)
 1ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1f2:	fee79ae3          	bne	a5,a4,1e6 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
    dst += n;
 1fc:	00c50733          	add	a4,a0,a2
    src += n;
 200:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 202:	fec05ae3          	blez	a2,1f6 <memmove+0x2c>
 206:	fff6079b          	addiw	a5,a2,-1
 20a:	1782                	slli	a5,a5,0x20
 20c:	9381                	srli	a5,a5,0x20
 20e:	fff7c793          	not	a5,a5
 212:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 214:	15fd                	addi	a1,a1,-1
 216:	177d                	addi	a4,a4,-1
 218:	0005c683          	lbu	a3,0(a1)
 21c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 220:	fef71ae3          	bne	a4,a5,214 <memmove+0x4a>
 224:	bfc9                	j	1f6 <memmove+0x2c>

0000000000000226 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 226:	1141                	addi	sp,sp,-16
 228:	e422                	sd	s0,8(sp)
 22a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 22c:	ce15                	beqz	a2,268 <memcmp+0x42>
 22e:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 232:	00054783          	lbu	a5,0(a0)
 236:	0005c703          	lbu	a4,0(a1)
 23a:	02e79063          	bne	a5,a4,25a <memcmp+0x34>
 23e:	1682                	slli	a3,a3,0x20
 240:	9281                	srli	a3,a3,0x20
 242:	0685                	addi	a3,a3,1
 244:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 246:	0505                	addi	a0,a0,1
    p2++;
 248:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 24a:	00d50d63          	beq	a0,a3,264 <memcmp+0x3e>
    if (*p1 != *p2) {
 24e:	00054783          	lbu	a5,0(a0)
 252:	0005c703          	lbu	a4,0(a1)
 256:	fee788e3          	beq	a5,a4,246 <memcmp+0x20>
      return *p1 - *p2;
 25a:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
  return 0;
 264:	4501                	li	a0,0
 266:	bfe5                	j	25e <memcmp+0x38>
 268:	4501                	li	a0,0
 26a:	bfd5                	j	25e <memcmp+0x38>

000000000000026c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 274:	00000097          	auipc	ra,0x0
 278:	f56080e7          	jalr	-170(ra) # 1ca <memmove>
}
 27c:	60a2                	ld	ra,8(sp)
 27e:	6402                	ld	s0,0(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret

0000000000000284 <close>:

int close(int fd){
 284:	1101                	addi	sp,sp,-32
 286:	ec06                	sd	ra,24(sp)
 288:	e822                	sd	s0,16(sp)
 28a:	e426                	sd	s1,8(sp)
 28c:	1000                	addi	s0,sp,32
 28e:	84aa                	mv	s1,a0
  fflush(fd);
 290:	00000097          	auipc	ra,0x0
 294:	2da080e7          	jalr	730(ra) # 56a <fflush>
  char* buf = get_putc_buf(fd);
 298:	8526                	mv	a0,s1
 29a:	00000097          	auipc	ra,0x0
 29e:	14e080e7          	jalr	334(ra) # 3e8 <get_putc_buf>
  if(buf){
 2a2:	cd11                	beqz	a0,2be <close+0x3a>
    free(buf);
 2a4:	00000097          	auipc	ra,0x0
 2a8:	548080e7          	jalr	1352(ra) # 7ec <free>
    putc_buf[fd] = 0;
 2ac:	00349713          	slli	a4,s1,0x3
 2b0:	00000797          	auipc	a5,0x0
 2b4:	6e078793          	addi	a5,a5,1760 # 990 <putc_buf>
 2b8:	97ba                	add	a5,a5,a4
 2ba:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2be:	8526                	mv	a0,s1
 2c0:	00000097          	auipc	ra,0x0
 2c4:	088080e7          	jalr	136(ra) # 348 <sclose>
}
 2c8:	60e2                	ld	ra,24(sp)
 2ca:	6442                	ld	s0,16(sp)
 2cc:	64a2                	ld	s1,8(sp)
 2ce:	6105                	addi	sp,sp,32
 2d0:	8082                	ret

00000000000002d2 <stat>:
{
 2d2:	1101                	addi	sp,sp,-32
 2d4:	ec06                	sd	ra,24(sp)
 2d6:	e822                	sd	s0,16(sp)
 2d8:	e426                	sd	s1,8(sp)
 2da:	e04a                	sd	s2,0(sp)
 2dc:	1000                	addi	s0,sp,32
 2de:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 2e0:	4581                	li	a1,0
 2e2:	00000097          	auipc	ra,0x0
 2e6:	07e080e7          	jalr	126(ra) # 360 <open>
  if(fd < 0)
 2ea:	02054563          	bltz	a0,314 <stat+0x42>
 2ee:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 2f0:	85ca                	mv	a1,s2
 2f2:	00000097          	auipc	ra,0x0
 2f6:	086080e7          	jalr	134(ra) # 378 <fstat>
 2fa:	892a                	mv	s2,a0
  close(fd);
 2fc:	8526                	mv	a0,s1
 2fe:	00000097          	auipc	ra,0x0
 302:	f86080e7          	jalr	-122(ra) # 284 <close>
}
 306:	854a                	mv	a0,s2
 308:	60e2                	ld	ra,24(sp)
 30a:	6442                	ld	s0,16(sp)
 30c:	64a2                	ld	s1,8(sp)
 30e:	6902                	ld	s2,0(sp)
 310:	6105                	addi	sp,sp,32
 312:	8082                	ret
    return -1;
 314:	597d                	li	s2,-1
 316:	bfc5                	j	306 <stat+0x34>

0000000000000318 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 318:	4885                	li	a7,1
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <exit>:
.global exit
exit:
 li a7, SYS_exit
 320:	4889                	li	a7,2
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <wait>:
.global wait
wait:
 li a7, SYS_wait
 328:	488d                	li	a7,3
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 330:	4891                	li	a7,4
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <read>:
.global read
read:
 li a7, SYS_read
 338:	4895                	li	a7,5
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <write>:
.global write
write:
 li a7, SYS_write
 340:	48c1                	li	a7,16
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 348:	48d5                	li	a7,21
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <kill>:
.global kill
kill:
 li a7, SYS_kill
 350:	4899                	li	a7,6
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exec>:
.global exec
exec:
 li a7, SYS_exec
 358:	489d                	li	a7,7
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <open>:
.global open
open:
 li a7, SYS_open
 360:	48bd                	li	a7,15
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 368:	48c5                	li	a7,17
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 370:	48c9                	li	a7,18
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 378:	48a1                	li	a7,8
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <link>:
.global link
link:
 li a7, SYS_link
 380:	48cd                	li	a7,19
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 388:	48d1                	li	a7,20
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 390:	48a5                	li	a7,9
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <dup>:
.global dup
dup:
 li a7, SYS_dup
 398:	48a9                	li	a7,10
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a0:	48ad                	li	a7,11
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a8:	48b1                	li	a7,12
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b0:	48b5                	li	a7,13
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b8:	48b9                	li	a7,14
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3c0:	48d9                	li	a7,22
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3c8:	48dd                	li	a7,23
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3d0:	48e1                	li	a7,24
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3d8:	48e5                	li	a7,25
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 3e0:	48e9                	li	a7,26
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 3e8:	1101                	addi	sp,sp,-32
 3ea:	ec06                	sd	ra,24(sp)
 3ec:	e822                	sd	s0,16(sp)
 3ee:	e426                	sd	s1,8(sp)
 3f0:	1000                	addi	s0,sp,32
 3f2:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 3f4:	00351693          	slli	a3,a0,0x3
 3f8:	00000797          	auipc	a5,0x0
 3fc:	59878793          	addi	a5,a5,1432 # 990 <putc_buf>
 400:	97b6                	add	a5,a5,a3
 402:	6388                	ld	a0,0(a5)
  if(buf) {
 404:	c511                	beqz	a0,410 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 406:	60e2                	ld	ra,24(sp)
 408:	6442                	ld	s0,16(sp)
 40a:	64a2                	ld	s1,8(sp)
 40c:	6105                	addi	sp,sp,32
 40e:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 410:	6505                	lui	a0,0x1
 412:	00000097          	auipc	ra,0x0
 416:	464080e7          	jalr	1124(ra) # 876 <malloc>
  putc_buf[fd] = buf;
 41a:	00000797          	auipc	a5,0x0
 41e:	57678793          	addi	a5,a5,1398 # 990 <putc_buf>
 422:	00349713          	slli	a4,s1,0x3
 426:	973e                	add	a4,a4,a5
 428:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 42a:	00249713          	slli	a4,s1,0x2
 42e:	973e                	add	a4,a4,a5
 430:	32072023          	sw	zero,800(a4)
  return buf;
 434:	bfc9                	j	406 <get_putc_buf+0x1e>

0000000000000436 <putc>:

static void
putc(int fd, char c)
{
 436:	1101                	addi	sp,sp,-32
 438:	ec06                	sd	ra,24(sp)
 43a:	e822                	sd	s0,16(sp)
 43c:	e426                	sd	s1,8(sp)
 43e:	e04a                	sd	s2,0(sp)
 440:	1000                	addi	s0,sp,32
 442:	84aa                	mv	s1,a0
 444:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 446:	00000097          	auipc	ra,0x0
 44a:	fa2080e7          	jalr	-94(ra) # 3e8 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 44e:	00249793          	slli	a5,s1,0x2
 452:	00000717          	auipc	a4,0x0
 456:	53e70713          	addi	a4,a4,1342 # 990 <putc_buf>
 45a:	973e                	add	a4,a4,a5
 45c:	32072783          	lw	a5,800(a4)
 460:	0017869b          	addiw	a3,a5,1
 464:	32d72023          	sw	a3,800(a4)
 468:	97aa                	add	a5,a5,a0
 46a:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 46e:	47a9                	li	a5,10
 470:	02f90463          	beq	s2,a5,498 <putc+0x62>
 474:	00249713          	slli	a4,s1,0x2
 478:	00000797          	auipc	a5,0x0
 47c:	51878793          	addi	a5,a5,1304 # 990 <putc_buf>
 480:	97ba                	add	a5,a5,a4
 482:	3207a703          	lw	a4,800(a5)
 486:	6785                	lui	a5,0x1
 488:	00f70863          	beq	a4,a5,498 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 48c:	60e2                	ld	ra,24(sp)
 48e:	6442                	ld	s0,16(sp)
 490:	64a2                	ld	s1,8(sp)
 492:	6902                	ld	s2,0(sp)
 494:	6105                	addi	sp,sp,32
 496:	8082                	ret
    write(fd, buf, putc_index[fd]);
 498:	00249793          	slli	a5,s1,0x2
 49c:	00000917          	auipc	s2,0x0
 4a0:	4f490913          	addi	s2,s2,1268 # 990 <putc_buf>
 4a4:	993e                	add	s2,s2,a5
 4a6:	32092603          	lw	a2,800(s2)
 4aa:	85aa                	mv	a1,a0
 4ac:	8526                	mv	a0,s1
 4ae:	00000097          	auipc	ra,0x0
 4b2:	e92080e7          	jalr	-366(ra) # 340 <write>
    putc_index[fd] = 0;
 4b6:	32092023          	sw	zero,800(s2)
}
 4ba:	bfc9                	j	48c <putc+0x56>

00000000000004bc <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4bc:	7139                	addi	sp,sp,-64
 4be:	fc06                	sd	ra,56(sp)
 4c0:	f822                	sd	s0,48(sp)
 4c2:	f426                	sd	s1,40(sp)
 4c4:	f04a                	sd	s2,32(sp)
 4c6:	ec4e                	sd	s3,24(sp)
 4c8:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ca:	c299                	beqz	a3,4d0 <printint+0x14>
 4cc:	0005cd63          	bltz	a1,4e6 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	2581                	sext.w	a1,a1
  neg = 0;
 4d2:	4301                	li	t1,0
 4d4:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4d8:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4da:	2601                	sext.w	a2,a2
 4dc:	00000897          	auipc	a7,0x0
 4e0:	48c88893          	addi	a7,a7,1164 # 968 <digits>
 4e4:	a801                	j	4f4 <printint+0x38>
    x = -xx;
 4e6:	40b005bb          	negw	a1,a1
 4ea:	2581                	sext.w	a1,a1
    neg = 1;
 4ec:	4305                	li	t1,1
    x = -xx;
 4ee:	b7dd                	j	4d4 <printint+0x18>
  }while((x /= base) != 0);
 4f0:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4f2:	8836                	mv	a6,a3
 4f4:	0018069b          	addiw	a3,a6,1
 4f8:	02c5f7bb          	remuw	a5,a1,a2
 4fc:	1782                	slli	a5,a5,0x20
 4fe:	9381                	srli	a5,a5,0x20
 500:	97c6                	add	a5,a5,a7
 502:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x1b0>
 506:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 50a:	0705                	addi	a4,a4,1
 50c:	02c5d7bb          	divuw	a5,a1,a2
 510:	fec5f0e3          	bleu	a2,a1,4f0 <printint+0x34>
  if(neg)
 514:	00030b63          	beqz	t1,52a <printint+0x6e>
    buf[i++] = '-';
 518:	fd040793          	addi	a5,s0,-48
 51c:	96be                	add	a3,a3,a5
 51e:	02d00793          	li	a5,45
 522:	fef68823          	sb	a5,-16(a3)
 526:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 52a:	02d05963          	blez	a3,55c <printint+0xa0>
 52e:	89aa                	mv	s3,a0
 530:	fc040793          	addi	a5,s0,-64
 534:	00d784b3          	add	s1,a5,a3
 538:	fff78913          	addi	s2,a5,-1
 53c:	9936                	add	s2,s2,a3
 53e:	36fd                	addiw	a3,a3,-1
 540:	1682                	slli	a3,a3,0x20
 542:	9281                	srli	a3,a3,0x20
 544:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 548:	fff4c583          	lbu	a1,-1(s1)
 54c:	854e                	mv	a0,s3
 54e:	00000097          	auipc	ra,0x0
 552:	ee8080e7          	jalr	-280(ra) # 436 <putc>
  while(--i >= 0)
 556:	14fd                	addi	s1,s1,-1
 558:	ff2498e3          	bne	s1,s2,548 <printint+0x8c>
}
 55c:	70e2                	ld	ra,56(sp)
 55e:	7442                	ld	s0,48(sp)
 560:	74a2                	ld	s1,40(sp)
 562:	7902                	ld	s2,32(sp)
 564:	69e2                	ld	s3,24(sp)
 566:	6121                	addi	sp,sp,64
 568:	8082                	ret

000000000000056a <fflush>:
void fflush(int fd){
 56a:	1101                	addi	sp,sp,-32
 56c:	ec06                	sd	ra,24(sp)
 56e:	e822                	sd	s0,16(sp)
 570:	e426                	sd	s1,8(sp)
 572:	e04a                	sd	s2,0(sp)
 574:	1000                	addi	s0,sp,32
 576:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 578:	00000097          	auipc	ra,0x0
 57c:	e70080e7          	jalr	-400(ra) # 3e8 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 580:	00291793          	slli	a5,s2,0x2
 584:	00000497          	auipc	s1,0x0
 588:	40c48493          	addi	s1,s1,1036 # 990 <putc_buf>
 58c:	94be                	add	s1,s1,a5
 58e:	3204a603          	lw	a2,800(s1)
 592:	85aa                	mv	a1,a0
 594:	854a                	mv	a0,s2
 596:	00000097          	auipc	ra,0x0
 59a:	daa080e7          	jalr	-598(ra) # 340 <write>
  putc_index[fd] = 0;
 59e:	3204a023          	sw	zero,800(s1)
}
 5a2:	60e2                	ld	ra,24(sp)
 5a4:	6442                	ld	s0,16(sp)
 5a6:	64a2                	ld	s1,8(sp)
 5a8:	6902                	ld	s2,0(sp)
 5aa:	6105                	addi	sp,sp,32
 5ac:	8082                	ret

00000000000005ae <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ae:	7119                	addi	sp,sp,-128
 5b0:	fc86                	sd	ra,120(sp)
 5b2:	f8a2                	sd	s0,112(sp)
 5b4:	f4a6                	sd	s1,104(sp)
 5b6:	f0ca                	sd	s2,96(sp)
 5b8:	ecce                	sd	s3,88(sp)
 5ba:	e8d2                	sd	s4,80(sp)
 5bc:	e4d6                	sd	s5,72(sp)
 5be:	e0da                	sd	s6,64(sp)
 5c0:	fc5e                	sd	s7,56(sp)
 5c2:	f862                	sd	s8,48(sp)
 5c4:	f466                	sd	s9,40(sp)
 5c6:	f06a                	sd	s10,32(sp)
 5c8:	ec6e                	sd	s11,24(sp)
 5ca:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5cc:	0005c483          	lbu	s1,0(a1)
 5d0:	18048d63          	beqz	s1,76a <vprintf+0x1bc>
 5d4:	8aaa                	mv	s5,a0
 5d6:	8b32                	mv	s6,a2
 5d8:	00158913          	addi	s2,a1,1
  state = 0;
 5dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5de:	02500a13          	li	s4,37
      if(c == 'd'){
 5e2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5e6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5ea:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5ee:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f2:	00000b97          	auipc	s7,0x0
 5f6:	376b8b93          	addi	s7,s7,886 # 968 <digits>
 5fa:	a839                	j	618 <vprintf+0x6a>
        putc(fd, c);
 5fc:	85a6                	mv	a1,s1
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e36080e7          	jalr	-458(ra) # 436 <putc>
 608:	a019                	j	60e <vprintf+0x60>
    } else if(state == '%'){
 60a:	01498f63          	beq	s3,s4,628 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 60e:	0905                	addi	s2,s2,1
 610:	fff94483          	lbu	s1,-1(s2)
 614:	14048b63          	beqz	s1,76a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 618:	0004879b          	sext.w	a5,s1
    if(state == 0){
 61c:	fe0997e3          	bnez	s3,60a <vprintf+0x5c>
      if(c == '%'){
 620:	fd479ee3          	bne	a5,s4,5fc <vprintf+0x4e>
        state = '%';
 624:	89be                	mv	s3,a5
 626:	b7e5                	j	60e <vprintf+0x60>
      if(c == 'd'){
 628:	05878063          	beq	a5,s8,668 <vprintf+0xba>
      } else if(c == 'l') {
 62c:	05978c63          	beq	a5,s9,684 <vprintf+0xd6>
      } else if(c == 'x') {
 630:	07a78863          	beq	a5,s10,6a0 <vprintf+0xf2>
      } else if(c == 'p') {
 634:	09b78463          	beq	a5,s11,6bc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 638:	07300713          	li	a4,115
 63c:	0ce78563          	beq	a5,a4,706 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 640:	06300713          	li	a4,99
 644:	0ee78c63          	beq	a5,a4,73c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 648:	11478663          	beq	a5,s4,754 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64c:	85d2                	mv	a1,s4
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	de6080e7          	jalr	-538(ra) # 436 <putc>
        putc(fd, c);
 658:	85a6                	mv	a1,s1
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	dda080e7          	jalr	-550(ra) # 436 <putc>
      }
      state = 0;
 664:	4981                	li	s3,0
 666:	b765                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 668:	008b0493          	addi	s1,s6,8
 66c:	4685                	li	a3,1
 66e:	4629                	li	a2,10
 670:	000b2583          	lw	a1,0(s6)
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e46080e7          	jalr	-442(ra) # 4bc <printint>
 67e:	8b26                	mv	s6,s1
      state = 0;
 680:	4981                	li	s3,0
 682:	b771                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 684:	008b0493          	addi	s1,s6,8
 688:	4681                	li	a3,0
 68a:	4629                	li	a2,10
 68c:	000b2583          	lw	a1,0(s6)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	e2a080e7          	jalr	-470(ra) # 4bc <printint>
 69a:	8b26                	mv	s6,s1
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bf85                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6a0:	008b0493          	addi	s1,s6,8
 6a4:	4681                	li	a3,0
 6a6:	4641                	li	a2,16
 6a8:	000b2583          	lw	a1,0(s6)
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	e0e080e7          	jalr	-498(ra) # 4bc <printint>
 6b6:	8b26                	mv	s6,s1
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bf91                	j	60e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6bc:	008b0793          	addi	a5,s6,8
 6c0:	f8f43423          	sd	a5,-120(s0)
 6c4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6c8:	03000593          	li	a1,48
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	d68080e7          	jalr	-664(ra) # 436 <putc>
  putc(fd, 'x');
 6d6:	85ea                	mv	a1,s10
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	d5c080e7          	jalr	-676(ra) # 436 <putc>
 6e2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e4:	03c9d793          	srli	a5,s3,0x3c
 6e8:	97de                	add	a5,a5,s7
 6ea:	0007c583          	lbu	a1,0(a5)
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	d46080e7          	jalr	-698(ra) # 436 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6f8:	0992                	slli	s3,s3,0x4
 6fa:	34fd                	addiw	s1,s1,-1
 6fc:	f4e5                	bnez	s1,6e4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6fe:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 702:	4981                	li	s3,0
 704:	b729                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 706:	008b0993          	addi	s3,s6,8
 70a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 70e:	c085                	beqz	s1,72e <vprintf+0x180>
        while(*s != 0){
 710:	0004c583          	lbu	a1,0(s1)
 714:	c9a1                	beqz	a1,764 <vprintf+0x1b6>
          putc(fd, *s);
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	d1e080e7          	jalr	-738(ra) # 436 <putc>
          s++;
 720:	0485                	addi	s1,s1,1
        while(*s != 0){
 722:	0004c583          	lbu	a1,0(s1)
 726:	f9e5                	bnez	a1,716 <vprintf+0x168>
        s = va_arg(ap, char*);
 728:	8b4e                	mv	s6,s3
      state = 0;
 72a:	4981                	li	s3,0
 72c:	b5cd                	j	60e <vprintf+0x60>
          s = "(null)";
 72e:	00000497          	auipc	s1,0x0
 732:	25248493          	addi	s1,s1,594 # 980 <digits+0x18>
        while(*s != 0){
 736:	02800593          	li	a1,40
 73a:	bff1                	j	716 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 73c:	008b0493          	addi	s1,s6,8
 740:	000b4583          	lbu	a1,0(s6)
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	cf0080e7          	jalr	-784(ra) # 436 <putc>
 74e:	8b26                	mv	s6,s1
      state = 0;
 750:	4981                	li	s3,0
 752:	bd75                	j	60e <vprintf+0x60>
        putc(fd, c);
 754:	85d2                	mv	a1,s4
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	cde080e7          	jalr	-802(ra) # 436 <putc>
      state = 0;
 760:	4981                	li	s3,0
 762:	b575                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 764:	8b4e                	mv	s6,s3
      state = 0;
 766:	4981                	li	s3,0
 768:	b55d                	j	60e <vprintf+0x60>
    }
  }
}
 76a:	70e6                	ld	ra,120(sp)
 76c:	7446                	ld	s0,112(sp)
 76e:	74a6                	ld	s1,104(sp)
 770:	7906                	ld	s2,96(sp)
 772:	69e6                	ld	s3,88(sp)
 774:	6a46                	ld	s4,80(sp)
 776:	6aa6                	ld	s5,72(sp)
 778:	6b06                	ld	s6,64(sp)
 77a:	7be2                	ld	s7,56(sp)
 77c:	7c42                	ld	s8,48(sp)
 77e:	7ca2                	ld	s9,40(sp)
 780:	7d02                	ld	s10,32(sp)
 782:	6de2                	ld	s11,24(sp)
 784:	6109                	addi	sp,sp,128
 786:	8082                	ret

0000000000000788 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 788:	715d                	addi	sp,sp,-80
 78a:	ec06                	sd	ra,24(sp)
 78c:	e822                	sd	s0,16(sp)
 78e:	1000                	addi	s0,sp,32
 790:	e010                	sd	a2,0(s0)
 792:	e414                	sd	a3,8(s0)
 794:	e818                	sd	a4,16(s0)
 796:	ec1c                	sd	a5,24(s0)
 798:	03043023          	sd	a6,32(s0)
 79c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a4:	8622                	mv	a2,s0
 7a6:	00000097          	auipc	ra,0x0
 7aa:	e08080e7          	jalr	-504(ra) # 5ae <vprintf>
}
 7ae:	60e2                	ld	ra,24(sp)
 7b0:	6442                	ld	s0,16(sp)
 7b2:	6161                	addi	sp,sp,80
 7b4:	8082                	ret

00000000000007b6 <printf>:

void
printf(const char *fmt, ...)
{
 7b6:	711d                	addi	sp,sp,-96
 7b8:	ec06                	sd	ra,24(sp)
 7ba:	e822                	sd	s0,16(sp)
 7bc:	1000                	addi	s0,sp,32
 7be:	e40c                	sd	a1,8(s0)
 7c0:	e810                	sd	a2,16(s0)
 7c2:	ec14                	sd	a3,24(s0)
 7c4:	f018                	sd	a4,32(s0)
 7c6:	f41c                	sd	a5,40(s0)
 7c8:	03043823          	sd	a6,48(s0)
 7cc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d0:	00840613          	addi	a2,s0,8
 7d4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d8:	85aa                	mv	a1,a0
 7da:	4505                	li	a0,1
 7dc:	00000097          	auipc	ra,0x0
 7e0:	dd2080e7          	jalr	-558(ra) # 5ae <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6125                	addi	sp,sp,96
 7ea:	8082                	ret

00000000000007ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ec:	1141                	addi	sp,sp,-16
 7ee:	e422                	sd	s0,8(sp)
 7f0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7f2:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x1a0>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f6:	00000797          	auipc	a5,0x0
 7fa:	19278793          	addi	a5,a5,402 # 988 <__bss_start>
 7fe:	639c                	ld	a5,0(a5)
 800:	a805                	j	830 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 802:	4618                	lw	a4,8(a2)
 804:	9db9                	addw	a1,a1,a4
 806:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 80a:	6398                	ld	a4,0(a5)
 80c:	6318                	ld	a4,0(a4)
 80e:	fee53823          	sd	a4,-16(a0)
 812:	a091                	j	856 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 814:	ff852703          	lw	a4,-8(a0)
 818:	9e39                	addw	a2,a2,a4
 81a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 81c:	ff053703          	ld	a4,-16(a0)
 820:	e398                	sd	a4,0(a5)
 822:	a099                	j	868 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 824:	6398                	ld	a4,0(a5)
 826:	00e7e463          	bltu	a5,a4,82e <free+0x42>
 82a:	00e6ea63          	bltu	a3,a4,83e <free+0x52>
{
 82e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 830:	fed7fae3          	bleu	a3,a5,824 <free+0x38>
 834:	6398                	ld	a4,0(a5)
 836:	00e6e463          	bltu	a3,a4,83e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83a:	fee7eae3          	bltu	a5,a4,82e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 83e:	ff852583          	lw	a1,-8(a0)
 842:	6390                	ld	a2,0(a5)
 844:	02059713          	slli	a4,a1,0x20
 848:	9301                	srli	a4,a4,0x20
 84a:	0712                	slli	a4,a4,0x4
 84c:	9736                	add	a4,a4,a3
 84e:	fae60ae3          	beq	a2,a4,802 <free+0x16>
    bp->s.ptr = p->s.ptr;
 852:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 856:	4790                	lw	a2,8(a5)
 858:	02061713          	slli	a4,a2,0x20
 85c:	9301                	srli	a4,a4,0x20
 85e:	0712                	slli	a4,a4,0x4
 860:	973e                	add	a4,a4,a5
 862:	fae689e3          	beq	a3,a4,814 <free+0x28>
  } else
    p->s.ptr = bp;
 866:	e394                	sd	a3,0(a5)
  freep = p;
 868:	00000717          	auipc	a4,0x0
 86c:	12f73023          	sd	a5,288(a4) # 988 <__bss_start>
}
 870:	6422                	ld	s0,8(sp)
 872:	0141                	addi	sp,sp,16
 874:	8082                	ret

0000000000000876 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 876:	7139                	addi	sp,sp,-64
 878:	fc06                	sd	ra,56(sp)
 87a:	f822                	sd	s0,48(sp)
 87c:	f426                	sd	s1,40(sp)
 87e:	f04a                	sd	s2,32(sp)
 880:	ec4e                	sd	s3,24(sp)
 882:	e852                	sd	s4,16(sp)
 884:	e456                	sd	s5,8(sp)
 886:	e05a                	sd	s6,0(sp)
 888:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88a:	02051993          	slli	s3,a0,0x20
 88e:	0209d993          	srli	s3,s3,0x20
 892:	09bd                	addi	s3,s3,15
 894:	0049d993          	srli	s3,s3,0x4
 898:	2985                	addiw	s3,s3,1
 89a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 89e:	00000797          	auipc	a5,0x0
 8a2:	0ea78793          	addi	a5,a5,234 # 988 <__bss_start>
 8a6:	6388                	ld	a0,0(a5)
 8a8:	c515                	beqz	a0,8d4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ac:	4798                	lw	a4,8(a5)
 8ae:	03277f63          	bleu	s2,a4,8ec <malloc+0x76>
 8b2:	8a4e                	mv	s4,s3
 8b4:	0009871b          	sext.w	a4,s3
 8b8:	6685                	lui	a3,0x1
 8ba:	00d77363          	bleu	a3,a4,8c0 <malloc+0x4a>
 8be:	6a05                	lui	s4,0x1
 8c0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8c4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c8:	00000497          	auipc	s1,0x0
 8cc:	0c048493          	addi	s1,s1,192 # 988 <__bss_start>
  if(p == (char*)-1)
 8d0:	5b7d                	li	s6,-1
 8d2:	a885                	j	942 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8d4:	00000797          	auipc	a5,0x0
 8d8:	56c78793          	addi	a5,a5,1388 # e40 <base>
 8dc:	00000717          	auipc	a4,0x0
 8e0:	0af73623          	sd	a5,172(a4) # 988 <__bss_start>
 8e4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8e6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ea:	b7e1                	j	8b2 <malloc+0x3c>
      if(p->s.size == nunits)
 8ec:	02e90b63          	beq	s2,a4,922 <malloc+0xac>
        p->s.size -= nunits;
 8f0:	4137073b          	subw	a4,a4,s3
 8f4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f6:	1702                	slli	a4,a4,0x20
 8f8:	9301                	srli	a4,a4,0x20
 8fa:	0712                	slli	a4,a4,0x4
 8fc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fe:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 902:	00000717          	auipc	a4,0x0
 906:	08a73323          	sd	a0,134(a4) # 988 <__bss_start>
      return (void*)(p + 1);
 90a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 90e:	70e2                	ld	ra,56(sp)
 910:	7442                	ld	s0,48(sp)
 912:	74a2                	ld	s1,40(sp)
 914:	7902                	ld	s2,32(sp)
 916:	69e2                	ld	s3,24(sp)
 918:	6a42                	ld	s4,16(sp)
 91a:	6aa2                	ld	s5,8(sp)
 91c:	6b02                	ld	s6,0(sp)
 91e:	6121                	addi	sp,sp,64
 920:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 922:	6398                	ld	a4,0(a5)
 924:	e118                	sd	a4,0(a0)
 926:	bff1                	j	902 <malloc+0x8c>
  hp->s.size = nu;
 928:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 92c:	0541                	addi	a0,a0,16
 92e:	00000097          	auipc	ra,0x0
 932:	ebe080e7          	jalr	-322(ra) # 7ec <free>
  return freep;
 936:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 938:	d979                	beqz	a0,90e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93c:	4798                	lw	a4,8(a5)
 93e:	fb2777e3          	bleu	s2,a4,8ec <malloc+0x76>
    if(p == freep)
 942:	6098                	ld	a4,0(s1)
 944:	853e                	mv	a0,a5
 946:	fef71ae3          	bne	a4,a5,93a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 94a:	8552                	mv	a0,s4
 94c:	00000097          	auipc	ra,0x0
 950:	a5c080e7          	jalr	-1444(ra) # 3a8 <sbrk>
  if(p == (char*)-1)
 954:	fd651ae3          	bne	a0,s6,928 <malloc+0xb2>
        return 0;
 958:	4501                	li	a0,0
 95a:	bf55                	j	90e <malloc+0x98>
