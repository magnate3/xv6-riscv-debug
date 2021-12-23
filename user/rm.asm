
user/_rm:     file format elf64-littleriscv


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
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d763          	ble	a0,a5,3e <main+0x3e>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	1902                	slli	s2,s2,0x20
  1e:	02095913          	srli	s2,s2,0x20
  22:	090e                	slli	s2,s2,0x3
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  28:	6088                	ld	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	37c080e7          	jalr	892(ra) # 3a6 <unlink>
  32:	02054463          	bltz	a0,5a <main+0x5a>
  for(i = 1; i < argc; i++){
  36:	04a1                	addi	s1,s1,8
  38:	ff2498e3          	bne	s1,s2,28 <main+0x28>
  3c:	a80d                	j	6e <main+0x6e>
    fprintf(2, "Usage: rm files...\n");
  3e:	00001597          	auipc	a1,0x1
  42:	95a58593          	addi	a1,a1,-1702 # 998 <malloc+0xec>
  46:	4509                	li	a0,2
  48:	00000097          	auipc	ra,0x0
  4c:	776080e7          	jalr	1910(ra) # 7be <fprintf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	304080e7          	jalr	772(ra) # 356 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	6090                	ld	a2,0(s1)
  5c:	00001597          	auipc	a1,0x1
  60:	95458593          	addi	a1,a1,-1708 # 9b0 <malloc+0x104>
  64:	4509                	li	a0,2
  66:	00000097          	auipc	ra,0x0
  6a:	758080e7          	jalr	1880(ra) # 7be <fprintf>
      break;
    }
  }

  exit(0);
  6e:	4501                	li	a0,0
  70:	00000097          	auipc	ra,0x0
  74:	2e6080e7          	jalr	742(ra) # 356 <exit>

0000000000000078 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7e:	87aa                	mv	a5,a0
  80:	0585                	addi	a1,a1,1
  82:	0785                	addi	a5,a5,1
  84:	fff5c703          	lbu	a4,-1(a1)
  88:	fee78fa3          	sb	a4,-1(a5)
  8c:	fb75                	bnez	a4,80 <strcpy+0x8>
    ;
  return os;
}
  8e:	6422                	ld	s0,8(sp)
  90:	0141                	addi	sp,sp,16
  92:	8082                	ret

0000000000000094 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  94:	1141                	addi	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	cf91                	beqz	a5,ba <strcmp+0x26>
  a0:	0005c703          	lbu	a4,0(a1)
  a4:	00f71b63          	bne	a4,a5,ba <strcmp+0x26>
    p++, q++;
  a8:	0505                	addi	a0,a0,1
  aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	c789                	beqz	a5,ba <strcmp+0x26>
  b2:	0005c703          	lbu	a4,0(a1)
  b6:	fef709e3          	beq	a4,a5,a8 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ba:	0005c503          	lbu	a0,0(a1)
}
  be:	40a7853b          	subw	a0,a5,a0
  c2:	6422                	ld	s0,8(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e422                	sd	s0,8(sp)
  cc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ce:	00054783          	lbu	a5,0(a0)
  d2:	cf91                	beqz	a5,ee <strlen+0x26>
  d4:	0505                	addi	a0,a0,1
  d6:	87aa                	mv	a5,a0
  d8:	4685                	li	a3,1
  da:	9e89                	subw	a3,a3,a0
  dc:	00f6853b          	addw	a0,a3,a5
  e0:	0785                	addi	a5,a5,1
  e2:	fff7c703          	lbu	a4,-1(a5)
  e6:	fb7d                	bnez	a4,dc <strlen+0x14>
    ;
  return n;
}
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret
  for(n = 0; s[n]; n++)
  ee:	4501                	li	a0,0
  f0:	bfe5                	j	e8 <strlen+0x20>

00000000000000f2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f8:	ce09                	beqz	a2,112 <memset+0x20>
  fa:	87aa                	mv	a5,a0
  fc:	fff6071b          	addiw	a4,a2,-1
 100:	1702                	slli	a4,a4,0x20
 102:	9301                	srli	a4,a4,0x20
 104:	0705                	addi	a4,a4,1
 106:	972a                	add	a4,a4,a0
    cdst[i] = c;
 108:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 10c:	0785                	addi	a5,a5,1
 10e:	fee79de3          	bne	a5,a4,108 <memset+0x16>
  }
  return dst;
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret

0000000000000118 <strchr>:

char*
strchr(const char *s, char c)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 11e:	00054783          	lbu	a5,0(a0)
 122:	cf91                	beqz	a5,13e <strchr+0x26>
    if(*s == c)
 124:	00f58a63          	beq	a1,a5,138 <strchr+0x20>
  for(; *s; s++)
 128:	0505                	addi	a0,a0,1
 12a:	00054783          	lbu	a5,0(a0)
 12e:	c781                	beqz	a5,136 <strchr+0x1e>
    if(*s == c)
 130:	feb79ce3          	bne	a5,a1,128 <strchr+0x10>
 134:	a011                	j	138 <strchr+0x20>
      return (char*)s;
  return 0;
 136:	4501                	li	a0,0
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret
  return 0;
 13e:	4501                	li	a0,0
 140:	bfe5                	j	138 <strchr+0x20>

