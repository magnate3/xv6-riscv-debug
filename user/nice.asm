
user/_nice:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  if(argc != 3){
   c:	478d                	li	a5,3
   e:	02f50063          	beq	a0,a5,2e <main+0x2e>
    fprintf(2, "usage: nice pid priority\n");
  12:	00001597          	auipc	a1,0x1
  16:	96658593          	addi	a1,a1,-1690 # 978 <malloc+0xe8>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	786080e7          	jalr	1926(ra) # 7a2 <fprintf>
    exit(1);
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	314080e7          	jalr	788(ra) # 33a <exit>
  2e:	84ae                	mv	s1,a1
  }
  nice(atoi(argv[1]), atoi(argv[2]));
  30:	6588                	ld	a0,8(a1)
  32:	00000097          	auipc	ra,0x0
  36:	168080e7          	jalr	360(ra) # 19a <atoi>
  3a:	892a                	mv	s2,a0
  3c:	6888                	ld	a0,16(s1)
  3e:	00000097          	auipc	ra,0x0
  42:	15c080e7          	jalr	348(ra) # 19a <atoi>
  46:	85aa                	mv	a1,a0
  48:	854a                	mv	a0,s2
  4a:	00000097          	auipc	ra,0x0
  4e:	398080e7          	jalr	920(ra) # 3e2 <nice>
  exit(0);
  52:	4501                	li	a0,0
  54:	00000097          	auipc	ra,0x0
  58:	2e6080e7          	jalr	742(ra) # 33a <exit>

000000000000005c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  5c:	1141                	addi	sp,sp,-16
  5e:	e422                	sd	s0,8(sp)
  60:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	87aa                	mv	a5,a0
  64:	0585                	addi	a1,a1,1
  66:	0785                	addi	a5,a5,1
  68:	fff5c703          	lbu	a4,-1(a1)
  6c:	fee78fa3          	sb	a4,-1(a5)
  70:	fb75                	bnez	a4,64 <strcpy+0x8>
    ;
  return os;
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cf91                	beqz	a5,9e <strcmp+0x26>
  84:	0005c703          	lbu	a4,0(a1)
  88:	00f71b63          	bne	a4,a5,9e <strcmp+0x26>
    p++, q++;
  8c:	0505                	addi	a0,a0,1
  8e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	c789                	beqz	a5,9e <strcmp+0x26>
  96:	0005c703          	lbu	a4,0(a1)
  9a:	fef709e3          	beq	a4,a5,8c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  9e:	0005c503          	lbu	a0,0(a1)
}
  a2:	40a7853b          	subw	a0,a5,a0
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	addi	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strlen>:

uint
strlen(const char *s)
{
  ac:	1141                	addi	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	cf91                	beqz	a5,d2 <strlen+0x26>
  b8:	0505                	addi	a0,a0,1
  ba:	87aa                	mv	a5,a0
  bc:	4685                	li	a3,1
  be:	9e89                	subw	a3,a3,a0
  c0:	00f6853b          	addw	a0,a3,a5
  c4:	0785                	addi	a5,a5,1
  c6:	fff7c703          	lbu	a4,-1(a5)
  ca:	fb7d                	bnez	a4,c0 <strlen+0x14>
    ;
  return n;
}
  cc:	6422                	ld	s0,8(sp)
  ce:	0141                	addi	sp,sp,16
  d0:	8082                	ret
  for(n = 0; s[n]; n++)
  d2:	4501                	li	a0,0
  d4:	bfe5                	j	cc <strlen+0x20>

00000000000000d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e422                	sd	s0,8(sp)
  da:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  dc:	ce09                	beqz	a2,f6 <memset+0x20>
  de:	87aa                	mv	a5,a0
  e0:	fff6071b          	addiw	a4,a2,-1
  e4:	1702                	slli	a4,a4,0x20
  e6:	9301                	srli	a4,a4,0x20
  e8:	0705                	addi	a4,a4,1
  ea:	972a                	add	a4,a4,a0
    cdst[i] = c;
  ec:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f0:	0785                	addi	a5,a5,1
  f2:	fee79de3          	bne	a5,a4,ec <memset+0x16>
  }
  return dst;
}
  f6:	6422                	ld	s0,8(sp)
  f8:	0141                	addi	sp,sp,16
  fa:	8082                	ret

00000000000000fc <strchr>:

char*
strchr(const char *s, char c)
{
  fc:	1141                	addi	sp,sp,-16
  fe:	e422                	sd	s0,8(sp)
 100:	0800                	addi	s0,sp,16
  for(; *s; s++)
 102:	00054783          	lbu	a5,0(a0)
 106:	cf91                	beqz	a5,122 <strchr+0x26>
    if(*s == c)
 108:	00f58a63          	beq	a1,a5,11c <strchr+0x20>
  for(; *s; s++)
 10c:	0505                	addi	a0,a0,1
 10e:	00054783          	lbu	a5,0(a0)
 112:	c781                	beqz	a5,11a <strchr+0x1e>
    if(*s == c)
 114:	feb79ce3          	bne	a5,a1,10c <strchr+0x10>
 118:	a011                	j	11c <strchr+0x20>
      return (char*)s;
  return 0;
 11a:	4501                	li	a0,0
}
 11c:	6422                	ld	s0,8(sp)
 11e:	0141                	addi	sp,sp,16
 120:	8082                	ret
  return 0;
 122:	4501                	li	a0,0
 124:	bfe5                	j	11c <strchr+0x20>

