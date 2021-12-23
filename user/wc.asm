
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  2e:	00001d97          	auipc	s11,0x1
  32:	af3d8d93          	addi	s11,s11,-1293 # b21 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	a78a0a13          	addi	s4,s4,-1416 # ab0 <malloc+0xe6>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	1f0080e7          	jalr	496(ra) # 236 <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89de                	mv	s3,s7
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addiw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c85                	addiw	s9,s9,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
  6e:	016d0d3b          	addw	s10,s10,s6
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	aaa58593          	addi	a1,a1,-1366 # b20 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	40a080e7          	jalr	1034(ra) # 48c <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
  8e:	00001497          	auipc	s1,0x1
  92:	a9248493          	addi	s1,s1,-1390 # b20 <buf>
  96:	00050b1b          	sext.w	s6,a0
  9a:	fffb091b          	addiw	s2,s6,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86ea                	mv	a3,s10
  b2:	8666                	mv	a2,s9
  b4:	85e2                	mv	a1,s8
  b6:	00001517          	auipc	a0,0x1
  ba:	a1250513          	addi	a0,a0,-1518 # ac8 <malloc+0xfe>
  be:	00001097          	auipc	ra,0x1
  c2:	84c080e7          	jalr	-1972(ra) # 90a <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	9d450513          	addi	a0,a0,-1580 # ab8 <malloc+0xee>
  ec:	00001097          	auipc	ra,0x1
  f0:	81e080e7          	jalr	-2018(ra) # 90a <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	37e080e7          	jalr	894(ra) # 474 <exit>

00000000000000fe <main>:

int
main(int argc, char *argv[])
{
  fe:	7179                	addi	sp,sp,-48
 100:	f406                	sd	ra,40(sp)
 102:	f022                	sd	s0,32(sp)
 104:	ec26                	sd	s1,24(sp)
 106:	e84a                	sd	s2,16(sp)
 108:	e44e                	sd	s3,8(sp)
 10a:	e052                	sd	s4,0(sp)
 10c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 10e:	4785                	li	a5,1
 110:	04a7d763          	ble	a0,a5,15e <main+0x60>
 114:	00858493          	addi	s1,a1,8
 118:	ffe5099b          	addiw	s3,a0,-2
 11c:	1982                	slli	s3,s3,0x20
 11e:	0209d993          	srli	s3,s3,0x20
 122:	098e                	slli	s3,s3,0x3
 124:	05c1                	addi	a1,a1,16
 126:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 128:	4581                	li	a1,0
 12a:	6088                	ld	a0,0(s1)
 12c:	00000097          	auipc	ra,0x0
 130:	388080e7          	jalr	904(ra) # 4b4 <open>
 134:	892a                	mv	s2,a0
 136:	04054263          	bltz	a0,17a <main+0x7c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 13a:	608c                	ld	a1,0(s1)
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <wc>
    close(fd);
 144:	854a                	mv	a0,s2
 146:	00000097          	auipc	ra,0x0
 14a:	292080e7          	jalr	658(ra) # 3d8 <close>
  for(i = 1; i < argc; i++){
 14e:	04a1                	addi	s1,s1,8
 150:	fd349ce3          	bne	s1,s3,128 <main+0x2a>
  }
  exit(0);
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	31e080e7          	jalr	798(ra) # 474 <exit>
    wc(0, "");
 15e:	00001597          	auipc	a1,0x1
 162:	97a58593          	addi	a1,a1,-1670 # ad8 <malloc+0x10e>
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	e98080e7          	jalr	-360(ra) # 0 <wc>
    exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	302080e7          	jalr	770(ra) # 474 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 17a:	608c                	ld	a1,0(s1)
 17c:	00001517          	auipc	a0,0x1
 180:	96450513          	addi	a0,a0,-1692 # ae0 <malloc+0x116>
 184:	00000097          	auipc	ra,0x0
 188:	786080e7          	jalr	1926(ra) # 90a <printf>
      exit(1);
 18c:	4505                	li	a0,1
 18e:	00000097          	auipc	ra,0x0
 192:	2e6080e7          	jalr	742(ra) # 474 <exit>

0000000000000196 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19c:	87aa                	mv	a5,a0
 19e:	0585                	addi	a1,a1,1
 1a0:	0785                	addi	a5,a5,1
 1a2:	fff5c703          	lbu	a4,-1(a1)
 1a6:	fee78fa3          	sb	a4,-1(a5)
 1aa:	fb75                	bnez	a4,19e <strcpy+0x8>
    ;
  return os;
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	addi	sp,sp,16
 1b0:	8082                	ret

00000000000001b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b2:	1141                	addi	sp,sp,-16
 1b4:	e422                	sd	s0,8(sp)
 1b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cf91                	beqz	a5,1d8 <strcmp+0x26>
 1be:	0005c703          	lbu	a4,0(a1)
 1c2:	00f71b63          	bne	a4,a5,1d8 <strcmp+0x26>
    p++, q++;
 1c6:	0505                	addi	a0,a0,1
 1c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	c789                	beqz	a5,1d8 <strcmp+0x26>
 1d0:	0005c703          	lbu	a4,0(a1)
 1d4:	fef709e3          	beq	a4,a5,1c6 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 1d8:	0005c503          	lbu	a0,0(a1)
}
 1dc:	40a7853b          	subw	a0,a5,a0
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <strlen>:

uint
strlen(const char *s)
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	cf91                	beqz	a5,20c <strlen+0x26>
 1f2:	0505                	addi	a0,a0,1
 1f4:	87aa                	mv	a5,a0
 1f6:	4685                	li	a3,1
 1f8:	9e89                	subw	a3,a3,a0
 1fa:	00f6853b          	addw	a0,a3,a5
 1fe:	0785                	addi	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	fb7d                	bnez	a4,1fa <strlen+0x14>
    ;
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  for(n = 0; s[n]; n++)
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <strlen+0x20>