0000000000000142 <gets>:

char*
gets(char *buf, int max)
{
 142:	711d                	addi	sp,sp,-96
 144:	ec86                	sd	ra,88(sp)
 146:	e8a2                	sd	s0,80(sp)
 148:	e4a6                	sd	s1,72(sp)
 14a:	e0ca                	sd	s2,64(sp)
 14c:	fc4e                	sd	s3,56(sp)
 14e:	f852                	sd	s4,48(sp)
 150:	f456                	sd	s5,40(sp)
 152:	f05a                	sd	s6,32(sp)
 154:	ec5e                	sd	s7,24(sp)
 156:	1080                	addi	s0,sp,96
 158:	8baa                	mv	s7,a0
 15a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15c:	892a                	mv	s2,a0
 15e:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 160:	4aa9                	li	s5,10
 162:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 164:	0019849b          	addiw	s1,s3,1
 168:	0344d863          	ble	s4,s1,198 <gets+0x56>
    cc = read(0, &c, 1);
 16c:	4605                	li	a2,1
 16e:	faf40593          	addi	a1,s0,-81
 172:	4501                	li	a0,0
 174:	00000097          	auipc	ra,0x0
 178:	1fa080e7          	jalr	506(ra) # 36e <read>
    if(cc < 1)
 17c:	00a05e63          	blez	a0,198 <gets+0x56>
    buf[i++] = c;
 180:	faf44783          	lbu	a5,-81(s0)
 184:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 188:	01578763          	beq	a5,s5,196 <gets+0x54>
 18c:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 18e:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 190:	fd679ae3          	bne	a5,s6,164 <gets+0x22>
 194:	a011                	j	198 <gets+0x56>
  for(i=0; i+1 < max; ){
 196:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 198:	99de                	add	s3,s3,s7
 19a:	00098023          	sb	zero,0(s3)
  return buf;
}
 19e:	855e                	mv	a0,s7
 1a0:	60e6                	ld	ra,88(sp)
 1a2:	6446                	ld	s0,80(sp)
 1a4:	64a6                	ld	s1,72(sp)
 1a6:	6906                	ld	s2,64(sp)
 1a8:	79e2                	ld	s3,56(sp)
 1aa:	7a42                	ld	s4,48(sp)
 1ac:	7aa2                	ld	s5,40(sp)
 1ae:	7b02                	ld	s6,32(sp)
 1b0:	6be2                	ld	s7,24(sp)
 1b2:	6125                	addi	sp,sp,96
 1b4:	8082                	ret

00000000000001b6 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bc:	00054683          	lbu	a3,0(a0)
 1c0:	fd06879b          	addiw	a5,a3,-48
 1c4:	0ff7f793          	andi	a5,a5,255
 1c8:	4725                	li	a4,9
 1ca:	02f76963          	bltu	a4,a5,1fc <atoi+0x46>
 1ce:	862a                	mv	a2,a0
  n = 0;
 1d0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1d2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1d4:	0605                	addi	a2,a2,1
 1d6:	0025179b          	slliw	a5,a0,0x2
 1da:	9fa9                	addw	a5,a5,a0
 1dc:	0017979b          	slliw	a5,a5,0x1
 1e0:	9fb5                	addw	a5,a5,a3
 1e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e6:	00064683          	lbu	a3,0(a2)
 1ea:	fd06871b          	addiw	a4,a3,-48
 1ee:	0ff77713          	andi	a4,a4,255
 1f2:	fee5f1e3          	bleu	a4,a1,1d4 <atoi+0x1e>
  return n;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
  n = 0;
 1fc:	4501                	li	a0,0
 1fe:	bfe5                	j	1f6 <atoi+0x40>

0000000000000200 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 206:	02b57663          	bleu	a1,a0,232 <memmove+0x32>
    while(n-- > 0)
 20a:	02c05163          	blez	a2,22c <memmove+0x2c>
 20e:	fff6079b          	addiw	a5,a2,-1
 212:	1782                	slli	a5,a5,0x20
 214:	9381                	srli	a5,a5,0x20
 216:	0785                	addi	a5,a5,1
 218:	97aa                	add	a5,a5,a0
  dst = vdst;
 21a:	872a                	mv	a4,a0
      *dst++ = *src++;
 21c:	0585                	addi	a1,a1,1
 21e:	0705                	addi	a4,a4,1
 220:	fff5c683          	lbu	a3,-1(a1)
 224:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 228:	fee79ae3          	bne	a5,a4,21c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
    dst += n;
 232:	00c50733          	add	a4,a0,a2
    src += n;
 236:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 238:	fec05ae3          	blez	a2,22c <memmove+0x2c>
 23c:	fff6079b          	addiw	a5,a2,-1
 240:	1782                	slli	a5,a5,0x20
 242:	9381                	srli	a5,a5,0x20
 244:	fff7c793          	not	a5,a5
 248:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24a:	15fd                	addi	a1,a1,-1
 24c:	177d                	addi	a4,a4,-1
 24e:	0005c683          	lbu	a3,0(a1)
 252:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 256:	fef71ae3          	bne	a4,a5,24a <memmove+0x4a>
 25a:	bfc9                	j	22c <memmove+0x2c>

000000000000025c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 262:	ce15                	beqz	a2,29e <memcmp+0x42>
 264:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 268:	00054783          	lbu	a5,0(a0)
 26c:	0005c703          	lbu	a4,0(a1)
 270:	02e79063          	bne	a5,a4,290 <memcmp+0x34>
 274:	1682                	slli	a3,a3,0x20
 276:	9281                	srli	a3,a3,0x20
 278:	0685                	addi	a3,a3,1
 27a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 27c:	0505                	addi	a0,a0,1
    p2++;
 27e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 280:	00d50d63          	beq	a0,a3,29a <memcmp+0x3e>
    if (*p1 != *p2) {
 284:	00054783          	lbu	a5,0(a0)
 288:	0005c703          	lbu	a4,0(a1)
 28c:	fee788e3          	beq	a5,a4,27c <memcmp+0x20>
      return *p1 - *p2;
 290:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 294:	6422                	ld	s0,8(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret
  return 0;
 29a:	4501                	li	a0,0
 29c:	bfe5                	j	294 <memcmp+0x38>
 29e:	4501                	li	a0,0
 2a0:	bfd5                	j	294 <memcmp+0x38>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2aa:	00000097          	auipc	ra,0x0
 2ae:	f56080e7          	jalr	-170(ra) # 200 <memmove>
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <close>:

int close(int fd){
 2ba:	1101                	addi	sp,sp,-32
 2bc:	ec06                	sd	ra,24(sp)
 2be:	e822                	sd	s0,16(sp)
 2c0:	e426                	sd	s1,8(sp)
 2c2:	1000                	addi	s0,sp,32
 2c4:	84aa                	mv	s1,a0
  fflush(fd);
 2c6:	00000097          	auipc	ra,0x0
 2ca:	2da080e7          	jalr	730(ra) # 5a0 <fflush>
  char* buf = get_putc_buf(fd);
 2ce:	8526                	mv	a0,s1
 2d0:	00000097          	auipc	ra,0x0
 2d4:	14e080e7          	jalr	334(ra) # 41e <get_putc_buf>
  if(buf){
 2d8:	cd11                	beqz	a0,2f4 <close+0x3a>
    free(buf);
 2da:	00000097          	auipc	ra,0x0
 2de:	548080e7          	jalr	1352(ra) # 822 <free>
    putc_buf[fd] = 0;
 2e2:	00349713          	slli	a4,s1,0x3
 2e6:	00000797          	auipc	a5,0x0
 2ea:	71278793          	addi	a5,a5,1810 # 9f8 <putc_buf>
 2ee:	97ba                	add	a5,a5,a4
 2f0:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 2f4:	8526                	mv	a0,s1
 2f6:	00000097          	auipc	ra,0x0
 2fa:	088080e7          	jalr	136(ra) # 37e <sclose>
}
 2fe:	60e2                	ld	ra,24(sp)
 300:	6442                	ld	s0,16(sp)
 302:	64a2                	ld	s1,8(sp)
 304:	6105                	addi	sp,sp,32
 306:	8082                	ret

0000000000000308 <stat>:
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	e426                	sd	s1,8(sp)
 310:	e04a                	sd	s2,0(sp)
 312:	1000                	addi	s0,sp,32
 314:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 316:	4581                	li	a1,0
 318:	00000097          	auipc	ra,0x0
 31c:	07e080e7          	jalr	126(ra) # 396 <open>
  if(fd < 0)
 320:	02054563          	bltz	a0,34a <stat+0x42>
 324:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 326:	85ca                	mv	a1,s2
 328:	00000097          	auipc	ra,0x0
 32c:	086080e7          	jalr	134(ra) # 3ae <fstat>
 330:	892a                	mv	s2,a0
  close(fd);
 332:	8526                	mv	a0,s1
 334:	00000097          	auipc	ra,0x0
 338:	f86080e7          	jalr	-122(ra) # 2ba <close>
}
 33c:	854a                	mv	a0,s2
 33e:	60e2                	ld	ra,24(sp)
 340:	6442                	ld	s0,16(sp)
 342:	64a2                	ld	s1,8(sp)
 344:	6902                	ld	s2,0(sp)
 346:	6105                	addi	sp,sp,32
 348:	8082                	ret
    return -1;
 34a:	597d                	li	s2,-1
 34c:	bfc5                	j	33c <stat+0x34>

000000000000034e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 34e:	4885                	li	a7,1
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exit>:
.global exit
exit:
 li a7, SYS_exit
 356:	4889                	li	a7,2
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <wait>:
.global wait
wait:
 li a7, SYS_wait
 35e:	488d                	li	a7,3
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 366:	4891                	li	a7,4
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <read>:
.global read
read:
 li a7, SYS_read
 36e:	4895                	li	a7,5
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <write>:
.global write
write:
 li a7, SYS_write
 376:	48c1                	li	a7,16
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 37e:	48d5                	li	a7,21
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <kill>:
.global kill
kill:
 li a7, SYS_kill
 386:	4899                	li	a7,6
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exec>:
.global exec
exec:
 li a7, SYS_exec
 38e:	489d                	li	a7,7
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <open>:
.global open
open:
 li a7, SYS_open
 396:	48bd                	li	a7,15
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 39e:	48c5                	li	a7,17
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a6:	48c9                	li	a7,18
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ae:	48a1                	li	a7,8
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <link>:
.global link
link:
 li a7, SYS_link
 3b6:	48cd                	li	a7,19
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3be:	48d1                	li	a7,20
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c6:	48a5                	li	a7,9
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ce:	48a9                	li	a7,10
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d6:	48ad                	li	a7,11
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3de:	48b1                	li	a7,12
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e6:	48b5                	li	a7,13
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ee:	48b9                	li	a7,14
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 3f6:	48d9                	li	a7,22
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <nice>:
.global nice
nice:
 li a7, SYS_nice
 3fe:	48dd                	li	a7,23
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 406:	48e1                	li	a7,24
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 40e:	48e5                	li	a7,25
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 416:	48e9                	li	a7,26
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 41e:	1101                	addi	sp,sp,-32
 420:	ec06                	sd	ra,24(sp)
 422:	e822                	sd	s0,16(sp)
 424:	e426                	sd	s1,8(sp)
 426:	1000                	addi	s0,sp,32
 428:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 42a:	00351693          	slli	a3,a0,0x3
 42e:	00000797          	auipc	a5,0x0
 432:	5ca78793          	addi	a5,a5,1482 # 9f8 <putc_buf>
 436:	97b6                	add	a5,a5,a3
 438:	6388                	ld	a0,0(a5)
  if(buf) {
 43a:	c511                	beqz	a0,446 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 43c:	60e2                	ld	ra,24(sp)
 43e:	6442                	ld	s0,16(sp)
 440:	64a2                	ld	s1,8(sp)
 442:	6105                	addi	sp,sp,32
 444:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 446:	6505                	lui	a0,0x1
 448:	00000097          	auipc	ra,0x0
 44c:	464080e7          	jalr	1124(ra) # 8ac <malloc>
  putc_buf[fd] = buf;
 450:	00000797          	auipc	a5,0x0
 454:	5a878793          	addi	a5,a5,1448 # 9f8 <putc_buf>
 458:	00349713          	slli	a4,s1,0x3
 45c:	973e                	add	a4,a4,a5
 45e:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 460:	00249713          	slli	a4,s1,0x2
 464:	973e                	add	a4,a4,a5
 466:	32072023          	sw	zero,800(a4)
  return buf;
 46a:	bfc9                	j	43c <get_putc_buf+0x1e>

000000000000046c <putc>:

static void
putc(int fd, char c)
{
 46c:	1101                	addi	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	e426                	sd	s1,8(sp)
 474:	e04a                	sd	s2,0(sp)
 476:	1000                	addi	s0,sp,32
 478:	84aa                	mv	s1,a0
 47a:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 47c:	00000097          	auipc	ra,0x0
 480:	fa2080e7          	jalr	-94(ra) # 41e <get_putc_buf>
  buf[putc_index[fd]++] = c;
 484:	00249793          	slli	a5,s1,0x2
 488:	00000717          	auipc	a4,0x0
 48c:	57070713          	addi	a4,a4,1392 # 9f8 <putc_buf>
 490:	973e                	add	a4,a4,a5
 492:	32072783          	lw	a5,800(a4)
 496:	0017869b          	addiw	a3,a5,1
 49a:	32d72023          	sw	a3,800(a4)
 49e:	97aa                	add	a5,a5,a0
 4a0:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 4a4:	47a9                	li	a5,10
 4a6:	02f90463          	beq	s2,a5,4ce <putc+0x62>
 4aa:	00249713          	slli	a4,s1,0x2
 4ae:	00000797          	auipc	a5,0x0
 4b2:	54a78793          	addi	a5,a5,1354 # 9f8 <putc_buf>
 4b6:	97ba                	add	a5,a5,a4
 4b8:	3207a703          	lw	a4,800(a5)
 4bc:	6785                	lui	a5,0x1
 4be:	00f70863          	beq	a4,a5,4ce <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 4c2:	60e2                	ld	ra,24(sp)
 4c4:	6442                	ld	s0,16(sp)
 4c6:	64a2                	ld	s1,8(sp)
 4c8:	6902                	ld	s2,0(sp)
 4ca:	6105                	addi	sp,sp,32
 4cc:	8082                	ret
    write(fd, buf, putc_index[fd]);
 4ce:	00249793          	slli	a5,s1,0x2
 4d2:	00000917          	auipc	s2,0x0
 4d6:	52690913          	addi	s2,s2,1318 # 9f8 <putc_buf>
 4da:	993e                	add	s2,s2,a5
 4dc:	32092603          	lw	a2,800(s2)
 4e0:	85aa                	mv	a1,a0
 4e2:	8526                	mv	a0,s1
 4e4:	00000097          	auipc	ra,0x0
 4e8:	e92080e7          	jalr	-366(ra) # 376 <write>
    putc_index[fd] = 0;
 4ec:	32092023          	sw	zero,800(s2)
}
 4f0:	bfc9                	j	4c2 <putc+0x56>

00000000000004f2 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f2:	7139                	addi	sp,sp,-64
 4f4:	fc06                	sd	ra,56(sp)
 4f6:	f822                	sd	s0,48(sp)
 4f8:	f426                	sd	s1,40(sp)
 4fa:	f04a                	sd	s2,32(sp)
 4fc:	ec4e                	sd	s3,24(sp)
 4fe:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 500:	c299                	beqz	a3,506 <printint+0x14>
 502:	0005cd63          	bltz	a1,51c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 506:	2581                	sext.w	a1,a1
  neg = 0;
 508:	4301                	li	t1,0
 50a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 50e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 510:	2601                	sext.w	a2,a2
 512:	00000897          	auipc	a7,0x0
 516:	4be88893          	addi	a7,a7,1214 # 9d0 <digits>
 51a:	a801                	j	52a <printint+0x38>
    x = -xx;
 51c:	40b005bb          	negw	a1,a1
 520:	2581                	sext.w	a1,a1
    neg = 1;
 522:	4305                	li	t1,1
    x = -xx;
 524:	b7dd                	j	50a <printint+0x18>
  }while((x /= base) != 0);
 526:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 528:	8836                	mv	a6,a3
 52a:	0018069b          	addiw	a3,a6,1
 52e:	02c5f7bb          	remuw	a5,a1,a2
 532:	1782                	slli	a5,a5,0x20
 534:	9381                	srli	a5,a5,0x20
 536:	97c6                	add	a5,a5,a7
 538:	0007c783          	lbu	a5,0(a5) # 1000 <_end+0x148>
 53c:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 540:	0705                	addi	a4,a4,1
 542:	02c5d7bb          	divuw	a5,a1,a2
 546:	fec5f0e3          	bleu	a2,a1,526 <printint+0x34>
  if(neg)
 54a:	00030b63          	beqz	t1,560 <printint+0x6e>
    buf[i++] = '-';
 54e:	fd040793          	addi	a5,s0,-48
 552:	96be                	add	a3,a3,a5
 554:	02d00793          	li	a5,45
 558:	fef68823          	sb	a5,-16(a3)
 55c:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 560:	02d05963          	blez	a3,592 <printint+0xa0>
 564:	89aa                	mv	s3,a0
 566:	fc040793          	addi	a5,s0,-64
 56a:	00d784b3          	add	s1,a5,a3
 56e:	fff78913          	addi	s2,a5,-1
 572:	9936                	add	s2,s2,a3
 574:	36fd                	addiw	a3,a3,-1
 576:	1682                	slli	a3,a3,0x20
 578:	9281                	srli	a3,a3,0x20
 57a:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 57e:	fff4c583          	lbu	a1,-1(s1)
 582:	854e                	mv	a0,s3
 584:	00000097          	auipc	ra,0x0
 588:	ee8080e7          	jalr	-280(ra) # 46c <putc>
  while(--i >= 0)
 58c:	14fd                	addi	s1,s1,-1
 58e:	ff2498e3          	bne	s1,s2,57e <printint+0x8c>
}
 592:	70e2                	ld	ra,56(sp)
 594:	7442                	ld	s0,48(sp)
 596:	74a2                	ld	s1,40(sp)
 598:	7902                	ld	s2,32(sp)
 59a:	69e2                	ld	s3,24(sp)
 59c:	6121                	addi	sp,sp,64
 59e:	8082                	ret

00000000000005a0 <fflush>:
void fflush(int fd){
 5a0:	1101                	addi	sp,sp,-32
 5a2:	ec06                	sd	ra,24(sp)
 5a4:	e822                	sd	s0,16(sp)
 5a6:	e426                	sd	s1,8(sp)
 5a8:	e04a                	sd	s2,0(sp)
 5aa:	1000                	addi	s0,sp,32
 5ac:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e70080e7          	jalr	-400(ra) # 41e <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 5b6:	00291793          	slli	a5,s2,0x2
 5ba:	00000497          	auipc	s1,0x0
 5be:	43e48493          	addi	s1,s1,1086 # 9f8 <putc_buf>
 5c2:	94be                	add	s1,s1,a5
 5c4:	3204a603          	lw	a2,800(s1)
 5c8:	85aa                	mv	a1,a0
 5ca:	854a                	mv	a0,s2
 5cc:	00000097          	auipc	ra,0x0
 5d0:	daa080e7          	jalr	-598(ra) # 376 <write>
  putc_index[fd] = 0;
 5d4:	3204a023          	sw	zero,800(s1)
}
 5d8:	60e2                	ld	ra,24(sp)
 5da:	6442                	ld	s0,16(sp)
 5dc:	64a2                	ld	s1,8(sp)
 5de:	6902                	ld	s2,0(sp)
 5e0:	6105                	addi	sp,sp,32
 5e2:	8082                	ret

00000000000005e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e4:	7119                	addi	sp,sp,-128
 5e6:	fc86                	sd	ra,120(sp)
 5e8:	f8a2                	sd	s0,112(sp)
 5ea:	f4a6                	sd	s1,104(sp)
 5ec:	f0ca                	sd	s2,96(sp)
 5ee:	ecce                	sd	s3,88(sp)
 5f0:	e8d2                	sd	s4,80(sp)
 5f2:	e4d6                	sd	s5,72(sp)
 5f4:	e0da                	sd	s6,64(sp)
 5f6:	fc5e                	sd	s7,56(sp)
 5f8:	f862                	sd	s8,48(sp)
 5fa:	f466                	sd	s9,40(sp)
 5fc:	f06a                	sd	s10,32(sp)
 5fe:	ec6e                	sd	s11,24(sp)
 600:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 602:	0005c483          	lbu	s1,0(a1)
 606:	18048d63          	beqz	s1,7a0 <vprintf+0x1bc>
 60a:	8aaa                	mv	s5,a0
 60c:	8b32                	mv	s6,a2
 60e:	00158913          	addi	s2,a1,1
  state = 0;
 612:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 614:	02500a13          	li	s4,37
      if(c == 'd'){
 618:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 61c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 620:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 624:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 628:	00000b97          	auipc	s7,0x0
 62c:	3a8b8b93          	addi	s7,s7,936 # 9d0 <digits>
 630:	a839                	j	64e <vprintf+0x6a>
        putc(fd, c);
 632:	85a6                	mv	a1,s1
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e36080e7          	jalr	-458(ra) # 46c <putc>
 63e:	a019                	j	644 <vprintf+0x60>
    } else if(state == '%'){
 640:	01498f63          	beq	s3,s4,65e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 644:	0905                	addi	s2,s2,1
 646:	fff94483          	lbu	s1,-1(s2)
 64a:	14048b63          	beqz	s1,7a0 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 64e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 652:	fe0997e3          	bnez	s3,640 <vprintf+0x5c>
      if(c == '%'){
 656:	fd479ee3          	bne	a5,s4,632 <vprintf+0x4e>
        state = '%';
 65a:	89be                	mv	s3,a5
 65c:	b7e5                	j	644 <vprintf+0x60>
      if(c == 'd'){
 65e:	05878063          	beq	a5,s8,69e <vprintf+0xba>
      } else if(c == 'l') {
 662:	05978c63          	beq	a5,s9,6ba <vprintf+0xd6>
      } else if(c == 'x') {
 666:	07a78863          	beq	a5,s10,6d6 <vprintf+0xf2>
      } else if(c == 'p') {
 66a:	09b78463          	beq	a5,s11,6f2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 66e:	07300713          	li	a4,115
 672:	0ce78563          	beq	a5,a4,73c <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 676:	06300713          	li	a4,99
 67a:	0ee78c63          	beq	a5,a4,772 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 67e:	11478663          	beq	a5,s4,78a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 682:	85d2                	mv	a1,s4
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	de6080e7          	jalr	-538(ra) # 46c <putc>
        putc(fd, c);
 68e:	85a6                	mv	a1,s1
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	dda080e7          	jalr	-550(ra) # 46c <putc>
      }
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b765                	j	644 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 69e:	008b0493          	addi	s1,s6,8
 6a2:	4685                	li	a3,1
 6a4:	4629                	li	a2,10
 6a6:	000b2583          	lw	a1,0(s6)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e46080e7          	jalr	-442(ra) # 4f2 <printint>
 6b4:	8b26                	mv	s6,s1
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b771                	j	644 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ba:	008b0493          	addi	s1,s6,8
 6be:	4681                	li	a3,0
 6c0:	4629                	li	a2,10
 6c2:	000b2583          	lw	a1,0(s6)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e2a080e7          	jalr	-470(ra) # 4f2 <printint>
 6d0:	8b26                	mv	s6,s1
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bf85                	j	644 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6d6:	008b0493          	addi	s1,s6,8
 6da:	4681                	li	a3,0
 6dc:	4641                	li	a2,16
 6de:	000b2583          	lw	a1,0(s6)
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e0e080e7          	jalr	-498(ra) # 4f2 <printint>
 6ec:	8b26                	mv	s6,s1
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	bf91                	j	644 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6f2:	008b0793          	addi	a5,s6,8
 6f6:	f8f43423          	sd	a5,-120(s0)
 6fa:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6fe:	03000593          	li	a1,48
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	d68080e7          	jalr	-664(ra) # 46c <putc>
  putc(fd, 'x');
 70c:	85ea                	mv	a1,s10
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	d5c080e7          	jalr	-676(ra) # 46c <putc>
 718:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 71a:	03c9d793          	srli	a5,s3,0x3c
 71e:	97de                	add	a5,a5,s7
 720:	0007c583          	lbu	a1,0(a5)
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	d46080e7          	jalr	-698(ra) # 46c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72e:	0992                	slli	s3,s3,0x4
 730:	34fd                	addiw	s1,s1,-1
 732:	f4e5                	bnez	s1,71a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 734:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 738:	4981                	li	s3,0
 73a:	b729                	j	644 <vprintf+0x60>
        s = va_arg(ap, char*);
 73c:	008b0993          	addi	s3,s6,8
 740:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 744:	c085                	beqz	s1,764 <vprintf+0x180>
        while(*s != 0){
 746:	0004c583          	lbu	a1,0(s1)
 74a:	c9a1                	beqz	a1,79a <vprintf+0x1b6>
          putc(fd, *s);
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	d1e080e7          	jalr	-738(ra) # 46c <putc>
          s++;
 756:	0485                	addi	s1,s1,1
        while(*s != 0){
 758:	0004c583          	lbu	a1,0(s1)
 75c:	f9e5                	bnez	a1,74c <vprintf+0x168>
        s = va_arg(ap, char*);
 75e:	8b4e                	mv	s6,s3
      state = 0;
 760:	4981                	li	s3,0
 762:	b5cd                	j	644 <vprintf+0x60>
          s = "(null)";
 764:	00000497          	auipc	s1,0x0
 768:	28448493          	addi	s1,s1,644 # 9e8 <digits+0x18>
        while(*s != 0){
 76c:	02800593          	li	a1,40
 770:	bff1                	j	74c <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 772:	008b0493          	addi	s1,s6,8
 776:	000b4583          	lbu	a1,0(s6)
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	cf0080e7          	jalr	-784(ra) # 46c <putc>
 784:	8b26                	mv	s6,s1
      state = 0;
 786:	4981                	li	s3,0
 788:	bd75                	j	644 <vprintf+0x60>
        putc(fd, c);
 78a:	85d2                	mv	a1,s4
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	cde080e7          	jalr	-802(ra) # 46c <putc>
      state = 0;
 796:	4981                	li	s3,0
 798:	b575                	j	644 <vprintf+0x60>
        s = va_arg(ap, char*);
 79a:	8b4e                	mv	s6,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b55d                	j	644 <vprintf+0x60>
    }
  }
}
 7a0:	70e6                	ld	ra,120(sp)
 7a2:	7446                	ld	s0,112(sp)
 7a4:	74a6                	ld	s1,104(sp)
 7a6:	7906                	ld	s2,96(sp)
 7a8:	69e6                	ld	s3,88(sp)
 7aa:	6a46                	ld	s4,80(sp)
 7ac:	6aa6                	ld	s5,72(sp)
 7ae:	6b06                	ld	s6,64(sp)
 7b0:	7be2                	ld	s7,56(sp)
 7b2:	7c42                	ld	s8,48(sp)
 7b4:	7ca2                	ld	s9,40(sp)
 7b6:	7d02                	ld	s10,32(sp)
 7b8:	6de2                	ld	s11,24(sp)
 7ba:	6109                	addi	sp,sp,128
 7bc:	8082                	ret

00000000000007be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7be:	715d                	addi	sp,sp,-80
 7c0:	ec06                	sd	ra,24(sp)
 7c2:	e822                	sd	s0,16(sp)
 7c4:	1000                	addi	s0,sp,32
 7c6:	e010                	sd	a2,0(s0)
 7c8:	e414                	sd	a3,8(s0)
 7ca:	e818                	sd	a4,16(s0)
 7cc:	ec1c                	sd	a5,24(s0)
 7ce:	03043023          	sd	a6,32(s0)
 7d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7da:	8622                	mv	a2,s0
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e08080e7          	jalr	-504(ra) # 5e4 <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6161                	addi	sp,sp,80
 7ea:	8082                	ret

00000000000007ec <printf>:

void
printf(const char *fmt, ...)
{
 7ec:	711d                	addi	sp,sp,-96
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e40c                	sd	a1,8(s0)
 7f6:	e810                	sd	a2,16(s0)
 7f8:	ec14                	sd	a3,24(s0)
 7fa:	f018                	sd	a4,32(s0)
 7fc:	f41c                	sd	a5,40(s0)
 7fe:	03043823          	sd	a6,48(s0)
 802:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	00840613          	addi	a2,s0,8
 80a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80e:	85aa                	mv	a1,a0
 810:	4505                	li	a0,1
 812:	00000097          	auipc	ra,0x0
 816:	dd2080e7          	jalr	-558(ra) # 5e4 <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6125                	addi	sp,sp,96
 820:	8082                	ret

0000000000000822 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 822:	1141                	addi	sp,sp,-16
 824:	e422                	sd	s0,8(sp)
 826:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 828:	ff050693          	addi	a3,a0,-16 # ff0 <_end+0x138>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82c:	00000797          	auipc	a5,0x0
 830:	1c478793          	addi	a5,a5,452 # 9f0 <__bss_start>
 834:	639c                	ld	a5,0(a5)
 836:	a805                	j	866 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 838:	4618                	lw	a4,8(a2)
 83a:	9db9                	addw	a1,a1,a4
 83c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 840:	6398                	ld	a4,0(a5)
 842:	6318                	ld	a4,0(a4)
 844:	fee53823          	sd	a4,-16(a0)
 848:	a091                	j	88c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84a:	ff852703          	lw	a4,-8(a0)
 84e:	9e39                	addw	a2,a2,a4
 850:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 852:	ff053703          	ld	a4,-16(a0)
 856:	e398                	sd	a4,0(a5)
 858:	a099                	j	89e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85a:	6398                	ld	a4,0(a5)
 85c:	00e7e463          	bltu	a5,a4,864 <free+0x42>
 860:	00e6ea63          	bltu	a3,a4,874 <free+0x52>
{
 864:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 866:	fed7fae3          	bleu	a3,a5,85a <free+0x38>
 86a:	6398                	ld	a4,0(a5)
 86c:	00e6e463          	bltu	a3,a4,874 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	fee7eae3          	bltu	a5,a4,864 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 874:	ff852583          	lw	a1,-8(a0)
 878:	6390                	ld	a2,0(a5)
 87a:	02059713          	slli	a4,a1,0x20
 87e:	9301                	srli	a4,a4,0x20
 880:	0712                	slli	a4,a4,0x4
 882:	9736                	add	a4,a4,a3
 884:	fae60ae3          	beq	a2,a4,838 <free+0x16>
    bp->s.ptr = p->s.ptr;
 888:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88c:	4790                	lw	a2,8(a5)
 88e:	02061713          	slli	a4,a2,0x20
 892:	9301                	srli	a4,a4,0x20
 894:	0712                	slli	a4,a4,0x4
 896:	973e                	add	a4,a4,a5
 898:	fae689e3          	beq	a3,a4,84a <free+0x28>
  } else
    p->s.ptr = bp;
 89c:	e394                	sd	a3,0(a5)
  freep = p;
 89e:	00000717          	auipc	a4,0x0
 8a2:	14f73923          	sd	a5,338(a4) # 9f0 <__bss_start>
}
 8a6:	6422                	ld	s0,8(sp)
 8a8:	0141                	addi	sp,sp,16
 8aa:	8082                	ret

00000000000008ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ac:	7139                	addi	sp,sp,-64
 8ae:	fc06                	sd	ra,56(sp)
 8b0:	f822                	sd	s0,48(sp)
 8b2:	f426                	sd	s1,40(sp)
 8b4:	f04a                	sd	s2,32(sp)
 8b6:	ec4e                	sd	s3,24(sp)
 8b8:	e852                	sd	s4,16(sp)
 8ba:	e456                	sd	s5,8(sp)
 8bc:	e05a                	sd	s6,0(sp)
 8be:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c0:	02051993          	slli	s3,a0,0x20
 8c4:	0209d993          	srli	s3,s3,0x20
 8c8:	09bd                	addi	s3,s3,15
 8ca:	0049d993          	srli	s3,s3,0x4
 8ce:	2985                	addiw	s3,s3,1
 8d0:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 8d4:	00000797          	auipc	a5,0x0
 8d8:	11c78793          	addi	a5,a5,284 # 9f0 <__bss_start>
 8dc:	6388                	ld	a0,0(a5)
 8de:	c515                	beqz	a0,90a <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e2:	4798                	lw	a4,8(a5)
 8e4:	03277f63          	bleu	s2,a4,922 <malloc+0x76>
 8e8:	8a4e                	mv	s4,s3
 8ea:	0009871b          	sext.w	a4,s3
 8ee:	6685                	lui	a3,0x1
 8f0:	00d77363          	bleu	a3,a4,8f6 <malloc+0x4a>
 8f4:	6a05                	lui	s4,0x1
 8f6:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 8fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8fe:	00000497          	auipc	s1,0x0
 902:	0f248493          	addi	s1,s1,242 # 9f0 <__bss_start>
  if(p == (char*)-1)
 906:	5b7d                	li	s6,-1
 908:	a885                	j	978 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 90a:	00000797          	auipc	a5,0x0
 90e:	59e78793          	addi	a5,a5,1438 # ea8 <base>
 912:	00000717          	auipc	a4,0x0
 916:	0cf73f23          	sd	a5,222(a4) # 9f0 <__bss_start>
 91a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 91c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 920:	b7e1                	j	8e8 <malloc+0x3c>
      if(p->s.size == nunits)
 922:	02e90b63          	beq	s2,a4,958 <malloc+0xac>
        p->s.size -= nunits;
 926:	4137073b          	subw	a4,a4,s3
 92a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 92c:	1702                	slli	a4,a4,0x20
 92e:	9301                	srli	a4,a4,0x20
 930:	0712                	slli	a4,a4,0x4
 932:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 934:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 938:	00000717          	auipc	a4,0x0
 93c:	0aa73c23          	sd	a0,184(a4) # 9f0 <__bss_start>
      return (void*)(p + 1);
 940:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 944:	70e2                	ld	ra,56(sp)
 946:	7442                	ld	s0,48(sp)
 948:	74a2                	ld	s1,40(sp)
 94a:	7902                	ld	s2,32(sp)
 94c:	69e2                	ld	s3,24(sp)
 94e:	6a42                	ld	s4,16(sp)
 950:	6aa2                	ld	s5,8(sp)
 952:	6b02                	ld	s6,0(sp)
 954:	6121                	addi	sp,sp,64
 956:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 958:	6398                	ld	a4,0(a5)
 95a:	e118                	sd	a4,0(a0)
 95c:	bff1                	j	938 <malloc+0x8c>
  hp->s.size = nu;
 95e:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 962:	0541                	addi	a0,a0,16
 964:	00000097          	auipc	ra,0x0
 968:	ebe080e7          	jalr	-322(ra) # 822 <free>
  return freep;
 96c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 96e:	d979                	beqz	a0,944 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 970:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 972:	4798                	lw	a4,8(a5)
 974:	fb2777e3          	bleu	s2,a4,922 <malloc+0x76>
    if(p == freep)
 978:	6098                	ld	a4,0(s1)
 97a:	853e                	mv	a0,a5
 97c:	fef71ae3          	bne	a4,a5,970 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 980:	8552                	mv	a0,s4
 982:	00000097          	auipc	ra,0x0
 986:	a5c080e7          	jalr	-1444(ra) # 3de <sbrk>
  if(p == (char*)-1)
 98a:	fd651ae3          	bne	a0,s6,95e <malloc+0xb2>
        return 0;
 98e:	4501                	li	a0,0
 990:	bf55                	j	944 <malloc+0x98>
