
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	162080e7          	jalr	354(ra) # 16e <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	400080e7          	jalr	1024(ra) # 41c <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00001517          	auipc	a0,0x1
  3e:	9fe50513          	addi	a0,a0,-1538 # a38 <printf+0x36>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	3a4080e7          	jalr	932(ra) # 3f4 <fork>
    if(pid < 0)
  58:	02054763          	bltz	a0,86 <forktest+0x58>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00001517          	auipc	a0,0x1
  68:	9e450513          	addi	a0,a0,-1564 # a48 <printf+0x46>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	386080e7          	jalr	902(ra) # 3fc <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	37e080e7          	jalr	894(ra) # 3fc <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	370080e7          	jalr	880(ra) # 404 <wait>
  9c:	02054a63          	bltz	a0,d0 <forktest+0xa2>
  for(; n > 0; n--){
  a0:	34fd                	addiw	s1,s1,-1
  a2:	f8e5                	bnez	s1,92 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	35e080e7          	jalr	862(ra) # 404 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	9e450513          	addi	a0,a0,-1564 # a98 <printf+0x96>
  bc:	00000097          	auipc	ra,0x0
  c0:	f44080e7          	jalr	-188(ra) # 0 <print>
}
  c4:	60e2                	ld	ra,24(sp)
  c6:	6442                	ld	s0,16(sp)
  c8:	64a2                	ld	s1,8(sp)
  ca:	6902                	ld	s2,0(sp)
  cc:	6105                	addi	sp,sp,32
  ce:	8082                	ret
      print("wait stopped early\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	99850513          	addi	a0,a0,-1640 # a68 <printf+0x66>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	31a080e7          	jalr	794(ra) # 3fc <exit>
    print("wait got too many\n");
  ea:	00001517          	auipc	a0,0x1
  ee:	99650513          	addi	a0,a0,-1642 # a80 <printf+0x7e>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	300080e7          	jalr	768(ra) # 3fc <exit>

0000000000000104 <main>:

int
main(void)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  forktest();
 10c:	00000097          	auipc	ra,0x0
 110:	f22080e7          	jalr	-222(ra) # 2e <forktest>
  exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	2e6080e7          	jalr	742(ra) # 3fc <exit>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0x8>
    ;
  return os;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	cf91                	beqz	a5,160 <strcmp+0x26>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	00f71b63          	bne	a4,a5,160 <strcmp+0x26>
    p++, q++;
 14e:	0505                	addi	a0,a0,1
 150:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 152:	00054783          	lbu	a5,0(a0)
 156:	c789                	beqz	a5,160 <strcmp+0x26>
 158:	0005c703          	lbu	a4,0(a1)
 15c:	fef709e3          	beq	a4,a5,14e <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint
strlen(const char *s)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	4685                	li	a3,1
 180:	9e89                	subw	a3,a3,a0
 182:	00f6853b          	addw	a0,a3,a5
 186:	0785                	addi	a5,a5,1
 188:	fff7c703          	lbu	a4,-1(a5)
 18c:	fb7d                	bnez	a4,182 <strlen+0x14>
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ce09                	beqz	a2,1b8 <memset+0x20>
 1a0:	87aa                	mv	a5,a0
 1a2:	fff6071b          	addiw	a4,a2,-1
 1a6:	1702                	slli	a4,a4,0x20
 1a8:	9301                	srli	a4,a4,0x20
 1aa:	0705                	addi	a4,a4,1
 1ac:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1ae:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b2:	0785                	addi	a5,a5,1
 1b4:	fee79de3          	bne	a5,a4,1ae <memset+0x16>
  }
  return dst;
}
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strchr>:

char*
strchr(const char *s, char c)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	cf91                	beqz	a5,1e4 <strchr+0x26>
    if(*s == c)
 1ca:	00f58a63          	beq	a1,a5,1de <strchr+0x20>
  for(; *s; s++)
 1ce:	0505                	addi	a0,a0,1
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	c781                	beqz	a5,1dc <strchr+0x1e>
    if(*s == c)
 1d6:	feb79ce3          	bne	a5,a1,1ce <strchr+0x10>
 1da:	a011                	j	1de <strchr+0x20>
      return (char*)s;
  return 0;
 1dc:	4501                	li	a0,0
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  return 0;
 1e4:	4501                	li	a0,0
 1e6:	bfe5                	j	1de <strchr+0x20>

00000000000001e8 <gets>:

char*
gets(char *buf, int max)
{
 1e8:	711d                	addi	sp,sp,-96
 1ea:	ec86                	sd	ra,88(sp)
 1ec:	e8a2                	sd	s0,80(sp)
 1ee:	e4a6                	sd	s1,72(sp)
 1f0:	e0ca                	sd	s2,64(sp)
 1f2:	fc4e                	sd	s3,56(sp)
 1f4:	f852                	sd	s4,48(sp)
 1f6:	f456                	sd	s5,40(sp)
 1f8:	f05a                	sd	s6,32(sp)
 1fa:	ec5e                	sd	s7,24(sp)
 1fc:	1080                	addi	s0,sp,96
 1fe:	8baa                	mv	s7,a0
 200:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 202:	892a                	mv	s2,a0
 204:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 206:	4aa9                	li	s5,10
 208:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 20a:	0019849b          	addiw	s1,s3,1
 20e:	0344d863          	ble	s4,s1,23e <gets+0x56>
    cc = read(0, &c, 1);
 212:	4605                	li	a2,1
 214:	faf40593          	addi	a1,s0,-81
 218:	4501                	li	a0,0
 21a:	00000097          	auipc	ra,0x0
 21e:	1fa080e7          	jalr	506(ra) # 414 <read>
    if(cc < 1)
 222:	00a05e63          	blez	a0,23e <gets+0x56>
    buf[i++] = c;
 226:	faf44783          	lbu	a5,-81(s0)
 22a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 22e:	01578763          	beq	a5,s5,23c <gets+0x54>
 232:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 234:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 236:	fd679ae3          	bne	a5,s6,20a <gets+0x22>
 23a:	a011                	j	23e <gets+0x56>
  for(i=0; i+1 < max; ){
 23c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 23e:	99de                	add	s3,s3,s7
 240:	00098023          	sb	zero,0(s3)
  return buf;
}
 244:	855e                	mv	a0,s7
 246:	60e6                	ld	ra,88(sp)
 248:	6446                	ld	s0,80(sp)
 24a:	64a6                	ld	s1,72(sp)
 24c:	6906                	ld	s2,64(sp)
 24e:	79e2                	ld	s3,56(sp)
 250:	7a42                	ld	s4,48(sp)
 252:	7aa2                	ld	s5,40(sp)
 254:	7b02                	ld	s6,32(sp)
 256:	6be2                	ld	s7,24(sp)
 258:	6125                	addi	sp,sp,96
 25a:	8082                	ret

000000000000025c <atoi>:
  return r;
}