0000000000000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 216:	ce09                	beqz	a2,230 <memset+0x20>
 218:	87aa                	mv	a5,a0
 21a:	fff6071b          	addiw	a4,a2,-1
 21e:	1702                	slli	a4,a4,0x20
 220:	9301                	srli	a4,a4,0x20
 222:	0705                	addi	a4,a4,1
 224:	972a                	add	a4,a4,a0
    cdst[i] = c;
 226:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22a:	0785                	addi	a5,a5,1
 22c:	fee79de3          	bne	a5,a4,226 <memset+0x16>
  }
  return dst;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret

0000000000000236 <strchr>:

char*
strchr(const char *s, char c)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cf91                	beqz	a5,25c <strchr+0x26>
    if(*s == c)
 242:	00f58a63          	beq	a1,a5,256 <strchr+0x20>
  for(; *s; s++)
 246:	0505                	addi	a0,a0,1
 248:	00054783          	lbu	a5,0(a0)
 24c:	c781                	beqz	a5,254 <strchr+0x1e>
    if(*s == c)
 24e:	feb79ce3          	bne	a5,a1,246 <strchr+0x10>
 252:	a011                	j	256 <strchr+0x20>
      return (char*)s;
  return 0;
 254:	4501                	li	a0,0
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  return 0;
 25c:	4501                	li	a0,0
 25e:	bfe5                	j	256 <strchr+0x20>

0000000000000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	711d                	addi	sp,sp,-96
 262:	ec86                	sd	ra,88(sp)
 264:	e8a2                	sd	s0,80(sp)
 266:	e4a6                	sd	s1,72(sp)
 268:	e0ca                	sd	s2,64(sp)
 26a:	fc4e                	sd	s3,56(sp)
 26c:	f852                	sd	s4,48(sp)
 26e:	f456                	sd	s5,40(sp)
 270:	f05a                	sd	s6,32(sp)
 272:	ec5e                	sd	s7,24(sp)
 274:	1080                	addi	s0,sp,96
 276:	8baa                	mv	s7,a0
 278:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27a:	892a                	mv	s2,a0
 27c:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 27e:	4aa9                	li	s5,10
 280:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 282:	0019849b          	addiw	s1,s3,1
 286:	0344d863          	ble	s4,s1,2b6 <gets+0x56>
    cc = read(0, &c, 1);
 28a:	4605                	li	a2,1
 28c:	faf40593          	addi	a1,s0,-81
 290:	4501                	li	a0,0
 292:	00000097          	auipc	ra,0x0
 296:	1fa080e7          	jalr	506(ra) # 48c <read>
    if(cc < 1)
 29a:	00a05e63          	blez	a0,2b6 <gets+0x56>
    buf[i++] = c;
 29e:	faf44783          	lbu	a5,-81(s0)
 2a2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a6:	01578763          	beq	a5,s5,2b4 <gets+0x54>
 2aa:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 2ac:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 2ae:	fd679ae3          	bne	a5,s6,282 <gets+0x22>
 2b2:	a011                	j	2b6 <gets+0x56>
  for(i=0; i+1 < max; ){
 2b4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b6:	99de                	add	s3,s3,s7
 2b8:	00098023          	sb	zero,0(s3)
  return buf;
}
 2bc:	855e                	mv	a0,s7
 2be:	60e6                	ld	ra,88(sp)
 2c0:	6446                	ld	s0,80(sp)
 2c2:	64a6                	ld	s1,72(sp)
 2c4:	6906                	ld	s2,64(sp)
 2c6:	79e2                	ld	s3,56(sp)
 2c8:	7a42                	ld	s4,48(sp)
 2ca:	7aa2                	ld	s5,40(sp)
 2cc:	7b02                	ld	s6,32(sp)
 2ce:	6be2                	ld	s7,24(sp)
 2d0:	6125                	addi	sp,sp,96
 2d2:	8082                	ret