0000000000000126 <gets>:

char*
gets(char *buf, int max)
{
 126:	711d                	addi	sp,sp,-96
 128:	ec86                	sd	ra,88(sp)
 12a:	e8a2                	sd	s0,80(sp)
 12c:	e4a6                	sd	s1,72(sp)
 12e:	e0ca                	sd	s2,64(sp)
 130:	fc4e                	sd	s3,56(sp)
 132:	f852                	sd	s4,48(sp)
 134:	f456                	sd	s5,40(sp)
 136:	f05a                	sd	s6,32(sp)
 138:	ec5e                	sd	s7,24(sp)
 13a:	1080                	addi	s0,sp,96
 13c:	8baa                	mv	s7,a0
 13e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	892a                	mv	s2,a0
 142:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 144:	4aa9                	li	s5,10
 146:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 148:	0019849b          	addiw	s1,s3,1
 14c:	0344d863          	ble	s4,s1,17c <gets+0x56>
    cc = read(0, &c, 1);
 150:	4605                	li	a2,1
 152:	faf40593          	addi	a1,s0,-81
 156:	4501                	li	a0,0
 158:	00000097          	auipc	ra,0x0
 15c:	1fa080e7          	jalr	506(ra) # 352 <read>
    if(cc < 1)
 160:	00a05e63          	blez	a0,17c <gets+0x56>
    buf[i++] = c;
 164:	faf44783          	lbu	a5,-81(s0)
 168:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 16c:	01578763          	beq	a5,s5,17a <gets+0x54>
 170:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 172:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 174:	fd679ae3          	bne	a5,s6,148 <gets+0x22>
 178:	a011                	j	17c <gets+0x56>
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 17c:	99de                	add	s3,s3,s7
 17e:	00098023          	sb	zero,0(s3)
  return buf;
}
 182:	855e                	mv	a0,s7
 184:	60e6                	ld	ra,88(sp)
 186:	6446                	ld	s0,80(sp)
 188:	64a6                	ld	s1,72(sp)
 18a:	6906                	ld	s2,64(sp)
 18c:	79e2                	ld	s3,56(sp)
 18e:	7a42                	ld	s4,48(sp)
 190:	7aa2                	ld	s5,40(sp)
 192:	7b02                	ld	s6,32(sp)
 194:	6be2                	ld	s7,24(sp)
 196:	6125                	addi	sp,sp,96
 198:	8082                	ret

000000000000019a <atoi>:
  return r;
}

int
atoi(const char *s)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e422                	sd	s0,8(sp)
 19e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a0:	00054683          	lbu	a3,0(a0)
 1a4:	fd06879b          	addiw	a5,a3,-48
 1a8:	0ff7f793          	andi	a5,a5,255
 1ac:	4725                	li	a4,9
 1ae:	02f76963          	bltu	a4,a5,1e0 <atoi+0x46>
 1b2:	862a                	mv	a2,a0
  n = 0;
 1b4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1b6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1b8:	0605                	addi	a2,a2,1
 1ba:	0025179b          	slliw	a5,a0,0x2
 1be:	9fa9                	addw	a5,a5,a0
 1c0:	0017979b          	slliw	a5,a5,0x1
 1c4:	9fb5                	addw	a5,a5,a3
 1c6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ca:	00064683          	lbu	a3,0(a2)
 1ce:	fd06871b          	addiw	a4,a3,-48
 1d2:	0ff77713          	andi	a4,a4,255
 1d6:	fee5f1e3          	bleu	a4,a1,1b8 <atoi+0x1e>
  return n;
}
 1da:	6422                	ld	s0,8(sp)
 1dc:	0141                	addi	sp,sp,16
 1de:	8082                	ret
  n = 0;
 1e0:	4501                	li	a0,0
 1e2:	bfe5                	j	1da <atoi+0x40>

00000000000001e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1ea:	02b57663          	bleu	a1,a0,216 <memmove+0x32>
    while(n-- > 0)
 1ee:	02c05163          	blez	a2,210 <memmove+0x2c>
 1f2:	fff6079b          	addiw	a5,a2,-1
 1f6:	1782                	slli	a5,a5,0x20
 1f8:	9381                	srli	a5,a5,0x20
 1fa:	0785                	addi	a5,a5,1
 1fc:	97aa                	add	a5,a5,a0
  dst = vdst;
 1fe:	872a                	mv	a4,a0
      *dst++ = *src++;
 200:	0585                	addi	a1,a1,1
 202:	0705                	addi	a4,a4,1
 204:	fff5c683          	lbu	a3,-1(a1)
 208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 20c:	fee79ae3          	bne	a5,a4,200 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 210:	6422                	ld	s0,8(sp)
 212:	0141                	addi	sp,sp,16
 214:	8082                	ret
    dst += n;
 216:	00c50733          	add	a4,a0,a2
    src += n;
 21a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 21c:	fec05ae3          	blez	a2,210 <memmove+0x2c>
 220:	fff6079b          	addiw	a5,a2,-1
 224:	1782                	slli	a5,a5,0x20
 226:	9381                	srli	a5,a5,0x20
 228:	fff7c793          	not	a5,a5
 22c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 22e:	15fd                	addi	a1,a1,-1
 230:	177d                	addi	a4,a4,-1
 232:	0005c683          	lbu	a3,0(a1)
 236:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 23a:	fef71ae3          	bne	a4,a5,22e <memmove+0x4a>
 23e:	bfc9                	j	210 <memmove+0x2c>

