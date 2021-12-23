
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2f8080e7          	jalr	760(ra) # 300 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2f2080e7          	jalr	754(ra) # 308 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	378080e7          	jalr	888(ra) # 398 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  30:	87aa                	mv	a5,a0
  32:	0585                	addi	a1,a1,1
  34:	0785                	addi	a5,a5,1
  36:	fff5c703          	lbu	a4,-1(a1)
  3a:	fee78fa3          	sb	a4,-1(a5)
  3e:	fb75                	bnez	a4,32 <strcpy+0x8>
    ;
  return os;
}
  40:	6422                	ld	s0,8(sp)
  42:	0141                	addi	sp,sp,16
  44:	8082                	ret

0000000000000046 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  46:	1141                	addi	sp,sp,-16
  48:	e422                	sd	s0,8(sp)
  4a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  4c:	00054783          	lbu	a5,0(a0)
  50:	cf91                	beqz	a5,6c <strcmp+0x26>
  52:	0005c703          	lbu	a4,0(a1)
  56:	00f71b63          	bne	a4,a5,6c <strcmp+0x26>
    p++, q++;
  5a:	0505                	addi	a0,a0,1
  5c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  5e:	00054783          	lbu	a5,0(a0)
  62:	c789                	beqz	a5,6c <strcmp+0x26>
  64:	0005c703          	lbu	a4,0(a1)
  68:	fef709e3          	beq	a4,a5,5a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  6c:	0005c503          	lbu	a0,0(a1)
}
  70:	40a7853b          	subw	a0,a5,a0
  74:	6422                	ld	s0,8(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint
strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  80:	00054783          	lbu	a5,0(a0)
  84:	cf91                	beqz	a5,a0 <strlen+0x26>
  86:	0505                	addi	a0,a0,1
  88:	87aa                	mv	a5,a0
  8a:	4685                	li	a3,1
  8c:	9e89                	subw	a3,a3,a0
  8e:	00f6853b          	addw	a0,a3,a5
  92:	0785                	addi	a5,a5,1
  94:	fff7c703          	lbu	a4,-1(a5)
  98:	fb7d                	bnez	a4,8e <strlen+0x14>
    ;
  return n;
}
  9a:	6422                	ld	s0,8(sp)
  9c:	0141                	addi	sp,sp,16
  9e:	8082                	ret
  for(n = 0; s[n]; n++)
  a0:	4501                	li	a0,0
  a2:	bfe5                	j	9a <strlen+0x20>

00000000000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  aa:	ce09                	beqz	a2,c4 <memset+0x20>
  ac:	87aa                	mv	a5,a0
  ae:	fff6071b          	addiw	a4,a2,-1
  b2:	1702                	slli	a4,a4,0x20
  b4:	9301                	srli	a4,a4,0x20
  b6:	0705                	addi	a4,a4,1
  b8:	972a                	add	a4,a4,a0
    cdst[i] = c;
  ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  be:	0785                	addi	a5,a5,1
  c0:	fee79de3          	bne	a5,a4,ba <memset+0x16>
  }
  return dst;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strchr>:

char*
strchr(const char *s, char c)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf91                	beqz	a5,f0 <strchr+0x26>
    if(*s == c)
  d6:	00f58a63          	beq	a1,a5,ea <strchr+0x20>
  for(; *s; s++)
  da:	0505                	addi	a0,a0,1
  dc:	00054783          	lbu	a5,0(a0)
  e0:	c781                	beqz	a5,e8 <strchr+0x1e>
    if(*s == c)
  e2:	feb79ce3          	bne	a5,a1,da <strchr+0x10>
  e6:	a011                	j	ea <strchr+0x20>
      return (char*)s;
  return 0;
  e8:	4501                	li	a0,0
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  return 0;
  f0:	4501                	li	a0,0
  f2:	bfe5                	j	ea <strchr+0x20>

00000000000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	711d                	addi	sp,sp,-96
  f6:	ec86                	sd	ra,88(sp)
  f8:	e8a2                	sd	s0,80(sp)
  fa:	e4a6                	sd	s1,72(sp)
  fc:	e0ca                	sd	s2,64(sp)
  fe:	fc4e                	sd	s3,56(sp)
 100:	f852                	sd	s4,48(sp)
 102:	f456                	sd	s5,40(sp)
 104:	f05a                	sd	s6,32(sp)
 106:	ec5e                	sd	s7,24(sp)
 108:	1080                	addi	s0,sp,96
 10a:	8baa                	mv	s7,a0
 10c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 10e:	892a                	mv	s2,a0
 110:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 112:	4aa9                	li	s5,10
 114:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 116:	0019849b          	addiw	s1,s3,1
 11a:	0344d863          	ble	s4,s1,14a <gets+0x56>
    cc = read(0, &c, 1);
 11e:	4605                	li	a2,1
 120:	faf40593          	addi	a1,s0,-81
 124:	4501                	li	a0,0
 126:	00000097          	auipc	ra,0x0
 12a:	1fa080e7          	jalr	506(ra) # 320 <read>
    if(cc < 1)
 12e:	00a05e63          	blez	a0,14a <gets+0x56>
    buf[i++] = c;
 132:	faf44783          	lbu	a5,-81(s0)
 136:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 13a:	01578763          	beq	a5,s5,148 <gets+0x54>
 13e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 140:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 142:	fd679ae3          	bne	a5,s6,116 <gets+0x22>
 146:	a011                	j	14a <gets+0x56>
  for(i=0; i+1 < max; ){
 148:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 14a:	99de                	add	s3,s3,s7
 14c:	00098023          	sb	zero,0(s3)
  return buf;
}
 150:	855e                	mv	a0,s7
 152:	60e6                	ld	ra,88(sp)
 154:	6446                	ld	s0,80(sp)
 156:	64a6                	ld	s1,72(sp)
 158:	6906                	ld	s2,64(sp)
 15a:	79e2                	ld	s3,56(sp)
 15c:	7a42                	ld	s4,48(sp)
 15e:	7aa2                	ld	s5,40(sp)
 160:	7b02                	ld	s6,32(sp)
 162:	6be2                	ld	s7,24(sp)
 164:	6125                	addi	sp,sp,96
 166:	8082                	ret

