
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	97058593          	addi	a1,a1,-1680 # 980 <malloc+0xec>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	78c080e7          	jalr	1932(ra) # 7a6 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	31a080e7          	jalr	794(ra) # 33e <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	36c080e7          	jalr	876(ra) # 39e <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2fe080e7          	jalr	766(ra) # 33e <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	94c58593          	addi	a1,a1,-1716 # 998 <malloc+0x104>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	750080e7          	jalr	1872(ra) # 7a6 <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
    ;
  return os;
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf91                	beqz	a5,a2 <strcmp+0x26>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71b63          	bne	a4,a5,a2 <strcmp+0x26>
    p++, q++;
  90:	0505                	addi	a0,a0,1
  92:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	c789                	beqz	a5,a2 <strcmp+0x26>
  9a:	0005c703          	lbu	a4,0(a1)
  9e:	fef709e3          	beq	a4,a5,90 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cf91                	beqz	a5,d6 <strlen+0x26>
  bc:	0505                	addi	a0,a0,1
  be:	87aa                	mv	a5,a0
  c0:	4685                	li	a3,1
  c2:	9e89                	subw	a3,a3,a0
  c4:	00f6853b          	addw	a0,a3,a5
  c8:	0785                	addi	a5,a5,1
  ca:	fff7c703          	lbu	a4,-1(a5)
  ce:	fb7d                	bnez	a4,c4 <strlen+0x14>
    ;
  return n;
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	addi	sp,sp,16
  d4:	8082                	ret
  for(n = 0; s[n]; n++)
  d6:	4501                	li	a0,0
  d8:	bfe5                	j	d0 <strlen+0x20>

00000000000000da <memset>:

void*
memset(void *dst, int c, uint n)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e0:	ce09                	beqz	a2,fa <memset+0x20>
  e2:	87aa                	mv	a5,a0
  e4:	fff6071b          	addiw	a4,a2,-1
  e8:	1702                	slli	a4,a4,0x20
  ea:	9301                	srli	a4,a4,0x20
  ec:	0705                	addi	a4,a4,1
  ee:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f4:	0785                	addi	a5,a5,1
  f6:	fee79de3          	bne	a5,a4,f0 <memset+0x16>
  }
  return dst;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret

0000000000000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	1141                	addi	sp,sp,-16
 102:	e422                	sd	s0,8(sp)
 104:	0800                	addi	s0,sp,16
  for(; *s; s++)
 106:	00054783          	lbu	a5,0(a0)
 10a:	cf91                	beqz	a5,126 <strchr+0x26>
    if(*s == c)
 10c:	00f58a63          	beq	a1,a5,120 <strchr+0x20>
  for(; *s; s++)
 110:	0505                	addi	a0,a0,1
 112:	00054783          	lbu	a5,0(a0)
 116:	c781                	beqz	a5,11e <strchr+0x1e>
    if(*s == c)
 118:	feb79ce3          	bne	a5,a1,110 <strchr+0x10>
 11c:	a011                	j	120 <strchr+0x20>
      return (char*)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfe5                	j	120 <strchr+0x20>

