
user/_prints:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	0080                	addi	s0,sp,64
  int pid;
  for(int i = 0; i < 4; i++){
   c:	4481                	li	s1,0
   e:	4911                	li	s2,4
    pid = fork();
  10:	00000097          	auipc	ra,0x0
  14:	342080e7          	jalr	834(ra) # 352 <fork>
    if(pid == 0){
  18:	c10d                	beqz	a0,3a <main+0x3a>
  for(int i = 0; i < 4; i++){
  1a:	2485                	addiw	s1,s1,1
  1c:	ff249ae3          	bne	s1,s2,10 <main+0x10>
      argv[1][0] = 'A' + i;
      exec("/print", argv);
      exit(1);
    }
  }
  while(wait(0) != -1);
  20:	54fd                	li	s1,-1
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	33e080e7          	jalr	830(ra) # 362 <wait>
  2c:	fe951be3          	bne	a0,s1,22 <main+0x22>
  exit(0);
  30:	4501                	li	a0,0
  32:	00000097          	auipc	ra,0x0
  36:	328080e7          	jalr	808(ra) # 35a <exit>
      char* argv[] = {"print", "X", 0};
  3a:	00001797          	auipc	a5,0x1
  3e:	95e78793          	addi	a5,a5,-1698 # 998 <malloc+0xe8>
  42:	fcf43423          	sd	a5,-56(s0)
  46:	00001797          	auipc	a5,0x1
  4a:	95a78793          	addi	a5,a5,-1702 # 9a0 <malloc+0xf0>
  4e:	fcf43823          	sd	a5,-48(s0)
  52:	fc043c23          	sd	zero,-40(s0)
      argv[1][0] = 'A' + i;
  56:	0414849b          	addiw	s1,s1,65
  5a:	00978023          	sb	s1,0(a5)
      exec("/print", argv);
  5e:	fc840593          	addi	a1,s0,-56
  62:	00001517          	auipc	a0,0x1
  66:	94650513          	addi	a0,a0,-1722 # 9a8 <malloc+0xf8>
  6a:	00000097          	auipc	ra,0x0
  6e:	328080e7          	jalr	808(ra) # 392 <exec>
      exit(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	2e6080e7          	jalr	742(ra) # 35a <exit>

000000000000007c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	87aa                	mv	a5,a0
  84:	0585                	addi	a1,a1,1
  86:	0785                	addi	a5,a5,1
  88:	fff5c703          	lbu	a4,-1(a1)
  8c:	fee78fa3          	sb	a4,-1(a5)
  90:	fb75                	bnez	a4,84 <strcpy+0x8>
    ;
  return os;
}
  92:	6422                	ld	s0,8(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e422                	sd	s0,8(sp)
  9c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  9e:	00054783          	lbu	a5,0(a0)
  a2:	cf91                	beqz	a5,be <strcmp+0x26>
  a4:	0005c703          	lbu	a4,0(a1)
  a8:	00f71b63          	bne	a4,a5,be <strcmp+0x26>
    p++, q++;
  ac:	0505                	addi	a0,a0,1
  ae:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	c789                	beqz	a5,be <strcmp+0x26>
  b6:	0005c703          	lbu	a4,0(a1)
  ba:	fef709e3          	beq	a4,a5,ac <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  be:	0005c503          	lbu	a0,0(a1)
}
  c2:	40a7853b          	subw	a0,a5,a0
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <strlen>:

uint
strlen(const char *s)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	cf91                	beqz	a5,f2 <strlen+0x26>
  d8:	0505                	addi	a0,a0,1
  da:	87aa                	mv	a5,a0
  dc:	4685                	li	a3,1
  de:	9e89                	subw	a3,a3,a0
  e0:	00f6853b          	addw	a0,a3,a5
  e4:	0785                	addi	a5,a5,1
  e6:	fff7c703          	lbu	a4,-1(a5)
  ea:	fb7d                	bnez	a4,e0 <strlen+0x14>
    ;
  return n;
}
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  for(n = 0; s[n]; n++)
  f2:	4501                	li	a0,0
  f4:	bfe5                	j	ec <strlen+0x20>