0000000000000168 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 16e:	00054683          	lbu	a3,0(a0)
 172:	fd06879b          	addiw	a5,a3,-48
 176:	0ff7f793          	andi	a5,a5,255
 17a:	4725                	li	a4,9
 17c:	02f76963          	bltu	a4,a5,1ae <atoi+0x46>
 180:	862a                	mv	a2,a0
  n = 0;
 182:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 184:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 186:	0605                	addi	a2,a2,1
 188:	0025179b          	slliw	a5,a0,0x2
 18c:	9fa9                	addw	a5,a5,a0
 18e:	0017979b          	slliw	a5,a5,0x1
 192:	9fb5                	addw	a5,a5,a3
 194:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 198:	00064683          	lbu	a3,0(a2)
 19c:	fd06871b          	addiw	a4,a3,-48
 1a0:	0ff77713          	andi	a4,a4,255
 1a4:	fee5f1e3          	bleu	a4,a1,186 <atoi+0x1e>
  return n;
}
 1a8:	6422                	ld	s0,8(sp)
 1aa:	0141                	addi	sp,sp,16
 1ac:	8082                	ret
  n = 0;
 1ae:	4501                	li	a0,0
 1b0:	bfe5                	j	1a8 <atoi+0x40>

00000000000001b2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1b2:	1141                	addi	sp,sp,-16
 1b4:	e422                	sd	s0,8(sp)
 1b6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1b8:	02b57663          	bleu	a1,a0,1e4 <memmove+0x32>
    while(n-- > 0)
 1bc:	02c05163          	blez	a2,1de <memmove+0x2c>
 1c0:	fff6079b          	addiw	a5,a2,-1
 1c4:	1782                	slli	a5,a5,0x20
 1c6:	9381                	srli	a5,a5,0x20
 1c8:	0785                	addi	a5,a5,1
 1ca:	97aa                	add	a5,a5,a0
  dst = vdst;
 1cc:	872a                	mv	a4,a0
      *dst++ = *src++;
 1ce:	0585                	addi	a1,a1,1
 1d0:	0705                	addi	a4,a4,1
 1d2:	fff5c683          	lbu	a3,-1(a1)
 1d6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1da:	fee79ae3          	bne	a5,a4,1ce <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
    dst += n;
 1e4:	00c50733          	add	a4,a0,a2
    src += n;
 1e8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 1ea:	fec05ae3          	blez	a2,1de <memmove+0x2c>
 1ee:	fff6079b          	addiw	a5,a2,-1
 1f2:	1782                	slli	a5,a5,0x20
 1f4:	9381                	srli	a5,a5,0x20
 1f6:	fff7c793          	not	a5,a5
 1fa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 1fc:	15fd                	addi	a1,a1,-1
 1fe:	177d                	addi	a4,a4,-1
 200:	0005c683          	lbu	a3,0(a1)
 204:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 208:	fef71ae3          	bne	a4,a5,1fc <memmove+0x4a>
 20c:	bfc9                	j	1de <memmove+0x2c>