000000000000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	711d                	addi	sp,sp,-96
 12c:	ec86                	sd	ra,88(sp)
 12e:	e8a2                	sd	s0,80(sp)
 130:	e4a6                	sd	s1,72(sp)
 132:	e0ca                	sd	s2,64(sp)
 134:	fc4e                	sd	s3,56(sp)
 136:	f852                	sd	s4,48(sp)
 138:	f456                	sd	s5,40(sp)
 13a:	f05a                	sd	s6,32(sp)
 13c:	ec5e                	sd	s7,24(sp)
 13e:	1080                	addi	s0,sp,96
 140:	8baa                	mv	s7,a0
 142:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	892a                	mv	s2,a0
 146:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 148:	4aa9                	li	s5,10
 14a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14c:	0019849b          	addiw	s1,s3,1
 150:	0344d863          	ble	s4,s1,180 <gets+0x56>
    cc = read(0, &c, 1);
 154:	4605                	li	a2,1
 156:	faf40593          	addi	a1,s0,-81
 15a:	4501                	li	a0,0
 15c:	00000097          	auipc	ra,0x0
 160:	1fa080e7          	jalr	506(ra) # 356 <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x56>
    buf[i++] = c;
 168:	faf44783          	lbu	a5,-81(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01578763          	beq	a5,s5,17e <gets+0x54>
 174:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 176:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 178:	fd679ae3          	bne	a5,s6,14c <gets+0x22>
 17c:	a011                	j	180 <gets+0x56>
  for(i=0; i+1 < max; ){
 17e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 180:	99de                	add	s3,s3,s7
 182:	00098023          	sb	zero,0(s3)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6125                	addi	sp,sp,96
 19c:	8082                	ret

000000000000019e <atoi>:
  return r;
}

int
atoi(const char *s)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a4:	00054683          	lbu	a3,0(a0)
 1a8:	fd06879b          	addiw	a5,a3,-48
 1ac:	0ff7f793          	andi	a5,a5,255
 1b0:	4725                	li	a4,9
 1b2:	02f76963          	bltu	a4,a5,1e4 <atoi+0x46>
 1b6:	862a                	mv	a2,a0
  n = 0;
 1b8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1ba:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1bc:	0605                	addi	a2,a2,1
 1be:	0025179b          	slliw	a5,a0,0x2
 1c2:	9fa9                	addw	a5,a5,a0
 1c4:	0017979b          	slliw	a5,a5,0x1
 1c8:	9fb5                	addw	a5,a5,a3
 1ca:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ce:	00064683          	lbu	a3,0(a2)
 1d2:	fd06871b          	addiw	a4,a3,-48
 1d6:	0ff77713          	andi	a4,a4,255
 1da:	fee5f1e3          	bleu	a4,a1,1bc <atoi+0x1e>
  return n;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  n = 0;
 1e4:	4501                	li	a0,0
 1e6:	bfe5                	j	1de <atoi+0x40>

00000000000001e8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1ee:	02b57663          	bleu	a1,a0,21a <memmove+0x32>
    while(n-- > 0)
 1f2:	02c05163          	blez	a2,214 <memmove+0x2c>
 1f6:	fff6079b          	addiw	a5,a2,-1
 1fa:	1782                	slli	a5,a5,0x20
 1fc:	9381                	srli	a5,a5,0x20
 1fe:	0785                	addi	a5,a5,1
 200:	97aa                	add	a5,a5,a0
  dst = vdst;
 202:	872a                	mv	a4,a0
      *dst++ = *src++;
 204:	0585                	addi	a1,a1,1
 206:	0705                	addi	a4,a4,1
 208:	fff5c683          	lbu	a3,-1(a1)
 20c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 210:	fee79ae3          	bne	a5,a4,204 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret
    dst += n;
 21a:	00c50733          	add	a4,a0,a2
    src += n;
 21e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 220:	fec05ae3          	blez	a2,214 <memmove+0x2c>
 224:	fff6079b          	addiw	a5,a2,-1
 228:	1782                	slli	a5,a5,0x20
 22a:	9381                	srli	a5,a5,0x20
 22c:	fff7c793          	not	a5,a5
 230:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 232:	15fd                	addi	a1,a1,-1
 234:	177d                	addi	a4,a4,-1
 236:	0005c683          	lbu	a3,0(a1)
 23a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 23e:	fef71ae3          	bne	a4,a5,232 <memmove+0x4a>
 242:	bfc9                	j	214 <memmove+0x2c>

0000000000000244 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 244:	1141                	addi	sp,sp,-16
 246:	e422                	sd	s0,8(sp)
 248:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 24a:	ce15                	beqz	a2,286 <memcmp+0x42>
 24c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 250:	00054783          	lbu	a5,0(a0)
 254:	0005c703          	lbu	a4,0(a1)
 258:	02e79063          	bne	a5,a4,278 <memcmp+0x34>
 25c:	1682                	slli	a3,a3,0x20
 25e:	9281                	srli	a3,a3,0x20
 260:	0685                	addi	a3,a3,1
 262:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 264:	0505                	addi	a0,a0,1
    p2++;
 266:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 268:	00d50d63          	beq	a0,a3,282 <memcmp+0x3e>
    if (*p1 != *p2) {
 26c:	00054783          	lbu	a5,0(a0)
 270:	0005c703          	lbu	a4,0(a1)
 274:	fee788e3          	beq	a5,a4,264 <memcmp+0x20>
      return *p1 - *p2;
 278:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  return 0;
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <memcmp+0x38>
 286:	4501                	li	a0,0
 288:	bfd5                	j	27c <memcmp+0x38>

000000000000028a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 292:	00000097          	auipc	ra,0x0
 296:	f56080e7          	jalr	-170(ra) # 1e8 <memmove>
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <close>:

int close(int fd){
 2a2:	1101                	addi	sp,sp,-32
 2a4:	ec06                	sd	ra,24(sp)
 2a6:	e822                	sd	s0,16(sp)
 2a8:	e426                	sd	s1,8(sp)
 2aa:	1000                	addi	s0,sp,32
 2ac:	84aa                	mv	s1,a0
  fflush(fd);
 2ae:	00000097          	auipc	ra,0x0
 2b2:	2da080e7          	jalr	730(ra) # 588 <fflush>
  char* buf = get_putc_buf(fd);
 2b6:	8526                	mv	a0,s1
 2b8:	00000097          	auipc	ra,0x0
 2bc:	14e080e7          	jalr	334(ra) # 406 <get_putc_buf>
  if(buf){
 2c0:	cd11                	beqz	a0,2dc <close+0x3a>
    free(buf);
 2c2:	00000097          	auipc	ra,0x0
 2c6:	548080e7          	jalr	1352(ra) # 80a <free>
    putc_buf[fd] = 0;
 2ca:	00349713          	slli	a4,s1,0x3
 2ce:	00000797          	auipc	a5,0x0
 2d2:	70a78793          	addi	a5,a5,1802 # 9d8 <putc_buf>
 2d6:	97ba                	add	a5,a5,a4
 2d8:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2dc:	8526                	mv	a0,s1
 2de:	00000097          	auipc	ra,0x0
 2e2:	088080e7          	jalr	136(ra) # 366 <sclose>
}
 2e6:	60e2                	ld	ra,24(sp)
 2e8:	6442                	ld	s0,16(sp)
 2ea:	64a2                	ld	s1,8(sp)
 2ec:	6105                	addi	sp,sp,32
 2ee:	8082                	ret

00000000000002f0 <stat>:
{
 2f0:	1101                	addi	sp,sp,-32
 2f2:	ec06                	sd	ra,24(sp)
 2f4:	e822                	sd	s0,16(sp)
 2f6:	e426                	sd	s1,8(sp)
 2f8:	e04a                	sd	s2,0(sp)
 2fa:	1000                	addi	s0,sp,32
 2fc:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 2fe:	4581                	li	a1,0
 300:	00000097          	auipc	ra,0x0
 304:	07e080e7          	jalr	126(ra) # 37e <open>
  if(fd < 0)
 308:	02054563          	bltz	a0,332 <stat+0x42>
 30c:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 30e:	85ca                	mv	a1,s2
 310:	00000097          	auipc	ra,0x0
 314:	086080e7          	jalr	134(ra) # 396 <fstat>
 318:	892a                	mv	s2,a0
  close(fd);
 31a:	8526                	mv	a0,s1
 31c:	00000097          	auipc	ra,0x0
 320:	f86080e7          	jalr	-122(ra) # 2a2 <close>
}
 324:	854a                	mv	a0,s2
 326:	60e2                	ld	ra,24(sp)
 328:	6442                	ld	s0,16(sp)
 32a:	64a2                	ld	s1,8(sp)
 32c:	6902                	ld	s2,0(sp)
 32e:	6105                	addi	sp,sp,32
 330:	8082                	ret
    return -1;
 332:	597d                	li	s2,-1
 334:	bfc5                	j	324 <stat+0x34>

0000000000000336 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 336:	4885                	li	a7,1
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <exit>:
.global exit
exit:
 li a7, SYS_exit
 33e:	4889                	li	a7,2
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <wait>:
.global wait
wait:
 li a7, SYS_wait
 346:	488d                	li	a7,3
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 34e:	4891                	li	a7,4
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <read>:
.global read
read:
 li a7, SYS_read
 356:	4895                	li	a7,5
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <write>:
.global write
write:
 li a7, SYS_write
 35e:	48c1                	li	a7,16
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 366:	48d5                	li	a7,21
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <kill>:
.global kill
kill:
 li a7, SYS_kill
 36e:	4899                	li	a7,6
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <exec>:
.global exec
exec:
 li a7, SYS_exec
 376:	489d                	li	a7,7
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <open>:
.global open
open:
 li a7, SYS_open
 37e:	48bd                	li	a7,15
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 386:	48c5                	li	a7,17
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 38e:	48c9                	li	a7,18
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 396:	48a1                	li	a7,8
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <link>:
.global link
link:
 li a7, SYS_link
 39e:	48cd                	li	a7,19
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a6:	48d1                	li	a7,20
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ae:	48a5                	li	a7,9
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b6:	48a9                	li	a7,10
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3be:	48ad                	li	a7,11
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c6:	48b1                	li	a7,12
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ce:	48b5                	li	a7,13
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d6:	48b9                	li	a7,14
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3de:	48d9                	li	a7,22
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3e6:	48dd                	li	a7,23
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3ee:	48e1                	li	a7,24
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3f6:	48e5                	li	a7,25
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 3fe:	48e9                	li	a7,26
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 406:	1101                	addi	sp,sp,-32
 408:	ec06                	sd	ra,24(sp)
 40a:	e822                	sd	s0,16(sp)
 40c:	e426                	sd	s1,8(sp)
 40e:	1000                	addi	s0,sp,32
 410:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 412:	00351693          	slli	a3,a0,0x3
 416:	00000797          	auipc	a5,0x0
 41a:	5c278793          	addi	a5,a5,1474 # 9d8 <putc_buf>
 41e:	97b6                	add	a5,a5,a3
 420:	6388                	ld	a0,0(a5)
  if(buf) {
 422:	c511                	beqz	a0,42e <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 424:	60e2                	ld	ra,24(sp)
 426:	6442                	ld	s0,16(sp)
 428:	64a2                	ld	s1,8(sp)
 42a:	6105                	addi	sp,sp,32
 42c:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 42e:	6505                	lui	a0,0x1
 430:	00000097          	auipc	ra,0x0
 434:	464080e7          	jalr	1124(ra) # 894 <malloc>
  putc_buf[fd] = buf;
 438:	00000797          	auipc	a5,0x0
 43c:	5a078793          	addi	a5,a5,1440 # 9d8 <putc_buf>
 440:	00349713          	slli	a4,s1,0x3
 444:	973e                	add	a4,a4,a5
 446:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 448:	00249713          	slli	a4,s1,0x2
 44c:	973e                	add	a4,a4,a5
 44e:	32072023          	sw	zero,800(a4)
  return buf;
 452:	bfc9                	j	424 <get_putc_buf+0x1e>

0000000000000454 <putc>:

static void
putc(int fd, char c)
{
 454:	1101                	addi	sp,sp,-32
 456:	ec06                	sd	ra,24(sp)
 458:	e822                	sd	s0,16(sp)
 45a:	e426                	sd	s1,8(sp)
 45c:	e04a                	sd	s2,0(sp)
 45e:	1000                	addi	s0,sp,32
 460:	84aa                	mv	s1,a0
 462:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 464:	00000097          	auipc	ra,0x0
 468:	fa2080e7          	jalr	-94(ra) # 406 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 46c:	00249793          	slli	a5,s1,0x2
 470:	00000717          	auipc	a4,0x0
 474:	56870713          	addi	a4,a4,1384 # 9d8 <putc_buf>
 478:	973e                	add	a4,a4,a5
 47a:	32072783          	lw	a5,800(a4)
 47e:	0017869b          	addiw	a3,a5,1
 482:	32d72023          	sw	a3,800(a4)
 486:	97aa                	add	a5,a5,a0
 488:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 48c:	47a9                	li	a5,10
 48e:	02f90463          	beq	s2,a5,4b6 <putc+0x62>
 492:	00249713          	slli	a4,s1,0x2
 496:	00000797          	auipc	a5,0x0
 49a:	54278793          	addi	a5,a5,1346 # 9d8 <putc_buf>
 49e:	97ba                	add	a5,a5,a4
 4a0:	3207a703          	lw	a4,800(a5)
 4a4:	6785                	lui	a5,0x1
 4a6:	00f70863          	beq	a4,a5,4b6 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4aa:	60e2                	ld	ra,24(sp)
 4ac:	6442                	ld	s0,16(sp)
 4ae:	64a2                	ld	s1,8(sp)
 4b0:	6902                	ld	s2,0(sp)
 4b2:	6105                	addi	sp,sp,32
 4b4:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4b6:	00249793          	slli	a5,s1,0x2
 4ba:	00000917          	auipc	s2,0x0
 4be:	51e90913          	addi	s2,s2,1310 # 9d8 <putc_buf>
 4c2:	993e                	add	s2,s2,a5
 4c4:	32092603          	lw	a2,800(s2)
 4c8:	85aa                	mv	a1,a0
 4ca:	8526                	mv	a0,s1
 4cc:	00000097          	auipc	ra,0x0
 4d0:	e92080e7          	jalr	-366(ra) # 35e <write>
    putc_index[fd] = 0;
 4d4:	32092023          	sw	zero,800(s2)
}
 4d8:	bfc9                	j	4aa <putc+0x56>

00000000000004da <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4da:	7139                	addi	sp,sp,-64
 4dc:	fc06                	sd	ra,56(sp)
 4de:	f822                	sd	s0,48(sp)
 4e0:	f426                	sd	s1,40(sp)
 4e2:	f04a                	sd	s2,32(sp)
 4e4:	ec4e                	sd	s3,24(sp)
 4e6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e8:	c299                	beqz	a3,4ee <printint+0x14>
 4ea:	0005cd63          	bltz	a1,504 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ee:	2581                	sext.w	a1,a1
  neg = 0;
 4f0:	4301                	li	t1,0
 4f2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4f6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4f8:	2601                	sext.w	a2,a2
 4fa:	00000897          	auipc	a7,0x0
 4fe:	4b688893          	addi	a7,a7,1206 # 9b0 <digits>
 502:	a801                	j	512 <printint+0x38>
    x = -xx;
 504:	40b005bb          	negw	a1,a1
 508:	2581                	sext.w	a1,a1
    neg = 1;
 50a:	4305                	li	t1,1
    x = -xx;
 50c:	b7dd                	j	4f2 <printint+0x18>
  }while((x /= base) != 0);
 50e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 510:	8836                	mv	a6,a3
 512:	0018069b          	addiw	a3,a6,1
 516:	02c5f7bb          	remuw	a5,a1,a2
 51a:	1782                	slli	a5,a5,0x20
 51c:	9381                	srli	a5,a5,0x20
 51e:	97c6                	add	a5,a5,a7
 520:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x168>
 524:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 528:	0705                	addi	a4,a4,1
 52a:	02c5d7bb          	divuw	a5,a1,a2
 52e:	fec5f0e3          	bleu	a2,a1,50e <printint+0x34>
  if(neg)
 532:	00030b63          	beqz	t1,548 <printint+0x6e>
    buf[i++] = '-';
 536:	fd040793          	addi	a5,s0,-48
 53a:	96be                	add	a3,a3,a5
 53c:	02d00793          	li	a5,45
 540:	fef68823          	sb	a5,-16(a3)
 544:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 548:	02d05963          	blez	a3,57a <printint+0xa0>
 54c:	89aa                	mv	s3,a0
 54e:	fc040793          	addi	a5,s0,-64
 552:	00d784b3          	add	s1,a5,a3
 556:	fff78913          	addi	s2,a5,-1
 55a:	9936                	add	s2,s2,a3
 55c:	36fd                	addiw	a3,a3,-1
 55e:	1682                	slli	a3,a3,0x20
 560:	9281                	srli	a3,a3,0x20
 562:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 566:	fff4c583          	lbu	a1,-1(s1)
 56a:	854e                	mv	a0,s3
 56c:	00000097          	auipc	ra,0x0
 570:	ee8080e7          	jalr	-280(ra) # 454 <putc>
  while(--i >= 0)
 574:	14fd                	addi	s1,s1,-1
 576:	ff2498e3          	bne	s1,s2,566 <printint+0x8c>
}
 57a:	70e2                	ld	ra,56(sp)
 57c:	7442                	ld	s0,48(sp)
 57e:	74a2                	ld	s1,40(sp)
 580:	7902                	ld	s2,32(sp)
 582:	69e2                	ld	s3,24(sp)
 584:	6121                	addi	sp,sp,64
 586:	8082                	ret

0000000000000588 <fflush>:
void fflush(int fd){
 588:	1101                	addi	sp,sp,-32
 58a:	ec06                	sd	ra,24(sp)
 58c:	e822                	sd	s0,16(sp)
 58e:	e426                	sd	s1,8(sp)
 590:	e04a                	sd	s2,0(sp)
 592:	1000                	addi	s0,sp,32
 594:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 596:	00000097          	auipc	ra,0x0
 59a:	e70080e7          	jalr	-400(ra) # 406 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 59e:	00291793          	slli	a5,s2,0x2
 5a2:	00000497          	auipc	s1,0x0
 5a6:	43648493          	addi	s1,s1,1078 # 9d8 <putc_buf>
 5aa:	94be                	add	s1,s1,a5
 5ac:	3204a603          	lw	a2,800(s1)
 5b0:	85aa                	mv	a1,a0
 5b2:	854a                	mv	a0,s2
 5b4:	00000097          	auipc	ra,0x0
 5b8:	daa080e7          	jalr	-598(ra) # 35e <write>
  putc_index[fd] = 0;
 5bc:	3204a023          	sw	zero,800(s1)
}
 5c0:	60e2                	ld	ra,24(sp)
 5c2:	6442                	ld	s0,16(sp)
 5c4:	64a2                	ld	s1,8(sp)
 5c6:	6902                	ld	s2,0(sp)
 5c8:	6105                	addi	sp,sp,32
 5ca:	8082                	ret

00000000000005cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5cc:	7119                	addi	sp,sp,-128
 5ce:	fc86                	sd	ra,120(sp)
 5d0:	f8a2                	sd	s0,112(sp)
 5d2:	f4a6                	sd	s1,104(sp)
 5d4:	f0ca                	sd	s2,96(sp)
 5d6:	ecce                	sd	s3,88(sp)
 5d8:	e8d2                	sd	s4,80(sp)
 5da:	e4d6                	sd	s5,72(sp)
 5dc:	e0da                	sd	s6,64(sp)
 5de:	fc5e                	sd	s7,56(sp)
 5e0:	f862                	sd	s8,48(sp)
 5e2:	f466                	sd	s9,40(sp)
 5e4:	f06a                	sd	s10,32(sp)
 5e6:	ec6e                	sd	s11,24(sp)
 5e8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ea:	0005c483          	lbu	s1,0(a1)
 5ee:	18048d63          	beqz	s1,788 <vprintf+0x1bc>
 5f2:	8aaa                	mv	s5,a0
 5f4:	8b32                	mv	s6,a2
 5f6:	00158913          	addi	s2,a1,1
  state = 0;
 5fa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5fc:	02500a13          	li	s4,37
      if(c == 'd'){
 600:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 604:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 608:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 60c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 610:	00000b97          	auipc	s7,0x0
 614:	3a0b8b93          	addi	s7,s7,928 # 9b0 <digits>
 618:	a839                	j	636 <vprintf+0x6a>
        putc(fd, c);
 61a:	85a6                	mv	a1,s1
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	e36080e7          	jalr	-458(ra) # 454 <putc>
 626:	a019                	j	62c <vprintf+0x60>
    } else if(state == '%'){
 628:	01498f63          	beq	s3,s4,646 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 62c:	0905                	addi	s2,s2,1
 62e:	fff94483          	lbu	s1,-1(s2)
 632:	14048b63          	beqz	s1,788 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 636:	0004879b          	sext.w	a5,s1
    if(state == 0){
 63a:	fe0997e3          	bnez	s3,628 <vprintf+0x5c>
      if(c == '%'){
 63e:	fd479ee3          	bne	a5,s4,61a <vprintf+0x4e>
        state = '%';
 642:	89be                	mv	s3,a5
 644:	b7e5                	j	62c <vprintf+0x60>
      if(c == 'd'){
 646:	05878063          	beq	a5,s8,686 <vprintf+0xba>
      } else if(c == 'l') {
 64a:	05978c63          	beq	a5,s9,6a2 <vprintf+0xd6>
      } else if(c == 'x') {
 64e:	07a78863          	beq	a5,s10,6be <vprintf+0xf2>
      } else if(c == 'p') {
 652:	09b78463          	beq	a5,s11,6da <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 656:	07300713          	li	a4,115
 65a:	0ce78563          	beq	a5,a4,724 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65e:	06300713          	li	a4,99
 662:	0ee78c63          	beq	a5,a4,75a <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 666:	11478663          	beq	a5,s4,772 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 66a:	85d2                	mv	a1,s4
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	de6080e7          	jalr	-538(ra) # 454 <putc>
        putc(fd, c);
 676:	85a6                	mv	a1,s1
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	dda080e7          	jalr	-550(ra) # 454 <putc>
      }
      state = 0;
 682:	4981                	li	s3,0
 684:	b765                	j	62c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 686:	008b0493          	addi	s1,s6,8
 68a:	4685                	li	a3,1
 68c:	4629                	li	a2,10
 68e:	000b2583          	lw	a1,0(s6)
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	e46080e7          	jalr	-442(ra) # 4da <printint>
 69c:	8b26                	mv	s6,s1
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b771                	j	62c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	008b0493          	addi	s1,s6,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000b2583          	lw	a1,0(s6)
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e2a080e7          	jalr	-470(ra) # 4da <printint>
 6b8:	8b26                	mv	s6,s1
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bf85                	j	62c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6be:	008b0493          	addi	s1,s6,8
 6c2:	4681                	li	a3,0
 6c4:	4641                	li	a2,16
 6c6:	000b2583          	lw	a1,0(s6)
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e0e080e7          	jalr	-498(ra) # 4da <printint>
 6d4:	8b26                	mv	s6,s1
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	bf91                	j	62c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6da:	008b0793          	addi	a5,s6,8
 6de:	f8f43423          	sd	a5,-120(s0)
 6e2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6e6:	03000593          	li	a1,48
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	d68080e7          	jalr	-664(ra) # 454 <putc>
  putc(fd, 'x');
 6f4:	85ea                	mv	a1,s10
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	d5c080e7          	jalr	-676(ra) # 454 <putc>
 700:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 702:	03c9d793          	srli	a5,s3,0x3c
 706:	97de                	add	a5,a5,s7
 708:	0007c583          	lbu	a1,0(a5)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	d46080e7          	jalr	-698(ra) # 454 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 716:	0992                	slli	s3,s3,0x4
 718:	34fd                	addiw	s1,s1,-1
 71a:	f4e5                	bnez	s1,702 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 71c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 720:	4981                	li	s3,0
 722:	b729                	j	62c <vprintf+0x60>
        s = va_arg(ap, char*);
 724:	008b0993          	addi	s3,s6,8
 728:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 72c:	c085                	beqz	s1,74c <vprintf+0x180>
        while(*s != 0){
 72e:	0004c583          	lbu	a1,0(s1)
 732:	c9a1                	beqz	a1,782 <vprintf+0x1b6>
          putc(fd, *s);
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	d1e080e7          	jalr	-738(ra) # 454 <putc>
          s++;
 73e:	0485                	addi	s1,s1,1
        while(*s != 0){
 740:	0004c583          	lbu	a1,0(s1)
 744:	f9e5                	bnez	a1,734 <vprintf+0x168>
        s = va_arg(ap, char*);
 746:	8b4e                	mv	s6,s3
      state = 0;
 748:	4981                	li	s3,0
 74a:	b5cd                	j	62c <vprintf+0x60>
          s = "(null)";
 74c:	00000497          	auipc	s1,0x0
 750:	27c48493          	addi	s1,s1,636 # 9c8 <digits+0x18>
        while(*s != 0){
 754:	02800593          	li	a1,40
 758:	bff1                	j	734 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 75a:	008b0493          	addi	s1,s6,8
 75e:	000b4583          	lbu	a1,0(s6)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	cf0080e7          	jalr	-784(ra) # 454 <putc>
 76c:	8b26                	mv	s6,s1
      state = 0;
 76e:	4981                	li	s3,0
 770:	bd75                	j	62c <vprintf+0x60>
        putc(fd, c);
 772:	85d2                	mv	a1,s4
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	cde080e7          	jalr	-802(ra) # 454 <putc>
      state = 0;
 77e:	4981                	li	s3,0
 780:	b575                	j	62c <vprintf+0x60>
        s = va_arg(ap, char*);
 782:	8b4e                	mv	s6,s3
      state = 0;
 784:	4981                	li	s3,0
 786:	b55d                	j	62c <vprintf+0x60>
    }
  }
}
 788:	70e6                	ld	ra,120(sp)
 78a:	7446                	ld	s0,112(sp)
 78c:	74a6                	ld	s1,104(sp)
 78e:	7906                	ld	s2,96(sp)
 790:	69e6                	ld	s3,88(sp)
 792:	6a46                	ld	s4,80(sp)
 794:	6aa6                	ld	s5,72(sp)
 796:	6b06                	ld	s6,64(sp)
 798:	7be2                	ld	s7,56(sp)
 79a:	7c42                	ld	s8,48(sp)
 79c:	7ca2                	ld	s9,40(sp)
 79e:	7d02                	ld	s10,32(sp)
 7a0:	6de2                	ld	s11,24(sp)
 7a2:	6109                	addi	sp,sp,128
 7a4:	8082                	ret

00000000000007a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a6:	715d                	addi	sp,sp,-80
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	e010                	sd	a2,0(s0)
 7b0:	e414                	sd	a3,8(s0)
 7b2:	e818                	sd	a4,16(s0)
 7b4:	ec1c                	sd	a5,24(s0)
 7b6:	03043023          	sd	a6,32(s0)
 7ba:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7be:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c2:	8622                	mv	a2,s0
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e08080e7          	jalr	-504(ra) # 5cc <vprintf>
}
 7cc:	60e2                	ld	ra,24(sp)
 7ce:	6442                	ld	s0,16(sp)
 7d0:	6161                	addi	sp,sp,80
 7d2:	8082                	ret

00000000000007d4 <printf>:

void
printf(const char *fmt, ...)
{
 7d4:	711d                	addi	sp,sp,-96
 7d6:	ec06                	sd	ra,24(sp)
 7d8:	e822                	sd	s0,16(sp)
 7da:	1000                	addi	s0,sp,32
 7dc:	e40c                	sd	a1,8(s0)
 7de:	e810                	sd	a2,16(s0)
 7e0:	ec14                	sd	a3,24(s0)
 7e2:	f018                	sd	a4,32(s0)
 7e4:	f41c                	sd	a5,40(s0)
 7e6:	03043823          	sd	a6,48(s0)
 7ea:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ee:	00840613          	addi	a2,s0,8
 7f2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f6:	85aa                	mv	a1,a0
 7f8:	4505                	li	a0,1
 7fa:	00000097          	auipc	ra,0x0
 7fe:	dd2080e7          	jalr	-558(ra) # 5cc <vprintf>
}
 802:	60e2                	ld	ra,24(sp)
 804:	6442                	ld	s0,16(sp)
 806:	6125                	addi	sp,sp,96
 808:	8082                	ret

000000000000080a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 80a:	1141                	addi	sp,sp,-16
 80c:	e422                	sd	s0,8(sp)
 80e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 810:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x158>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 814:	00000797          	auipc	a5,0x0
 818:	1bc78793          	addi	a5,a5,444 # 9d0 <__bss_start>
 81c:	639c                	ld	a5,0(a5)
 81e:	a805                	j	84e <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 820:	4618                	lw	a4,8(a2)
 822:	9db9                	addw	a1,a1,a4
 824:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 828:	6398                	ld	a4,0(a5)
 82a:	6318                	ld	a4,0(a4)
 82c:	fee53823          	sd	a4,-16(a0)
 830:	a091                	j	874 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 832:	ff852703          	lw	a4,-8(a0)
 836:	9e39                	addw	a2,a2,a4
 838:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 83a:	ff053703          	ld	a4,-16(a0)
 83e:	e398                	sd	a4,0(a5)
 840:	a099                	j	886 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 842:	6398                	ld	a4,0(a5)
 844:	00e7e463          	bltu	a5,a4,84c <free+0x42>
 848:	00e6ea63          	bltu	a3,a4,85c <free+0x52>
{
 84c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84e:	fed7fae3          	bleu	a3,a5,842 <free+0x38>
 852:	6398                	ld	a4,0(a5)
 854:	00e6e463          	bltu	a3,a4,85c <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	fee7eae3          	bltu	a5,a4,84c <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 85c:	ff852583          	lw	a1,-8(a0)
 860:	6390                	ld	a2,0(a5)
 862:	02059713          	slli	a4,a1,0x20
 866:	9301                	srli	a4,a4,0x20
 868:	0712                	slli	a4,a4,0x4
 86a:	9736                	add	a4,a4,a3
 86c:	fae60ae3          	beq	a2,a4,820 <free+0x16>
    bp->s.ptr = p->s.ptr;
 870:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 874:	4790                	lw	a2,8(a5)
 876:	02061713          	slli	a4,a2,0x20
 87a:	9301                	srli	a4,a4,0x20
 87c:	0712                	slli	a4,a4,0x4
 87e:	973e                	add	a4,a4,a5
 880:	fae689e3          	beq	a3,a4,832 <free+0x28>
  } else
    p->s.ptr = bp;
 884:	e394                	sd	a3,0(a5)
  freep = p;
 886:	00000717          	auipc	a4,0x0
 88a:	14f73523          	sd	a5,330(a4) # 9d0 <__bss_start>
}
 88e:	6422                	ld	s0,8(sp)
 890:	0141                	addi	sp,sp,16
 892:	8082                	ret

0000000000000894 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 894:	7139                	addi	sp,sp,-64
 896:	fc06                	sd	ra,56(sp)
 898:	f822                	sd	s0,48(sp)
 89a:	f426                	sd	s1,40(sp)
 89c:	f04a                	sd	s2,32(sp)
 89e:	ec4e                	sd	s3,24(sp)
 8a0:	e852                	sd	s4,16(sp)
 8a2:	e456                	sd	s5,8(sp)
 8a4:	e05a                	sd	s6,0(sp)
 8a6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a8:	02051993          	slli	s3,a0,0x20
 8ac:	0209d993          	srli	s3,s3,0x20
 8b0:	09bd                	addi	s3,s3,15
 8b2:	0049d993          	srli	s3,s3,0x4
 8b6:	2985                	addiw	s3,s3,1
 8b8:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8bc:	00000797          	auipc	a5,0x0
 8c0:	11478793          	addi	a5,a5,276 # 9d0 <__bss_start>
 8c4:	6388                	ld	a0,0(a5)
 8c6:	c515                	beqz	a0,8f2 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ca:	4798                	lw	a4,8(a5)
 8cc:	03277f63          	bleu	s2,a4,90a <malloc+0x76>
 8d0:	8a4e                	mv	s4,s3
 8d2:	0009871b          	sext.w	a4,s3
 8d6:	6685                	lui	a3,0x1
 8d8:	00d77363          	bleu	a3,a4,8de <malloc+0x4a>
 8dc:	6a05                	lui	s4,0x1
 8de:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8e2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e6:	00000497          	auipc	s1,0x0
 8ea:	0ea48493          	addi	s1,s1,234 # 9d0 <__bss_start>
  if(p == (char*)-1)
 8ee:	5b7d                	li	s6,-1
 8f0:	a885                	j	960 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8f2:	00000797          	auipc	a5,0x0
 8f6:	59678793          	addi	a5,a5,1430 # e88 <base>
 8fa:	00000717          	auipc	a4,0x0
 8fe:	0cf73b23          	sd	a5,214(a4) # 9d0 <__bss_start>
 902:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 904:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 908:	b7e1                	j	8d0 <malloc+0x3c>
      if(p->s.size == nunits)
 90a:	02e90b63          	beq	s2,a4,940 <malloc+0xac>
        p->s.size -= nunits;
 90e:	4137073b          	subw	a4,a4,s3
 912:	c798                	sw	a4,8(a5)
        p += p->s.size;
 914:	1702                	slli	a4,a4,0x20
 916:	9301                	srli	a4,a4,0x20
 918:	0712                	slli	a4,a4,0x4
 91a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 920:	00000717          	auipc	a4,0x0
 924:	0aa73823          	sd	a0,176(a4) # 9d0 <__bss_start>
      return (void*)(p + 1);
 928:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 92c:	70e2                	ld	ra,56(sp)
 92e:	7442                	ld	s0,48(sp)
 930:	74a2                	ld	s1,40(sp)
 932:	7902                	ld	s2,32(sp)
 934:	69e2                	ld	s3,24(sp)
 936:	6a42                	ld	s4,16(sp)
 938:	6aa2                	ld	s5,8(sp)
 93a:	6b02                	ld	s6,0(sp)
 93c:	6121                	addi	sp,sp,64
 93e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 940:	6398                	ld	a4,0(a5)
 942:	e118                	sd	a4,0(a0)
 944:	bff1                	j	920 <malloc+0x8c>
  hp->s.size = nu;
 946:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 94a:	0541                	addi	a0,a0,16
 94c:	00000097          	auipc	ra,0x0
 950:	ebe080e7          	jalr	-322(ra) # 80a <free>
  return freep;
 954:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 956:	d979                	beqz	a0,92c <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95a:	4798                	lw	a4,8(a5)
 95c:	fb2777e3          	bleu	s2,a4,90a <malloc+0x76>
    if(p == freep)
 960:	6098                	ld	a4,0(s1)
 962:	853e                	mv	a0,a5
 964:	fef71ae3          	bne	a4,a5,958 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 968:	8552                	mv	a0,s4
 96a:	00000097          	auipc	ra,0x0
 96e:	a5c080e7          	jalr	-1444(ra) # 3c6 <sbrk>
  if(p == (char*)-1)
 972:	fd651ae3          	bne	a0,s6,946 <malloc+0xb2>
        return 0;
 976:	4501                	li	a0,0
 978:	bf55                	j	92c <malloc+0x98>