int
atoi(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	00054683          	lbu	a3,0(a0)
 266:	fd06879b          	addiw	a5,a3,-48
 26a:	0ff7f793          	andi	a5,a5,255
 26e:	4725                	li	a4,9
 270:	02f76963          	bltu	a4,a5,2a2 <atoi+0x46>
 274:	862a                	mv	a2,a0
  n = 0;
 276:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 278:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 27a:	0605                	addi	a2,a2,1
 27c:	0025179b          	slliw	a5,a0,0x2
 280:	9fa9                	addw	a5,a5,a0
 282:	0017979b          	slliw	a5,a5,0x1
 286:	9fb5                	addw	a5,a5,a3
 288:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	00064683          	lbu	a3,0(a2)
 290:	fd06871b          	addiw	a4,a3,-48
 294:	0ff77713          	andi	a4,a4,255
 298:	fee5f1e3          	bleu	a4,a1,27a <atoi+0x1e>
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  n = 0;
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <atoi+0x40>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57663          	bleu	a1,a0,2d8 <memmove+0x32>
    while(n-- > 0)
 2b0:	02c05163          	blez	a2,2d2 <memmove+0x2c>
 2b4:	fff6079b          	addiw	a5,a2,-1
 2b8:	1782                	slli	a5,a5,0x20
 2ba:	9381                	srli	a5,a5,0x20
 2bc:	0785                	addi	a5,a5,1
 2be:	97aa                	add	a5,a5,a0
  dst = vdst;
 2c0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c2:	0585                	addi	a1,a1,1
 2c4:	0705                	addi	a4,a4,1
 2c6:	fff5c683          	lbu	a3,-1(a1)
 2ca:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ce:	fee79ae3          	bne	a5,a4,2c2 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
    dst += n;
 2d8:	00c50733          	add	a4,a0,a2
    src += n;
 2dc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2de:	fec05ae3          	blez	a2,2d2 <memmove+0x2c>
 2e2:	fff6079b          	addiw	a5,a2,-1
 2e6:	1782                	slli	a5,a5,0x20
 2e8:	9381                	srli	a5,a5,0x20
 2ea:	fff7c793          	not	a5,a5
 2ee:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f0:	15fd                	addi	a1,a1,-1
 2f2:	177d                	addi	a4,a4,-1
 2f4:	0005c683          	lbu	a3,0(a1)
 2f8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fc:	fef71ae3          	bne	a4,a5,2f0 <memmove+0x4a>
 300:	bfc9                	j	2d2 <memmove+0x2c>

0000000000000302 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 308:	ce15                	beqz	a2,344 <memcmp+0x42>
 30a:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 30e:	00054783          	lbu	a5,0(a0)
 312:	0005c703          	lbu	a4,0(a1)
 316:	02e79063          	bne	a5,a4,336 <memcmp+0x34>
 31a:	1682                	slli	a3,a3,0x20
 31c:	9281                	srli	a3,a3,0x20
 31e:	0685                	addi	a3,a3,1
 320:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 322:	0505                	addi	a0,a0,1
    p2++;
 324:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 326:	00d50d63          	beq	a0,a3,340 <memcmp+0x3e>
    if (*p1 != *p2) {
 32a:	00054783          	lbu	a5,0(a0)
 32e:	0005c703          	lbu	a4,0(a1)
 332:	fee788e3          	beq	a5,a4,322 <memcmp+0x20>
      return *p1 - *p2;
 336:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
  return 0;
 340:	4501                	li	a0,0
 342:	bfe5                	j	33a <memcmp+0x38>
 344:	4501                	li	a0,0
 346:	bfd5                	j	33a <memcmp+0x38>

0000000000000348 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 350:	00000097          	auipc	ra,0x0
 354:	f56080e7          	jalr	-170(ra) # 2a6 <memmove>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <close>:

int close(int fd){
 360:	1101                	addi	sp,sp,-32
 362:	ec06                	sd	ra,24(sp)
 364:	e822                	sd	s0,16(sp)
 366:	e426                	sd	s1,8(sp)
 368:	1000                	addi	s0,sp,32
 36a:	84aa                	mv	s1,a0
  fflush(fd);
 36c:	00000097          	auipc	ra,0x0
 370:	44a080e7          	jalr	1098(ra) # 7b6 <fflush>
  char* buf = get_putc_buf(fd);
 374:	8526                	mv	a0,s1
 376:	00000097          	auipc	ra,0x0
 37a:	2be080e7          	jalr	702(ra) # 634 <get_putc_buf>
  if(buf){
 37e:	cd11                	beqz	a0,39a <close+0x3a>
    free(buf);
 380:	00000097          	auipc	ra,0x0
 384:	144080e7          	jalr	324(ra) # 4c4 <free>
    putc_buf[fd] = 0;
 388:	00349713          	slli	a4,s1,0x3
 38c:	00000797          	auipc	a5,0x0
 390:	75478793          	addi	a5,a5,1876 # ae0 <putc_buf>
 394:	97ba                	add	a5,a5,a4
 396:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 39a:	8526                	mv	a0,s1
 39c:	00000097          	auipc	ra,0x0
 3a0:	088080e7          	jalr	136(ra) # 424 <sclose>
}
 3a4:	60e2                	ld	ra,24(sp)
 3a6:	6442                	ld	s0,16(sp)
 3a8:	64a2                	ld	s1,8(sp)
 3aa:	6105                	addi	sp,sp,32
 3ac:	8082                	ret

00000000000003ae <stat>:
{
 3ae:	1101                	addi	sp,sp,-32
 3b0:	ec06                	sd	ra,24(sp)
 3b2:	e822                	sd	s0,16(sp)
 3b4:	e426                	sd	s1,8(sp)
 3b6:	e04a                	sd	s2,0(sp)
 3b8:	1000                	addi	s0,sp,32
 3ba:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 3bc:	4581                	li	a1,0
 3be:	00000097          	auipc	ra,0x0
 3c2:	07e080e7          	jalr	126(ra) # 43c <open>
  if(fd < 0)
 3c6:	02054563          	bltz	a0,3f0 <stat+0x42>
 3ca:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 3cc:	85ca                	mv	a1,s2
 3ce:	00000097          	auipc	ra,0x0
 3d2:	086080e7          	jalr	134(ra) # 454 <fstat>
 3d6:	892a                	mv	s2,a0
  close(fd);
 3d8:	8526                	mv	a0,s1
 3da:	00000097          	auipc	ra,0x0
 3de:	f86080e7          	jalr	-122(ra) # 360 <close>
}
 3e2:	854a                	mv	a0,s2
 3e4:	60e2                	ld	ra,24(sp)
 3e6:	6442                	ld	s0,16(sp)
 3e8:	64a2                	ld	s1,8(sp)
 3ea:	6902                	ld	s2,0(sp)
 3ec:	6105                	addi	sp,sp,32
 3ee:	8082                	ret
    return -1;
 3f0:	597d                	li	s2,-1
 3f2:	bfc5                	j	3e2 <stat+0x34>

00000000000003f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f4:	4885                	li	a7,1
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3fc:	4889                	li	a7,2
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <wait>:
.global wait
wait:
 li a7, SYS_wait
 404:	488d                	li	a7,3
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 40c:	4891                	li	a7,4
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <read>:
.global read
read:
 li a7, SYS_read
 414:	4895                	li	a7,5
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <write>:
.global write
write:
 li a7, SYS_write
 41c:	48c1                	li	a7,16
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 424:	48d5                	li	a7,21
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <kill>:
.global kill
kill:
 li a7, SYS_kill
 42c:	4899                	li	a7,6
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <exec>:
.global exec
exec:
 li a7, SYS_exec
 434:	489d                	li	a7,7
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <open>:
.global open
open:
 li a7, SYS_open
 43c:	48bd                	li	a7,15
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 444:	48c5                	li	a7,17
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 44c:	48c9                	li	a7,18
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 454:	48a1                	li	a7,8
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <link>:
.global link
link:
 li a7, SYS_link
 45c:	48cd                	li	a7,19
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 464:	48d1                	li	a7,20
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46c:	48a5                	li	a7,9
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <dup>:
.global dup
dup:
 li a7, SYS_dup
 474:	48a9                	li	a7,10
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47c:	48ad                	li	a7,11
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 484:	48b1                	li	a7,12
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 48c:	48b5                	li	a7,13
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 494:	48b9                	li	a7,14
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 49c:	48d9                	li	a7,22
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <nice>:
.global nice
nice:
 li a7, SYS_nice
 4a4:	48dd                	li	a7,23
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 4ac:	48e1                	li	a7,24
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 4b4:	48e5                	li	a7,25
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 4bc:	48e9                	li	a7,26
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e422                	sd	s0,8(sp)
 4c8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4ca:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4ce:	00000797          	auipc	a5,0x0
 4d2:	5fa78793          	addi	a5,a5,1530 # ac8 <__bss_start>
 4d6:	639c                	ld	a5,0(a5)
 4d8:	a805                	j	508 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4da:	4618                	lw	a4,8(a2)
 4dc:	9db9                	addw	a1,a1,a4
 4de:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 4e2:	6398                	ld	a4,0(a5)
 4e4:	6318                	ld	a4,0(a4)
 4e6:	fee53823          	sd	a4,-16(a0)
 4ea:	a091                	j	52e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 4ec:	ff852703          	lw	a4,-8(a0)
 4f0:	9e39                	addw	a2,a2,a4
 4f2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 4f4:	ff053703          	ld	a4,-16(a0)
 4f8:	e398                	sd	a4,0(a5)
 4fa:	a099                	j	540 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4fc:	6398                	ld	a4,0(a5)
 4fe:	00e7e463          	bltu	a5,a4,506 <free+0x42>
 502:	00e6ea63          	bltu	a3,a4,516 <free+0x52>
{
 506:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 508:	fed7fae3          	bleu	a3,a5,4fc <free+0x38>
 50c:	6398                	ld	a4,0(a5)
 50e:	00e6e463          	bltu	a3,a4,516 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 512:	fee7eae3          	bltu	a5,a4,506 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 516:	ff852583          	lw	a1,-8(a0)
 51a:	6390                	ld	a2,0(a5)
 51c:	02059713          	slli	a4,a1,0x20
 520:	9301                	srli	a4,a4,0x20
 522:	0712                	slli	a4,a4,0x4
 524:	9736                	add	a4,a4,a3
 526:	fae60ae3          	beq	a2,a4,4da <free+0x16>
    bp->s.ptr = p->s.ptr;
 52a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 52e:	4790                	lw	a2,8(a5)
 530:	02061713          	slli	a4,a2,0x20
 534:	9301                	srli	a4,a4,0x20
 536:	0712                	slli	a4,a4,0x4
 538:	973e                	add	a4,a4,a5
 53a:	fae689e3          	beq	a3,a4,4ec <free+0x28>
  } else
    p->s.ptr = bp;
 53e:	e394                	sd	a3,0(a5)
  freep = p;
 540:	00000717          	auipc	a4,0x0
 544:	58f73423          	sd	a5,1416(a4) # ac8 <__bss_start>
}
 548:	6422                	ld	s0,8(sp)
 54a:	0141                	addi	sp,sp,16
 54c:	8082                	ret

000000000000054e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 54e:	7139                	addi	sp,sp,-64
 550:	fc06                	sd	ra,56(sp)
 552:	f822                	sd	s0,48(sp)
 554:	f426                	sd	s1,40(sp)
 556:	f04a                	sd	s2,32(sp)
 558:	ec4e                	sd	s3,24(sp)
 55a:	e852                	sd	s4,16(sp)
 55c:	e456                	sd	s5,8(sp)
 55e:	e05a                	sd	s6,0(sp)
 560:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 562:	02051993          	slli	s3,a0,0x20
 566:	0209d993          	srli	s3,s3,0x20
 56a:	09bd                	addi	s3,s3,15
 56c:	0049d993          	srli	s3,s3,0x4
 570:	2985                	addiw	s3,s3,1
 572:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 576:	00000797          	auipc	a5,0x0
 57a:	55278793          	addi	a5,a5,1362 # ac8 <__bss_start>
 57e:	6388                	ld	a0,0(a5)
 580:	c515                	beqz	a0,5ac <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 582:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 584:	4798                	lw	a4,8(a5)
 586:	03277f63          	bleu	s2,a4,5c4 <malloc+0x76>
 58a:	8a4e                	mv	s4,s3
 58c:	0009871b          	sext.w	a4,s3
 590:	6685                	lui	a3,0x1
 592:	00d77363          	bleu	a3,a4,598 <malloc+0x4a>
 596:	6a05                	lui	s4,0x1
 598:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 59c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5a0:	00000497          	auipc	s1,0x0
 5a4:	52848493          	addi	s1,s1,1320 # ac8 <__bss_start>
  if(p == (char*)-1)
 5a8:	5b7d                	li	s6,-1
 5aa:	a885                	j	61a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 5ac:	00000797          	auipc	a5,0x0
 5b0:	52478793          	addi	a5,a5,1316 # ad0 <base>
 5b4:	00000717          	auipc	a4,0x0
 5b8:	50f73a23          	sd	a5,1300(a4) # ac8 <__bss_start>
 5bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 5be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 5c2:	b7e1                	j	58a <malloc+0x3c>
      if(p->s.size == nunits)
 5c4:	02e90b63          	beq	s2,a4,5fa <malloc+0xac>
        p->s.size -= nunits;
 5c8:	4137073b          	subw	a4,a4,s3
 5cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 5ce:	1702                	slli	a4,a4,0x20
 5d0:	9301                	srli	a4,a4,0x20
 5d2:	0712                	slli	a4,a4,0x4
 5d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 5d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 5da:	00000717          	auipc	a4,0x0
 5de:	4ea73723          	sd	a0,1262(a4) # ac8 <__bss_start>
      return (void*)(p + 1);
 5e2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5e6:	70e2                	ld	ra,56(sp)
 5e8:	7442                	ld	s0,48(sp)
 5ea:	74a2                	ld	s1,40(sp)
 5ec:	7902                	ld	s2,32(sp)
 5ee:	69e2                	ld	s3,24(sp)
 5f0:	6a42                	ld	s4,16(sp)
 5f2:	6aa2                	ld	s5,8(sp)
 5f4:	6b02                	ld	s6,0(sp)
 5f6:	6121                	addi	sp,sp,64
 5f8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 5fa:	6398                	ld	a4,0(a5)
 5fc:	e118                	sd	a4,0(a0)
 5fe:	bff1                	j	5da <malloc+0x8c>
  hp->s.size = nu;
 600:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 604:	0541                	addi	a0,a0,16
 606:	00000097          	auipc	ra,0x0
 60a:	ebe080e7          	jalr	-322(ra) # 4c4 <free>
  return freep;
 60e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 610:	d979                	beqz	a0,5e6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 612:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 614:	4798                	lw	a4,8(a5)
 616:	fb2777e3          	bleu	s2,a4,5c4 <malloc+0x76>
    if(p == freep)
 61a:	6098                	ld	a4,0(s1)
 61c:	853e                	mv	a0,a5
 61e:	fef71ae3          	bne	a4,a5,612 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 622:	8552                	mv	a0,s4
 624:	00000097          	auipc	ra,0x0
 628:	e60080e7          	jalr	-416(ra) # 484 <sbrk>
  if(p == (char*)-1)
 62c:	fd651ae3          	bne	a0,s6,600 <malloc+0xb2>
        return 0;
 630:	4501                	li	a0,0
 632:	bf55                	j	5e6 <malloc+0x98>

0000000000000634 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 634:	1101                	addi	sp,sp,-32
 636:	ec06                	sd	ra,24(sp)
 638:	e822                	sd	s0,16(sp)
 63a:	e426                	sd	s1,8(sp)
 63c:	1000                	addi	s0,sp,32
 63e:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 640:	00351693          	slli	a3,a0,0x3
 644:	00000797          	auipc	a5,0x0
 648:	49c78793          	addi	a5,a5,1180 # ae0 <putc_buf>
 64c:	97b6                	add	a5,a5,a3
 64e:	6388                	ld	a0,0(a5)
  if(buf) {
 650:	c511                	beqz	a0,65c <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	64a2                	ld	s1,8(sp)
 658:	6105                	addi	sp,sp,32
 65a:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 65c:	6505                	lui	a0,0x1
 65e:	00000097          	auipc	ra,0x0
 662:	ef0080e7          	jalr	-272(ra) # 54e <malloc>
  putc_buf[fd] = buf;
 666:	00000797          	auipc	a5,0x0
 66a:	47a78793          	addi	a5,a5,1146 # ae0 <putc_buf>
 66e:	00349713          	slli	a4,s1,0x3
 672:	973e                	add	a4,a4,a5
 674:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 676:	00249713          	slli	a4,s1,0x2
 67a:	973e                	add	a4,a4,a5
 67c:	32072023          	sw	zero,800(a4)
  return buf;
 680:	bfc9                	j	652 <get_putc_buf+0x1e>

0000000000000682 <putc>:

static void
putc(int fd, char c)
{
 682:	1101                	addi	sp,sp,-32
 684:	ec06                	sd	ra,24(sp)
 686:	e822                	sd	s0,16(sp)
 688:	e426                	sd	s1,8(sp)
 68a:	e04a                	sd	s2,0(sp)
 68c:	1000                	addi	s0,sp,32
 68e:	84aa                	mv	s1,a0
 690:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 692:	00000097          	auipc	ra,0x0
 696:	fa2080e7          	jalr	-94(ra) # 634 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 69a:	00249793          	slli	a5,s1,0x2
 69e:	00000717          	auipc	a4,0x0
 6a2:	44270713          	addi	a4,a4,1090 # ae0 <putc_buf>
 6a6:	973e                	add	a4,a4,a5
 6a8:	32072783          	lw	a5,800(a4)
 6ac:	0017869b          	addiw	a3,a5,1
 6b0:	32d72023          	sw	a3,800(a4)
 6b4:	97aa                	add	a5,a5,a0
 6b6:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 6ba:	47a9                	li	a5,10
 6bc:	02f90463          	beq	s2,a5,6e4 <putc+0x62>
 6c0:	00249713          	slli	a4,s1,0x2
 6c4:	00000797          	auipc	a5,0x0
 6c8:	41c78793          	addi	a5,a5,1052 # ae0 <putc_buf>
 6cc:	97ba                	add	a5,a5,a4
 6ce:	3207a703          	lw	a4,800(a5)
 6d2:	6785                	lui	a5,0x1
 6d4:	00f70863          	beq	a4,a5,6e4 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 6d8:	60e2                	ld	ra,24(sp)
 6da:	6442                	ld	s0,16(sp)
 6dc:	64a2                	ld	s1,8(sp)
 6de:	6902                	ld	s2,0(sp)
 6e0:	6105                	addi	sp,sp,32
 6e2:	8082                	ret
    write(fd, buf, putc_index[fd]);
 6e4:	00249793          	slli	a5,s1,0x2
 6e8:	00000917          	auipc	s2,0x0
 6ec:	3f890913          	addi	s2,s2,1016 # ae0 <putc_buf>
 6f0:	993e                	add	s2,s2,a5
 6f2:	32092603          	lw	a2,800(s2)
 6f6:	85aa                	mv	a1,a0
 6f8:	8526                	mv	a0,s1
 6fa:	00000097          	auipc	ra,0x0
 6fe:	d22080e7          	jalr	-734(ra) # 41c <write>
    putc_index[fd] = 0;
 702:	32092023          	sw	zero,800(s2)
}
 706:	bfc9                	j	6d8 <putc+0x56>

0000000000000708 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 708:	7139                	addi	sp,sp,-64
 70a:	fc06                	sd	ra,56(sp)
 70c:	f822                	sd	s0,48(sp)
 70e:	f426                	sd	s1,40(sp)
 710:	f04a                	sd	s2,32(sp)
 712:	ec4e                	sd	s3,24(sp)
 714:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 716:	c299                	beqz	a3,71c <printint+0x14>
 718:	0005cd63          	bltz	a1,732 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 71c:	2581                	sext.w	a1,a1
  neg = 0;
 71e:	4301                	li	t1,0
 720:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 724:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 726:	2601                	sext.w	a2,a2
 728:	00000897          	auipc	a7,0x0
 72c:	38088893          	addi	a7,a7,896 # aa8 <digits>
 730:	a801                	j	740 <printint+0x38>
    x = -xx;
 732:	40b005bb          	negw	a1,a1
 736:	2581                	sext.w	a1,a1
    neg = 1;
 738:	4305                	li	t1,1
    x = -xx;
 73a:	b7dd                	j	720 <printint+0x18>
  }while((x /= base) != 0);
 73c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 73e:	8836                	mv	a6,a3
 740:	0018069b          	addiw	a3,a6,1
 744:	02c5f7bb          	remuw	a5,a1,a2
 748:	1782                	slli	a5,a5,0x20
 74a:	9381                	srli	a5,a5,0x20
 74c:	97c6                	add	a5,a5,a7
 74e:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x70>
 752:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 756:	0705                	addi	a4,a4,1
 758:	02c5d7bb          	divuw	a5,a1,a2
 75c:	fec5f0e3          	bleu	a2,a1,73c <printint+0x34>
  if(neg)
 760:	00030b63          	beqz	t1,776 <printint+0x6e>
    buf[i++] = '-';
 764:	fd040793          	addi	a5,s0,-48
 768:	96be                	add	a3,a3,a5
 76a:	02d00793          	li	a5,45
 76e:	fef68823          	sb	a5,-16(a3) # ff0 <_end+0x60>
 772:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 776:	02d05963          	blez	a3,7a8 <printint+0xa0>
 77a:	89aa                	mv	s3,a0
 77c:	fc040793          	addi	a5,s0,-64
 780:	00d784b3          	add	s1,a5,a3
 784:	fff78913          	addi	s2,a5,-1
 788:	9936                	add	s2,s2,a3
 78a:	36fd                	addiw	a3,a3,-1
 78c:	1682                	slli	a3,a3,0x20
 78e:	9281                	srli	a3,a3,0x20
 790:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 794:	fff4c583          	lbu	a1,-1(s1)
 798:	854e                	mv	a0,s3
 79a:	00000097          	auipc	ra,0x0
 79e:	ee8080e7          	jalr	-280(ra) # 682 <putc>
  while(--i >= 0)
 7a2:	14fd                	addi	s1,s1,-1
 7a4:	ff2498e3          	bne	s1,s2,794 <printint+0x8c>
}
 7a8:	70e2                	ld	ra,56(sp)
 7aa:	7442                	ld	s0,48(sp)
 7ac:	74a2                	ld	s1,40(sp)
 7ae:	7902                	ld	s2,32(sp)
 7b0:	69e2                	ld	s3,24(sp)
 7b2:	6121                	addi	sp,sp,64
 7b4:	8082                	ret

00000000000007b6 <fflush>:
void fflush(int fd){
 7b6:	1101                	addi	sp,sp,-32
 7b8:	ec06                	sd	ra,24(sp)
 7ba:	e822                	sd	s0,16(sp)
 7bc:	e426                	sd	s1,8(sp)
 7be:	e04a                	sd	s2,0(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e70080e7          	jalr	-400(ra) # 634 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 7cc:	00291793          	slli	a5,s2,0x2
 7d0:	00000497          	auipc	s1,0x0
 7d4:	31048493          	addi	s1,s1,784 # ae0 <putc_buf>
 7d8:	94be                	add	s1,s1,a5
 7da:	3204a603          	lw	a2,800(s1)
 7de:	85aa                	mv	a1,a0
 7e0:	854a                	mv	a0,s2
 7e2:	00000097          	auipc	ra,0x0
 7e6:	c3a080e7          	jalr	-966(ra) # 41c <write>
  putc_index[fd] = 0;
 7ea:	3204a023          	sw	zero,800(s1)
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	64a2                	ld	s1,8(sp)
 7f4:	6902                	ld	s2,0(sp)
 7f6:	6105                	addi	sp,sp,32
 7f8:	8082                	ret

00000000000007fa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7fa:	7119                	addi	sp,sp,-128
 7fc:	fc86                	sd	ra,120(sp)
 7fe:	f8a2                	sd	s0,112(sp)
 800:	f4a6                	sd	s1,104(sp)
 802:	f0ca                	sd	s2,96(sp)
 804:	ecce                	sd	s3,88(sp)
 806:	e8d2                	sd	s4,80(sp)
 808:	e4d6                	sd	s5,72(sp)
 80a:	e0da                	sd	s6,64(sp)
 80c:	fc5e                	sd	s7,56(sp)
 80e:	f862                	sd	s8,48(sp)
 810:	f466                	sd	s9,40(sp)
 812:	f06a                	sd	s10,32(sp)
 814:	ec6e                	sd	s11,24(sp)
 816:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 818:	0005c483          	lbu	s1,0(a1)
 81c:	18048d63          	beqz	s1,9b6 <vprintf+0x1bc>
 820:	8aaa                	mv	s5,a0
 822:	8b32                	mv	s6,a2
 824:	00158913          	addi	s2,a1,1
  state = 0;
 828:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 82a:	02500a13          	li	s4,37
      if(c == 'd'){
 82e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 832:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 836:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 83a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 83e:	00000b97          	auipc	s7,0x0
 842:	26ab8b93          	addi	s7,s7,618 # aa8 <digits>
 846:	a839                	j	864 <vprintf+0x6a>
        putc(fd, c);
 848:	85a6                	mv	a1,s1
 84a:	8556                	mv	a0,s5
 84c:	00000097          	auipc	ra,0x0
 850:	e36080e7          	jalr	-458(ra) # 682 <putc>
 854:	a019                	j	85a <vprintf+0x60>
    } else if(state == '%'){
 856:	01498f63          	beq	s3,s4,874 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 85a:	0905                	addi	s2,s2,1
 85c:	fff94483          	lbu	s1,-1(s2)
 860:	14048b63          	beqz	s1,9b6 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 864:	0004879b          	sext.w	a5,s1
    if(state == 0){
 868:	fe0997e3          	bnez	s3,856 <vprintf+0x5c>
      if(c == '%'){
 86c:	fd479ee3          	bne	a5,s4,848 <vprintf+0x4e>
        state = '%';
 870:	89be                	mv	s3,a5
 872:	b7e5                	j	85a <vprintf+0x60>
      if(c == 'd'){
 874:	05878063          	beq	a5,s8,8b4 <vprintf+0xba>
      } else if(c == 'l') {
 878:	05978c63          	beq	a5,s9,8d0 <vprintf+0xd6>
      } else if(c == 'x') {
 87c:	07a78863          	beq	a5,s10,8ec <vprintf+0xf2>
      } else if(c == 'p') {
 880:	09b78463          	beq	a5,s11,908 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 884:	07300713          	li	a4,115
 888:	0ce78563          	beq	a5,a4,952 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 88c:	06300713          	li	a4,99
 890:	0ee78c63          	beq	a5,a4,988 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 894:	11478663          	beq	a5,s4,9a0 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 898:	85d2                	mv	a1,s4
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	de6080e7          	jalr	-538(ra) # 682 <putc>
        putc(fd, c);
 8a4:	85a6                	mv	a1,s1
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	dda080e7          	jalr	-550(ra) # 682 <putc>
      }
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b765                	j	85a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8b4:	008b0493          	addi	s1,s6,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000b2583          	lw	a1,0(s6)
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	e46080e7          	jalr	-442(ra) # 708 <printint>
 8ca:	8b26                	mv	s6,s1
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b771                	j	85a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d0:	008b0493          	addi	s1,s6,8
 8d4:	4681                	li	a3,0
 8d6:	4629                	li	a2,10
 8d8:	000b2583          	lw	a1,0(s6)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	e2a080e7          	jalr	-470(ra) # 708 <printint>
 8e6:	8b26                	mv	s6,s1
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bf85                	j	85a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8ec:	008b0493          	addi	s1,s6,8
 8f0:	4681                	li	a3,0
 8f2:	4641                	li	a2,16
 8f4:	000b2583          	lw	a1,0(s6)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e0e080e7          	jalr	-498(ra) # 708 <printint>
 902:	8b26                	mv	s6,s1
      state = 0;
 904:	4981                	li	s3,0
 906:	bf91                	j	85a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 908:	008b0793          	addi	a5,s6,8
 90c:	f8f43423          	sd	a5,-120(s0)
 910:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 914:	03000593          	li	a1,48
 918:	8556                	mv	a0,s5
 91a:	00000097          	auipc	ra,0x0
 91e:	d68080e7          	jalr	-664(ra) # 682 <putc>
  putc(fd, 'x');
 922:	85ea                	mv	a1,s10
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	d5c080e7          	jalr	-676(ra) # 682 <putc>
 92e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 930:	03c9d793          	srli	a5,s3,0x3c
 934:	97de                	add	a5,a5,s7
 936:	0007c583          	lbu	a1,0(a5)
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	d46080e7          	jalr	-698(ra) # 682 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 944:	0992                	slli	s3,s3,0x4
 946:	34fd                	addiw	s1,s1,-1
 948:	f4e5                	bnez	s1,930 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 94a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 94e:	4981                	li	s3,0
 950:	b729                	j	85a <vprintf+0x60>
        s = va_arg(ap, char*);
 952:	008b0993          	addi	s3,s6,8
 956:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 95a:	c085                	beqz	s1,97a <vprintf+0x180>
        while(*s != 0){
 95c:	0004c583          	lbu	a1,0(s1)
 960:	c9a1                	beqz	a1,9b0 <vprintf+0x1b6>
          putc(fd, *s);
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	d1e080e7          	jalr	-738(ra) # 682 <putc>
          s++;
 96c:	0485                	addi	s1,s1,1
        while(*s != 0){
 96e:	0004c583          	lbu	a1,0(s1)
 972:	f9e5                	bnez	a1,962 <vprintf+0x168>
        s = va_arg(ap, char*);
 974:	8b4e                	mv	s6,s3
      state = 0;
 976:	4981                	li	s3,0
 978:	b5cd                	j	85a <vprintf+0x60>
          s = "(null)";
 97a:	00000497          	auipc	s1,0x0
 97e:	14648493          	addi	s1,s1,326 # ac0 <digits+0x18>
        while(*s != 0){
 982:	02800593          	li	a1,40
 986:	bff1                	j	962 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 988:	008b0493          	addi	s1,s6,8
 98c:	000b4583          	lbu	a1,0(s6)
 990:	8556                	mv	a0,s5
 992:	00000097          	auipc	ra,0x0
 996:	cf0080e7          	jalr	-784(ra) # 682 <putc>
 99a:	8b26                	mv	s6,s1
      state = 0;
 99c:	4981                	li	s3,0
 99e:	bd75                	j	85a <vprintf+0x60>
        putc(fd, c);
 9a0:	85d2                	mv	a1,s4
 9a2:	8556                	mv	a0,s5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	cde080e7          	jalr	-802(ra) # 682 <putc>
      state = 0;
 9ac:	4981                	li	s3,0
 9ae:	b575                	j	85a <vprintf+0x60>
        s = va_arg(ap, char*);
 9b0:	8b4e                	mv	s6,s3
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	b55d                	j	85a <vprintf+0x60>
    }
  }
}
 9b6:	70e6                	ld	ra,120(sp)
 9b8:	7446                	ld	s0,112(sp)
 9ba:	74a6                	ld	s1,104(sp)
 9bc:	7906                	ld	s2,96(sp)
 9be:	69e6                	ld	s3,88(sp)
 9c0:	6a46                	ld	s4,80(sp)
 9c2:	6aa6                	ld	s5,72(sp)
 9c4:	6b06                	ld	s6,64(sp)
 9c6:	7be2                	ld	s7,56(sp)
 9c8:	7c42                	ld	s8,48(sp)
 9ca:	7ca2                	ld	s9,40(sp)
 9cc:	7d02                	ld	s10,32(sp)
 9ce:	6de2                	ld	s11,24(sp)
 9d0:	6109                	addi	sp,sp,128
 9d2:	8082                	ret

00000000000009d4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9d4:	715d                	addi	sp,sp,-80
 9d6:	ec06                	sd	ra,24(sp)
 9d8:	e822                	sd	s0,16(sp)
 9da:	1000                	addi	s0,sp,32
 9dc:	e010                	sd	a2,0(s0)
 9de:	e414                	sd	a3,8(s0)
 9e0:	e818                	sd	a4,16(s0)
 9e2:	ec1c                	sd	a5,24(s0)
 9e4:	03043023          	sd	a6,32(s0)
 9e8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9f0:	8622                	mv	a2,s0
 9f2:	00000097          	auipc	ra,0x0
 9f6:	e08080e7          	jalr	-504(ra) # 7fa <vprintf>
}
 9fa:	60e2                	ld	ra,24(sp)
 9fc:	6442                	ld	s0,16(sp)
 9fe:	6161                	addi	sp,sp,80
 a00:	8082                	ret

0000000000000a02 <printf>:

void
printf(const char *fmt, ...)
{
 a02:	711d                	addi	sp,sp,-96
 a04:	ec06                	sd	ra,24(sp)
 a06:	e822                	sd	s0,16(sp)
 a08:	1000                	addi	s0,sp,32
 a0a:	e40c                	sd	a1,8(s0)
 a0c:	e810                	sd	a2,16(s0)
 a0e:	ec14                	sd	a3,24(s0)
 a10:	f018                	sd	a4,32(s0)
 a12:	f41c                	sd	a5,40(s0)
 a14:	03043823          	sd	a6,48(s0)
 a18:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a1c:	00840613          	addi	a2,s0,8
 a20:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a24:	85aa                	mv	a1,a0
 a26:	4505                	li	a0,1
 a28:	00000097          	auipc	ra,0x0
 a2c:	dd2080e7          	jalr	-558(ra) # 7fa <vprintf>
}
 a30:	60e2                	ld	ra,24(sp)
 a32:	6442                	ld	s0,16(sp)
 a34:	6125                	addi	sp,sp,96
 a36:	8082                	ret
