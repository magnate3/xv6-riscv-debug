
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	a9090913          	addi	s2,s2,-1392 # aa0 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3ea080e7          	jalr	1002(ra) # 40a <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05863          	blez	a0,5a <cat+0x5a>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	3de080e7          	jalr	990(ra) # 412 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      printf("cat: write error\n");
  40:	00001517          	auipc	a0,0x1
  44:	9f050513          	addi	a0,a0,-1552 # a30 <malloc+0xe8>
  48:	00001097          	auipc	ra,0x1
  4c:	840080e7          	jalr	-1984(ra) # 888 <printf>
      exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	3a0080e7          	jalr	928(ra) # 3f2 <exit>
    }
  }
  if(n < 0){
  5a:	00054963          	bltz	a0,6c <cat+0x6c>
    printf("cat: read error\n");
    exit(1);
  }
}
  5e:	70a2                	ld	ra,40(sp)
  60:	7402                	ld	s0,32(sp)
  62:	64e2                	ld	s1,24(sp)
  64:	6942                	ld	s2,16(sp)
  66:	69a2                	ld	s3,8(sp)
  68:	6145                	addi	sp,sp,48
  6a:	8082                	ret
    printf("cat: read error\n");
  6c:	00001517          	auipc	a0,0x1
  70:	9dc50513          	addi	a0,a0,-1572 # a48 <malloc+0x100>
  74:	00001097          	auipc	ra,0x1
  78:	814080e7          	jalr	-2028(ra) # 888 <printf>
    exit(1);
  7c:	4505                	li	a0,1
  7e:	00000097          	auipc	ra,0x0
  82:	374080e7          	jalr	884(ra) # 3f2 <exit>

0000000000000086 <main>:

int
main(int argc, char *argv[])
{
  86:	7179                	addi	sp,sp,-48
  88:	f406                	sd	ra,40(sp)
  8a:	f022                	sd	s0,32(sp)
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	e052                	sd	s4,0(sp)
  94:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  96:	4785                	li	a5,1
  98:	04a7d663          	ble	a0,a5,e4 <main+0x5e>
  9c:	00858493          	addi	s1,a1,8
  a0:	ffe5099b          	addiw	s3,a0,-2
  a4:	1982                	slli	s3,s3,0x20
  a6:	0209d993          	srli	s3,s3,0x20
  aa:	098e                	slli	s3,s3,0x3
  ac:	05c1                	addi	a1,a1,16
  ae:	99ae                	add	s3,s3,a1
    cat(0);
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b0:	4581                	li	a1,0
  b2:	6088                	ld	a0,0(s1)
  b4:	00000097          	auipc	ra,0x0
  b8:	37e080e7          	jalr	894(ra) # 432 <open>
  bc:	892a                	mv	s2,a0
  be:	02054d63          	bltz	a0,f8 <main+0x72>
      printf("cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c2:	00000097          	auipc	ra,0x0
  c6:	f3e080e7          	jalr	-194(ra) # 0 <cat>
    close(fd);
  ca:	854a                	mv	a0,s2
  cc:	00000097          	auipc	ra,0x0
  d0:	28a080e7          	jalr	650(ra) # 356 <close>
  for(i = 1; i < argc; i++){
  d4:	04a1                	addi	s1,s1,8
  d6:	fd349de3          	bne	s1,s3,b0 <main+0x2a>
  }
  exit(0);
  da:	4501                	li	a0,0
  dc:	00000097          	auipc	ra,0x0
  e0:	316080e7          	jalr	790(ra) # 3f2 <exit>
    cat(0);
  e4:	4501                	li	a0,0
  e6:	00000097          	auipc	ra,0x0
  ea:	f1a080e7          	jalr	-230(ra) # 0 <cat>
    exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	302080e7          	jalr	770(ra) # 3f2 <exit>
      printf("cat: cannot open %s\n", argv[i]);
  f8:	608c                	ld	a1,0(s1)
  fa:	00001517          	auipc	a0,0x1
  fe:	96650513          	addi	a0,a0,-1690 # a60 <malloc+0x118>
 102:	00000097          	auipc	ra,0x0
 106:	786080e7          	jalr	1926(ra) # 888 <printf>
      exit(1);
 10a:	4505                	li	a0,1
 10c:	00000097          	auipc	ra,0x0
 110:	2e6080e7          	jalr	742(ra) # 3f2 <exit>

0000000000000114 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strcmp+0x26>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71b63          	bne	a4,a5,156 <strcmp+0x26>
    p++, q++;
 144:	0505                	addi	a0,a0,1
 146:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	c789                	beqz	a5,156 <strcmp+0x26>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	fef709e3          	beq	a4,a5,144 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 156:	0005c503          	lbu	a0,0(a1)
}
 15a:	40a7853b          	subw	a0,a5,a0
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strlen>:

uint
strlen(const char *s)
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	cf91                	beqz	a5,18a <strlen+0x26>
 170:	0505                	addi	a0,a0,1
 172:	87aa                	mv	a5,a0
 174:	4685                	li	a3,1
 176:	9e89                	subw	a3,a3,a0
 178:	00f6853b          	addw	a0,a3,a5
 17c:	0785                	addi	a5,a5,1
 17e:	fff7c703          	lbu	a4,-1(a5)
 182:	fb7d                	bnez	a4,178 <strlen+0x14>
    ;
  return n;
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret
  for(n = 0; s[n]; n++)
 18a:	4501                	li	a0,0
 18c:	bfe5                	j	184 <strlen+0x20>

000000000000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e422                	sd	s0,8(sp)
 192:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 194:	ce09                	beqz	a2,1ae <memset+0x20>
 196:	87aa                	mv	a5,a0
 198:	fff6071b          	addiw	a4,a2,-1
 19c:	1702                	slli	a4,a4,0x20
 19e:	9301                	srli	a4,a4,0x20
 1a0:	0705                	addi	a4,a4,1
 1a2:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1a8:	0785                	addi	a5,a5,1
 1aa:	fee79de3          	bne	a5,a4,1a4 <memset+0x16>
  }
  return dst;
}
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strchr>:

char*
strchr(const char *s, char c)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	cf91                	beqz	a5,1da <strchr+0x26>
    if(*s == c)
 1c0:	00f58a63          	beq	a1,a5,1d4 <strchr+0x20>
  for(; *s; s++)
 1c4:	0505                	addi	a0,a0,1
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	c781                	beqz	a5,1d2 <strchr+0x1e>
    if(*s == c)
 1cc:	feb79ce3          	bne	a5,a1,1c4 <strchr+0x10>
 1d0:	a011                	j	1d4 <strchr+0x20>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x20>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	0019849b          	addiw	s1,s3,1
 204:	0344d863          	ble	s4,s1,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	1fa080e7          	jalr	506(ra) # 40a <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 22c:	fd679ae3          	bne	a5,s6,200 <gets+0x22>
 230:	a011                	j	234 <gets+0x56>
  for(i=0; i+1 < max; ){
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 258:	00054683          	lbu	a3,0(a0)
 25c:	fd06879b          	addiw	a5,a3,-48
 260:	0ff7f793          	andi	a5,a5,255
 264:	4725                	li	a4,9
 266:	02f76963          	bltu	a4,a5,298 <atoi+0x46>
 26a:	862a                	mv	a2,a0
  n = 0;
 26c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 26e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 270:	0605                	addi	a2,a2,1
 272:	0025179b          	slliw	a5,a0,0x2
 276:	9fa9                	addw	a5,a5,a0
 278:	0017979b          	slliw	a5,a5,0x1
 27c:	9fb5                	addw	a5,a5,a3
 27e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 282:	00064683          	lbu	a3,0(a2)
 286:	fd06871b          	addiw	a4,a3,-48
 28a:	0ff77713          	andi	a4,a4,255
 28e:	fee5f1e3          	bleu	a4,a1,270 <atoi+0x1e>
  return n;
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
  n = 0;
 298:	4501                	li	a0,0
 29a:	bfe5                	j	292 <atoi+0x40>

000000000000029c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2a2:	02b57663          	bleu	a1,a0,2ce <memmove+0x32>
    while(n-- > 0)
 2a6:	02c05163          	blez	a2,2c8 <memmove+0x2c>
 2aa:	fff6079b          	addiw	a5,a2,-1
 2ae:	1782                	slli	a5,a5,0x20
 2b0:	9381                	srli	a5,a5,0x20
 2b2:	0785                	addi	a5,a5,1
 2b4:	97aa                	add	a5,a5,a0
  dst = vdst;
 2b6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b8:	0585                	addi	a1,a1,1
 2ba:	0705                	addi	a4,a4,1
 2bc:	fff5c683          	lbu	a3,-1(a1)
 2c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c4:	fee79ae3          	bne	a5,a4,2b8 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret
    dst += n;
 2ce:	00c50733          	add	a4,a0,a2
    src += n;
 2d2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2d4:	fec05ae3          	blez	a2,2c8 <memmove+0x2c>
 2d8:	fff6079b          	addiw	a5,a2,-1
 2dc:	1782                	slli	a5,a5,0x20
 2de:	9381                	srli	a5,a5,0x20
 2e0:	fff7c793          	not	a5,a5
 2e4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e6:	15fd                	addi	a1,a1,-1
 2e8:	177d                	addi	a4,a4,-1
 2ea:	0005c683          	lbu	a3,0(a1)
 2ee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f2:	fef71ae3          	bne	a4,a5,2e6 <memmove+0x4a>
 2f6:	bfc9                	j	2c8 <memmove+0x2c>

00000000000002f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2fe:	ce15                	beqz	a2,33a <memcmp+0x42>
 300:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 304:	00054783          	lbu	a5,0(a0)
 308:	0005c703          	lbu	a4,0(a1)
 30c:	02e79063          	bne	a5,a4,32c <memcmp+0x34>
 310:	1682                	slli	a3,a3,0x20
 312:	9281                	srli	a3,a3,0x20
 314:	0685                	addi	a3,a3,1
 316:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 318:	0505                	addi	a0,a0,1
    p2++;
 31a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 31c:	00d50d63          	beq	a0,a3,336 <memcmp+0x3e>
    if (*p1 != *p2) {
 320:	00054783          	lbu	a5,0(a0)
 324:	0005c703          	lbu	a4,0(a1)
 328:	fee788e3          	beq	a5,a4,318 <memcmp+0x20>
      return *p1 - *p2;
 32c:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 330:	6422                	ld	s0,8(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret
  return 0;
 336:	4501                	li	a0,0
 338:	bfe5                	j	330 <memcmp+0x38>
 33a:	4501                	li	a0,0
 33c:	bfd5                	j	330 <memcmp+0x38>

000000000000033e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 346:	00000097          	auipc	ra,0x0
 34a:	f56080e7          	jalr	-170(ra) # 29c <memmove>
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <close>:

int close(int fd){
 356:	1101                	addi	sp,sp,-32
 358:	ec06                	sd	ra,24(sp)
 35a:	e822                	sd	s0,16(sp)
 35c:	e426                	sd	s1,8(sp)
 35e:	1000                	addi	s0,sp,32
 360:	84aa                	mv	s1,a0
  fflush(fd);
 362:	00000097          	auipc	ra,0x0
 366:	2da080e7          	jalr	730(ra) # 63c <fflush>
  char* buf = get_putc_buf(fd);
 36a:	8526                	mv	a0,s1
 36c:	00000097          	auipc	ra,0x0
 370:	14e080e7          	jalr	334(ra) # 4ba <get_putc_buf>
  if(buf){
 374:	cd11                	beqz	a0,390 <close+0x3a>
    free(buf);
 376:	00000097          	auipc	ra,0x0
 37a:	548080e7          	jalr	1352(ra) # 8be <free>
    putc_buf[fd] = 0;
 37e:	00349713          	slli	a4,s1,0x3
 382:	00001797          	auipc	a5,0x1
 386:	91e78793          	addi	a5,a5,-1762 # ca0 <putc_buf>
 38a:	97ba                	add	a5,a5,a4
 38c:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 390:	8526                	mv	a0,s1
 392:	00000097          	auipc	ra,0x0
 396:	088080e7          	jalr	136(ra) # 41a <sclose>
}
 39a:	60e2                	ld	ra,24(sp)
 39c:	6442                	ld	s0,16(sp)
 39e:	64a2                	ld	s1,8(sp)
 3a0:	6105                	addi	sp,sp,32
 3a2:	8082                	ret

00000000000003a4 <stat>:
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	e426                	sd	s1,8(sp)
 3ac:	e04a                	sd	s2,0(sp)
 3ae:	1000                	addi	s0,sp,32
 3b0:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 3b2:	4581                	li	a1,0
 3b4:	00000097          	auipc	ra,0x0
 3b8:	07e080e7          	jalr	126(ra) # 432 <open>
  if(fd < 0)
 3bc:	02054563          	bltz	a0,3e6 <stat+0x42>
 3c0:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 3c2:	85ca                	mv	a1,s2
 3c4:	00000097          	auipc	ra,0x0
 3c8:	086080e7          	jalr	134(ra) # 44a <fstat>
 3cc:	892a                	mv	s2,a0
  close(fd);
 3ce:	8526                	mv	a0,s1
 3d0:	00000097          	auipc	ra,0x0
 3d4:	f86080e7          	jalr	-122(ra) # 356 <close>
}
 3d8:	854a                	mv	a0,s2
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	64a2                	ld	s1,8(sp)
 3e0:	6902                	ld	s2,0(sp)
 3e2:	6105                	addi	sp,sp,32
 3e4:	8082                	ret
    return -1;
 3e6:	597d                	li	s2,-1
 3e8:	bfc5                	j	3d8 <stat+0x34>

00000000000003ea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ea:	4885                	li	a7,1
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f2:	4889                	li	a7,2
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <wait>:
.global wait
wait:
 li a7, SYS_wait
 3fa:	488d                	li	a7,3
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 402:	4891                	li	a7,4
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <read>:
.global read
read:
 li a7, SYS_read
 40a:	4895                	li	a7,5
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <write>:
.global write
write:
 li a7, SYS_write
 412:	48c1                	li	a7,16
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 41a:	48d5                	li	a7,21
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <kill>:
.global kill
kill:
 li a7, SYS_kill
 422:	4899                	li	a7,6
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <exec>:
.global exec
exec:
 li a7, SYS_exec
 42a:	489d                	li	a7,7
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <open>:
.global open
open:
 li a7, SYS_open
 432:	48bd                	li	a7,15
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 43a:	48c5                	li	a7,17
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 442:	48c9                	li	a7,18
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 44a:	48a1                	li	a7,8
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <link>:
.global link
link:
 li a7, SYS_link
 452:	48cd                	li	a7,19
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45a:	48d1                	li	a7,20
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 462:	48a5                	li	a7,9
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <dup>:
.global dup
dup:
 li a7, SYS_dup
 46a:	48a9                	li	a7,10
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 472:	48ad                	li	a7,11
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 47a:	48b1                	li	a7,12
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 482:	48b5                	li	a7,13
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48a:	48b9                	li	a7,14
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 492:	48d9                	li	a7,22
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <nice>:
.global nice
nice:
 li a7, SYS_nice
 49a:	48dd                	li	a7,23
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 4a2:	48e1                	li	a7,24
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 4aa:	48e5                	li	a7,25
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 4b2:	48e9                	li	a7,26
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 4ba:	1101                	addi	sp,sp,-32
 4bc:	ec06                	sd	ra,24(sp)
 4be:	e822                	sd	s0,16(sp)
 4c0:	e426                	sd	s1,8(sp)
 4c2:	1000                	addi	s0,sp,32
 4c4:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 4c6:	00351693          	slli	a3,a0,0x3
 4ca:	00000797          	auipc	a5,0x0
 4ce:	7d678793          	addi	a5,a5,2006 # ca0 <putc_buf>
 4d2:	97b6                	add	a5,a5,a3
 4d4:	6388                	ld	a0,0(a5)
  if(buf) {
 4d6:	c511                	beqz	a0,4e2 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 4d8:	60e2                	ld	ra,24(sp)
 4da:	6442                	ld	s0,16(sp)
 4dc:	64a2                	ld	s1,8(sp)
 4de:	6105                	addi	sp,sp,32
 4e0:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 4e2:	6505                	lui	a0,0x1
 4e4:	00000097          	auipc	ra,0x0
 4e8:	464080e7          	jalr	1124(ra) # 948 <malloc>
  putc_buf[fd] = buf;
 4ec:	00000797          	auipc	a5,0x0
 4f0:	7b478793          	addi	a5,a5,1972 # ca0 <putc_buf>
 4f4:	00349713          	slli	a4,s1,0x3
 4f8:	973e                	add	a4,a4,a5
 4fa:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 4fc:	00249713          	slli	a4,s1,0x2
 500:	973e                	add	a4,a4,a5
 502:	32072023          	sw	zero,800(a4)
  return buf;
 506:	bfc9                	j	4d8 <get_putc_buf+0x1e>

0000000000000508 <putc>:

static void
putc(int fd, char c)
{
 508:	1101                	addi	sp,sp,-32
 50a:	ec06                	sd	ra,24(sp)
 50c:	e822                	sd	s0,16(sp)
 50e:	e426                	sd	s1,8(sp)
 510:	e04a                	sd	s2,0(sp)
 512:	1000                	addi	s0,sp,32
 514:	84aa                	mv	s1,a0
 516:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 518:	00000097          	auipc	ra,0x0
 51c:	fa2080e7          	jalr	-94(ra) # 4ba <get_putc_buf>
  buf[putc_index[fd]++] = c;
 520:	00249793          	slli	a5,s1,0x2
 524:	00000717          	auipc	a4,0x0
 528:	77c70713          	addi	a4,a4,1916 # ca0 <putc_buf>
 52c:	973e                	add	a4,a4,a5
 52e:	32072783          	lw	a5,800(a4)
 532:	0017869b          	addiw	a3,a5,1
 536:	32d72023          	sw	a3,800(a4)
 53a:	97aa                	add	a5,a5,a0
 53c:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 540:	47a9                	li	a5,10
 542:	02f90463          	beq	s2,a5,56a <putc+0x62>
 546:	00249713          	slli	a4,s1,0x2
 54a:	00000797          	auipc	a5,0x0
 54e:	75678793          	addi	a5,a5,1878 # ca0 <putc_buf>
 552:	97ba                	add	a5,a5,a4
 554:	3207a703          	lw	a4,800(a5)
 558:	6785                	lui	a5,0x1
 55a:	00f70863          	beq	a4,a5,56a <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 55e:	60e2                	ld	ra,24(sp)
 560:	6442                	ld	s0,16(sp)
 562:	64a2                	ld	s1,8(sp)
 564:	6902                	ld	s2,0(sp)
 566:	6105                	addi	sp,sp,32
 568:	8082                	ret
    write(fd, buf, putc_index[fd]);
 56a:	00249793          	slli	a5,s1,0x2
 56e:	00000917          	auipc	s2,0x0
 572:	73290913          	addi	s2,s2,1842 # ca0 <putc_buf>
 576:	993e                	add	s2,s2,a5
 578:	32092603          	lw	a2,800(s2)
 57c:	85aa                	mv	a1,a0
 57e:	8526                	mv	a0,s1
 580:	00000097          	auipc	ra,0x0
 584:	e92080e7          	jalr	-366(ra) # 412 <write>
    putc_index[fd] = 0;
 588:	32092023          	sw	zero,800(s2)
}
 58c:	bfc9                	j	55e <putc+0x56>

000000000000058e <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 58e:	7139                	addi	sp,sp,-64
 590:	fc06                	sd	ra,56(sp)
 592:	f822                	sd	s0,48(sp)
 594:	f426                	sd	s1,40(sp)
 596:	f04a                	sd	s2,32(sp)
 598:	ec4e                	sd	s3,24(sp)
 59a:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 59c:	c299                	beqz	a3,5a2 <printint+0x14>
 59e:	0005cd63          	bltz	a1,5b8 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5a2:	2581                	sext.w	a1,a1
  neg = 0;
 5a4:	4301                	li	t1,0
 5a6:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 5aa:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 5ac:	2601                	sext.w	a2,a2
 5ae:	00000897          	auipc	a7,0x0
 5b2:	4ca88893          	addi	a7,a7,1226 # a78 <digits>
 5b6:	a801                	j	5c6 <printint+0x38>
    x = -xx;
 5b8:	40b005bb          	negw	a1,a1
 5bc:	2581                	sext.w	a1,a1
    neg = 1;
 5be:	4305                	li	t1,1
    x = -xx;
 5c0:	b7dd                	j	5a6 <printint+0x18>
  }while((x /= base) != 0);
 5c2:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5c4:	8836                	mv	a6,a3
 5c6:	0018069b          	addiw	a3,a6,1
 5ca:	02c5f7bb          	remuw	a5,a1,a2
 5ce:	1782                	slli	a5,a5,0x20
 5d0:	9381                	srli	a5,a5,0x20
 5d2:	97c6                	add	a5,a5,a7
 5d4:	0007c783          	lbu	a5,0(a5) # 1000 <putc_index+0x40>
 5d8:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 5dc:	0705                	addi	a4,a4,1
 5de:	02c5d7bb          	divuw	a5,a1,a2
 5e2:	fec5f0e3          	bleu	a2,a1,5c2 <printint+0x34>
  if(neg)
 5e6:	00030b63          	beqz	t1,5fc <printint+0x6e>
    buf[i++] = '-';
 5ea:	fd040793          	addi	a5,s0,-48
 5ee:	96be                	add	a3,a3,a5
 5f0:	02d00793          	li	a5,45
 5f4:	fef68823          	sb	a5,-16(a3)
 5f8:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 5fc:	02d05963          	blez	a3,62e <printint+0xa0>
 600:	89aa                	mv	s3,a0
 602:	fc040793          	addi	a5,s0,-64
 606:	00d784b3          	add	s1,a5,a3
 60a:	fff78913          	addi	s2,a5,-1
 60e:	9936                	add	s2,s2,a3
 610:	36fd                	addiw	a3,a3,-1
 612:	1682                	slli	a3,a3,0x20
 614:	9281                	srli	a3,a3,0x20
 616:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 61a:	fff4c583          	lbu	a1,-1(s1)
 61e:	854e                	mv	a0,s3
 620:	00000097          	auipc	ra,0x0
 624:	ee8080e7          	jalr	-280(ra) # 508 <putc>
  while(--i >= 0)
 628:	14fd                	addi	s1,s1,-1
 62a:	ff2498e3          	bne	s1,s2,61a <printint+0x8c>
}
 62e:	70e2                	ld	ra,56(sp)
 630:	7442                	ld	s0,48(sp)
 632:	74a2                	ld	s1,40(sp)
 634:	7902                	ld	s2,32(sp)
 636:	69e2                	ld	s3,24(sp)
 638:	6121                	addi	sp,sp,64
 63a:	8082                	ret

000000000000063c <fflush>:
void fflush(int fd){
 63c:	1101                	addi	sp,sp,-32
 63e:	ec06                	sd	ra,24(sp)
 640:	e822                	sd	s0,16(sp)
 642:	e426                	sd	s1,8(sp)
 644:	e04a                	sd	s2,0(sp)
 646:	1000                	addi	s0,sp,32
 648:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 64a:	00000097          	auipc	ra,0x0
 64e:	e70080e7          	jalr	-400(ra) # 4ba <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 652:	00291793          	slli	a5,s2,0x2
 656:	00000497          	auipc	s1,0x0
 65a:	64a48493          	addi	s1,s1,1610 # ca0 <putc_buf>
 65e:	94be                	add	s1,s1,a5
 660:	3204a603          	lw	a2,800(s1)
 664:	85aa                	mv	a1,a0
 666:	854a                	mv	a0,s2
 668:	00000097          	auipc	ra,0x0
 66c:	daa080e7          	jalr	-598(ra) # 412 <write>
  putc_index[fd] = 0;
 670:	3204a023          	sw	zero,800(s1)
}
 674:	60e2                	ld	ra,24(sp)
 676:	6442                	ld	s0,16(sp)
 678:	64a2                	ld	s1,8(sp)
 67a:	6902                	ld	s2,0(sp)
 67c:	6105                	addi	sp,sp,32
 67e:	8082                	ret

0000000000000680 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 680:	7119                	addi	sp,sp,-128
 682:	fc86                	sd	ra,120(sp)
 684:	f8a2                	sd	s0,112(sp)
 686:	f4a6                	sd	s1,104(sp)
 688:	f0ca                	sd	s2,96(sp)
 68a:	ecce                	sd	s3,88(sp)
 68c:	e8d2                	sd	s4,80(sp)
 68e:	e4d6                	sd	s5,72(sp)
 690:	e0da                	sd	s6,64(sp)
 692:	fc5e                	sd	s7,56(sp)
 694:	f862                	sd	s8,48(sp)
 696:	f466                	sd	s9,40(sp)
 698:	f06a                	sd	s10,32(sp)
 69a:	ec6e                	sd	s11,24(sp)
 69c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 69e:	0005c483          	lbu	s1,0(a1)
 6a2:	18048d63          	beqz	s1,83c <vprintf+0x1bc>
 6a6:	8aaa                	mv	s5,a0
 6a8:	8b32                	mv	s6,a2
 6aa:	00158913          	addi	s2,a1,1
  state = 0;
 6ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6b0:	02500a13          	li	s4,37
      if(c == 'd'){
 6b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6b8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6bc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6c0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c4:	00000b97          	auipc	s7,0x0
 6c8:	3b4b8b93          	addi	s7,s7,948 # a78 <digits>
 6cc:	a839                	j	6ea <vprintf+0x6a>
        putc(fd, c);
 6ce:	85a6                	mv	a1,s1
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	e36080e7          	jalr	-458(ra) # 508 <putc>
 6da:	a019                	j	6e0 <vprintf+0x60>
    } else if(state == '%'){
 6dc:	01498f63          	beq	s3,s4,6fa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6e0:	0905                	addi	s2,s2,1
 6e2:	fff94483          	lbu	s1,-1(s2)
 6e6:	14048b63          	beqz	s1,83c <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 6ea:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6ee:	fe0997e3          	bnez	s3,6dc <vprintf+0x5c>
      if(c == '%'){
 6f2:	fd479ee3          	bne	a5,s4,6ce <vprintf+0x4e>
        state = '%';
 6f6:	89be                	mv	s3,a5
 6f8:	b7e5                	j	6e0 <vprintf+0x60>
      if(c == 'd'){
 6fa:	05878063          	beq	a5,s8,73a <vprintf+0xba>
      } else if(c == 'l') {
 6fe:	05978c63          	beq	a5,s9,756 <vprintf+0xd6>
      } else if(c == 'x') {
 702:	07a78863          	beq	a5,s10,772 <vprintf+0xf2>
      } else if(c == 'p') {
 706:	09b78463          	beq	a5,s11,78e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 70a:	07300713          	li	a4,115
 70e:	0ce78563          	beq	a5,a4,7d8 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 712:	06300713          	li	a4,99
 716:	0ee78c63          	beq	a5,a4,80e <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 71a:	11478663          	beq	a5,s4,826 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 71e:	85d2                	mv	a1,s4
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	de6080e7          	jalr	-538(ra) # 508 <putc>
        putc(fd, c);
 72a:	85a6                	mv	a1,s1
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	dda080e7          	jalr	-550(ra) # 508 <putc>
      }
      state = 0;
 736:	4981                	li	s3,0
 738:	b765                	j	6e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 73a:	008b0493          	addi	s1,s6,8
 73e:	4685                	li	a3,1
 740:	4629                	li	a2,10
 742:	000b2583          	lw	a1,0(s6)
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	e46080e7          	jalr	-442(ra) # 58e <printint>
 750:	8b26                	mv	s6,s1
      state = 0;
 752:	4981                	li	s3,0
 754:	b771                	j	6e0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 756:	008b0493          	addi	s1,s6,8
 75a:	4681                	li	a3,0
 75c:	4629                	li	a2,10
 75e:	000b2583          	lw	a1,0(s6)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	e2a080e7          	jalr	-470(ra) # 58e <printint>
 76c:	8b26                	mv	s6,s1
      state = 0;
 76e:	4981                	li	s3,0
 770:	bf85                	j	6e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 772:	008b0493          	addi	s1,s6,8
 776:	4681                	li	a3,0
 778:	4641                	li	a2,16
 77a:	000b2583          	lw	a1,0(s6)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e0e080e7          	jalr	-498(ra) # 58e <printint>
 788:	8b26                	mv	s6,s1
      state = 0;
 78a:	4981                	li	s3,0
 78c:	bf91                	j	6e0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 78e:	008b0793          	addi	a5,s6,8
 792:	f8f43423          	sd	a5,-120(s0)
 796:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 79a:	03000593          	li	a1,48
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	d68080e7          	jalr	-664(ra) # 508 <putc>
  putc(fd, 'x');
 7a8:	85ea                	mv	a1,s10
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	d5c080e7          	jalr	-676(ra) # 508 <putc>
 7b4:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b6:	03c9d793          	srli	a5,s3,0x3c
 7ba:	97de                	add	a5,a5,s7
 7bc:	0007c583          	lbu	a1,0(a5)
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	d46080e7          	jalr	-698(ra) # 508 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ca:	0992                	slli	s3,s3,0x4
 7cc:	34fd                	addiw	s1,s1,-1
 7ce:	f4e5                	bnez	s1,7b6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7d0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b729                	j	6e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7d8:	008b0993          	addi	s3,s6,8
 7dc:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 7e0:	c085                	beqz	s1,800 <vprintf+0x180>
        while(*s != 0){
 7e2:	0004c583          	lbu	a1,0(s1)
 7e6:	c9a1                	beqz	a1,836 <vprintf+0x1b6>
          putc(fd, *s);
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	d1e080e7          	jalr	-738(ra) # 508 <putc>
          s++;
 7f2:	0485                	addi	s1,s1,1
        while(*s != 0){
 7f4:	0004c583          	lbu	a1,0(s1)
 7f8:	f9e5                	bnez	a1,7e8 <vprintf+0x168>
        s = va_arg(ap, char*);
 7fa:	8b4e                	mv	s6,s3
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	b5cd                	j	6e0 <vprintf+0x60>
          s = "(null)";
 800:	00000497          	auipc	s1,0x0
 804:	29048493          	addi	s1,s1,656 # a90 <digits+0x18>
        while(*s != 0){
 808:	02800593          	li	a1,40
 80c:	bff1                	j	7e8 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 80e:	008b0493          	addi	s1,s6,8
 812:	000b4583          	lbu	a1,0(s6)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	cf0080e7          	jalr	-784(ra) # 508 <putc>
 820:	8b26                	mv	s6,s1
      state = 0;
 822:	4981                	li	s3,0
 824:	bd75                	j	6e0 <vprintf+0x60>
        putc(fd, c);
 826:	85d2                	mv	a1,s4
 828:	8556                	mv	a0,s5
 82a:	00000097          	auipc	ra,0x0
 82e:	cde080e7          	jalr	-802(ra) # 508 <putc>
      state = 0;
 832:	4981                	li	s3,0
 834:	b575                	j	6e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 836:	8b4e                	mv	s6,s3
      state = 0;
 838:	4981                	li	s3,0
 83a:	b55d                	j	6e0 <vprintf+0x60>
    }
  }
}
 83c:	70e6                	ld	ra,120(sp)
 83e:	7446                	ld	s0,112(sp)
 840:	74a6                	ld	s1,104(sp)
 842:	7906                	ld	s2,96(sp)
 844:	69e6                	ld	s3,88(sp)
 846:	6a46                	ld	s4,80(sp)
 848:	6aa6                	ld	s5,72(sp)
 84a:	6b06                	ld	s6,64(sp)
 84c:	7be2                	ld	s7,56(sp)
 84e:	7c42                	ld	s8,48(sp)
 850:	7ca2                	ld	s9,40(sp)
 852:	7d02                	ld	s10,32(sp)
 854:	6de2                	ld	s11,24(sp)
 856:	6109                	addi	sp,sp,128
 858:	8082                	ret

000000000000085a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 85a:	715d                	addi	sp,sp,-80
 85c:	ec06                	sd	ra,24(sp)
 85e:	e822                	sd	s0,16(sp)
 860:	1000                	addi	s0,sp,32
 862:	e010                	sd	a2,0(s0)
 864:	e414                	sd	a3,8(s0)
 866:	e818                	sd	a4,16(s0)
 868:	ec1c                	sd	a5,24(s0)
 86a:	03043023          	sd	a6,32(s0)
 86e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 872:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 876:	8622                	mv	a2,s0
 878:	00000097          	auipc	ra,0x0
 87c:	e08080e7          	jalr	-504(ra) # 680 <vprintf>
}
 880:	60e2                	ld	ra,24(sp)
 882:	6442                	ld	s0,16(sp)
 884:	6161                	addi	sp,sp,80
 886:	8082                	ret

0000000000000888 <printf>:

void
printf(const char *fmt, ...)
{
 888:	711d                	addi	sp,sp,-96
 88a:	ec06                	sd	ra,24(sp)
 88c:	e822                	sd	s0,16(sp)
 88e:	1000                	addi	s0,sp,32
 890:	e40c                	sd	a1,8(s0)
 892:	e810                	sd	a2,16(s0)
 894:	ec14                	sd	a3,24(s0)
 896:	f018                	sd	a4,32(s0)
 898:	f41c                	sd	a5,40(s0)
 89a:	03043823          	sd	a6,48(s0)
 89e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8a2:	00840613          	addi	a2,s0,8
 8a6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8aa:	85aa                	mv	a1,a0
 8ac:	4505                	li	a0,1
 8ae:	00000097          	auipc	ra,0x0
 8b2:	dd2080e7          	jalr	-558(ra) # 680 <vprintf>
}
 8b6:	60e2                	ld	ra,24(sp)
 8b8:	6442                	ld	s0,16(sp)
 8ba:	6125                	addi	sp,sp,96
 8bc:	8082                	ret

00000000000008be <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8be:	1141                	addi	sp,sp,-16
 8c0:	e422                	sd	s0,8(sp)
 8c2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c4:	ff050693          	addi	a3,a0,-16 # ff0 <putc_index+0x30>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c8:	00000797          	auipc	a5,0x0
 8cc:	1d078793          	addi	a5,a5,464 # a98 <__bss_start>
 8d0:	639c                	ld	a5,0(a5)
 8d2:	a805                	j	902 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8d4:	4618                	lw	a4,8(a2)
 8d6:	9db9                	addw	a1,a1,a4
 8d8:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8dc:	6398                	ld	a4,0(a5)
 8de:	6318                	ld	a4,0(a4)
 8e0:	fee53823          	sd	a4,-16(a0)
 8e4:	a091                	j	928 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8e6:	ff852703          	lw	a4,-8(a0)
 8ea:	9e39                	addw	a2,a2,a4
 8ec:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8ee:	ff053703          	ld	a4,-16(a0)
 8f2:	e398                	sd	a4,0(a5)
 8f4:	a099                	j	93a <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	6398                	ld	a4,0(a5)
 8f8:	00e7e463          	bltu	a5,a4,900 <free+0x42>
 8fc:	00e6ea63          	bltu	a3,a4,910 <free+0x52>
{
 900:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	fed7fae3          	bleu	a3,a5,8f6 <free+0x38>
 906:	6398                	ld	a4,0(a5)
 908:	00e6e463          	bltu	a3,a4,910 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	fee7eae3          	bltu	a5,a4,900 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 910:	ff852583          	lw	a1,-8(a0)
 914:	6390                	ld	a2,0(a5)
 916:	02059713          	slli	a4,a1,0x20
 91a:	9301                	srli	a4,a4,0x20
 91c:	0712                	slli	a4,a4,0x4
 91e:	9736                	add	a4,a4,a3
 920:	fae60ae3          	beq	a2,a4,8d4 <free+0x16>
    bp->s.ptr = p->s.ptr;
 924:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 928:	4790                	lw	a2,8(a5)
 92a:	02061713          	slli	a4,a2,0x20
 92e:	9301                	srli	a4,a4,0x20
 930:	0712                	slli	a4,a4,0x4
 932:	973e                	add	a4,a4,a5
 934:	fae689e3          	beq	a3,a4,8e6 <free+0x28>
  } else
    p->s.ptr = bp;
 938:	e394                	sd	a3,0(a5)
  freep = p;
 93a:	00000717          	auipc	a4,0x0
 93e:	14f73f23          	sd	a5,350(a4) # a98 <__bss_start>
}
 942:	6422                	ld	s0,8(sp)
 944:	0141                	addi	sp,sp,16
 946:	8082                	ret

0000000000000948 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 948:	7139                	addi	sp,sp,-64
 94a:	fc06                	sd	ra,56(sp)
 94c:	f822                	sd	s0,48(sp)
 94e:	f426                	sd	s1,40(sp)
 950:	f04a                	sd	s2,32(sp)
 952:	ec4e                	sd	s3,24(sp)
 954:	e852                	sd	s4,16(sp)
 956:	e456                	sd	s5,8(sp)
 958:	e05a                	sd	s6,0(sp)
 95a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 95c:	02051993          	slli	s3,a0,0x20
 960:	0209d993          	srli	s3,s3,0x20
 964:	09bd                	addi	s3,s3,15
 966:	0049d993          	srli	s3,s3,0x4
 96a:	2985                	addiw	s3,s3,1
 96c:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 970:	00000797          	auipc	a5,0x0
 974:	12878793          	addi	a5,a5,296 # a98 <__bss_start>
 978:	6388                	ld	a0,0(a5)
 97a:	c515                	beqz	a0,9a6 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 97e:	4798                	lw	a4,8(a5)
 980:	03277f63          	bleu	s2,a4,9be <malloc+0x76>
 984:	8a4e                	mv	s4,s3
 986:	0009871b          	sext.w	a4,s3
 98a:	6685                	lui	a3,0x1
 98c:	00d77363          	bleu	a3,a4,992 <malloc+0x4a>
 990:	6a05                	lui	s4,0x1
 992:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 996:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 99a:	00000497          	auipc	s1,0x0
 99e:	0fe48493          	addi	s1,s1,254 # a98 <__bss_start>
  if(p == (char*)-1)
 9a2:	5b7d                	li	s6,-1
 9a4:	a885                	j	a14 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 9a6:	00000797          	auipc	a5,0x0
 9aa:	7aa78793          	addi	a5,a5,1962 # 1150 <base>
 9ae:	00000717          	auipc	a4,0x0
 9b2:	0ef73523          	sd	a5,234(a4) # a98 <__bss_start>
 9b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9bc:	b7e1                	j	984 <malloc+0x3c>
      if(p->s.size == nunits)
 9be:	02e90b63          	beq	s2,a4,9f4 <malloc+0xac>
        p->s.size -= nunits;
 9c2:	4137073b          	subw	a4,a4,s3
 9c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9c8:	1702                	slli	a4,a4,0x20
 9ca:	9301                	srli	a4,a4,0x20
 9cc:	0712                	slli	a4,a4,0x4
 9ce:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9d4:	00000717          	auipc	a4,0x0
 9d8:	0ca73223          	sd	a0,196(a4) # a98 <__bss_start>
      return (void*)(p + 1);
 9dc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e0:	70e2                	ld	ra,56(sp)
 9e2:	7442                	ld	s0,48(sp)
 9e4:	74a2                	ld	s1,40(sp)
 9e6:	7902                	ld	s2,32(sp)
 9e8:	69e2                	ld	s3,24(sp)
 9ea:	6a42                	ld	s4,16(sp)
 9ec:	6aa2                	ld	s5,8(sp)
 9ee:	6b02                	ld	s6,0(sp)
 9f0:	6121                	addi	sp,sp,64
 9f2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9f4:	6398                	ld	a4,0(a5)
 9f6:	e118                	sd	a4,0(a0)
 9f8:	bff1                	j	9d4 <malloc+0x8c>
  hp->s.size = nu;
 9fa:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 9fe:	0541                	addi	a0,a0,16
 a00:	00000097          	auipc	ra,0x0
 a04:	ebe080e7          	jalr	-322(ra) # 8be <free>
  return freep;
 a08:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a0a:	d979                	beqz	a0,9e0 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a0e:	4798                	lw	a4,8(a5)
 a10:	fb2777e3          	bleu	s2,a4,9be <malloc+0x76>
    if(p == freep)
 a14:	6098                	ld	a4,0(s1)
 a16:	853e                	mv	a0,a5
 a18:	fef71ae3          	bne	a4,a5,a0c <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a1c:	8552                	mv	a0,s4
 a1e:	00000097          	auipc	ra,0x0
 a22:	a5c080e7          	jalr	-1444(ra) # 47a <sbrk>
  if(p == (char*)-1)
 a26:	fd651ae3          	bne	a0,s6,9fa <malloc+0xb2>
        return 0;
 a2a:	4501                	li	a0,0
 a2c:	bf55                	j	9e0 <malloc+0x98>