00000000000002d4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2da:	00054683          	lbu	a3,0(a0)
 2de:	fd06879b          	addiw	a5,a3,-48
 2e2:	0ff7f793          	andi	a5,a5,255
 2e6:	4725                	li	a4,9
 2e8:	02f76963          	bltu	a4,a5,31a <atoi+0x46>
 2ec:	862a                	mv	a2,a0
  n = 0;
 2ee:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2f0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2f2:	0605                	addi	a2,a2,1
 2f4:	0025179b          	slliw	a5,a0,0x2
 2f8:	9fa9                	addw	a5,a5,a0
 2fa:	0017979b          	slliw	a5,a5,0x1
 2fe:	9fb5                	addw	a5,a5,a3
 300:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 304:	00064683          	lbu	a3,0(a2)
 308:	fd06871b          	addiw	a4,a3,-48
 30c:	0ff77713          	andi	a4,a4,255
 310:	fee5f1e3          	bleu	a4,a1,2f2 <atoi+0x1e>
  return n;
}
 314:	6422                	ld	s0,8(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret
  n = 0;
 31a:	4501                	li	a0,0
 31c:	bfe5                	j	314 <atoi+0x40>

000000000000031e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 31e:	1141                	addi	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 324:	02b57663          	bleu	a1,a0,350 <memmove+0x32>
    while(n-- > 0)
 328:	02c05163          	blez	a2,34a <memmove+0x2c>
 32c:	fff6079b          	addiw	a5,a2,-1
 330:	1782                	slli	a5,a5,0x20
 332:	9381                	srli	a5,a5,0x20
 334:	0785                	addi	a5,a5,1
 336:	97aa                	add	a5,a5,a0
  dst = vdst;
 338:	872a                	mv	a4,a0
      *dst++ = *src++;
 33a:	0585                	addi	a1,a1,1
 33c:	0705                	addi	a4,a4,1
 33e:	fff5c683          	lbu	a3,-1(a1)
 342:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 346:	fee79ae3          	bne	a5,a4,33a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
    dst += n;
 350:	00c50733          	add	a4,a0,a2
    src += n;
 354:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 356:	fec05ae3          	blez	a2,34a <memmove+0x2c>
 35a:	fff6079b          	addiw	a5,a2,-1
 35e:	1782                	slli	a5,a5,0x20
 360:	9381                	srli	a5,a5,0x20
 362:	fff7c793          	not	a5,a5
 366:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 368:	15fd                	addi	a1,a1,-1
 36a:	177d                	addi	a4,a4,-1
 36c:	0005c683          	lbu	a3,0(a1)
 370:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 374:	fef71ae3          	bne	a4,a5,368 <memmove+0x4a>
 378:	bfc9                	j	34a <memmove+0x2c>

000000000000037a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 37a:	1141                	addi	sp,sp,-16
 37c:	e422                	sd	s0,8(sp)
 37e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 380:	ce15                	beqz	a2,3bc <memcmp+0x42>
 382:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 386:	00054783          	lbu	a5,0(a0)
 38a:	0005c703          	lbu	a4,0(a1)
 38e:	02e79063          	bne	a5,a4,3ae <memcmp+0x34>
 392:	1682                	slli	a3,a3,0x20
 394:	9281                	srli	a3,a3,0x20
 396:	0685                	addi	a3,a3,1
 398:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 39a:	0505                	addi	a0,a0,1
    p2++;
 39c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 39e:	00d50d63          	beq	a0,a3,3b8 <memcmp+0x3e>
    if (*p1 != *p2) {
 3a2:	00054783          	lbu	a5,0(a0)
 3a6:	0005c703          	lbu	a4,0(a1)
 3aa:	fee788e3          	beq	a5,a4,39a <memcmp+0x20>
      return *p1 - *p2;
 3ae:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <memcmp+0x38>
 3bc:	4501                	li	a0,0
 3be:	bfd5                	j	3b2 <memcmp+0x38>

00000000000003c0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e406                	sd	ra,8(sp)
 3c4:	e022                	sd	s0,0(sp)
 3c6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3c8:	00000097          	auipc	ra,0x0
 3cc:	f56080e7          	jalr	-170(ra) # 31e <memmove>
}
 3d0:	60a2                	ld	ra,8(sp)
 3d2:	6402                	ld	s0,0(sp)
 3d4:	0141                	addi	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <close>:

int close(int fd){
 3d8:	1101                	addi	sp,sp,-32
 3da:	ec06                	sd	ra,24(sp)
 3dc:	e822                	sd	s0,16(sp)
 3de:	e426                	sd	s1,8(sp)
 3e0:	1000                	addi	s0,sp,32
 3e2:	84aa                	mv	s1,a0
  fflush(fd);
 3e4:	00000097          	auipc	ra,0x0
 3e8:	2da080e7          	jalr	730(ra) # 6be <fflush>
  char* buf = get_putc_buf(fd);
 3ec:	8526                	mv	a0,s1
 3ee:	00000097          	auipc	ra,0x0
 3f2:	14e080e7          	jalr	334(ra) # 53c <get_putc_buf>
  if(buf){
 3f6:	cd11                	beqz	a0,412 <close+0x3a>
    free(buf);
 3f8:	00000097          	auipc	ra,0x0
 3fc:	548080e7          	jalr	1352(ra) # 940 <free>
    putc_buf[fd] = 0;
 400:	00349713          	slli	a4,s1,0x3
 404:	00001797          	auipc	a5,0x1
 408:	91c78793          	addi	a5,a5,-1764 # d20 <putc_buf>
 40c:	97ba                	add	a5,a5,a4
 40e:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 412:	8526                	mv	a0,s1
 414:	00000097          	auipc	ra,0x0
 418:	088080e7          	jalr	136(ra) # 49c <sclose>
}
 41c:	60e2                	ld	ra,24(sp)
 41e:	6442                	ld	s0,16(sp)
 420:	64a2                	ld	s1,8(sp)
 422:	6105                	addi	sp,sp,32
 424:	8082                	ret

0000000000000426 <stat>:
{
 426:	1101                	addi	sp,sp,-32
 428:	ec06                	sd	ra,24(sp)
 42a:	e822                	sd	s0,16(sp)
 42c:	e426                	sd	s1,8(sp)
 42e:	e04a                	sd	s2,0(sp)
 430:	1000                	addi	s0,sp,32
 432:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 434:	4581                	li	a1,0
 436:	00000097          	auipc	ra,0x0
 43a:	07e080e7          	jalr	126(ra) # 4b4 <open>
  if(fd < 0)
 43e:	02054563          	bltz	a0,468 <stat+0x42>
 442:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 444:	85ca                	mv	a1,s2
 446:	00000097          	auipc	ra,0x0
 44a:	086080e7          	jalr	134(ra) # 4cc <fstat>
 44e:	892a                	mv	s2,a0
  close(fd);
 450:	8526                	mv	a0,s1
 452:	00000097          	auipc	ra,0x0
 456:	f86080e7          	jalr	-122(ra) # 3d8 <close>
}
 45a:	854a                	mv	a0,s2
 45c:	60e2                	ld	ra,24(sp)
 45e:	6442                	ld	s0,16(sp)
 460:	64a2                	ld	s1,8(sp)
 462:	6902                	ld	s2,0(sp)
 464:	6105                	addi	sp,sp,32
 466:	8082                	ret
    return -1;
 468:	597d                	li	s2,-1
 46a:	bfc5                	j	45a <stat+0x34>

000000000000046c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 46c:	4885                	li	a7,1
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <exit>:
.global exit
exit:
 li a7, SYS_exit
 474:	4889                	li	a7,2
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <wait>:
.global wait
wait:
 li a7, SYS_wait
 47c:	488d                	li	a7,3
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 484:	4891                	li	a7,4
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <read>:
.global read
read:
 li a7, SYS_read
 48c:	4895                	li	a7,5
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <write>:
.global write
write:
 li a7, SYS_write
 494:	48c1                	li	a7,16
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 49c:	48d5                	li	a7,21
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a4:	4899                	li	a7,6
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ac:	489d                	li	a7,7
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <open>:
.global open
open:
 li a7, SYS_open
 4b4:	48bd                	li	a7,15
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4bc:	48c5                	li	a7,17
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c4:	48c9                	li	a7,18
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4cc:	48a1                	li	a7,8
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <link>:
.global link
link:
 li a7, SYS_link
 4d4:	48cd                	li	a7,19
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4dc:	48d1                	li	a7,20
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e4:	48a5                	li	a7,9
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ec:	48a9                	li	a7,10
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f4:	48ad                	li	a7,11
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4fc:	48b1                	li	a7,12
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 504:	48b5                	li	a7,13
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 50c:	48b9                	li	a7,14
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 514:	48d9                	li	a7,22
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <nice>:
.global nice
nice:
 li a7, SYS_nice
 51c:	48dd                	li	a7,23
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 524:	48e1                	li	a7,24
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 52c:	48e5                	li	a7,25
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 534:	48e9                	li	a7,26
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 53c:	1101                	addi	sp,sp,-32
 53e:	ec06                	sd	ra,24(sp)
 540:	e822                	sd	s0,16(sp)
 542:	e426                	sd	s1,8(sp)
 544:	1000                	addi	s0,sp,32
 546:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 548:	00351693          	slli	a3,a0,0x3
 54c:	00000797          	auipc	a5,0x0
 550:	7d478793          	addi	a5,a5,2004 # d20 <putc_buf>
 554:	97b6                	add	a5,a5,a3
 556:	6388                	ld	a0,0(a5)
  if(buf) {
 558:	c511                	beqz	a0,564 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 55a:	60e2                	ld	ra,24(sp)
 55c:	6442                	ld	s0,16(sp)
 55e:	64a2                	ld	s1,8(sp)
 560:	6105                	addi	sp,sp,32
 562:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 564:	6505                	lui	a0,0x1
 566:	00000097          	auipc	ra,0x0
 56a:	464080e7          	jalr	1124(ra) # 9ca <malloc>
  putc_buf[fd] = buf;
 56e:	00000797          	auipc	a5,0x0
 572:	7b278793          	addi	a5,a5,1970 # d20 <putc_buf>
 576:	00349713          	slli	a4,s1,0x3
 57a:	973e                	add	a4,a4,a5
 57c:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 57e:	00249713          	slli	a4,s1,0x2
 582:	973e                	add	a4,a4,a5
 584:	32072023          	sw	zero,800(a4)
  return buf;
 588:	bfc9                	j	55a <get_putc_buf+0x1e>

000000000000058a <putc>:

static void
putc(int fd, char c)
{
 58a:	1101                	addi	sp,sp,-32
 58c:	ec06                	sd	ra,24(sp)
 58e:	e822                	sd	s0,16(sp)
 590:	e426                	sd	s1,8(sp)
 592:	e04a                	sd	s2,0(sp)
 594:	1000                	addi	s0,sp,32
 596:	84aa                	mv	s1,a0
 598:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 59a:	00000097          	auipc	ra,0x0
 59e:	fa2080e7          	jalr	-94(ra) # 53c <get_putc_buf>
  buf[putc_index[fd]++] = c;
 5a2:	00249793          	slli	a5,s1,0x2
 5a6:	00000717          	auipc	a4,0x0
 5aa:	77a70713          	addi	a4,a4,1914 # d20 <putc_buf>
 5ae:	973e                	add	a4,a4,a5
 5b0:	32072783          	lw	a5,800(a4)
 5b4:	0017869b          	addiw	a3,a5,1
 5b8:	32d72023          	sw	a3,800(a4)
 5bc:	97aa                	add	a5,a5,a0
 5be:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 5c2:	47a9                	li	a5,10
 5c4:	02f90463          	beq	s2,a5,5ec <putc+0x62>
 5c8:	00249713          	slli	a4,s1,0x2
 5cc:	00000797          	auipc	a5,0x0
 5d0:	75478793          	addi	a5,a5,1876 # d20 <putc_buf>
 5d4:	97ba                	add	a5,a5,a4
 5d6:	3207a703          	lw	a4,800(a5)
 5da:	6785                	lui	a5,0x1
 5dc:	00f70863          	beq	a4,a5,5ec <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 5e0:	60e2                	ld	ra,24(sp)
 5e2:	6442                	ld	s0,16(sp)
 5e4:	64a2                	ld	s1,8(sp)
 5e6:	6902                	ld	s2,0(sp)
 5e8:	6105                	addi	sp,sp,32
 5ea:	8082                	ret
    write(fd, buf, putc_index[fd]);
 5ec:	00249793          	slli	a5,s1,0x2
 5f0:	00000917          	auipc	s2,0x0
 5f4:	73090913          	addi	s2,s2,1840 # d20 <putc_buf>
 5f8:	993e                	add	s2,s2,a5
 5fa:	32092603          	lw	a2,800(s2)
 5fe:	85aa                	mv	a1,a0
 600:	8526                	mv	a0,s1
 602:	00000097          	auipc	ra,0x0
 606:	e92080e7          	jalr	-366(ra) # 494 <write>
    putc_index[fd] = 0;
 60a:	32092023          	sw	zero,800(s2)
}
 60e:	bfc9                	j	5e0 <putc+0x56>

0000000000000610 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 610:	7139                	addi	sp,sp,-64
 612:	fc06                	sd	ra,56(sp)
 614:	f822                	sd	s0,48(sp)
 616:	f426                	sd	s1,40(sp)
 618:	f04a                	sd	s2,32(sp)
 61a:	ec4e                	sd	s3,24(sp)
 61c:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 61e:	c299                	beqz	a3,624 <printint+0x14>
 620:	0005cd63          	bltz	a1,63a <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 624:	2581                	sext.w	a1,a1
  neg = 0;
 626:	4301                	li	t1,0
 628:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 62c:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 62e:	2601                	sext.w	a2,a2
 630:	00000897          	auipc	a7,0x0
 634:	4c888893          	addi	a7,a7,1224 # af8 <digits>
 638:	a801                	j	648 <printint+0x38>
    x = -xx;
 63a:	40b005bb          	negw	a1,a1
 63e:	2581                	sext.w	a1,a1
    neg = 1;
 640:	4305                	li	t1,1
    x = -xx;
 642:	b7dd                	j	628 <printint+0x18>
  }while((x /= base) != 0);
 644:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 646:	8836                	mv	a6,a3
 648:	0018069b          	addiw	a3,a6,1
 64c:	02c5f7bb          	remuw	a5,a1,a2
 650:	1782                	slli	a5,a5,0x20
 652:	9381                	srli	a5,a5,0x20
 654:	97c6                	add	a5,a5,a7
 656:	0007c783          	lbu	a5,0(a5) # 1000 <putc_buf+0x2e0>
 65a:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 65e:	0705                	addi	a4,a4,1
 660:	02c5d7bb          	divuw	a5,a1,a2
 664:	fec5f0e3          	bleu	a2,a1,644 <printint+0x34>
  if(neg)
 668:	00030b63          	beqz	t1,67e <printint+0x6e>
    buf[i++] = '-';
 66c:	fd040793          	addi	a5,s0,-48
 670:	96be                	add	a3,a3,a5
 672:	02d00793          	li	a5,45
 676:	fef68823          	sb	a5,-16(a3)
 67a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 67e:	02d05963          	blez	a3,6b0 <printint+0xa0>
 682:	89aa                	mv	s3,a0
 684:	fc040793          	addi	a5,s0,-64
 688:	00d784b3          	add	s1,a5,a3
 68c:	fff78913          	addi	s2,a5,-1
 690:	9936                	add	s2,s2,a3
 692:	36fd                	addiw	a3,a3,-1
 694:	1682                	slli	a3,a3,0x20
 696:	9281                	srli	a3,a3,0x20
 698:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 69c:	fff4c583          	lbu	a1,-1(s1)
 6a0:	854e                	mv	a0,s3
 6a2:	00000097          	auipc	ra,0x0
 6a6:	ee8080e7          	jalr	-280(ra) # 58a <putc>
  while(--i >= 0)
 6aa:	14fd                	addi	s1,s1,-1
 6ac:	ff2498e3          	bne	s1,s2,69c <printint+0x8c>
}
 6b0:	70e2                	ld	ra,56(sp)
 6b2:	7442                	ld	s0,48(sp)
 6b4:	74a2                	ld	s1,40(sp)
 6b6:	7902                	ld	s2,32(sp)
 6b8:	69e2                	ld	s3,24(sp)
 6ba:	6121                	addi	sp,sp,64
 6bc:	8082                	ret

00000000000006be <fflush>:
void fflush(int fd){
 6be:	1101                	addi	sp,sp,-32
 6c0:	ec06                	sd	ra,24(sp)
 6c2:	e822                	sd	s0,16(sp)
 6c4:	e426                	sd	s1,8(sp)
 6c6:	e04a                	sd	s2,0(sp)
 6c8:	1000                	addi	s0,sp,32
 6ca:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e70080e7          	jalr	-400(ra) # 53c <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 6d4:	00291793          	slli	a5,s2,0x2
 6d8:	00000497          	auipc	s1,0x0
 6dc:	64848493          	addi	s1,s1,1608 # d20 <putc_buf>
 6e0:	94be                	add	s1,s1,a5
 6e2:	3204a603          	lw	a2,800(s1)
 6e6:	85aa                	mv	a1,a0
 6e8:	854a                	mv	a0,s2
 6ea:	00000097          	auipc	ra,0x0
 6ee:	daa080e7          	jalr	-598(ra) # 494 <write>
  putc_index[fd] = 0;
 6f2:	3204a023          	sw	zero,800(s1)
}
 6f6:	60e2                	ld	ra,24(sp)
 6f8:	6442                	ld	s0,16(sp)
 6fa:	64a2                	ld	s1,8(sp)
 6fc:	6902                	ld	s2,0(sp)
 6fe:	6105                	addi	sp,sp,32
 700:	8082                	ret

0000000000000702 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 702:	7119                	addi	sp,sp,-128
 704:	fc86                	sd	ra,120(sp)
 706:	f8a2                	sd	s0,112(sp)
 708:	f4a6                	sd	s1,104(sp)
 70a:	f0ca                	sd	s2,96(sp)
 70c:	ecce                	sd	s3,88(sp)
 70e:	e8d2                	sd	s4,80(sp)
 710:	e4d6                	sd	s5,72(sp)
 712:	e0da                	sd	s6,64(sp)
 714:	fc5e                	sd	s7,56(sp)
 716:	f862                	sd	s8,48(sp)
 718:	f466                	sd	s9,40(sp)
 71a:	f06a                	sd	s10,32(sp)
 71c:	ec6e                	sd	s11,24(sp)
 71e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 720:	0005c483          	lbu	s1,0(a1)
 724:	18048d63          	beqz	s1,8be <vprintf+0x1bc>
 728:	8aaa                	mv	s5,a0
 72a:	8b32                	mv	s6,a2
 72c:	00158913          	addi	s2,a1,1
  state = 0;
 730:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 732:	02500a13          	li	s4,37
      if(c == 'd'){
 736:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 73a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 73e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 742:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 746:	00000b97          	auipc	s7,0x0
 74a:	3b2b8b93          	addi	s7,s7,946 # af8 <digits>
 74e:	a839                	j	76c <vprintf+0x6a>
        putc(fd, c);
 750:	85a6                	mv	a1,s1
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e36080e7          	jalr	-458(ra) # 58a <putc>
 75c:	a019                	j	762 <vprintf+0x60>
    } else if(state == '%'){
 75e:	01498f63          	beq	s3,s4,77c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 762:	0905                	addi	s2,s2,1
 764:	fff94483          	lbu	s1,-1(s2)
 768:	14048b63          	beqz	s1,8be <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 76c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 770:	fe0997e3          	bnez	s3,75e <vprintf+0x5c>
      if(c == '%'){
 774:	fd479ee3          	bne	a5,s4,750 <vprintf+0x4e>
        state = '%';
 778:	89be                	mv	s3,a5
 77a:	b7e5                	j	762 <vprintf+0x60>
      if(c == 'd'){
 77c:	05878063          	beq	a5,s8,7bc <vprintf+0xba>
      } else if(c == 'l') {
 780:	05978c63          	beq	a5,s9,7d8 <vprintf+0xd6>
      } else if(c == 'x') {
 784:	07a78863          	beq	a5,s10,7f4 <vprintf+0xf2>
      } else if(c == 'p') {
 788:	09b78463          	beq	a5,s11,810 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 78c:	07300713          	li	a4,115
 790:	0ce78563          	beq	a5,a4,85a <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 794:	06300713          	li	a4,99
 798:	0ee78c63          	beq	a5,a4,890 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 79c:	11478663          	beq	a5,s4,8a8 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7a0:	85d2                	mv	a1,s4
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	de6080e7          	jalr	-538(ra) # 58a <putc>
        putc(fd, c);
 7ac:	85a6                	mv	a1,s1
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	dda080e7          	jalr	-550(ra) # 58a <putc>
      }
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	b765                	j	762 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7bc:	008b0493          	addi	s1,s6,8
 7c0:	4685                	li	a3,1
 7c2:	4629                	li	a2,10
 7c4:	000b2583          	lw	a1,0(s6)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	e46080e7          	jalr	-442(ra) # 610 <printint>
 7d2:	8b26                	mv	s6,s1
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b771                	j	762 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d8:	008b0493          	addi	s1,s6,8
 7dc:	4681                	li	a3,0
 7de:	4629                	li	a2,10
 7e0:	000b2583          	lw	a1,0(s6)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e2a080e7          	jalr	-470(ra) # 610 <printint>
 7ee:	8b26                	mv	s6,s1
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	bf85                	j	762 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7f4:	008b0493          	addi	s1,s6,8
 7f8:	4681                	li	a3,0
 7fa:	4641                	li	a2,16
 7fc:	000b2583          	lw	a1,0(s6)
 800:	8556                	mv	a0,s5
 802:	00000097          	auipc	ra,0x0
 806:	e0e080e7          	jalr	-498(ra) # 610 <printint>
 80a:	8b26                	mv	s6,s1
      state = 0;
 80c:	4981                	li	s3,0
 80e:	bf91                	j	762 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 810:	008b0793          	addi	a5,s6,8
 814:	f8f43423          	sd	a5,-120(s0)
 818:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 81c:	03000593          	li	a1,48
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	d68080e7          	jalr	-664(ra) # 58a <putc>
  putc(fd, 'x');
 82a:	85ea                	mv	a1,s10
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	d5c080e7          	jalr	-676(ra) # 58a <putc>
 836:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 838:	03c9d793          	srli	a5,s3,0x3c
 83c:	97de                	add	a5,a5,s7
 83e:	0007c583          	lbu	a1,0(a5)
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	d46080e7          	jalr	-698(ra) # 58a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 84c:	0992                	slli	s3,s3,0x4
 84e:	34fd                	addiw	s1,s1,-1
 850:	f4e5                	bnez	s1,838 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 852:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 856:	4981                	li	s3,0
 858:	b729                	j	762 <vprintf+0x60>
        s = va_arg(ap, char*);
 85a:	008b0993          	addi	s3,s6,8
 85e:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 862:	c085                	beqz	s1,882 <vprintf+0x180>
        while(*s != 0){
 864:	0004c583          	lbu	a1,0(s1)
 868:	c9a1                	beqz	a1,8b8 <vprintf+0x1b6>
          putc(fd, *s);
 86a:	8556                	mv	a0,s5
 86c:	00000097          	auipc	ra,0x0
 870:	d1e080e7          	jalr	-738(ra) # 58a <putc>
          s++;
 874:	0485                	addi	s1,s1,1
        while(*s != 0){
 876:	0004c583          	lbu	a1,0(s1)
 87a:	f9e5                	bnez	a1,86a <vprintf+0x168>
        s = va_arg(ap, char*);
 87c:	8b4e                	mv	s6,s3
      state = 0;
 87e:	4981                	li	s3,0
 880:	b5cd                	j	762 <vprintf+0x60>
          s = "(null)";
 882:	00000497          	auipc	s1,0x0
 886:	28e48493          	addi	s1,s1,654 # b10 <digits+0x18>
        while(*s != 0){
 88a:	02800593          	li	a1,40
 88e:	bff1                	j	86a <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 890:	008b0493          	addi	s1,s6,8
 894:	000b4583          	lbu	a1,0(s6)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	cf0080e7          	jalr	-784(ra) # 58a <putc>
 8a2:	8b26                	mv	s6,s1
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	bd75                	j	762 <vprintf+0x60>
        putc(fd, c);
 8a8:	85d2                	mv	a1,s4
 8aa:	8556                	mv	a0,s5
 8ac:	00000097          	auipc	ra,0x0
 8b0:	cde080e7          	jalr	-802(ra) # 58a <putc>
      state = 0;
 8b4:	4981                	li	s3,0
 8b6:	b575                	j	762 <vprintf+0x60>
        s = va_arg(ap, char*);
 8b8:	8b4e                	mv	s6,s3
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b55d                	j	762 <vprintf+0x60>
    }
  }
}
 8be:	70e6                	ld	ra,120(sp)
 8c0:	7446                	ld	s0,112(sp)
 8c2:	74a6                	ld	s1,104(sp)
 8c4:	7906                	ld	s2,96(sp)
 8c6:	69e6                	ld	s3,88(sp)
 8c8:	6a46                	ld	s4,80(sp)
 8ca:	6aa6                	ld	s5,72(sp)
 8cc:	6b06                	ld	s6,64(sp)
 8ce:	7be2                	ld	s7,56(sp)
 8d0:	7c42                	ld	s8,48(sp)
 8d2:	7ca2                	ld	s9,40(sp)
 8d4:	7d02                	ld	s10,32(sp)
 8d6:	6de2                	ld	s11,24(sp)
 8d8:	6109                	addi	sp,sp,128
 8da:	8082                	ret

00000000000008dc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8dc:	715d                	addi	sp,sp,-80
 8de:	ec06                	sd	ra,24(sp)
 8e0:	e822                	sd	s0,16(sp)
 8e2:	1000                	addi	s0,sp,32
 8e4:	e010                	sd	a2,0(s0)
 8e6:	e414                	sd	a3,8(s0)
 8e8:	e818                	sd	a4,16(s0)
 8ea:	ec1c                	sd	a5,24(s0)
 8ec:	03043023          	sd	a6,32(s0)
 8f0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8f8:	8622                	mv	a2,s0
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e08080e7          	jalr	-504(ra) # 702 <vprintf>
}
 902:	60e2                	ld	ra,24(sp)
 904:	6442                	ld	s0,16(sp)
 906:	6161                	addi	sp,sp,80
 908:	8082                	ret

000000000000090a <printf>:

void
printf(const char *fmt, ...)
{
 90a:	711d                	addi	sp,sp,-96
 90c:	ec06                	sd	ra,24(sp)
 90e:	e822                	sd	s0,16(sp)
 910:	1000                	addi	s0,sp,32
 912:	e40c                	sd	a1,8(s0)
 914:	e810                	sd	a2,16(s0)
 916:	ec14                	sd	a3,24(s0)
 918:	f018                	sd	a4,32(s0)
 91a:	f41c                	sd	a5,40(s0)
 91c:	03043823          	sd	a6,48(s0)
 920:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 924:	00840613          	addi	a2,s0,8
 928:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 92c:	85aa                	mv	a1,a0
 92e:	4505                	li	a0,1
 930:	00000097          	auipc	ra,0x0
 934:	dd2080e7          	jalr	-558(ra) # 702 <vprintf>
}
 938:	60e2                	ld	ra,24(sp)
 93a:	6442                	ld	s0,16(sp)
 93c:	6125                	addi	sp,sp,96
 93e:	8082                	ret

0000000000000940 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 940:	1141                	addi	sp,sp,-16
 942:	e422                	sd	s0,8(sp)
 944:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 946:	ff050693          	addi	a3,a0,-16 # ff0 <putc_buf+0x2d0>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94a:	00000797          	auipc	a5,0x0
 94e:	1ce78793          	addi	a5,a5,462 # b18 <__bss_start>
 952:	639c                	ld	a5,0(a5)
 954:	a805                	j	984 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 956:	4618                	lw	a4,8(a2)
 958:	9db9                	addw	a1,a1,a4
 95a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 95e:	6398                	ld	a4,0(a5)
 960:	6318                	ld	a4,0(a4)
 962:	fee53823          	sd	a4,-16(a0)
 966:	a091                	j	9aa <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 968:	ff852703          	lw	a4,-8(a0)
 96c:	9e39                	addw	a2,a2,a4
 96e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 970:	ff053703          	ld	a4,-16(a0)
 974:	e398                	sd	a4,0(a5)
 976:	a099                	j	9bc <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	6398                	ld	a4,0(a5)
 97a:	00e7e463          	bltu	a5,a4,982 <free+0x42>
 97e:	00e6ea63          	bltu	a3,a4,992 <free+0x52>
{
 982:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	fed7fae3          	bleu	a3,a5,978 <free+0x38>
 988:	6398                	ld	a4,0(a5)
 98a:	00e6e463          	bltu	a3,a4,992 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98e:	fee7eae3          	bltu	a5,a4,982 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 992:	ff852583          	lw	a1,-8(a0)
 996:	6390                	ld	a2,0(a5)
 998:	02059713          	slli	a4,a1,0x20
 99c:	9301                	srli	a4,a4,0x20
 99e:	0712                	slli	a4,a4,0x4
 9a0:	9736                	add	a4,a4,a3
 9a2:	fae60ae3          	beq	a2,a4,956 <free+0x16>
    bp->s.ptr = p->s.ptr;
 9a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9aa:	4790                	lw	a2,8(a5)
 9ac:	02061713          	slli	a4,a2,0x20
 9b0:	9301                	srli	a4,a4,0x20
 9b2:	0712                	slli	a4,a4,0x4
 9b4:	973e                	add	a4,a4,a5
 9b6:	fae689e3          	beq	a3,a4,968 <free+0x28>
  } else
    p->s.ptr = bp;
 9ba:	e394                	sd	a3,0(a5)
  freep = p;
 9bc:	00000717          	auipc	a4,0x0
 9c0:	14f73e23          	sd	a5,348(a4) # b18 <__bss_start>
}
 9c4:	6422                	ld	s0,8(sp)
 9c6:	0141                	addi	sp,sp,16
 9c8:	8082                	ret

00000000000009ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ca:	7139                	addi	sp,sp,-64
 9cc:	fc06                	sd	ra,56(sp)
 9ce:	f822                	sd	s0,48(sp)
 9d0:	f426                	sd	s1,40(sp)
 9d2:	f04a                	sd	s2,32(sp)
 9d4:	ec4e                	sd	s3,24(sp)
 9d6:	e852                	sd	s4,16(sp)
 9d8:	e456                	sd	s5,8(sp)
 9da:	e05a                	sd	s6,0(sp)
 9dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9de:	02051993          	slli	s3,a0,0x20
 9e2:	0209d993          	srli	s3,s3,0x20
 9e6:	09bd                	addi	s3,s3,15
 9e8:	0049d993          	srli	s3,s3,0x4
 9ec:	2985                	addiw	s3,s3,1
 9ee:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 9f2:	00000797          	auipc	a5,0x0
 9f6:	12678793          	addi	a5,a5,294 # b18 <__bss_start>
 9fa:	6388                	ld	a0,0(a5)
 9fc:	c515                	beqz	a0,a28 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a00:	4798                	lw	a4,8(a5)
 a02:	03277f63          	bleu	s2,a4,a40 <malloc+0x76>
 a06:	8a4e                	mv	s4,s3
 a08:	0009871b          	sext.w	a4,s3
 a0c:	6685                	lui	a3,0x1
 a0e:	00d77363          	bleu	a3,a4,a14 <malloc+0x4a>
 a12:	6a05                	lui	s4,0x1
 a14:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a18:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a1c:	00000497          	auipc	s1,0x0
 a20:	0fc48493          	addi	s1,s1,252 # b18 <__bss_start>
  if(p == (char*)-1)
 a24:	5b7d                	li	s6,-1
 a26:	a885                	j	a96 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a28:	00000797          	auipc	a5,0x0
 a2c:	7a878793          	addi	a5,a5,1960 # 11d0 <base>
 a30:	00000717          	auipc	a4,0x0
 a34:	0ef73423          	sd	a5,232(a4) # b18 <__bss_start>
 a38:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a3a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a3e:	b7e1                	j	a06 <malloc+0x3c>
      if(p->s.size == nunits)
 a40:	02e90b63          	beq	s2,a4,a76 <malloc+0xac>
        p->s.size -= nunits;
 a44:	4137073b          	subw	a4,a4,s3
 a48:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a4a:	1702                	slli	a4,a4,0x20
 a4c:	9301                	srli	a4,a4,0x20
 a4e:	0712                	slli	a4,a4,0x4
 a50:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a52:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a56:	00000717          	auipc	a4,0x0
 a5a:	0ca73123          	sd	a0,194(a4) # b18 <__bss_start>
      return (void*)(p + 1);
 a5e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a62:	70e2                	ld	ra,56(sp)
 a64:	7442                	ld	s0,48(sp)
 a66:	74a2                	ld	s1,40(sp)
 a68:	7902                	ld	s2,32(sp)
 a6a:	69e2                	ld	s3,24(sp)
 a6c:	6a42                	ld	s4,16(sp)
 a6e:	6aa2                	ld	s5,8(sp)
 a70:	6b02                	ld	s6,0(sp)
 a72:	6121                	addi	sp,sp,64
 a74:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a76:	6398                	ld	a4,0(a5)
 a78:	e118                	sd	a4,0(a0)
 a7a:	bff1                	j	a56 <malloc+0x8c>
  hp->s.size = nu;
 a7c:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a80:	0541                	addi	a0,a0,16
 a82:	00000097          	auipc	ra,0x0
 a86:	ebe080e7          	jalr	-322(ra) # 940 <free>
  return freep;
 a8a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a8c:	d979                	beqz	a0,a62 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a90:	4798                	lw	a4,8(a5)
 a92:	fb2777e3          	bleu	s2,a4,a40 <malloc+0x76>
    if(p == freep)
 a96:	6098                	ld	a4,0(s1)
 a98:	853e                	mv	a0,a5
 a9a:	fef71ae3          	bne	a4,a5,a8e <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a9e:	8552                	mv	a0,s4
 aa0:	00000097          	auipc	ra,0x0
 aa4:	a5c080e7          	jalr	-1444(ra) # 4fc <sbrk>
  if(p == (char*)-1)
 aa8:	fd651ae3          	bne	a0,s6,a7c <malloc+0xb2>
        return 0;
 aac:	4501                	li	a0,0
 aae:	bf55                	j	a62 <malloc+0x98>