000000000000020e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 214:	ce15                	beqz	a2,250 <memcmp+0x42>
 216:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 21a:	00054783          	lbu	a5,0(a0)
 21e:	0005c703          	lbu	a4,0(a1)
 222:	02e79063          	bne	a5,a4,242 <memcmp+0x34>
 226:	1682                	slli	a3,a3,0x20
 228:	9281                	srli	a3,a3,0x20
 22a:	0685                	addi	a3,a3,1
 22c:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 22e:	0505                	addi	a0,a0,1
    p2++;
 230:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 232:	00d50d63          	beq	a0,a3,24c <memcmp+0x3e>
    if (*p1 != *p2) {
 236:	00054783          	lbu	a5,0(a0)
 23a:	0005c703          	lbu	a4,0(a1)
 23e:	fee788e3          	beq	a5,a4,22e <memcmp+0x20>
      return *p1 - *p2;
 242:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret
  return 0;
 24c:	4501                	li	a0,0
 24e:	bfe5                	j	246 <memcmp+0x38>
 250:	4501                	li	a0,0
 252:	bfd5                	j	246 <memcmp+0x38>

0000000000000254 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 254:	1141                	addi	sp,sp,-16
 256:	e406                	sd	ra,8(sp)
 258:	e022                	sd	s0,0(sp)
 25a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 25c:	00000097          	auipc	ra,0x0
 260:	f56080e7          	jalr	-170(ra) # 1b2 <memmove>
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <close>:

int close(int fd){
 26c:	1101                	addi	sp,sp,-32
 26e:	ec06                	sd	ra,24(sp)
 270:	e822                	sd	s0,16(sp)
 272:	e426                	sd	s1,8(sp)
 274:	1000                	addi	s0,sp,32
 276:	84aa                	mv	s1,a0
  fflush(fd);
 278:	00000097          	auipc	ra,0x0
 27c:	2da080e7          	jalr	730(ra) # 552 <fflush>
  char* buf = get_putc_buf(fd);
 280:	8526                	mv	a0,s1
 282:	00000097          	auipc	ra,0x0
 286:	14e080e7          	jalr	334(ra) # 3d0 <get_putc_buf>
  if(buf){
 28a:	cd11                	beqz	a0,2a6 <close+0x3a>
    free(buf);
 28c:	00000097          	auipc	ra,0x0
 290:	548080e7          	jalr	1352(ra) # 7d4 <free>
    putc_buf[fd] = 0;
 294:	00349713          	slli	a4,s1,0x3
 298:	00000797          	auipc	a5,0x0
 29c:	6d878793          	addi	a5,a5,1752 # 970 <putc_buf>
 2a0:	97ba                	add	a5,a5,a4
 2a2:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2a6:	8526                	mv	a0,s1
 2a8:	00000097          	auipc	ra,0x0
 2ac:	088080e7          	jalr	136(ra) # 330 <sclose>
}
 2b0:	60e2                	ld	ra,24(sp)
 2b2:	6442                	ld	s0,16(sp)
 2b4:	64a2                	ld	s1,8(sp)
 2b6:	6105                	addi	sp,sp,32
 2b8:	8082                	ret

00000000000002ba <stat>:
{
 2ba:	1101                	addi	sp,sp,-32
 2bc:	ec06                	sd	ra,24(sp)
 2be:	e822                	sd	s0,16(sp)
 2c0:	e426                	sd	s1,8(sp)
 2c2:	e04a                	sd	s2,0(sp)
 2c4:	1000                	addi	s0,sp,32
 2c6:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 2c8:	4581                	li	a1,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	07e080e7          	jalr	126(ra) # 348 <open>
  if(fd < 0)
 2d2:	02054563          	bltz	a0,2fc <stat+0x42>
 2d6:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 2d8:	85ca                	mv	a1,s2
 2da:	00000097          	auipc	ra,0x0
 2de:	086080e7          	jalr	134(ra) # 360 <fstat>
 2e2:	892a                	mv	s2,a0
  close(fd);
 2e4:	8526                	mv	a0,s1
 2e6:	00000097          	auipc	ra,0x0
 2ea:	f86080e7          	jalr	-122(ra) # 26c <close>
}
 2ee:	854a                	mv	a0,s2
 2f0:	60e2                	ld	ra,24(sp)
 2f2:	6442                	ld	s0,16(sp)
 2f4:	64a2                	ld	s1,8(sp)
 2f6:	6902                	ld	s2,0(sp)
 2f8:	6105                	addi	sp,sp,32
 2fa:	8082                	ret
    return -1;
 2fc:	597d                	li	s2,-1
 2fe:	bfc5                	j	2ee <stat+0x34>

0000000000000300 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 300:	4885                	li	a7,1
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <exit>:
.global exit
exit:
 li a7, SYS_exit
 308:	4889                	li	a7,2
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <wait>:
.global wait
wait:
 li a7, SYS_wait
 310:	488d                	li	a7,3
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 318:	4891                	li	a7,4
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <read>:
.global read
read:
 li a7, SYS_read
 320:	4895                	li	a7,5
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <write>:
.global write
write:
 li a7, SYS_write
 328:	48c1                	li	a7,16
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 330:	48d5                	li	a7,21
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <kill>:
.global kill
kill:
 li a7, SYS_kill
 338:	4899                	li	a7,6
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <exec>:
.global exec
exec:
 li a7, SYS_exec
 340:	489d                	li	a7,7
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <open>:
.global open
open:
 li a7, SYS_open
 348:	48bd                	li	a7,15
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 350:	48c5                	li	a7,17
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 358:	48c9                	li	a7,18
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 360:	48a1                	li	a7,8
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <link>:
.global link
link:
 li a7, SYS_link
 368:	48cd                	li	a7,19
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 370:	48d1                	li	a7,20
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 378:	48a5                	li	a7,9
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <dup>:
.global dup
dup:
 li a7, SYS_dup
 380:	48a9                	li	a7,10
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 388:	48ad                	li	a7,11
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 390:	48b1                	li	a7,12
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 398:	48b5                	li	a7,13
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a0:	48b9                	li	a7,14
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3a8:	48d9                	li	a7,22
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3b0:	48dd                	li	a7,23
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3b8:	48e1                	li	a7,24
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3c0:	48e5                	li	a7,25
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 3c8:	48e9                	li	a7,26
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 3d0:	1101                	addi	sp,sp,-32
 3d2:	ec06                	sd	ra,24(sp)
 3d4:	e822                	sd	s0,16(sp)
 3d6:	e426                	sd	s1,8(sp)
 3d8:	1000                	addi	s0,sp,32
 3da:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 3dc:	00351693          	slli	a3,a0,0x3
 3e0:	00000797          	auipc	a5,0x0
 3e4:	59078793          	addi	a5,a5,1424 # 970 <putc_buf>
 3e8:	97b6                	add	a5,a5,a3
 3ea:	6388                	ld	a0,0(a5)
  if(buf) {
 3ec:	c511                	beqz	a0,3f8 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 3ee:	60e2                	ld	ra,24(sp)
 3f0:	6442                	ld	s0,16(sp)
 3f2:	64a2                	ld	s1,8(sp)
 3f4:	6105                	addi	sp,sp,32
 3f6:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 3f8:	6505                	lui	a0,0x1
 3fa:	00000097          	auipc	ra,0x0
 3fe:	464080e7          	jalr	1124(ra) # 85e <malloc>
  putc_buf[fd] = buf;
 402:	00000797          	auipc	a5,0x0
 406:	56e78793          	addi	a5,a5,1390 # 970 <putc_buf>
 40a:	00349713          	slli	a4,s1,0x3
 40e:	973e                	add	a4,a4,a5
 410:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 412:	00249713          	slli	a4,s1,0x2
 416:	973e                	add	a4,a4,a5
 418:	32072023          	sw	zero,800(a4)
  return buf;
 41c:	bfc9                	j	3ee <get_putc_buf+0x1e>

000000000000041e <putc>:

static void
putc(int fd, char c)
{
 41e:	1101                	addi	sp,sp,-32
 420:	ec06                	sd	ra,24(sp)
 422:	e822                	sd	s0,16(sp)
 424:	e426                	sd	s1,8(sp)
 426:	e04a                	sd	s2,0(sp)
 428:	1000                	addi	s0,sp,32
 42a:	84aa                	mv	s1,a0
 42c:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 42e:	00000097          	auipc	ra,0x0
 432:	fa2080e7          	jalr	-94(ra) # 3d0 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 436:	00249793          	slli	a5,s1,0x2
 43a:	00000717          	auipc	a4,0x0
 43e:	53670713          	addi	a4,a4,1334 # 970 <putc_buf>
 442:	973e                	add	a4,a4,a5
 444:	32072783          	lw	a5,800(a4)
 448:	0017869b          	addiw	a3,a5,1
 44c:	32d72023          	sw	a3,800(a4)
 450:	97aa                	add	a5,a5,a0
 452:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 456:	47a9                	li	a5,10
 458:	02f90463          	beq	s2,a5,480 <putc+0x62>
 45c:	00249713          	slli	a4,s1,0x2
 460:	00000797          	auipc	a5,0x0
 464:	51078793          	addi	a5,a5,1296 # 970 <putc_buf>
 468:	97ba                	add	a5,a5,a4
 46a:	3207a703          	lw	a4,800(a5)
 46e:	6785                	lui	a5,0x1
 470:	00f70863          	beq	a4,a5,480 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 474:	60e2                	ld	ra,24(sp)
 476:	6442                	ld	s0,16(sp)
 478:	64a2                	ld	s1,8(sp)
 47a:	6902                	ld	s2,0(sp)
 47c:	6105                	addi	sp,sp,32
 47e:	8082                	ret
    write(fd, buf, putc_index[fd]);
 480:	00249793          	slli	a5,s1,0x2
 484:	00000917          	auipc	s2,0x0
 488:	4ec90913          	addi	s2,s2,1260 # 970 <putc_buf>
 48c:	993e                	add	s2,s2,a5
 48e:	32092603          	lw	a2,800(s2)
 492:	85aa                	mv	a1,a0
 494:	8526                	mv	a0,s1
 496:	00000097          	auipc	ra,0x0
 49a:	e92080e7          	jalr	-366(ra) # 328 <write>
    putc_index[fd] = 0;
 49e:	32092023          	sw	zero,800(s2)
}
 4a2:	bfc9                	j	474 <putc+0x56>

00000000000004a4 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a4:	7139                	addi	sp,sp,-64
 4a6:	fc06                	sd	ra,56(sp)
 4a8:	f822                	sd	s0,48(sp)
 4aa:	f426                	sd	s1,40(sp)
 4ac:	f04a                	sd	s2,32(sp)
 4ae:	ec4e                	sd	s3,24(sp)
 4b0:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b2:	c299                	beqz	a3,4b8 <printint+0x14>
 4b4:	0005cd63          	bltz	a1,4ce <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b8:	2581                	sext.w	a1,a1
  neg = 0;
 4ba:	4301                	li	t1,0
 4bc:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4c0:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4c2:	2601                	sext.w	a2,a2
 4c4:	00000897          	auipc	a7,0x0
 4c8:	48488893          	addi	a7,a7,1156 # 948 <digits>
 4cc:	a801                	j	4dc <printint+0x38>
    x = -xx;
 4ce:	40b005bb          	negw	a1,a1
 4d2:	2581                	sext.w	a1,a1
    neg = 1;
 4d4:	4305                	li	t1,1
    x = -xx;
 4d6:	b7dd                	j	4bc <printint+0x18>
  }while((x /= base) != 0);
 4d8:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4da:	8836                	mv	a6,a3
 4dc:	0018069b          	addiw	a3,a6,1
 4e0:	02c5f7bb          	remuw	a5,a1,a2
 4e4:	1782                	slli	a5,a5,0x20
 4e6:	9381                	srli	a5,a5,0x20
 4e8:	97c6                	add	a5,a5,a7
 4ea:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x1d0>
 4ee:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 4f2:	0705                	addi	a4,a4,1
 4f4:	02c5d7bb          	divuw	a5,a1,a2
 4f8:	fec5f0e3          	bleu	a2,a1,4d8 <printint+0x34>
  if(neg)
 4fc:	00030b63          	beqz	t1,512 <printint+0x6e>
    buf[i++] = '-';
 500:	fd040793          	addi	a5,s0,-48
 504:	96be                	add	a3,a3,a5
 506:	02d00793          	li	a5,45
 50a:	fef68823          	sb	a5,-16(a3)
 50e:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 512:	02d05963          	blez	a3,544 <printint+0xa0>
 516:	89aa                	mv	s3,a0
 518:	fc040793          	addi	a5,s0,-64
 51c:	00d784b3          	add	s1,a5,a3
 520:	fff78913          	addi	s2,a5,-1
 524:	9936                	add	s2,s2,a3
 526:	36fd                	addiw	a3,a3,-1
 528:	1682                	slli	a3,a3,0x20
 52a:	9281                	srli	a3,a3,0x20
 52c:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 530:	fff4c583          	lbu	a1,-1(s1)
 534:	854e                	mv	a0,s3
 536:	00000097          	auipc	ra,0x0
 53a:	ee8080e7          	jalr	-280(ra) # 41e <putc>
  while(--i >= 0)
 53e:	14fd                	addi	s1,s1,-1
 540:	ff2498e3          	bne	s1,s2,530 <printint+0x8c>
}
 544:	70e2                	ld	ra,56(sp)
 546:	7442                	ld	s0,48(sp)
 548:	74a2                	ld	s1,40(sp)
 54a:	7902                	ld	s2,32(sp)
 54c:	69e2                	ld	s3,24(sp)
 54e:	6121                	addi	sp,sp,64
 550:	8082                	ret

0000000000000552 <fflush>:
void fflush(int fd){
 552:	1101                	addi	sp,sp,-32
 554:	ec06                	sd	ra,24(sp)
 556:	e822                	sd	s0,16(sp)
 558:	e426                	sd	s1,8(sp)
 55a:	e04a                	sd	s2,0(sp)
 55c:	1000                	addi	s0,sp,32
 55e:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 560:	00000097          	auipc	ra,0x0
 564:	e70080e7          	jalr	-400(ra) # 3d0 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 568:	00291793          	slli	a5,s2,0x2
 56c:	00000497          	auipc	s1,0x0
 570:	40448493          	addi	s1,s1,1028 # 970 <putc_buf>
 574:	94be                	add	s1,s1,a5
 576:	3204a603          	lw	a2,800(s1)
 57a:	85aa                	mv	a1,a0
 57c:	854a                	mv	a0,s2
 57e:	00000097          	auipc	ra,0x0
 582:	daa080e7          	jalr	-598(ra) # 328 <write>
  putc_index[fd] = 0;
 586:	3204a023          	sw	zero,800(s1)
}
 58a:	60e2                	ld	ra,24(sp)
 58c:	6442                	ld	s0,16(sp)
 58e:	64a2                	ld	s1,8(sp)
 590:	6902                	ld	s2,0(sp)
 592:	6105                	addi	sp,sp,32
 594:	8082                	ret

0000000000000596 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 596:	7119                	addi	sp,sp,-128
 598:	fc86                	sd	ra,120(sp)
 59a:	f8a2                	sd	s0,112(sp)
 59c:	f4a6                	sd	s1,104(sp)
 59e:	f0ca                	sd	s2,96(sp)
 5a0:	ecce                	sd	s3,88(sp)
 5a2:	e8d2                	sd	s4,80(sp)
 5a4:	e4d6                	sd	s5,72(sp)
 5a6:	e0da                	sd	s6,64(sp)
 5a8:	fc5e                	sd	s7,56(sp)
 5aa:	f862                	sd	s8,48(sp)
 5ac:	f466                	sd	s9,40(sp)
 5ae:	f06a                	sd	s10,32(sp)
 5b0:	ec6e                	sd	s11,24(sp)
 5b2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5b4:	0005c483          	lbu	s1,0(a1)
 5b8:	18048d63          	beqz	s1,752 <vprintf+0x1bc>
 5bc:	8aaa                	mv	s5,a0
 5be:	8b32                	mv	s6,a2
 5c0:	00158913          	addi	s2,a1,1
  state = 0;
 5c4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5c6:	02500a13          	li	s4,37
      if(c == 'd'){
 5ca:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5ce:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5d2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5d6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5da:	00000b97          	auipc	s7,0x0
 5de:	36eb8b93          	addi	s7,s7,878 # 948 <digits>
 5e2:	a839                	j	600 <vprintf+0x6a>
        putc(fd, c);
 5e4:	85a6                	mv	a1,s1
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e36080e7          	jalr	-458(ra) # 41e <putc>
 5f0:	a019                	j	5f6 <vprintf+0x60>
    } else if(state == '%'){
 5f2:	01498f63          	beq	s3,s4,610 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5f6:	0905                	addi	s2,s2,1
 5f8:	fff94483          	lbu	s1,-1(s2)
 5fc:	14048b63          	beqz	s1,752 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 600:	0004879b          	sext.w	a5,s1
    if(state == 0){
 604:	fe0997e3          	bnez	s3,5f2 <vprintf+0x5c>
      if(c == '%'){
 608:	fd479ee3          	bne	a5,s4,5e4 <vprintf+0x4e>
        state = '%';
 60c:	89be                	mv	s3,a5
 60e:	b7e5                	j	5f6 <vprintf+0x60>
      if(c == 'd'){
 610:	05878063          	beq	a5,s8,650 <vprintf+0xba>
      } else if(c == 'l') {
 614:	05978c63          	beq	a5,s9,66c <vprintf+0xd6>
      } else if(c == 'x') {
 618:	07a78863          	beq	a5,s10,688 <vprintf+0xf2>
      } else if(c == 'p') {
 61c:	09b78463          	beq	a5,s11,6a4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 620:	07300713          	li	a4,115
 624:	0ce78563          	beq	a5,a4,6ee <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 628:	06300713          	li	a4,99
 62c:	0ee78c63          	beq	a5,a4,724 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 630:	11478663          	beq	a5,s4,73c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 634:	85d2                	mv	a1,s4
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	de6080e7          	jalr	-538(ra) # 41e <putc>
        putc(fd, c);
 640:	85a6                	mv	a1,s1
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	dda080e7          	jalr	-550(ra) # 41e <putc>
      }
      state = 0;
 64c:	4981                	li	s3,0
 64e:	b765                	j	5f6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 650:	008b0493          	addi	s1,s6,8
 654:	4685                	li	a3,1
 656:	4629                	li	a2,10
 658:	000b2583          	lw	a1,0(s6)
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	e46080e7          	jalr	-442(ra) # 4a4 <printint>
 666:	8b26                	mv	s6,s1
      state = 0;
 668:	4981                	li	s3,0
 66a:	b771                	j	5f6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 66c:	008b0493          	addi	s1,s6,8
 670:	4681                	li	a3,0
 672:	4629                	li	a2,10
 674:	000b2583          	lw	a1,0(s6)
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e2a080e7          	jalr	-470(ra) # 4a4 <printint>
 682:	8b26                	mv	s6,s1
      state = 0;
 684:	4981                	li	s3,0
 686:	bf85                	j	5f6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 688:	008b0493          	addi	s1,s6,8
 68c:	4681                	li	a3,0
 68e:	4641                	li	a2,16
 690:	000b2583          	lw	a1,0(s6)
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	e0e080e7          	jalr	-498(ra) # 4a4 <printint>
 69e:	8b26                	mv	s6,s1
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bf91                	j	5f6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6a4:	008b0793          	addi	a5,s6,8
 6a8:	f8f43423          	sd	a5,-120(s0)
 6ac:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6b0:	03000593          	li	a1,48
 6b4:	8556                	mv	a0,s5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	d68080e7          	jalr	-664(ra) # 41e <putc>
  putc(fd, 'x');
 6be:	85ea                	mv	a1,s10
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	d5c080e7          	jalr	-676(ra) # 41e <putc>
 6ca:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6cc:	03c9d793          	srli	a5,s3,0x3c
 6d0:	97de                	add	a5,a5,s7
 6d2:	0007c583          	lbu	a1,0(a5)
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	d46080e7          	jalr	-698(ra) # 41e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e0:	0992                	slli	s3,s3,0x4
 6e2:	34fd                	addiw	s1,s1,-1
 6e4:	f4e5                	bnez	s1,6cc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6e6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b729                	j	5f6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6ee:	008b0993          	addi	s3,s6,8
 6f2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6f6:	c085                	beqz	s1,716 <vprintf+0x180>
        while(*s != 0){
 6f8:	0004c583          	lbu	a1,0(s1)
 6fc:	c9a1                	beqz	a1,74c <vprintf+0x1b6>
          putc(fd, *s);
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	d1e080e7          	jalr	-738(ra) # 41e <putc>
          s++;
 708:	0485                	addi	s1,s1,1
        while(*s != 0){
 70a:	0004c583          	lbu	a1,0(s1)
 70e:	f9e5                	bnez	a1,6fe <vprintf+0x168>
        s = va_arg(ap, char*);
 710:	8b4e                	mv	s6,s3
      state = 0;
 712:	4981                	li	s3,0
 714:	b5cd                	j	5f6 <vprintf+0x60>
          s = "(null)";
 716:	00000497          	auipc	s1,0x0
 71a:	24a48493          	addi	s1,s1,586 # 960 <digits+0x18>
        while(*s != 0){
 71e:	02800593          	li	a1,40
 722:	bff1                	j	6fe <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 724:	008b0493          	addi	s1,s6,8
 728:	000b4583          	lbu	a1,0(s6)
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	cf0080e7          	jalr	-784(ra) # 41e <putc>
 736:	8b26                	mv	s6,s1
      state = 0;
 738:	4981                	li	s3,0
 73a:	bd75                	j	5f6 <vprintf+0x60>
        putc(fd, c);
 73c:	85d2                	mv	a1,s4
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	cde080e7          	jalr	-802(ra) # 41e <putc>
      state = 0;
 748:	4981                	li	s3,0
 74a:	b575                	j	5f6 <vprintf+0x60>
        s = va_arg(ap, char*);
 74c:	8b4e                	mv	s6,s3
      state = 0;
 74e:	4981                	li	s3,0
 750:	b55d                	j	5f6 <vprintf+0x60>
    }
  }
}
 752:	70e6                	ld	ra,120(sp)
 754:	7446                	ld	s0,112(sp)
 756:	74a6                	ld	s1,104(sp)
 758:	7906                	ld	s2,96(sp)
 75a:	69e6                	ld	s3,88(sp)
 75c:	6a46                	ld	s4,80(sp)
 75e:	6aa6                	ld	s5,72(sp)
 760:	6b06                	ld	s6,64(sp)
 762:	7be2                	ld	s7,56(sp)
 764:	7c42                	ld	s8,48(sp)
 766:	7ca2                	ld	s9,40(sp)
 768:	7d02                	ld	s10,32(sp)
 76a:	6de2                	ld	s11,24(sp)
 76c:	6109                	addi	sp,sp,128
 76e:	8082                	ret

0000000000000770 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 770:	715d                	addi	sp,sp,-80
 772:	ec06                	sd	ra,24(sp)
 774:	e822                	sd	s0,16(sp)
 776:	1000                	addi	s0,sp,32
 778:	e010                	sd	a2,0(s0)
 77a:	e414                	sd	a3,8(s0)
 77c:	e818                	sd	a4,16(s0)
 77e:	ec1c                	sd	a5,24(s0)
 780:	03043023          	sd	a6,32(s0)
 784:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 788:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 78c:	8622                	mv	a2,s0
 78e:	00000097          	auipc	ra,0x0
 792:	e08080e7          	jalr	-504(ra) # 596 <vprintf>
}
 796:	60e2                	ld	ra,24(sp)
 798:	6442                	ld	s0,16(sp)
 79a:	6161                	addi	sp,sp,80
 79c:	8082                	ret

000000000000079e <printf>:

void
printf(const char *fmt, ...)
{
 79e:	711d                	addi	sp,sp,-96
 7a0:	ec06                	sd	ra,24(sp)
 7a2:	e822                	sd	s0,16(sp)
 7a4:	1000                	addi	s0,sp,32
 7a6:	e40c                	sd	a1,8(s0)
 7a8:	e810                	sd	a2,16(s0)
 7aa:	ec14                	sd	a3,24(s0)
 7ac:	f018                	sd	a4,32(s0)
 7ae:	f41c                	sd	a5,40(s0)
 7b0:	03043823          	sd	a6,48(s0)
 7b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b8:	00840613          	addi	a2,s0,8
 7bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c0:	85aa                	mv	a1,a0
 7c2:	4505                	li	a0,1
 7c4:	00000097          	auipc	ra,0x0
 7c8:	dd2080e7          	jalr	-558(ra) # 596 <vprintf>
}
 7cc:	60e2                	ld	ra,24(sp)
 7ce:	6442                	ld	s0,16(sp)
 7d0:	6125                	addi	sp,sp,96
 7d2:	8082                	ret

00000000000007d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d4:	1141                	addi	sp,sp,-16
 7d6:	e422                	sd	s0,8(sp)
 7d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7da:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x1c0>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7de:	00000797          	auipc	a5,0x0
 7e2:	18a78793          	addi	a5,a5,394 # 968 <__bss_start>
 7e6:	639c                	ld	a5,0(a5)
 7e8:	a805                	j	818 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ea:	4618                	lw	a4,8(a2)
 7ec:	9db9                	addw	a1,a1,a4
 7ee:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f2:	6398                	ld	a4,0(a5)
 7f4:	6318                	ld	a4,0(a4)
 7f6:	fee53823          	sd	a4,-16(a0)
 7fa:	a091                	j	83e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7fc:	ff852703          	lw	a4,-8(a0)
 800:	9e39                	addw	a2,a2,a4
 802:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 804:	ff053703          	ld	a4,-16(a0)
 808:	e398                	sd	a4,0(a5)
 80a:	a099                	j	850 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	6398                	ld	a4,0(a5)
 80e:	00e7e463          	bltu	a5,a4,816 <free+0x42>
 812:	00e6ea63          	bltu	a3,a4,826 <free+0x52>
{
 816:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 818:	fed7fae3          	bleu	a3,a5,80c <free+0x38>
 81c:	6398                	ld	a4,0(a5)
 81e:	00e6e463          	bltu	a3,a4,826 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 822:	fee7eae3          	bltu	a5,a4,816 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 826:	ff852583          	lw	a1,-8(a0)
 82a:	6390                	ld	a2,0(a5)
 82c:	02059713          	slli	a4,a1,0x20
 830:	9301                	srli	a4,a4,0x20
 832:	0712                	slli	a4,a4,0x4
 834:	9736                	add	a4,a4,a3
 836:	fae60ae3          	beq	a2,a4,7ea <free+0x16>
    bp->s.ptr = p->s.ptr;
 83a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 83e:	4790                	lw	a2,8(a5)
 840:	02061713          	slli	a4,a2,0x20
 844:	9301                	srli	a4,a4,0x20
 846:	0712                	slli	a4,a4,0x4
 848:	973e                	add	a4,a4,a5
 84a:	fae689e3          	beq	a3,a4,7fc <free+0x28>
  } else
    p->s.ptr = bp;
 84e:	e394                	sd	a3,0(a5)
  freep = p;
 850:	00000717          	auipc	a4,0x0
 854:	10f73c23          	sd	a5,280(a4) # 968 <__bss_start>
}
 858:	6422                	ld	s0,8(sp)
 85a:	0141                	addi	sp,sp,16
 85c:	8082                	ret

000000000000085e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 85e:	7139                	addi	sp,sp,-64
 860:	fc06                	sd	ra,56(sp)
 862:	f822                	sd	s0,48(sp)
 864:	f426                	sd	s1,40(sp)
 866:	f04a                	sd	s2,32(sp)
 868:	ec4e                	sd	s3,24(sp)
 86a:	e852                	sd	s4,16(sp)
 86c:	e456                	sd	s5,8(sp)
 86e:	e05a                	sd	s6,0(sp)
 870:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 872:	02051993          	slli	s3,a0,0x20
 876:	0209d993          	srli	s3,s3,0x20
 87a:	09bd                	addi	s3,s3,15
 87c:	0049d993          	srli	s3,s3,0x4
 880:	2985                	addiw	s3,s3,1
 882:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 886:	00000797          	auipc	a5,0x0
 88a:	0e278793          	addi	a5,a5,226 # 968 <__bss_start>
 88e:	6388                	ld	a0,0(a5)
 890:	c515                	beqz	a0,8bc <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 892:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 894:	4798                	lw	a4,8(a5)
 896:	03277f63          	bleu	s2,a4,8d4 <malloc+0x76>
 89a:	8a4e                	mv	s4,s3
 89c:	0009871b          	sext.w	a4,s3
 8a0:	6685                	lui	a3,0x1
 8a2:	00d77363          	bleu	a3,a4,8a8 <malloc+0x4a>
 8a6:	6a05                	lui	s4,0x1
 8a8:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8ac:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b0:	00000497          	auipc	s1,0x0
 8b4:	0b848493          	addi	s1,s1,184 # 968 <__bss_start>
  if(p == (char*)-1)
 8b8:	5b7d                	li	s6,-1
 8ba:	a885                	j	92a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8bc:	00000797          	auipc	a5,0x0
 8c0:	56478793          	addi	a5,a5,1380 # e20 <base>
 8c4:	00000717          	auipc	a4,0x0
 8c8:	0af73223          	sd	a5,164(a4) # 968 <__bss_start>
 8cc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ce:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8d2:	b7e1                	j	89a <malloc+0x3c>
      if(p->s.size == nunits)
 8d4:	02e90b63          	beq	s2,a4,90a <malloc+0xac>
        p->s.size -= nunits;
 8d8:	4137073b          	subw	a4,a4,s3
 8dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8de:	1702                	slli	a4,a4,0x20
 8e0:	9301                	srli	a4,a4,0x20
 8e2:	0712                	slli	a4,a4,0x4
 8e4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8e6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ea:	00000717          	auipc	a4,0x0
 8ee:	06a73f23          	sd	a0,126(a4) # 968 <__bss_start>
      return (void*)(p + 1);
 8f2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8f6:	70e2                	ld	ra,56(sp)
 8f8:	7442                	ld	s0,48(sp)
 8fa:	74a2                	ld	s1,40(sp)
 8fc:	7902                	ld	s2,32(sp)
 8fe:	69e2                	ld	s3,24(sp)
 900:	6a42                	ld	s4,16(sp)
 902:	6aa2                	ld	s5,8(sp)
 904:	6b02                	ld	s6,0(sp)
 906:	6121                	addi	sp,sp,64
 908:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 90a:	6398                	ld	a4,0(a5)
 90c:	e118                	sd	a4,0(a0)
 90e:	bff1                	j	8ea <malloc+0x8c>
  hp->s.size = nu;
 910:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 914:	0541                	addi	a0,a0,16
 916:	00000097          	auipc	ra,0x0
 91a:	ebe080e7          	jalr	-322(ra) # 7d4 <free>
  return freep;
 91e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 920:	d979                	beqz	a0,8f6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	fb2777e3          	bleu	s2,a4,8d4 <malloc+0x76>
    if(p == freep)
 92a:	6098                	ld	a4,0(s1)
 92c:	853e                	mv	a0,a5
 92e:	fef71ae3          	bne	a4,a5,922 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 932:	8552                	mv	a0,s4
 934:	00000097          	auipc	ra,0x0
 938:	a5c080e7          	jalr	-1444(ra) # 390 <sbrk>
  if(p == (char*)-1)
 93c:	fd651ae3          	bne	a0,s6,910 <malloc+0xb2>
        return 0;
 940:	4501                	li	a0,0
 942:	bf55                	j	8f6 <malloc+0x98>