0000000000000240 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 246:	ce15                	beqz	a2,282 <memcmp+0x42>
 248:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 24c:	00054783          	lbu	a5,0(a0)
 250:	0005c703          	lbu	a4,0(a1)
 254:	02e79063          	bne	a5,a4,274 <memcmp+0x34>
 258:	1682                	slli	a3,a3,0x20
 25a:	9281                	srli	a3,a3,0x20
 25c:	0685                	addi	a3,a3,1
 25e:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 260:	0505                	addi	a0,a0,1
    p2++;
 262:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 264:	00d50d63          	beq	a0,a3,27e <memcmp+0x3e>
    if (*p1 != *p2) {
 268:	00054783          	lbu	a5,0(a0)
 26c:	0005c703          	lbu	a4,0(a1)
 270:	fee788e3          	beq	a5,a4,260 <memcmp+0x20>
      return *p1 - *p2;
 274:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret
  return 0;
 27e:	4501                	li	a0,0
 280:	bfe5                	j	278 <memcmp+0x38>
 282:	4501                	li	a0,0
 284:	bfd5                	j	278 <memcmp+0x38>

0000000000000286 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e406                	sd	ra,8(sp)
 28a:	e022                	sd	s0,0(sp)
 28c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 28e:	00000097          	auipc	ra,0x0
 292:	f56080e7          	jalr	-170(ra) # 1e4 <memmove>
}
 296:	60a2                	ld	ra,8(sp)
 298:	6402                	ld	s0,0(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret

000000000000029e <close>:

int close(int fd){
 29e:	1101                	addi	sp,sp,-32
 2a0:	ec06                	sd	ra,24(sp)
 2a2:	e822                	sd	s0,16(sp)
 2a4:	e426                	sd	s1,8(sp)
 2a6:	1000                	addi	s0,sp,32
 2a8:	84aa                	mv	s1,a0
  fflush(fd);
 2aa:	00000097          	auipc	ra,0x0
 2ae:	2da080e7          	jalr	730(ra) # 584 <fflush>
  char* buf = get_putc_buf(fd);
 2b2:	8526                	mv	a0,s1
 2b4:	00000097          	auipc	ra,0x0
 2b8:	14e080e7          	jalr	334(ra) # 402 <get_putc_buf>
  if(buf){
 2bc:	cd11                	beqz	a0,2d8 <close+0x3a>
    free(buf);
 2be:	00000097          	auipc	ra,0x0
 2c2:	548080e7          	jalr	1352(ra) # 806 <free>
    putc_buf[fd] = 0;
 2c6:	00349713          	slli	a4,s1,0x3
 2ca:	00000797          	auipc	a5,0x0
 2ce:	6f678793          	addi	a5,a5,1782 # 9c0 <putc_buf>
 2d2:	97ba                	add	a5,a5,a4
 2d4:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2d8:	8526                	mv	a0,s1
 2da:	00000097          	auipc	ra,0x0
 2de:	088080e7          	jalr	136(ra) # 362 <sclose>
}
 2e2:	60e2                	ld	ra,24(sp)
 2e4:	6442                	ld	s0,16(sp)
 2e6:	64a2                	ld	s1,8(sp)
 2e8:	6105                	addi	sp,sp,32
 2ea:	8082                	ret

00000000000002ec <stat>:
{
 2ec:	1101                	addi	sp,sp,-32
 2ee:	ec06                	sd	ra,24(sp)
 2f0:	e822                	sd	s0,16(sp)
 2f2:	e426                	sd	s1,8(sp)
 2f4:	e04a                	sd	s2,0(sp)
 2f6:	1000                	addi	s0,sp,32
 2f8:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 2fa:	4581                	li	a1,0
 2fc:	00000097          	auipc	ra,0x0
 300:	07e080e7          	jalr	126(ra) # 37a <open>
  if(fd < 0)
 304:	02054563          	bltz	a0,32e <stat+0x42>
 308:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 30a:	85ca                	mv	a1,s2
 30c:	00000097          	auipc	ra,0x0
 310:	086080e7          	jalr	134(ra) # 392 <fstat>
 314:	892a                	mv	s2,a0
  close(fd);
 316:	8526                	mv	a0,s1
 318:	00000097          	auipc	ra,0x0
 31c:	f86080e7          	jalr	-122(ra) # 29e <close>
}
 320:	854a                	mv	a0,s2
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	64a2                	ld	s1,8(sp)
 328:	6902                	ld	s2,0(sp)
 32a:	6105                	addi	sp,sp,32
 32c:	8082                	ret
    return -1;
 32e:	597d                	li	s2,-1
 330:	bfc5                	j	320 <stat+0x34>

0000000000000332 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 332:	4885                	li	a7,1
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <exit>:
.global exit
exit:
 li a7, SYS_exit
 33a:	4889                	li	a7,2
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <wait>:
.global wait
wait:
 li a7, SYS_wait
 342:	488d                	li	a7,3
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 34a:	4891                	li	a7,4
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <read>:
.global read
read:
 li a7, SYS_read
 352:	4895                	li	a7,5
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <write>:
.global write
write:
 li a7, SYS_write
 35a:	48c1                	li	a7,16
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 362:	48d5                	li	a7,21
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <kill>:
.global kill
kill:
 li a7, SYS_kill
 36a:	4899                	li	a7,6
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <exec>:
.global exec
exec:
 li a7, SYS_exec
 372:	489d                	li	a7,7
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <open>:
.global open
open:
 li a7, SYS_open
 37a:	48bd                	li	a7,15
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 382:	48c5                	li	a7,17
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 38a:	48c9                	li	a7,18
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 392:	48a1                	li	a7,8
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <link>:
.global link
link:
 li a7, SYS_link
 39a:	48cd                	li	a7,19
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a2:	48d1                	li	a7,20
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3aa:	48a5                	li	a7,9
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b2:	48a9                	li	a7,10
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ba:	48ad                	li	a7,11
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c2:	48b1                	li	a7,12
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ca:	48b5                	li	a7,13
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d2:	48b9                	li	a7,14
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3da:	48d9                	li	a7,22
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <nice>:
.global nice
nice:
 li a7, SYS_nice
 3e2:	48dd                	li	a7,23
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 3ea:	48e1                	li	a7,24
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 3f2:	48e5                	li	a7,25
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 3fa:	48e9                	li	a7,26
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 402:	1101                	addi	sp,sp,-32
 404:	ec06                	sd	ra,24(sp)
 406:	e822                	sd	s0,16(sp)
 408:	e426                	sd	s1,8(sp)
 40a:	1000                	addi	s0,sp,32
 40c:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 40e:	00351693          	slli	a3,a0,0x3
 412:	00000797          	auipc	a5,0x0
 416:	5ae78793          	addi	a5,a5,1454 # 9c0 <putc_buf>
 41a:	97b6                	add	a5,a5,a3
 41c:	6388                	ld	a0,0(a5)
  if(buf) {
 41e:	c511                	beqz	a0,42a <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 420:	60e2                	ld	ra,24(sp)
 422:	6442                	ld	s0,16(sp)
 424:	64a2                	ld	s1,8(sp)
 426:	6105                	addi	sp,sp,32
 428:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 42a:	6505                	lui	a0,0x1
 42c:	00000097          	auipc	ra,0x0
 430:	464080e7          	jalr	1124(ra) # 890 <malloc>
  putc_buf[fd] = buf;
 434:	00000797          	auipc	a5,0x0
 438:	58c78793          	addi	a5,a5,1420 # 9c0 <putc_buf>
 43c:	00349713          	slli	a4,s1,0x3
 440:	973e                	add	a4,a4,a5
 442:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 444:	00249713          	slli	a4,s1,0x2
 448:	973e                	add	a4,a4,a5
 44a:	32072023          	sw	zero,800(a4)
  return buf;
 44e:	bfc9                	j	420 <get_putc_buf+0x1e>

0000000000000450 <putc>:

static void
putc(int fd, char c)
{
 450:	1101                	addi	sp,sp,-32
 452:	ec06                	sd	ra,24(sp)
 454:	e822                	sd	s0,16(sp)
 456:	e426                	sd	s1,8(sp)
 458:	e04a                	sd	s2,0(sp)
 45a:	1000                	addi	s0,sp,32
 45c:	84aa                	mv	s1,a0
 45e:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 460:	00000097          	auipc	ra,0x0
 464:	fa2080e7          	jalr	-94(ra) # 402 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 468:	00249793          	slli	a5,s1,0x2
 46c:	00000717          	auipc	a4,0x0
 470:	55470713          	addi	a4,a4,1364 # 9c0 <putc_buf>
 474:	973e                	add	a4,a4,a5
 476:	32072783          	lw	a5,800(a4)
 47a:	0017869b          	addiw	a3,a5,1
 47e:	32d72023          	sw	a3,800(a4)
 482:	97aa                	add	a5,a5,a0
 484:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 488:	47a9                	li	a5,10
 48a:	02f90463          	beq	s2,a5,4b2 <putc+0x62>
 48e:	00249713          	slli	a4,s1,0x2
 492:	00000797          	auipc	a5,0x0
 496:	52e78793          	addi	a5,a5,1326 # 9c0 <putc_buf>
 49a:	97ba                	add	a5,a5,a4
 49c:	3207a703          	lw	a4,800(a5)
 4a0:	6785                	lui	a5,0x1
 4a2:	00f70863          	beq	a4,a5,4b2 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4a6:	60e2                	ld	ra,24(sp)
 4a8:	6442                	ld	s0,16(sp)
 4aa:	64a2                	ld	s1,8(sp)
 4ac:	6902                	ld	s2,0(sp)
 4ae:	6105                	addi	sp,sp,32
 4b0:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4b2:	00249793          	slli	a5,s1,0x2
 4b6:	00000917          	auipc	s2,0x0
 4ba:	50a90913          	addi	s2,s2,1290 # 9c0 <putc_buf>
 4be:	993e                	add	s2,s2,a5
 4c0:	32092603          	lw	a2,800(s2)
 4c4:	85aa                	mv	a1,a0
 4c6:	8526                	mv	a0,s1
 4c8:	00000097          	auipc	ra,0x0
 4cc:	e92080e7          	jalr	-366(ra) # 35a <write>
    putc_index[fd] = 0;
 4d0:	32092023          	sw	zero,800(s2)
}
 4d4:	bfc9                	j	4a6 <putc+0x56>

00000000000004d6 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4d6:	7139                	addi	sp,sp,-64
 4d8:	fc06                	sd	ra,56(sp)
 4da:	f822                	sd	s0,48(sp)
 4dc:	f426                	sd	s1,40(sp)
 4de:	f04a                	sd	s2,32(sp)
 4e0:	ec4e                	sd	s3,24(sp)
 4e2:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e4:	c299                	beqz	a3,4ea <printint+0x14>
 4e6:	0005cd63          	bltz	a1,500 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ea:	2581                	sext.w	a1,a1
  neg = 0;
 4ec:	4301                	li	t1,0
 4ee:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4f2:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4f4:	2601                	sext.w	a2,a2
 4f6:	00000897          	auipc	a7,0x0
 4fa:	4a288893          	addi	a7,a7,1186 # 998 <digits>
 4fe:	a801                	j	50e <printint+0x38>
    x = -xx;
 500:	40b005bb          	negw	a1,a1
 504:	2581                	sext.w	a1,a1
    neg = 1;
 506:	4305                	li	t1,1
    x = -xx;
 508:	b7dd                	j	4ee <printint+0x18>
  }while((x /= base) != 0);
 50a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 50c:	8836                	mv	a6,a3
 50e:	0018069b          	addiw	a3,a6,1
 512:	02c5f7bb          	remuw	a5,a1,a2
 516:	1782                	slli	a5,a5,0x20
 518:	9381                	srli	a5,a5,0x20
 51a:	97c6                	add	a5,a5,a7
 51c:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x180>
 520:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 524:	0705                	addi	a4,a4,1
 526:	02c5d7bb          	divuw	a5,a1,a2
 52a:	fec5f0e3          	bleu	a2,a1,50a <printint+0x34>
  if(neg)
 52e:	00030b63          	beqz	t1,544 <printint+0x6e>
    buf[i++] = '-';
 532:	fd040793          	addi	a5,s0,-48
 536:	96be                	add	a3,a3,a5
 538:	02d00793          	li	a5,45
 53c:	fef68823          	sb	a5,-16(a3)
 540:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 544:	02d05963          	blez	a3,576 <printint+0xa0>
 548:	89aa                	mv	s3,a0
 54a:	fc040793          	addi	a5,s0,-64
 54e:	00d784b3          	add	s1,a5,a3
 552:	fff78913          	addi	s2,a5,-1
 556:	9936                	add	s2,s2,a3
 558:	36fd                	addiw	a3,a3,-1
 55a:	1682                	slli	a3,a3,0x20
 55c:	9281                	srli	a3,a3,0x20
 55e:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 562:	fff4c583          	lbu	a1,-1(s1)
 566:	854e                	mv	a0,s3
 568:	00000097          	auipc	ra,0x0
 56c:	ee8080e7          	jalr	-280(ra) # 450 <putc>
  while(--i >= 0)
 570:	14fd                	addi	s1,s1,-1
 572:	ff2498e3          	bne	s1,s2,562 <printint+0x8c>
}
 576:	70e2                	ld	ra,56(sp)
 578:	7442                	ld	s0,48(sp)
 57a:	74a2                	ld	s1,40(sp)
 57c:	7902                	ld	s2,32(sp)
 57e:	69e2                	ld	s3,24(sp)
 580:	6121                	addi	sp,sp,64
 582:	8082                	ret

0000000000000584 <fflush>:
void fflush(int fd){
 584:	1101                	addi	sp,sp,-32
 586:	ec06                	sd	ra,24(sp)
 588:	e822                	sd	s0,16(sp)
 58a:	e426                	sd	s1,8(sp)
 58c:	e04a                	sd	s2,0(sp)
 58e:	1000                	addi	s0,sp,32
 590:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 592:	00000097          	auipc	ra,0x0
 596:	e70080e7          	jalr	-400(ra) # 402 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 59a:	00291793          	slli	a5,s2,0x2
 59e:	00000497          	auipc	s1,0x0
 5a2:	42248493          	addi	s1,s1,1058 # 9c0 <putc_buf>
 5a6:	94be                	add	s1,s1,a5
 5a8:	3204a603          	lw	a2,800(s1)
 5ac:	85aa                	mv	a1,a0
 5ae:	854a                	mv	a0,s2
 5b0:	00000097          	auipc	ra,0x0
 5b4:	daa080e7          	jalr	-598(ra) # 35a <write>
  putc_index[fd] = 0;
 5b8:	3204a023          	sw	zero,800(s1)
}
 5bc:	60e2                	ld	ra,24(sp)
 5be:	6442                	ld	s0,16(sp)
 5c0:	64a2                	ld	s1,8(sp)
 5c2:	6902                	ld	s2,0(sp)
 5c4:	6105                	addi	sp,sp,32
 5c6:	8082                	ret

00000000000005c8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c8:	7119                	addi	sp,sp,-128
 5ca:	fc86                	sd	ra,120(sp)
 5cc:	f8a2                	sd	s0,112(sp)
 5ce:	f4a6                	sd	s1,104(sp)
 5d0:	f0ca                	sd	s2,96(sp)
 5d2:	ecce                	sd	s3,88(sp)
 5d4:	e8d2                	sd	s4,80(sp)
 5d6:	e4d6                	sd	s5,72(sp)
 5d8:	e0da                	sd	s6,64(sp)
 5da:	fc5e                	sd	s7,56(sp)
 5dc:	f862                	sd	s8,48(sp)
 5de:	f466                	sd	s9,40(sp)
 5e0:	f06a                	sd	s10,32(sp)
 5e2:	ec6e                	sd	s11,24(sp)
 5e4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5e6:	0005c483          	lbu	s1,0(a1)
 5ea:	18048d63          	beqz	s1,784 <vprintf+0x1bc>
 5ee:	8aaa                	mv	s5,a0
 5f0:	8b32                	mv	s6,a2
 5f2:	00158913          	addi	s2,a1,1
  state = 0;
 5f6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f8:	02500a13          	li	s4,37
      if(c == 'd'){
 5fc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 600:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 604:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 608:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 60c:	00000b97          	auipc	s7,0x0
 610:	38cb8b93          	addi	s7,s7,908 # 998 <digits>
 614:	a839                	j	632 <vprintf+0x6a>
        putc(fd, c);
 616:	85a6                	mv	a1,s1
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e36080e7          	jalr	-458(ra) # 450 <putc>
 622:	a019                	j	628 <vprintf+0x60>
    } else if(state == '%'){
 624:	01498f63          	beq	s3,s4,642 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 628:	0905                	addi	s2,s2,1
 62a:	fff94483          	lbu	s1,-1(s2)
 62e:	14048b63          	beqz	s1,784 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 632:	0004879b          	sext.w	a5,s1
    if(state == 0){
 636:	fe0997e3          	bnez	s3,624 <vprintf+0x5c>
      if(c == '%'){
 63a:	fd479ee3          	bne	a5,s4,616 <vprintf+0x4e>
        state = '%';
 63e:	89be                	mv	s3,a5
 640:	b7e5                	j	628 <vprintf+0x60>
      if(c == 'd'){
 642:	05878063          	beq	a5,s8,682 <vprintf+0xba>
      } else if(c == 'l') {
 646:	05978c63          	beq	a5,s9,69e <vprintf+0xd6>
      } else if(c == 'x') {
 64a:	07a78863          	beq	a5,s10,6ba <vprintf+0xf2>
      } else if(c == 'p') {
 64e:	09b78463          	beq	a5,s11,6d6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 652:	07300713          	li	a4,115
 656:	0ce78563          	beq	a5,a4,720 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65a:	06300713          	li	a4,99
 65e:	0ee78c63          	beq	a5,a4,756 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 662:	11478663          	beq	a5,s4,76e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 666:	85d2                	mv	a1,s4
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	de6080e7          	jalr	-538(ra) # 450 <putc>
        putc(fd, c);
 672:	85a6                	mv	a1,s1
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	dda080e7          	jalr	-550(ra) # 450 <putc>
      }
      state = 0;
 67e:	4981                	li	s3,0
 680:	b765                	j	628 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 682:	008b0493          	addi	s1,s6,8
 686:	4685                	li	a3,1
 688:	4629                	li	a2,10
 68a:	000b2583          	lw	a1,0(s6)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e46080e7          	jalr	-442(ra) # 4d6 <printint>
 698:	8b26                	mv	s6,s1
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b771                	j	628 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 69e:	008b0493          	addi	s1,s6,8
 6a2:	4681                	li	a3,0
 6a4:	4629                	li	a2,10
 6a6:	000b2583          	lw	a1,0(s6)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e2a080e7          	jalr	-470(ra) # 4d6 <printint>
 6b4:	8b26                	mv	s6,s1
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	bf85                	j	628 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6ba:	008b0493          	addi	s1,s6,8
 6be:	4681                	li	a3,0
 6c0:	4641                	li	a2,16
 6c2:	000b2583          	lw	a1,0(s6)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e0e080e7          	jalr	-498(ra) # 4d6 <printint>
 6d0:	8b26                	mv	s6,s1
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bf91                	j	628 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6d6:	008b0793          	addi	a5,s6,8
 6da:	f8f43423          	sd	a5,-120(s0)
 6de:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6e2:	03000593          	li	a1,48
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	d68080e7          	jalr	-664(ra) # 450 <putc>
  putc(fd, 'x');
 6f0:	85ea                	mv	a1,s10
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	d5c080e7          	jalr	-676(ra) # 450 <putc>
 6fc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fe:	03c9d793          	srli	a5,s3,0x3c
 702:	97de                	add	a5,a5,s7
 704:	0007c583          	lbu	a1,0(a5)
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	d46080e7          	jalr	-698(ra) # 450 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 712:	0992                	slli	s3,s3,0x4
 714:	34fd                	addiw	s1,s1,-1
 716:	f4e5                	bnez	s1,6fe <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 718:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 71c:	4981                	li	s3,0
 71e:	b729                	j	628 <vprintf+0x60>
        s = va_arg(ap, char*);
 720:	008b0993          	addi	s3,s6,8
 724:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 728:	c085                	beqz	s1,748 <vprintf+0x180>
        while(*s != 0){
 72a:	0004c583          	lbu	a1,0(s1)
 72e:	c9a1                	beqz	a1,77e <vprintf+0x1b6>
          putc(fd, *s);
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	d1e080e7          	jalr	-738(ra) # 450 <putc>
          s++;
 73a:	0485                	addi	s1,s1,1
        while(*s != 0){
 73c:	0004c583          	lbu	a1,0(s1)
 740:	f9e5                	bnez	a1,730 <vprintf+0x168>
        s = va_arg(ap, char*);
 742:	8b4e                	mv	s6,s3
      state = 0;
 744:	4981                	li	s3,0
 746:	b5cd                	j	628 <vprintf+0x60>
          s = "(null)";
 748:	00000497          	auipc	s1,0x0
 74c:	26848493          	addi	s1,s1,616 # 9b0 <digits+0x18>
        while(*s != 0){
 750:	02800593          	li	a1,40
 754:	bff1                	j	730 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 756:	008b0493          	addi	s1,s6,8
 75a:	000b4583          	lbu	a1,0(s6)
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	cf0080e7          	jalr	-784(ra) # 450 <putc>
 768:	8b26                	mv	s6,s1
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bd75                	j	628 <vprintf+0x60>
        putc(fd, c);
 76e:	85d2                	mv	a1,s4
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	cde080e7          	jalr	-802(ra) # 450 <putc>
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b575                	j	628 <vprintf+0x60>
        s = va_arg(ap, char*);
 77e:	8b4e                	mv	s6,s3
      state = 0;
 780:	4981                	li	s3,0
 782:	b55d                	j	628 <vprintf+0x60>
    }
  }
}
 784:	70e6                	ld	ra,120(sp)
 786:	7446                	ld	s0,112(sp)
 788:	74a6                	ld	s1,104(sp)
 78a:	7906                	ld	s2,96(sp)
 78c:	69e6                	ld	s3,88(sp)
 78e:	6a46                	ld	s4,80(sp)
 790:	6aa6                	ld	s5,72(sp)
 792:	6b06                	ld	s6,64(sp)
 794:	7be2                	ld	s7,56(sp)
 796:	7c42                	ld	s8,48(sp)
 798:	7ca2                	ld	s9,40(sp)
 79a:	7d02                	ld	s10,32(sp)
 79c:	6de2                	ld	s11,24(sp)
 79e:	6109                	addi	sp,sp,128
 7a0:	8082                	ret

00000000000007a2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a2:	715d                	addi	sp,sp,-80
 7a4:	ec06                	sd	ra,24(sp)
 7a6:	e822                	sd	s0,16(sp)
 7a8:	1000                	addi	s0,sp,32
 7aa:	e010                	sd	a2,0(s0)
 7ac:	e414                	sd	a3,8(s0)
 7ae:	e818                	sd	a4,16(s0)
 7b0:	ec1c                	sd	a5,24(s0)
 7b2:	03043023          	sd	a6,32(s0)
 7b6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7be:	8622                	mv	a2,s0
 7c0:	00000097          	auipc	ra,0x0
 7c4:	e08080e7          	jalr	-504(ra) # 5c8 <vprintf>
}
 7c8:	60e2                	ld	ra,24(sp)
 7ca:	6442                	ld	s0,16(sp)
 7cc:	6161                	addi	sp,sp,80
 7ce:	8082                	ret

00000000000007d0 <printf>:

void
printf(const char *fmt, ...)
{
 7d0:	711d                	addi	sp,sp,-96
 7d2:	ec06                	sd	ra,24(sp)
 7d4:	e822                	sd	s0,16(sp)
 7d6:	1000                	addi	s0,sp,32
 7d8:	e40c                	sd	a1,8(s0)
 7da:	e810                	sd	a2,16(s0)
 7dc:	ec14                	sd	a3,24(s0)
 7de:	f018                	sd	a4,32(s0)
 7e0:	f41c                	sd	a5,40(s0)
 7e2:	03043823          	sd	a6,48(s0)
 7e6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ea:	00840613          	addi	a2,s0,8
 7ee:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f2:	85aa                	mv	a1,a0
 7f4:	4505                	li	a0,1
 7f6:	00000097          	auipc	ra,0x0
 7fa:	dd2080e7          	jalr	-558(ra) # 5c8 <vprintf>
}
 7fe:	60e2                	ld	ra,24(sp)
 800:	6442                	ld	s0,16(sp)
 802:	6125                	addi	sp,sp,96
 804:	8082                	ret

0000000000000806 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 806:	1141                	addi	sp,sp,-16
 808:	e422                	sd	s0,8(sp)
 80a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80c:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x170>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 810:	00000797          	auipc	a5,0x0
 814:	1a878793          	addi	a5,a5,424 # 9b8 <__bss_start>
 818:	639c                	ld	a5,0(a5)
 81a:	a805                	j	84a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 81c:	4618                	lw	a4,8(a2)
 81e:	9db9                	addw	a1,a1,a4
 820:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 824:	6398                	ld	a4,0(a5)
 826:	6318                	ld	a4,0(a4)
 828:	fee53823          	sd	a4,-16(a0)
 82c:	a091                	j	870 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 82e:	ff852703          	lw	a4,-8(a0)
 832:	9e39                	addw	a2,a2,a4
 834:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 836:	ff053703          	ld	a4,-16(a0)
 83a:	e398                	sd	a4,0(a5)
 83c:	a099                	j	882 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83e:	6398                	ld	a4,0(a5)
 840:	00e7e463          	bltu	a5,a4,848 <free+0x42>
 844:	00e6ea63          	bltu	a3,a4,858 <free+0x52>
{
 848:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84a:	fed7fae3          	bleu	a3,a5,83e <free+0x38>
 84e:	6398                	ld	a4,0(a5)
 850:	00e6e463          	bltu	a3,a4,858 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 854:	fee7eae3          	bltu	a5,a4,848 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 858:	ff852583          	lw	a1,-8(a0)
 85c:	6390                	ld	a2,0(a5)
 85e:	02059713          	slli	a4,a1,0x20
 862:	9301                	srli	a4,a4,0x20
 864:	0712                	slli	a4,a4,0x4
 866:	9736                	add	a4,a4,a3
 868:	fae60ae3          	beq	a2,a4,81c <free+0x16>
    bp->s.ptr = p->s.ptr;
 86c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 870:	4790                	lw	a2,8(a5)
 872:	02061713          	slli	a4,a2,0x20
 876:	9301                	srli	a4,a4,0x20
 878:	0712                	slli	a4,a4,0x4
 87a:	973e                	add	a4,a4,a5
 87c:	fae689e3          	beq	a3,a4,82e <free+0x28>
  } else
    p->s.ptr = bp;
 880:	e394                	sd	a3,0(a5)
  freep = p;
 882:	00000717          	auipc	a4,0x0
 886:	12f73b23          	sd	a5,310(a4) # 9b8 <__bss_start>
}
 88a:	6422                	ld	s0,8(sp)
 88c:	0141                	addi	sp,sp,16
 88e:	8082                	ret

0000000000000890 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 890:	7139                	addi	sp,sp,-64
 892:	fc06                	sd	ra,56(sp)
 894:	f822                	sd	s0,48(sp)
 896:	f426                	sd	s1,40(sp)
 898:	f04a                	sd	s2,32(sp)
 89a:	ec4e                	sd	s3,24(sp)
 89c:	e852                	sd	s4,16(sp)
 89e:	e456                	sd	s5,8(sp)
 8a0:	e05a                	sd	s6,0(sp)
 8a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a4:	02051993          	slli	s3,a0,0x20
 8a8:	0209d993          	srli	s3,s3,0x20
 8ac:	09bd                	addi	s3,s3,15
 8ae:	0049d993          	srli	s3,s3,0x4
 8b2:	2985                	addiw	s3,s3,1
 8b4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8b8:	00000797          	auipc	a5,0x0
 8bc:	10078793          	addi	a5,a5,256 # 9b8 <__bss_start>
 8c0:	6388                	ld	a0,0(a5)
 8c2:	c515                	beqz	a0,8ee <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c6:	4798                	lw	a4,8(a5)
 8c8:	03277f63          	bleu	s2,a4,906 <malloc+0x76>
 8cc:	8a4e                	mv	s4,s3
 8ce:	0009871b          	sext.w	a4,s3
 8d2:	6685                	lui	a3,0x1
 8d4:	00d77363          	bleu	a3,a4,8da <malloc+0x4a>
 8d8:	6a05                	lui	s4,0x1
 8da:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8de:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e2:	00000497          	auipc	s1,0x0
 8e6:	0d648493          	addi	s1,s1,214 # 9b8 <__bss_start>
  if(p == (char*)-1)
 8ea:	5b7d                	li	s6,-1
 8ec:	a885                	j	95c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8ee:	00000797          	auipc	a5,0x0
 8f2:	58278793          	addi	a5,a5,1410 # e70 <base>
 8f6:	00000717          	auipc	a4,0x0
 8fa:	0cf73123          	sd	a5,194(a4) # 9b8 <__bss_start>
 8fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 900:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 904:	b7e1                	j	8cc <malloc+0x3c>
      if(p->s.size == nunits)
 906:	02e90b63          	beq	s2,a4,93c <malloc+0xac>
        p->s.size -= nunits;
 90a:	4137073b          	subw	a4,a4,s3
 90e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 910:	1702                	slli	a4,a4,0x20
 912:	9301                	srli	a4,a4,0x20
 914:	0712                	slli	a4,a4,0x4
 916:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 918:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91c:	00000717          	auipc	a4,0x0
 920:	08a73e23          	sd	a0,156(a4) # 9b8 <__bss_start>
      return (void*)(p + 1);
 924:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 928:	70e2                	ld	ra,56(sp)
 92a:	7442                	ld	s0,48(sp)
 92c:	74a2                	ld	s1,40(sp)
 92e:	7902                	ld	s2,32(sp)
 930:	69e2                	ld	s3,24(sp)
 932:	6a42                	ld	s4,16(sp)
 934:	6aa2                	ld	s5,8(sp)
 936:	6b02                	ld	s6,0(sp)
 938:	6121                	addi	sp,sp,64
 93a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 93c:	6398                	ld	a4,0(a5)
 93e:	e118                	sd	a4,0(a0)
 940:	bff1                	j	91c <malloc+0x8c>
  hp->s.size = nu;
 942:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 946:	0541                	addi	a0,a0,16
 948:	00000097          	auipc	ra,0x0
 94c:	ebe080e7          	jalr	-322(ra) # 806 <free>
  return freep;
 950:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 952:	d979                	beqz	a0,928 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 954:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 956:	4798                	lw	a4,8(a5)
 958:	fb2777e3          	bleu	s2,a4,906 <malloc+0x76>
    if(p == freep)
 95c:	6098                	ld	a4,0(s1)
 95e:	853e                	mv	a0,a5
 960:	fef71ae3          	bne	a4,a5,954 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 964:	8552                	mv	a0,s4
 966:	00000097          	auipc	ra,0x0
 96a:	a5c080e7          	jalr	-1444(ra) # 3c2 <sbrk>
  if(p == (char*)-1)
 96e:	fd651ae3          	bne	a0,s6,942 <malloc+0xb2>
        return 0;
 972:	4501                	li	a0,0
 974:	bf55                	j	928 <malloc+0x98>