00000000000000f6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  fc:	ce09                	beqz	a2,116 <memset+0x20>
  fe:	87aa                	mv	a5,a0
 100:	fff6071b          	addiw	a4,a2,-1
 104:	1702                	slli	a4,a4,0x20
 106:	9301                	srli	a4,a4,0x20
 108:	0705                	addi	a4,a4,1
 10a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 10c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 110:	0785                	addi	a5,a5,1
 112:	fee79de3          	bne	a5,a4,10c <memset+0x16>
  }
  return dst;
}
 116:	6422                	ld	s0,8(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <strchr>:

char*
strchr(const char *s, char c)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  for(; *s; s++)
 122:	00054783          	lbu	a5,0(a0)
 126:	cf91                	beqz	a5,142 <strchr+0x26>
    if(*s == c)
 128:	00f58a63          	beq	a1,a5,13c <strchr+0x20>
  for(; *s; s++)
 12c:	0505                	addi	a0,a0,1
 12e:	00054783          	lbu	a5,0(a0)
 132:	c781                	beqz	a5,13a <strchr+0x1e>
    if(*s == c)
 134:	feb79ce3          	bne	a5,a1,12c <strchr+0x10>
 138:	a011                	j	13c <strchr+0x20>
      return (char*)s;
  return 0;
 13a:	4501                	li	a0,0
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  return 0;
 142:	4501                	li	a0,0
 144:	bfe5                	j	13c <strchr+0x20>

0000000000000146 <gets>:

char*
gets(char *buf, int max)
{
 146:	711d                	addi	sp,sp,-96
 148:	ec86                	sd	ra,88(sp)
 14a:	e8a2                	sd	s0,80(sp)
 14c:	e4a6                	sd	s1,72(sp)
 14e:	e0ca                	sd	s2,64(sp)
 150:	fc4e                	sd	s3,56(sp)
 152:	f852                	sd	s4,48(sp)
 154:	f456                	sd	s5,40(sp)
 156:	f05a                	sd	s6,32(sp)
 158:	ec5e                	sd	s7,24(sp)
 15a:	1080                	addi	s0,sp,96
 15c:	8baa                	mv	s7,a0
 15e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 160:	892a                	mv	s2,a0
 162:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 164:	4aa9                	li	s5,10
 166:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 168:	0019849b          	addiw	s1,s3,1
 16c:	0344d863          	ble	s4,s1,19c <gets+0x56>
    cc = read(0, &c, 1);
 170:	4605                	li	a2,1
 172:	faf40593          	addi	a1,s0,-81
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	1fa080e7          	jalr	506(ra) # 372 <read>
    if(cc < 1)
 180:	00a05e63          	blez	a0,19c <gets+0x56>
    buf[i++] = c;
 184:	faf44783          	lbu	a5,-81(s0)
 188:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18c:	01578763          	beq	a5,s5,19a <gets+0x54>
 190:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 192:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 194:	fd679ae3          	bne	a5,s6,168 <gets+0x22>
 198:	a011                	j	19c <gets+0x56>
  for(i=0; i+1 < max; ){
 19a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19c:	99de                	add	s3,s3,s7
 19e:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a2:	855e                	mv	a0,s7
 1a4:	60e6                	ld	ra,88(sp)
 1a6:	6446                	ld	s0,80(sp)
 1a8:	64a6                	ld	s1,72(sp)
 1aa:	6906                	ld	s2,64(sp)
 1ac:	79e2                	ld	s3,56(sp)
 1ae:	7a42                	ld	s4,48(sp)
 1b0:	7aa2                	ld	s5,40(sp)
 1b2:	7b02                	ld	s6,32(sp)
 1b4:	6be2                	ld	s7,24(sp)
 1b6:	6125                	addi	sp,sp,96
 1b8:	8082                	ret

00000000000001ba <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c0:	00054683          	lbu	a3,0(a0)
 1c4:	fd06879b          	addiw	a5,a3,-48
 1c8:	0ff7f793          	andi	a5,a5,255
 1cc:	4725                	li	a4,9
 1ce:	02f76963          	bltu	a4,a5,200 <atoi+0x46>
 1d2:	862a                	mv	a2,a0
  n = 0;
 1d4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1d6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1d8:	0605                	addi	a2,a2,1
 1da:	0025179b          	slliw	a5,a0,0x2
 1de:	9fa9                	addw	a5,a5,a0
 1e0:	0017979b          	slliw	a5,a5,0x1
 1e4:	9fb5                	addw	a5,a5,a3
 1e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ea:	00064683          	lbu	a3,0(a2)
 1ee:	fd06871b          	addiw	a4,a3,-48
 1f2:	0ff77713          	andi	a4,a4,255
 1f6:	fee5f1e3          	bleu	a4,a1,1d8 <atoi+0x1e>
  return n;
}
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret
  n = 0;
 200:	4501                	li	a0,0
 202:	bfe5                	j	1fa <atoi+0x40>

0000000000000204 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 204:	1141                	addi	sp,sp,-16
 206:	e422                	sd	s0,8(sp)
 208:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 20a:	02b57663          	bleu	a1,a0,236 <memmove+0x32>
    while(n-- > 0)
 20e:	02c05163          	blez	a2,230 <memmove+0x2c>
 212:	fff6079b          	addiw	a5,a2,-1
 216:	1782                	slli	a5,a5,0x20
 218:	9381                	srli	a5,a5,0x20
 21a:	0785                	addi	a5,a5,1
 21c:	97aa                	add	a5,a5,a0
  dst = vdst;
 21e:	872a                	mv	a4,a0
      *dst++ = *src++;
 220:	0585                	addi	a1,a1,1
 222:	0705                	addi	a4,a4,1
 224:	fff5c683          	lbu	a3,-1(a1)
 228:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22c:	fee79ae3          	bne	a5,a4,220 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
    dst += n;
 236:	00c50733          	add	a4,a0,a2
    src += n;
 23a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23c:	fec05ae3          	blez	a2,230 <memmove+0x2c>
 240:	fff6079b          	addiw	a5,a2,-1
 244:	1782                	slli	a5,a5,0x20
 246:	9381                	srli	a5,a5,0x20
 248:	fff7c793          	not	a5,a5
 24c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24e:	15fd                	addi	a1,a1,-1
 250:	177d                	addi	a4,a4,-1
 252:	0005c683          	lbu	a3,0(a1)
 256:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25a:	fef71ae3          	bne	a4,a5,24e <memmove+0x4a>
 25e:	bfc9                	j	230 <memmove+0x2c>

0000000000000260 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 266:	ce15                	beqz	a2,2a2 <memcmp+0x42>
 268:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 26c:	00054783          	lbu	a5,0(a0)
 270:	0005c703          	lbu	a4,0(a1)
 274:	02e79063          	bne	a5,a4,294 <memcmp+0x34>
 278:	1682                	slli	a3,a3,0x20
 27a:	9281                	srli	a3,a3,0x20
 27c:	0685                	addi	a3,a3,1
 27e:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 280:	0505                	addi	a0,a0,1
    p2++;
 282:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 284:	00d50d63          	beq	a0,a3,29e <memcmp+0x3e>
    if (*p1 != *p2) {
 288:	00054783          	lbu	a5,0(a0)
 28c:	0005c703          	lbu	a4,0(a1)
 290:	fee788e3          	beq	a5,a4,280 <memcmp+0x20>
      return *p1 - *p2;
 294:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <memcmp+0x38>
 2a2:	4501                	li	a0,0
 2a4:	bfd5                	j	298 <memcmp+0x38>

00000000000002a6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e406                	sd	ra,8(sp)
 2aa:	e022                	sd	s0,0(sp)
 2ac:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ae:	00000097          	auipc	ra,0x0
 2b2:	f56080e7          	jalr	-170(ra) # 204 <memmove>
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <close>:

int close(int fd){
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	84aa                	mv	s1,a0
  fflush(fd);
 2ca:	00000097          	auipc	ra,0x0
 2ce:	2da080e7          	jalr	730(ra) # 5a4 <fflush>
  char* buf = get_putc_buf(fd);
 2d2:	8526                	mv	a0,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	14e080e7          	jalr	334(ra) # 422 <get_putc_buf>
  if(buf){
 2dc:	cd11                	beqz	a0,2f8 <close+0x3a>
    free(buf);
 2de:	00000097          	auipc	ra,0x0
 2e2:	548080e7          	jalr	1352(ra) # 826 <free>
    putc_buf[fd] = 0;
 2e6:	00349713          	slli	a4,s1,0x3
 2ea:	00000797          	auipc	a5,0x0
 2ee:	6ee78793          	addi	a5,a5,1774 # 9d8 <putc_buf>
 2f2:	97ba                	add	a5,a5,a4
 2f4:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2f8:	8526                	mv	a0,s1
 2fa:	00000097          	auipc	ra,0x0
 2fe:	088080e7          	jalr	136(ra) # 382 <sclose>
}
 302:	60e2                	ld	ra,24(sp)
 304:	6442                	ld	s0,16(sp)
 306:	64a2                	ld	s1,8(sp)
 308:	6105                	addi	sp,sp,32
 30a:	8082                	ret

000000000000030c <stat>:
{
 30c:	1101                	addi	sp,sp,-32
 30e:	ec06                	sd	ra,24(sp)
 310:	e822                	sd	s0,16(sp)
 312:	e426                	sd	s1,8(sp)
 314:	e04a                	sd	s2,0(sp)
 316:	1000                	addi	s0,sp,32
 318:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 31a:	4581                	li	a1,0
 31c:	00000097          	auipc	ra,0x0
 320:	07e080e7          	jalr	126(ra) # 39a <open>
  if(fd < 0)
 324:	02054563          	bltz	a0,34e <stat+0x42>
 328:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 32a:	85ca                	mv	a1,s2
 32c:	00000097          	auipc	ra,0x0
 330:	086080e7          	jalr	134(ra) # 3b2 <fstat>
 334:	892a                	mv	s2,a0
  close(fd);
 336:	8526                	mv	a0,s1
 338:	00000097          	auipc	ra,0x0
 33c:	f86080e7          	jalr	-122(ra) # 2be <close>
}
 340:	854a                	mv	a0,s2
 342:	60e2                	ld	ra,24(sp)
 344:	6442                	ld	s0,16(sp)
 346:	64a2                	ld	s1,8(sp)
 348:	6902                	ld	s2,0(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret
    return -1;
 34e:	597d                	li	s2,-1
 350:	bfc5                	j	340 <stat+0x34>

0000000000000352 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 352:	4885                	li	a7,1
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <exit>:
.global exit
exit:
 li a7, SYS_exit
 35a:	4889                	li	a7,2
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <wait>:
.global wait
wait:
 li a7, SYS_wait
 362:	488d                	li	a7,3
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36a:	4891                	li	a7,4
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <read>:
.global read
read:
 li a7, SYS_read
 372:	4895                	li	a7,5
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <write>:
.global write
write:
 li a7, SYS_write
 37a:	48c1                	li	a7,16
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 382:	48d5                	li	a7,21
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <kill>:
.global kill
kill:
 li a7, SYS_kill
 38a:	4899                	li	a7,6
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exec>:
.global exec
exec:
 li a7, SYS_exec
 392:	489d                	li	a7,7
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <open>:
.global open
open:
 li a7, SYS_open
 39a:	48bd                	li	a7,15
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a2:	48c5                	li	a7,17
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3aa:	48c9                	li	a7,18
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b2:	48a1                	li	a7,8
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <link>:
.global link
link:
 li a7, SYS_link
 3ba:	48cd                	li	a7,19
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c2:	48d1                	li	a7,20
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ca:	48a5                	li	a7,9
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d2:	48a9                	li	a7,10
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3da:	48ad                	li	a7,11
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e2:	48b1                	li	a7,12
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ea:	48b5                	li	a7,13
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f2:	48b9                	li	a7,14
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3fa:	48d9                	li	a7,22
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <nice>:
.global nice
nice:
 li a7, SYS_nice
 402:	48dd                	li	a7,23
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 40a:	48e1                	li	a7,24
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 412:	48e5                	li	a7,25
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 41a:	48e9                	li	a7,26
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 422:	1101                	addi	sp,sp,-32
 424:	ec06                	sd	ra,24(sp)
 426:	e822                	sd	s0,16(sp)
 428:	e426                	sd	s1,8(sp)
 42a:	1000                	addi	s0,sp,32
 42c:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 42e:	00351693          	slli	a3,a0,0x3
 432:	00000797          	auipc	a5,0x0
 436:	5a678793          	addi	a5,a5,1446 # 9d8 <putc_buf>
 43a:	97b6                	add	a5,a5,a3
 43c:	6388                	ld	a0,0(a5)
  if(buf) {
 43e:	c511                	beqz	a0,44a <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 440:	60e2                	ld	ra,24(sp)
 442:	6442                	ld	s0,16(sp)
 444:	64a2                	ld	s1,8(sp)
 446:	6105                	addi	sp,sp,32
 448:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 44a:	6505                	lui	a0,0x1
 44c:	00000097          	auipc	ra,0x0
 450:	464080e7          	jalr	1124(ra) # 8b0 <malloc>
  putc_buf[fd] = buf;
 454:	00000797          	auipc	a5,0x0
 458:	58478793          	addi	a5,a5,1412 # 9d8 <putc_buf>
 45c:	00349713          	slli	a4,s1,0x3
 460:	973e                	add	a4,a4,a5
 462:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 464:	00249713          	slli	a4,s1,0x2
 468:	973e                	add	a4,a4,a5
 46a:	32072023          	sw	zero,800(a4)
  return buf;
 46e:	bfc9                	j	440 <get_putc_buf+0x1e>

0000000000000470 <putc>:

static void
putc(int fd, char c)
{
 470:	1101                	addi	sp,sp,-32
 472:	ec06                	sd	ra,24(sp)
 474:	e822                	sd	s0,16(sp)
 476:	e426                	sd	s1,8(sp)
 478:	e04a                	sd	s2,0(sp)
 47a:	1000                	addi	s0,sp,32
 47c:	84aa                	mv	s1,a0
 47e:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 480:	00000097          	auipc	ra,0x0
 484:	fa2080e7          	jalr	-94(ra) # 422 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 488:	00249793          	slli	a5,s1,0x2
 48c:	00000717          	auipc	a4,0x0
 490:	54c70713          	addi	a4,a4,1356 # 9d8 <putc_buf>
 494:	973e                	add	a4,a4,a5
 496:	32072783          	lw	a5,800(a4)
 49a:	0017869b          	addiw	a3,a5,1
 49e:	32d72023          	sw	a3,800(a4)
 4a2:	97aa                	add	a5,a5,a0
 4a4:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 4a8:	47a9                	li	a5,10
 4aa:	02f90463          	beq	s2,a5,4d2 <putc+0x62>
 4ae:	00249713          	slli	a4,s1,0x2
 4b2:	00000797          	auipc	a5,0x0
 4b6:	52678793          	addi	a5,a5,1318 # 9d8 <putc_buf>
 4ba:	97ba                	add	a5,a5,a4
 4bc:	3207a703          	lw	a4,800(a5)
 4c0:	6785                	lui	a5,0x1
 4c2:	00f70863          	beq	a4,a5,4d2 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4c6:	60e2                	ld	ra,24(sp)
 4c8:	6442                	ld	s0,16(sp)
 4ca:	64a2                	ld	s1,8(sp)
 4cc:	6902                	ld	s2,0(sp)
 4ce:	6105                	addi	sp,sp,32
 4d0:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4d2:	00249793          	slli	a5,s1,0x2
 4d6:	00000917          	auipc	s2,0x0
 4da:	50290913          	addi	s2,s2,1282 # 9d8 <putc_buf>
 4de:	993e                	add	s2,s2,a5
 4e0:	32092603          	lw	a2,800(s2)
 4e4:	85aa                	mv	a1,a0
 4e6:	8526                	mv	a0,s1
 4e8:	00000097          	auipc	ra,0x0
 4ec:	e92080e7          	jalr	-366(ra) # 37a <write>
    putc_index[fd] = 0;
 4f0:	32092023          	sw	zero,800(s2)
}
 4f4:	bfc9                	j	4c6 <putc+0x56>

00000000000004f6 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f6:	7139                	addi	sp,sp,-64
 4f8:	fc06                	sd	ra,56(sp)
 4fa:	f822                	sd	s0,48(sp)
 4fc:	f426                	sd	s1,40(sp)
 4fe:	f04a                	sd	s2,32(sp)
 500:	ec4e                	sd	s3,24(sp)
 502:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 504:	c299                	beqz	a3,50a <printint+0x14>
 506:	0005cd63          	bltz	a1,520 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 50a:	2581                	sext.w	a1,a1
  neg = 0;
 50c:	4301                	li	t1,0
 50e:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 512:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 514:	2601                	sext.w	a2,a2
 516:	00000897          	auipc	a7,0x0
 51a:	49a88893          	addi	a7,a7,1178 # 9b0 <digits>
 51e:	a801                	j	52e <printint+0x38>
    x = -xx;
 520:	40b005bb          	negw	a1,a1
 524:	2581                	sext.w	a1,a1
    neg = 1;
 526:	4305                	li	t1,1
    x = -xx;
 528:	b7dd                	j	50e <printint+0x18>
  }while((x /= base) != 0);
 52a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 52c:	8836                	mv	a6,a3
 52e:	0018069b          	addiw	a3,a6,1
 532:	02c5f7bb          	remuw	a5,a1,a2
 536:	1782                	slli	a5,a5,0x20
 538:	9381                	srli	a5,a5,0x20
 53a:	97c6                	add	a5,a5,a7
 53c:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x168>
 540:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 544:	0705                	addi	a4,a4,1
 546:	02c5d7bb          	divuw	a5,a1,a2
 54a:	fec5f0e3          	bleu	a2,a1,52a <printint+0x34>
  if(neg)
 54e:	00030b63          	beqz	t1,564 <printint+0x6e>
    buf[i++] = '-';
 552:	fd040793          	addi	a5,s0,-48
 556:	96be                	add	a3,a3,a5
 558:	02d00793          	li	a5,45
 55c:	fef68823          	sb	a5,-16(a3)
 560:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 564:	02d05963          	blez	a3,596 <printint+0xa0>
 568:	89aa                	mv	s3,a0
 56a:	fc040793          	addi	a5,s0,-64
 56e:	00d784b3          	add	s1,a5,a3
 572:	fff78913          	addi	s2,a5,-1
 576:	9936                	add	s2,s2,a3
 578:	36fd                	addiw	a3,a3,-1
 57a:	1682                	slli	a3,a3,0x20
 57c:	9281                	srli	a3,a3,0x20
 57e:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 582:	fff4c583          	lbu	a1,-1(s1)
 586:	854e                	mv	a0,s3
 588:	00000097          	auipc	ra,0x0
 58c:	ee8080e7          	jalr	-280(ra) # 470 <putc>
  while(--i >= 0)
 590:	14fd                	addi	s1,s1,-1
 592:	ff2498e3          	bne	s1,s2,582 <printint+0x8c>
}
 596:	70e2                	ld	ra,56(sp)
 598:	7442                	ld	s0,48(sp)
 59a:	74a2                	ld	s1,40(sp)
 59c:	7902                	ld	s2,32(sp)
 59e:	69e2                	ld	s3,24(sp)
 5a0:	6121                	addi	sp,sp,64
 5a2:	8082                	ret

00000000000005a4 <fflush>:
void fflush(int fd){
 5a4:	1101                	addi	sp,sp,-32
 5a6:	ec06                	sd	ra,24(sp)
 5a8:	e822                	sd	s0,16(sp)
 5aa:	e426                	sd	s1,8(sp)
 5ac:	e04a                	sd	s2,0(sp)
 5ae:	1000                	addi	s0,sp,32
 5b0:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e70080e7          	jalr	-400(ra) # 422 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5ba:	00291793          	slli	a5,s2,0x2
 5be:	00000497          	auipc	s1,0x0
 5c2:	41a48493          	addi	s1,s1,1050 # 9d8 <putc_buf>
 5c6:	94be                	add	s1,s1,a5
 5c8:	3204a603          	lw	a2,800(s1)
 5cc:	85aa                	mv	a1,a0
 5ce:	854a                	mv	a0,s2
 5d0:	00000097          	auipc	ra,0x0
 5d4:	daa080e7          	jalr	-598(ra) # 37a <write>
  putc_index[fd] = 0;
 5d8:	3204a023          	sw	zero,800(s1)
}
 5dc:	60e2                	ld	ra,24(sp)
 5de:	6442                	ld	s0,16(sp)
 5e0:	64a2                	ld	s1,8(sp)
 5e2:	6902                	ld	s2,0(sp)
 5e4:	6105                	addi	sp,sp,32
 5e6:	8082                	ret

00000000000005e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e8:	7119                	addi	sp,sp,-128
 5ea:	fc86                	sd	ra,120(sp)
 5ec:	f8a2                	sd	s0,112(sp)
 5ee:	f4a6                	sd	s1,104(sp)
 5f0:	f0ca                	sd	s2,96(sp)
 5f2:	ecce                	sd	s3,88(sp)
 5f4:	e8d2                	sd	s4,80(sp)
 5f6:	e4d6                	sd	s5,72(sp)
 5f8:	e0da                	sd	s6,64(sp)
 5fa:	fc5e                	sd	s7,56(sp)
 5fc:	f862                	sd	s8,48(sp)
 5fe:	f466                	sd	s9,40(sp)
 600:	f06a                	sd	s10,32(sp)
 602:	ec6e                	sd	s11,24(sp)
 604:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 606:	0005c483          	lbu	s1,0(a1)
 60a:	18048d63          	beqz	s1,7a4 <vprintf+0x1bc>
 60e:	8aaa                	mv	s5,a0
 610:	8b32                	mv	s6,a2
 612:	00158913          	addi	s2,a1,1
  state = 0;
 616:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 618:	02500a13          	li	s4,37
      if(c == 'd'){
 61c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 620:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 624:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 628:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 62c:	00000b97          	auipc	s7,0x0
 630:	384b8b93          	addi	s7,s7,900 # 9b0 <digits>
 634:	a839                	j	652 <vprintf+0x6a>
        putc(fd, c);
 636:	85a6                	mv	a1,s1
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	e36080e7          	jalr	-458(ra) # 470 <putc>
 642:	a019                	j	648 <vprintf+0x60>
    } else if(state == '%'){
 644:	01498f63          	beq	s3,s4,662 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 648:	0905                	addi	s2,s2,1
 64a:	fff94483          	lbu	s1,-1(s2)
 64e:	14048b63          	beqz	s1,7a4 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 652:	0004879b          	sext.w	a5,s1
    if(state == 0){
 656:	fe0997e3          	bnez	s3,644 <vprintf+0x5c>
      if(c == '%'){
 65a:	fd479ee3          	bne	a5,s4,636 <vprintf+0x4e>
        state = '%';
 65e:	89be                	mv	s3,a5
 660:	b7e5                	j	648 <vprintf+0x60>
      if(c == 'd'){
 662:	05878063          	beq	a5,s8,6a2 <vprintf+0xba>
      } else if(c == 'l') {
 666:	05978c63          	beq	a5,s9,6be <vprintf+0xd6>
      } else if(c == 'x') {
 66a:	07a78863          	beq	a5,s10,6da <vprintf+0xf2>
      } else if(c == 'p') {
 66e:	09b78463          	beq	a5,s11,6f6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 672:	07300713          	li	a4,115
 676:	0ce78563          	beq	a5,a4,740 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 67a:	06300713          	li	a4,99
 67e:	0ee78c63          	beq	a5,a4,776 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 682:	11478663          	beq	a5,s4,78e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 686:	85d2                	mv	a1,s4
 688:	8556                	mv	a0,s5
 68a:	00000097          	auipc	ra,0x0
 68e:	de6080e7          	jalr	-538(ra) # 470 <putc>
        putc(fd, c);
 692:	85a6                	mv	a1,s1
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	dda080e7          	jalr	-550(ra) # 470 <putc>
      }
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b765                	j	648 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6a2:	008b0493          	addi	s1,s6,8
 6a6:	4685                	li	a3,1
 6a8:	4629                	li	a2,10
 6aa:	000b2583          	lw	a1,0(s6)
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e46080e7          	jalr	-442(ra) # 4f6 <printint>
 6b8:	8b26                	mv	s6,s1
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b771                	j	648 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6be:	008b0493          	addi	s1,s6,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000b2583          	lw	a1,0(s6)
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e2a080e7          	jalr	-470(ra) # 4f6 <printint>
 6d4:	8b26                	mv	s6,s1
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	bf85                	j	648 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6da:	008b0493          	addi	s1,s6,8
 6de:	4681                	li	a3,0
 6e0:	4641                	li	a2,16
 6e2:	000b2583          	lw	a1,0(s6)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e0e080e7          	jalr	-498(ra) # 4f6 <printint>
 6f0:	8b26                	mv	s6,s1
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	bf91                	j	648 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6f6:	008b0793          	addi	a5,s6,8
 6fa:	f8f43423          	sd	a5,-120(s0)
 6fe:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 702:	03000593          	li	a1,48
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	d68080e7          	jalr	-664(ra) # 470 <putc>
  putc(fd, 'x');
 710:	85ea                	mv	a1,s10
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	d5c080e7          	jalr	-676(ra) # 470 <putc>
 71c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71e:	03c9d793          	srli	a5,s3,0x3c
 722:	97de                	add	a5,a5,s7
 724:	0007c583          	lbu	a1,0(a5)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	d46080e7          	jalr	-698(ra) # 470 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 732:	0992                	slli	s3,s3,0x4
 734:	34fd                	addiw	s1,s1,-1
 736:	f4e5                	bnez	s1,71e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 738:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 73c:	4981                	li	s3,0
 73e:	b729                	j	648 <vprintf+0x60>
        s = va_arg(ap, char*);
 740:	008b0993          	addi	s3,s6,8
 744:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 748:	c085                	beqz	s1,768 <vprintf+0x180>
        while(*s != 0){
 74a:	0004c583          	lbu	a1,0(s1)
 74e:	c9a1                	beqz	a1,79e <vprintf+0x1b6>
          putc(fd, *s);
 750:	8556                	mv	a0,s5
 752:	00000097          	auipc	ra,0x0
 756:	d1e080e7          	jalr	-738(ra) # 470 <putc>
          s++;
 75a:	0485                	addi	s1,s1,1
        while(*s != 0){
 75c:	0004c583          	lbu	a1,0(s1)
 760:	f9e5                	bnez	a1,750 <vprintf+0x168>
        s = va_arg(ap, char*);
 762:	8b4e                	mv	s6,s3
      state = 0;
 764:	4981                	li	s3,0
 766:	b5cd                	j	648 <vprintf+0x60>
          s = "(null)";
 768:	00000497          	auipc	s1,0x0
 76c:	26048493          	addi	s1,s1,608 # 9c8 <digits+0x18>
        while(*s != 0){
 770:	02800593          	li	a1,40
 774:	bff1                	j	750 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 776:	008b0493          	addi	s1,s6,8
 77a:	000b4583          	lbu	a1,0(s6)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	cf0080e7          	jalr	-784(ra) # 470 <putc>
 788:	8b26                	mv	s6,s1
      state = 0;
 78a:	4981                	li	s3,0
 78c:	bd75                	j	648 <vprintf+0x60>
        putc(fd, c);
 78e:	85d2                	mv	a1,s4
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	cde080e7          	jalr	-802(ra) # 470 <putc>
      state = 0;
 79a:	4981                	li	s3,0
 79c:	b575                	j	648 <vprintf+0x60>
        s = va_arg(ap, char*);
 79e:	8b4e                	mv	s6,s3
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b55d                	j	648 <vprintf+0x60>
    }
  }
}
 7a4:	70e6                	ld	ra,120(sp)
 7a6:	7446                	ld	s0,112(sp)
 7a8:	74a6                	ld	s1,104(sp)
 7aa:	7906                	ld	s2,96(sp)
 7ac:	69e6                	ld	s3,88(sp)
 7ae:	6a46                	ld	s4,80(sp)
 7b0:	6aa6                	ld	s5,72(sp)
 7b2:	6b06                	ld	s6,64(sp)
 7b4:	7be2                	ld	s7,56(sp)
 7b6:	7c42                	ld	s8,48(sp)
 7b8:	7ca2                	ld	s9,40(sp)
 7ba:	7d02                	ld	s10,32(sp)
 7bc:	6de2                	ld	s11,24(sp)
 7be:	6109                	addi	sp,sp,128
 7c0:	8082                	ret

00000000000007c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7c2:	715d                	addi	sp,sp,-80
 7c4:	ec06                	sd	ra,24(sp)
 7c6:	e822                	sd	s0,16(sp)
 7c8:	1000                	addi	s0,sp,32
 7ca:	e010                	sd	a2,0(s0)
 7cc:	e414                	sd	a3,8(s0)
 7ce:	e818                	sd	a4,16(s0)
 7d0:	ec1c                	sd	a5,24(s0)
 7d2:	03043023          	sd	a6,32(s0)
 7d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7de:	8622                	mv	a2,s0
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e08080e7          	jalr	-504(ra) # 5e8 <vprintf>
}
 7e8:	60e2                	ld	ra,24(sp)
 7ea:	6442                	ld	s0,16(sp)
 7ec:	6161                	addi	sp,sp,80
 7ee:	8082                	ret

00000000000007f0 <printf>:

void
printf(const char *fmt, ...)
{
 7f0:	711d                	addi	sp,sp,-96
 7f2:	ec06                	sd	ra,24(sp)
 7f4:	e822                	sd	s0,16(sp)
 7f6:	1000                	addi	s0,sp,32
 7f8:	e40c                	sd	a1,8(s0)
 7fa:	e810                	sd	a2,16(s0)
 7fc:	ec14                	sd	a3,24(s0)
 7fe:	f018                	sd	a4,32(s0)
 800:	f41c                	sd	a5,40(s0)
 802:	03043823          	sd	a6,48(s0)
 806:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 80a:	00840613          	addi	a2,s0,8
 80e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 812:	85aa                	mv	a1,a0
 814:	4505                	li	a0,1
 816:	00000097          	auipc	ra,0x0
 81a:	dd2080e7          	jalr	-558(ra) # 5e8 <vprintf>
}
 81e:	60e2                	ld	ra,24(sp)
 820:	6442                	ld	s0,16(sp)
 822:	6125                	addi	sp,sp,96
 824:	8082                	ret

0000000000000826 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 826:	1141                	addi	sp,sp,-16
 828:	e422                	sd	s0,8(sp)
 82a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 82c:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x158>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 830:	00000797          	auipc	a5,0x0
 834:	1a078793          	addi	a5,a5,416 # 9d0 <__bss_start>
 838:	639c                	ld	a5,0(a5)
 83a:	a805                	j	86a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 83c:	4618                	lw	a4,8(a2)
 83e:	9db9                	addw	a1,a1,a4
 840:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 844:	6398                	ld	a4,0(a5)
 846:	6318                	ld	a4,0(a4)
 848:	fee53823          	sd	a4,-16(a0)
 84c:	a091                	j	890 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84e:	ff852703          	lw	a4,-8(a0)
 852:	9e39                	addw	a2,a2,a4
 854:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 856:	ff053703          	ld	a4,-16(a0)
 85a:	e398                	sd	a4,0(a5)
 85c:	a099                	j	8a2 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85e:	6398                	ld	a4,0(a5)
 860:	00e7e463          	bltu	a5,a4,868 <free+0x42>
 864:	00e6ea63          	bltu	a3,a4,878 <free+0x52>
{
 868:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86a:	fed7fae3          	bleu	a3,a5,85e <free+0x38>
 86e:	6398                	ld	a4,0(a5)
 870:	00e6e463          	bltu	a3,a4,878 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 874:	fee7eae3          	bltu	a5,a4,868 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 878:	ff852583          	lw	a1,-8(a0)
 87c:	6390                	ld	a2,0(a5)
 87e:	02059713          	slli	a4,a1,0x20
 882:	9301                	srli	a4,a4,0x20
 884:	0712                	slli	a4,a4,0x4
 886:	9736                	add	a4,a4,a3
 888:	fae60ae3          	beq	a2,a4,83c <free+0x16>
    bp->s.ptr = p->s.ptr;
 88c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 890:	4790                	lw	a2,8(a5)
 892:	02061713          	slli	a4,a2,0x20
 896:	9301                	srli	a4,a4,0x20
 898:	0712                	slli	a4,a4,0x4
 89a:	973e                	add	a4,a4,a5
 89c:	fae689e3          	beq	a3,a4,84e <free+0x28>
  } else
    p->s.ptr = bp;
 8a0:	e394                	sd	a3,0(a5)
  freep = p;
 8a2:	00000717          	auipc	a4,0x0
 8a6:	12f73723          	sd	a5,302(a4) # 9d0 <__bss_start>
}
 8aa:	6422                	ld	s0,8(sp)
 8ac:	0141                	addi	sp,sp,16
 8ae:	8082                	ret

00000000000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	7139                	addi	sp,sp,-64
 8b2:	fc06                	sd	ra,56(sp)
 8b4:	f822                	sd	s0,48(sp)
 8b6:	f426                	sd	s1,40(sp)
 8b8:	f04a                	sd	s2,32(sp)
 8ba:	ec4e                	sd	s3,24(sp)
 8bc:	e852                	sd	s4,16(sp)
 8be:	e456                	sd	s5,8(sp)
 8c0:	e05a                	sd	s6,0(sp)
 8c2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c4:	02051993          	slli	s3,a0,0x20
 8c8:	0209d993          	srli	s3,s3,0x20
 8cc:	09bd                	addi	s3,s3,15
 8ce:	0049d993          	srli	s3,s3,0x4
 8d2:	2985                	addiw	s3,s3,1
 8d4:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8d8:	00000797          	auipc	a5,0x0
 8dc:	0f878793          	addi	a5,a5,248 # 9d0 <__bss_start>
 8e0:	6388                	ld	a0,0(a5)
 8e2:	c515                	beqz	a0,90e <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e6:	4798                	lw	a4,8(a5)
 8e8:	03277f63          	bleu	s2,a4,926 <malloc+0x76>
 8ec:	8a4e                	mv	s4,s3
 8ee:	0009871b          	sext.w	a4,s3
 8f2:	6685                	lui	a3,0x1
 8f4:	00d77363          	bleu	a3,a4,8fa <malloc+0x4a>
 8f8:	6a05                	lui	s4,0x1
 8fa:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8fe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 902:	00000497          	auipc	s1,0x0
 906:	0ce48493          	addi	s1,s1,206 # 9d0 <__bss_start>
  if(p == (char*)-1)
 90a:	5b7d                	li	s6,-1
 90c:	a885                	j	97c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 90e:	00000797          	auipc	a5,0x0
 912:	57a78793          	addi	a5,a5,1402 # e88 <base>
 916:	00000717          	auipc	a4,0x0
 91a:	0af73d23          	sd	a5,186(a4) # 9d0 <__bss_start>
 91e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 920:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 924:	b7e1                	j	8ec <malloc+0x3c>
      if(p->s.size == nunits)
 926:	02e90b63          	beq	s2,a4,95c <malloc+0xac>
        p->s.size -= nunits;
 92a:	4137073b          	subw	a4,a4,s3
 92e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 930:	1702                	slli	a4,a4,0x20
 932:	9301                	srli	a4,a4,0x20
 934:	0712                	slli	a4,a4,0x4
 936:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 938:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 93c:	00000717          	auipc	a4,0x0
 940:	08a73a23          	sd	a0,148(a4) # 9d0 <__bss_start>
      return (void*)(p + 1);
 944:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 948:	70e2                	ld	ra,56(sp)
 94a:	7442                	ld	s0,48(sp)
 94c:	74a2                	ld	s1,40(sp)
 94e:	7902                	ld	s2,32(sp)
 950:	69e2                	ld	s3,24(sp)
 952:	6a42                	ld	s4,16(sp)
 954:	6aa2                	ld	s5,8(sp)
 956:	6b02                	ld	s6,0(sp)
 958:	6121                	addi	sp,sp,64
 95a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 95c:	6398                	ld	a4,0(a5)
 95e:	e118                	sd	a4,0(a0)
 960:	bff1                	j	93c <malloc+0x8c>
  hp->s.size = nu;
 962:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 966:	0541                	addi	a0,a0,16
 968:	00000097          	auipc	ra,0x0
 96c:	ebe080e7          	jalr	-322(ra) # 826 <free>
  return freep;
 970:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 972:	d979                	beqz	a0,948 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 974:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 976:	4798                	lw	a4,8(a5)
 978:	fb2777e3          	bleu	s2,a4,926 <malloc+0x76>
    if(p == freep)
 97c:	6098                	ld	a4,0(s1)
 97e:	853e                	mv	a0,a5
 980:	fef71ae3          	bne	a4,a5,974 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 984:	8552                	mv	a0,s4
 986:	00000097          	auipc	ra,0x0
 98a:	a5c080e7          	jalr	-1444(ra) # 3e2 <sbrk>
  if(p == (char*)-1)
 98e:	fd651ae3          	bne	a0,s6,962 <malloc+0xb2>
        return 0;
 992:	4501                	li	a0,0
 994:	bf55                	j	948 <malloc+0x98>
