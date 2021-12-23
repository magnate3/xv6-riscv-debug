
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	e06a                	sd	s10,0(sp)
 134:	1080                	addi	s0,sp,96
 136:	89aa                	mv	s3,a0
 138:	8c2e                	mv	s8,a1
  m = 0;
 13a:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13c:	3ff00b93          	li	s7,1023
 140:	00001b17          	auipc	s6,0x1
 144:	ae8b0b13          	addi	s6,s6,-1304 # c28 <buf>
    p = buf;
 148:	8d5a                	mv	s10,s6
        *q = '\n';
 14a:	4aa9                	li	s5,10
    p = buf;
 14c:	8cda                	mv	s9,s6
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14e:	a099                	j	194 <grep+0x7a>
        *q = '\n';
 150:	01548023          	sb	s5,0(s1)
        write(1, p, q+1 - p);
 154:	00148613          	addi	a2,s1,1
 158:	4126063b          	subw	a2,a2,s2
 15c:	85ca                	mv	a1,s2
 15e:	4505                	li	a0,1
 160:	00000097          	auipc	ra,0x0
 164:	448080e7          	jalr	1096(ra) # 5a8 <write>
      p = q+1;
 168:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 16c:	45a9                	li	a1,10
 16e:	854a                	mv	a0,s2
 170:	00000097          	auipc	ra,0x0
 174:	1da080e7          	jalr	474(ra) # 34a <strchr>
 178:	84aa                	mv	s1,a0
 17a:	c919                	beqz	a0,190 <grep+0x76>
      *q = 0;
 17c:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 180:	85ca                	mv	a1,s2
 182:	854e                	mv	a0,s3
 184:	00000097          	auipc	ra,0x0
 188:	f48080e7          	jalr	-184(ra) # cc <match>
 18c:	dd71                	beqz	a0,168 <grep+0x4e>
 18e:	b7c9                	j	150 <grep+0x36>
    if(m > 0){
 190:	03404563          	bgtz	s4,1ba <grep+0xa0>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 194:	414b863b          	subw	a2,s7,s4
 198:	014b05b3          	add	a1,s6,s4
 19c:	8562                	mv	a0,s8
 19e:	00000097          	auipc	ra,0x0
 1a2:	402080e7          	jalr	1026(ra) # 5a0 <read>
 1a6:	02a05663          	blez	a0,1d2 <grep+0xb8>
    m += n;
 1aa:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1ae:	014b07b3          	add	a5,s6,s4
 1b2:	00078023          	sb	zero,0(a5)
    p = buf;
 1b6:	8966                	mv	s2,s9
    while((q = strchr(p, '\n')) != 0){
 1b8:	bf55                	j	16c <grep+0x52>
      m -= p - buf;
 1ba:	416907b3          	sub	a5,s2,s6
 1be:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1c2:	8652                	mv	a2,s4
 1c4:	85ca                	mv	a1,s2
 1c6:	856a                	mv	a0,s10
 1c8:	00000097          	auipc	ra,0x0
 1cc:	26a080e7          	jalr	618(ra) # 432 <memmove>
 1d0:	b7d1                	j	194 <grep+0x7a>
}
 1d2:	60e6                	ld	ra,88(sp)
 1d4:	6446                	ld	s0,80(sp)
 1d6:	64a6                	ld	s1,72(sp)
 1d8:	6906                	ld	s2,64(sp)
 1da:	79e2                	ld	s3,56(sp)
 1dc:	7a42                	ld	s4,48(sp)
 1de:	7aa2                	ld	s5,40(sp)
 1e0:	7b02                	ld	s6,32(sp)
 1e2:	6be2                	ld	s7,24(sp)
 1e4:	6c42                	ld	s8,16(sp)
 1e6:	6ca2                	ld	s9,8(sp)
 1e8:	6d02                	ld	s10,0(sp)
 1ea:	6125                	addi	sp,sp,96
 1ec:	8082                	ret

00000000000001ee <main>:
{
 1ee:	7139                	addi	sp,sp,-64
 1f0:	fc06                	sd	ra,56(sp)
 1f2:	f822                	sd	s0,48(sp)
 1f4:	f426                	sd	s1,40(sp)
 1f6:	f04a                	sd	s2,32(sp)
 1f8:	ec4e                	sd	s3,24(sp)
 1fa:	e852                	sd	s4,16(sp)
 1fc:	e456                	sd	s5,8(sp)
 1fe:	0080                	addi	s0,sp,64
  if(argc <= 1){
 200:	4785                	li	a5,1
 202:	04a7dd63          	ble	a0,a5,25c <main+0x6e>
  pattern = argv[1];
 206:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 20a:	4789                	li	a5,2
 20c:	06a7d663          	ble	a0,a5,278 <main+0x8a>
 210:	01058493          	addi	s1,a1,16
 214:	ffd5099b          	addiw	s3,a0,-3
 218:	1982                	slli	s3,s3,0x20
 21a:	0209d993          	srli	s3,s3,0x20
 21e:	098e                	slli	s3,s3,0x3
 220:	05e1                	addi	a1,a1,24
 222:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 224:	4581                	li	a1,0
 226:	6088                	ld	a0,0(s1)
 228:	00000097          	auipc	ra,0x0
 22c:	3a0080e7          	jalr	928(ra) # 5c8 <open>
 230:	892a                	mv	s2,a0
 232:	04054e63          	bltz	a0,28e <main+0xa0>
    grep(pattern, fd);
 236:	85aa                	mv	a1,a0
 238:	8552                	mv	a0,s4
 23a:	00000097          	auipc	ra,0x0
 23e:	ee0080e7          	jalr	-288(ra) # 11a <grep>
    close(fd);
 242:	854a                	mv	a0,s2
 244:	00000097          	auipc	ra,0x0
 248:	2a8080e7          	jalr	680(ra) # 4ec <close>
  for(i = 2; i < argc; i++){
 24c:	04a1                	addi	s1,s1,8
 24e:	fd349be3          	bne	s1,s3,224 <main+0x36>
  exit(0);
 252:	4501                	li	a0,0
 254:	00000097          	auipc	ra,0x0
 258:	334080e7          	jalr	820(ra) # 588 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25c:	00001597          	auipc	a1,0x1
 260:	96c58593          	addi	a1,a1,-1684 # bc8 <malloc+0xea>
 264:	4509                	li	a0,2
 266:	00000097          	auipc	ra,0x0
 26a:	78a080e7          	jalr	1930(ra) # 9f0 <fprintf>
    exit(1);
 26e:	4505                	li	a0,1
 270:	00000097          	auipc	ra,0x0
 274:	318080e7          	jalr	792(ra) # 588 <exit>
    grep(pattern, 0);
 278:	4581                	li	a1,0
 27a:	8552                	mv	a0,s4
 27c:	00000097          	auipc	ra,0x0
 280:	e9e080e7          	jalr	-354(ra) # 11a <grep>
    exit(0);
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	302080e7          	jalr	770(ra) # 588 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28e:	608c                	ld	a1,0(s1)
 290:	00001517          	auipc	a0,0x1
 294:	95850513          	addi	a0,a0,-1704 # be8 <malloc+0x10a>
 298:	00000097          	auipc	ra,0x0
 29c:	786080e7          	jalr	1926(ra) # a1e <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	2e6080e7          	jalr	742(ra) # 588 <exit>

00000000000002aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b0:	87aa                	mv	a5,a0
 2b2:	0585                	addi	a1,a1,1
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcpy+0x8>
    ;
  return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf91                	beqz	a5,2ec <strcmp+0x26>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71b63          	bne	a4,a5,2ec <strcmp+0x26>
    p++, q++;
 2da:	0505                	addi	a0,a0,1
 2dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	c789                	beqz	a5,2ec <strcmp+0x26>
 2e4:	0005c703          	lbu	a4,0(a1)
 2e8:	fef709e3          	beq	a4,a5,2da <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 2ec:	0005c503          	lbu	a0,0(a1)
}
 2f0:	40a7853b          	subw	a0,a5,a0
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strlen>:

uint
strlen(const char *s)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 300:	00054783          	lbu	a5,0(a0)
 304:	cf91                	beqz	a5,320 <strlen+0x26>
 306:	0505                	addi	a0,a0,1
 308:	87aa                	mv	a5,a0
 30a:	4685                	li	a3,1
 30c:	9e89                	subw	a3,a3,a0
 30e:	00f6853b          	addw	a0,a3,a5
 312:	0785                	addi	a5,a5,1
 314:	fff7c703          	lbu	a4,-1(a5)
 318:	fb7d                	bnez	a4,30e <strlen+0x14>
    ;
  return n;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  for(n = 0; s[n]; n++)
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strlen+0x20>

0000000000000324 <memset>:

void*
memset(void *dst, int c, uint n)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 32a:	ce09                	beqz	a2,344 <memset+0x20>
 32c:	87aa                	mv	a5,a0
 32e:	fff6071b          	addiw	a4,a2,-1
 332:	1702                	slli	a4,a4,0x20
 334:	9301                	srli	a4,a4,0x20
 336:	0705                	addi	a4,a4,1
 338:	972a                	add	a4,a4,a0
    cdst[i] = c;
 33a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 33e:	0785                	addi	a5,a5,1
 340:	fee79de3          	bne	a5,a4,33a <memset+0x16>
  }
  return dst;
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <strchr>:

char*
strchr(const char *s, char c)
{
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 350:	00054783          	lbu	a5,0(a0)
 354:	cf91                	beqz	a5,370 <strchr+0x26>
    if(*s == c)
 356:	00f58a63          	beq	a1,a5,36a <strchr+0x20>
  for(; *s; s++)
 35a:	0505                	addi	a0,a0,1
 35c:	00054783          	lbu	a5,0(a0)
 360:	c781                	beqz	a5,368 <strchr+0x1e>
    if(*s == c)
 362:	feb79ce3          	bne	a5,a1,35a <strchr+0x10>
 366:	a011                	j	36a <strchr+0x20>
      return (char*)s;
  return 0;
 368:	4501                	li	a0,0
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <strchr+0x20>

0000000000000374 <gets>:

char*
gets(char *buf, int max)
{
 374:	711d                	addi	sp,sp,-96
 376:	ec86                	sd	ra,88(sp)
 378:	e8a2                	sd	s0,80(sp)
 37a:	e4a6                	sd	s1,72(sp)
 37c:	e0ca                	sd	s2,64(sp)
 37e:	fc4e                	sd	s3,56(sp)
 380:	f852                	sd	s4,48(sp)
 382:	f456                	sd	s5,40(sp)
 384:	f05a                	sd	s6,32(sp)
 386:	ec5e                	sd	s7,24(sp)
 388:	1080                	addi	s0,sp,96
 38a:	8baa                	mv	s7,a0
 38c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38e:	892a                	mv	s2,a0
 390:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 392:	4aa9                	li	s5,10
 394:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 396:	0019849b          	addiw	s1,s3,1
 39a:	0344d863          	ble	s4,s1,3ca <gets+0x56>
    cc = read(0, &c, 1);
 39e:	4605                	li	a2,1
 3a0:	faf40593          	addi	a1,s0,-81
 3a4:	4501                	li	a0,0
 3a6:	00000097          	auipc	ra,0x0
 3aa:	1fa080e7          	jalr	506(ra) # 5a0 <read>
    if(cc < 1)
 3ae:	00a05e63          	blez	a0,3ca <gets+0x56>
    buf[i++] = c;
 3b2:	faf44783          	lbu	a5,-81(s0)
 3b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ba:	01578763          	beq	a5,s5,3c8 <gets+0x54>
 3be:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3c0:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3c2:	fd679ae3          	bne	a5,s6,396 <gets+0x22>
 3c6:	a011                	j	3ca <gets+0x56>
  for(i=0; i+1 < max; ){
 3c8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ca:	99de                	add	s3,s3,s7
 3cc:	00098023          	sb	zero,0(s3)
  return buf;
}
 3d0:	855e                	mv	a0,s7
 3d2:	60e6                	ld	ra,88(sp)
 3d4:	6446                	ld	s0,80(sp)
 3d6:	64a6                	ld	s1,72(sp)
 3d8:	6906                	ld	s2,64(sp)
 3da:	79e2                	ld	s3,56(sp)
 3dc:	7a42                	ld	s4,48(sp)
 3de:	7aa2                	ld	s5,40(sp)
 3e0:	7b02                	ld	s6,32(sp)
 3e2:	6be2                	ld	s7,24(sp)
 3e4:	6125                	addi	sp,sp,96
 3e6:	8082                	ret

00000000000003e8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ee:	00054683          	lbu	a3,0(a0)
 3f2:	fd06879b          	addiw	a5,a3,-48
 3f6:	0ff7f793          	andi	a5,a5,255
 3fa:	4725                	li	a4,9
 3fc:	02f76963          	bltu	a4,a5,42e <atoi+0x46>
 400:	862a                	mv	a2,a0
  n = 0;
 402:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 404:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 406:	0605                	addi	a2,a2,1
 408:	0025179b          	slliw	a5,a0,0x2
 40c:	9fa9                	addw	a5,a5,a0
 40e:	0017979b          	slliw	a5,a5,0x1
 412:	9fb5                	addw	a5,a5,a3
 414:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 418:	00064683          	lbu	a3,0(a2)
 41c:	fd06871b          	addiw	a4,a3,-48
 420:	0ff77713          	andi	a4,a4,255
 424:	fee5f1e3          	bleu	a4,a1,406 <atoi+0x1e>
  return n;
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  n = 0;
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <atoi+0x40>

0000000000000432 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 438:	02b57663          	bleu	a1,a0,464 <memmove+0x32>
    while(n-- > 0)
 43c:	02c05163          	blez	a2,45e <memmove+0x2c>
 440:	fff6079b          	addiw	a5,a2,-1
 444:	1782                	slli	a5,a5,0x20
 446:	9381                	srli	a5,a5,0x20
 448:	0785                	addi	a5,a5,1
 44a:	97aa                	add	a5,a5,a0
  dst = vdst;
 44c:	872a                	mv	a4,a0
      *dst++ = *src++;
 44e:	0585                	addi	a1,a1,1
 450:	0705                	addi	a4,a4,1
 452:	fff5c683          	lbu	a3,-1(a1)
 456:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 45a:	fee79ae3          	bne	a5,a4,44e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 45e:	6422                	ld	s0,8(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret
    dst += n;
 464:	00c50733          	add	a4,a0,a2
    src += n;
 468:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 46a:	fec05ae3          	blez	a2,45e <memmove+0x2c>
 46e:	fff6079b          	addiw	a5,a2,-1
 472:	1782                	slli	a5,a5,0x20
 474:	9381                	srli	a5,a5,0x20
 476:	fff7c793          	not	a5,a5
 47a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 47c:	15fd                	addi	a1,a1,-1
 47e:	177d                	addi	a4,a4,-1
 480:	0005c683          	lbu	a3,0(a1)
 484:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 488:	fef71ae3          	bne	a4,a5,47c <memmove+0x4a>
 48c:	bfc9                	j	45e <memmove+0x2c>

000000000000048e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 494:	ce15                	beqz	a2,4d0 <memcmp+0x42>
 496:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 49a:	00054783          	lbu	a5,0(a0)
 49e:	0005c703          	lbu	a4,0(a1)
 4a2:	02e79063          	bne	a5,a4,4c2 <memcmp+0x34>
 4a6:	1682                	slli	a3,a3,0x20
 4a8:	9281                	srli	a3,a3,0x20
 4aa:	0685                	addi	a3,a3,1
 4ac:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 4ae:	0505                	addi	a0,a0,1
    p2++;
 4b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b2:	00d50d63          	beq	a0,a3,4cc <memcmp+0x3e>
    if (*p1 != *p2) {
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	0005c703          	lbu	a4,0(a1)
 4be:	fee788e3          	beq	a5,a4,4ae <memcmp+0x20>
      return *p1 - *p2;
 4c2:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret
  return 0;
 4cc:	4501                	li	a0,0
 4ce:	bfe5                	j	4c6 <memcmp+0x38>
 4d0:	4501                	li	a0,0
 4d2:	bfd5                	j	4c6 <memcmp+0x38>

00000000000004d4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4d4:	1141                	addi	sp,sp,-16
 4d6:	e406                	sd	ra,8(sp)
 4d8:	e022                	sd	s0,0(sp)
 4da:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f56080e7          	jalr	-170(ra) # 432 <memmove>
}
 4e4:	60a2                	ld	ra,8(sp)
 4e6:	6402                	ld	s0,0(sp)
 4e8:	0141                	addi	sp,sp,16
 4ea:	8082                	ret

00000000000004ec <close>:

int close(int fd){
 4ec:	1101                	addi	sp,sp,-32
 4ee:	ec06                	sd	ra,24(sp)
 4f0:	e822                	sd	s0,16(sp)
 4f2:	e426                	sd	s1,8(sp)
 4f4:	1000                	addi	s0,sp,32
 4f6:	84aa                	mv	s1,a0
  fflush(fd);
 4f8:	00000097          	auipc	ra,0x0
 4fc:	2da080e7          	jalr	730(ra) # 7d2 <fflush>
  char* buf = get_putc_buf(fd);
 500:	8526                	mv	a0,s1
 502:	00000097          	auipc	ra,0x0
 506:	14e080e7          	jalr	334(ra) # 650 <get_putc_buf>
  if(buf){
 50a:	cd11                	beqz	a0,526 <close+0x3a>
    free(buf);
 50c:	00000097          	auipc	ra,0x0
 510:	548080e7          	jalr	1352(ra) # a54 <free>
    putc_buf[fd] = 0;
 514:	00349713          	slli	a4,s1,0x3
 518:	00001797          	auipc	a5,0x1
 51c:	b1078793          	addi	a5,a5,-1264 # 1028 <putc_buf>
 520:	97ba                	add	a5,a5,a4
 522:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 526:	8526                	mv	a0,s1
 528:	00000097          	auipc	ra,0x0
 52c:	088080e7          	jalr	136(ra) # 5b0 <sclose>
}
 530:	60e2                	ld	ra,24(sp)
 532:	6442                	ld	s0,16(sp)
 534:	64a2                	ld	s1,8(sp)
 536:	6105                	addi	sp,sp,32
 538:	8082                	ret

000000000000053a <stat>:
{
 53a:	1101                	addi	sp,sp,-32
 53c:	ec06                	sd	ra,24(sp)
 53e:	e822                	sd	s0,16(sp)
 540:	e426                	sd	s1,8(sp)
 542:	e04a                	sd	s2,0(sp)
 544:	1000                	addi	s0,sp,32
 546:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 548:	4581                	li	a1,0
 54a:	00000097          	auipc	ra,0x0
 54e:	07e080e7          	jalr	126(ra) # 5c8 <open>
  if(fd < 0)
 552:	02054563          	bltz	a0,57c <stat+0x42>
 556:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 558:	85ca                	mv	a1,s2
 55a:	00000097          	auipc	ra,0x0
 55e:	086080e7          	jalr	134(ra) # 5e0 <fstat>
 562:	892a                	mv	s2,a0
  close(fd);
 564:	8526                	mv	a0,s1
 566:	00000097          	auipc	ra,0x0
 56a:	f86080e7          	jalr	-122(ra) # 4ec <close>
}
 56e:	854a                	mv	a0,s2
 570:	60e2                	ld	ra,24(sp)
 572:	6442                	ld	s0,16(sp)
 574:	64a2                	ld	s1,8(sp)
 576:	6902                	ld	s2,0(sp)
 578:	6105                	addi	sp,sp,32
 57a:	8082                	ret
    return -1;
 57c:	597d                	li	s2,-1
 57e:	bfc5                	j	56e <stat+0x34>

0000000000000580 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 580:	4885                	li	a7,1
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <exit>:
.global exit
exit:
 li a7, SYS_exit
 588:	4889                	li	a7,2
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <wait>:
.global wait
wait:
 li a7, SYS_wait
 590:	488d                	li	a7,3
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 598:	4891                	li	a7,4
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <read>:
.global read
read:
 li a7, SYS_read
 5a0:	4895                	li	a7,5
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <write>:
.global write
write:
 li a7, SYS_write
 5a8:	48c1                	li	a7,16
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 5b0:	48d5                	li	a7,21
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5b8:	4899                	li	a7,6
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5c0:	489d                	li	a7,7
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <open>:
.global open
open:
 li a7, SYS_open
 5c8:	48bd                	li	a7,15
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5d0:	48c5                	li	a7,17
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5d8:	48c9                	li	a7,18
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5e0:	48a1                	li	a7,8
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <link>:
.global link
link:
 li a7, SYS_link
 5e8:	48cd                	li	a7,19
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5f0:	48d1                	li	a7,20
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5f8:	48a5                	li	a7,9
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <dup>:
.global dup
dup:
 li a7, SYS_dup
 600:	48a9                	li	a7,10
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 608:	48ad                	li	a7,11
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 610:	48b1                	li	a7,12
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 618:	48b5                	li	a7,13
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 620:	48b9                	li	a7,14
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 628:	48d9                	li	a7,22
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <nice>:
.global nice
nice:
 li a7, SYS_nice
 630:	48dd                	li	a7,23
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 638:	48e1                	li	a7,24
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 640:	48e5                	li	a7,25
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 648:	48e9                	li	a7,26
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 650:	1101                	addi	sp,sp,-32
 652:	ec06                	sd	ra,24(sp)
 654:	e822                	sd	s0,16(sp)
 656:	e426                	sd	s1,8(sp)
 658:	1000                	addi	s0,sp,32
 65a:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 65c:	00351693          	slli	a3,a0,0x3
 660:	00001797          	auipc	a5,0x1
 664:	9c878793          	addi	a5,a5,-1592 # 1028 <putc_buf>
 668:	97b6                	add	a5,a5,a3
 66a:	6388                	ld	a0,0(a5)
  if(buf) {
 66c:	c511                	beqz	a0,678 <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 66e:	60e2                	ld	ra,24(sp)
 670:	6442                	ld	s0,16(sp)
 672:	64a2                	ld	s1,8(sp)
 674:	6105                	addi	sp,sp,32
 676:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 678:	6505                	lui	a0,0x1
 67a:	00000097          	auipc	ra,0x0
 67e:	464080e7          	jalr	1124(ra) # ade <malloc>
  putc_buf[fd] = buf;
 682:	00001797          	auipc	a5,0x1
 686:	9a678793          	addi	a5,a5,-1626 # 1028 <putc_buf>
 68a:	00349713          	slli	a4,s1,0x3
 68e:	973e                	add	a4,a4,a5
 690:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 692:	00249713          	slli	a4,s1,0x2
 696:	973e                	add	a4,a4,a5
 698:	32072023          	sw	zero,800(a4)
  return buf;
 69c:	bfc9                	j	66e <get_putc_buf+0x1e>

000000000000069e <putc>:

static void
putc(int fd, char c)
{
 69e:	1101                	addi	sp,sp,-32
 6a0:	ec06                	sd	ra,24(sp)
 6a2:	e822                	sd	s0,16(sp)
 6a4:	e426                	sd	s1,8(sp)
 6a6:	e04a                	sd	s2,0(sp)
 6a8:	1000                	addi	s0,sp,32
 6aa:	84aa                	mv	s1,a0
 6ac:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 6ae:	00000097          	auipc	ra,0x0
 6b2:	fa2080e7          	jalr	-94(ra) # 650 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 6b6:	00249793          	slli	a5,s1,0x2
 6ba:	00001717          	auipc	a4,0x1
 6be:	96e70713          	addi	a4,a4,-1682 # 1028 <putc_buf>
 6c2:	973e                	add	a4,a4,a5
 6c4:	32072783          	lw	a5,800(a4)
 6c8:	0017869b          	addiw	a3,a5,1
 6cc:	32d72023          	sw	a3,800(a4)
 6d0:	97aa                	add	a5,a5,a0
 6d2:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 6d6:	47a9                	li	a5,10
 6d8:	02f90463          	beq	s2,a5,700 <putc+0x62>
 6dc:	00249713          	slli	a4,s1,0x2
 6e0:	00001797          	auipc	a5,0x1
 6e4:	94878793          	addi	a5,a5,-1720 # 1028 <putc_buf>
 6e8:	97ba                	add	a5,a5,a4
 6ea:	3207a703          	lw	a4,800(a5)
 6ee:	6785                	lui	a5,0x1
 6f0:	00f70863          	beq	a4,a5,700 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 6f4:	60e2                	ld	ra,24(sp)
 6f6:	6442                	ld	s0,16(sp)
 6f8:	64a2                	ld	s1,8(sp)
 6fa:	6902                	ld	s2,0(sp)
 6fc:	6105                	addi	sp,sp,32
 6fe:	8082                	ret
    write(fd, buf, putc_index[fd]);
 700:	00249793          	slli	a5,s1,0x2
 704:	00001917          	auipc	s2,0x1
 708:	92490913          	addi	s2,s2,-1756 # 1028 <putc_buf>
 70c:	993e                	add	s2,s2,a5
 70e:	32092603          	lw	a2,800(s2)
 712:	85aa                	mv	a1,a0
 714:	8526                	mv	a0,s1
 716:	00000097          	auipc	ra,0x0
 71a:	e92080e7          	jalr	-366(ra) # 5a8 <write>
    putc_index[fd] = 0;
 71e:	32092023          	sw	zero,800(s2)
}
 722:	bfc9                	j	6f4 <putc+0x56>

0000000000000724 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 724:	7139                	addi	sp,sp,-64
 726:	fc06                	sd	ra,56(sp)
 728:	f822                	sd	s0,48(sp)
 72a:	f426                	sd	s1,40(sp)
 72c:	f04a                	sd	s2,32(sp)
 72e:	ec4e                	sd	s3,24(sp)
 730:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 732:	c299                	beqz	a3,738 <printint+0x14>
 734:	0005cd63          	bltz	a1,74e <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 738:	2581                	sext.w	a1,a1
  neg = 0;
 73a:	4301                	li	t1,0
 73c:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 740:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 742:	2601                	sext.w	a2,a2
 744:	00000897          	auipc	a7,0x0
 748:	4bc88893          	addi	a7,a7,1212 # c00 <digits>
 74c:	a801                	j	75c <printint+0x38>
    x = -xx;
 74e:	40b005bb          	negw	a1,a1
 752:	2581                	sext.w	a1,a1
    neg = 1;
 754:	4305                	li	t1,1
    x = -xx;
 756:	b7dd                	j	73c <printint+0x18>
  }while((x /= base) != 0);
 758:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 75a:	8836                	mv	a6,a3
 75c:	0018069b          	addiw	a3,a6,1
 760:	02c5f7bb          	remuw	a5,a1,a2
 764:	1782                	slli	a5,a5,0x20
 766:	9381                	srli	a5,a5,0x20
 768:	97c6                	add	a5,a5,a7
 76a:	0007c783          	lbu	a5,0(a5) # 1000 <buf+0x3d8>
 76e:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 772:	0705                	addi	a4,a4,1
 774:	02c5d7bb          	divuw	a5,a1,a2
 778:	fec5f0e3          	bleu	a2,a1,758 <printint+0x34>
  if(neg)
 77c:	00030b63          	beqz	t1,792 <printint+0x6e>
    buf[i++] = '-';
 780:	fd040793          	addi	a5,s0,-48
 784:	96be                	add	a3,a3,a5
 786:	02d00793          	li	a5,45
 78a:	fef68823          	sb	a5,-16(a3)
 78e:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 792:	02d05963          	blez	a3,7c4 <printint+0xa0>
 796:	89aa                	mv	s3,a0
 798:	fc040793          	addi	a5,s0,-64
 79c:	00d784b3          	add	s1,a5,a3
 7a0:	fff78913          	addi	s2,a5,-1
 7a4:	9936                	add	s2,s2,a3
 7a6:	36fd                	addiw	a3,a3,-1
 7a8:	1682                	slli	a3,a3,0x20
 7aa:	9281                	srli	a3,a3,0x20
 7ac:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 7b0:	fff4c583          	lbu	a1,-1(s1)
 7b4:	854e                	mv	a0,s3
 7b6:	00000097          	auipc	ra,0x0
 7ba:	ee8080e7          	jalr	-280(ra) # 69e <putc>
  while(--i >= 0)
 7be:	14fd                	addi	s1,s1,-1
 7c0:	ff2498e3          	bne	s1,s2,7b0 <printint+0x8c>
}
 7c4:	70e2                	ld	ra,56(sp)
 7c6:	7442                	ld	s0,48(sp)
 7c8:	74a2                	ld	s1,40(sp)
 7ca:	7902                	ld	s2,32(sp)
 7cc:	69e2                	ld	s3,24(sp)
 7ce:	6121                	addi	sp,sp,64
 7d0:	8082                	ret

00000000000007d2 <fflush>:
void fflush(int fd){
 7d2:	1101                	addi	sp,sp,-32
 7d4:	ec06                	sd	ra,24(sp)
 7d6:	e822                	sd	s0,16(sp)
 7d8:	e426                	sd	s1,8(sp)
 7da:	e04a                	sd	s2,0(sp)
 7dc:	1000                	addi	s0,sp,32
 7de:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e70080e7          	jalr	-400(ra) # 650 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 7e8:	00291793          	slli	a5,s2,0x2
 7ec:	00001497          	auipc	s1,0x1
 7f0:	83c48493          	addi	s1,s1,-1988 # 1028 <putc_buf>
 7f4:	94be                	add	s1,s1,a5
 7f6:	3204a603          	lw	a2,800(s1)
 7fa:	85aa                	mv	a1,a0
 7fc:	854a                	mv	a0,s2
 7fe:	00000097          	auipc	ra,0x0
 802:	daa080e7          	jalr	-598(ra) # 5a8 <write>
  putc_index[fd] = 0;
 806:	3204a023          	sw	zero,800(s1)
}
 80a:	60e2                	ld	ra,24(sp)
 80c:	6442                	ld	s0,16(sp)
 80e:	64a2                	ld	s1,8(sp)
 810:	6902                	ld	s2,0(sp)
 812:	6105                	addi	sp,sp,32
 814:	8082                	ret

0000000000000816 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 816:	7119                	addi	sp,sp,-128
 818:	fc86                	sd	ra,120(sp)
 81a:	f8a2                	sd	s0,112(sp)
 81c:	f4a6                	sd	s1,104(sp)
 81e:	f0ca                	sd	s2,96(sp)
 820:	ecce                	sd	s3,88(sp)
 822:	e8d2                	sd	s4,80(sp)
 824:	e4d6                	sd	s5,72(sp)
 826:	e0da                	sd	s6,64(sp)
 828:	fc5e                	sd	s7,56(sp)
 82a:	f862                	sd	s8,48(sp)
 82c:	f466                	sd	s9,40(sp)
 82e:	f06a                	sd	s10,32(sp)
 830:	ec6e                	sd	s11,24(sp)
 832:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 834:	0005c483          	lbu	s1,0(a1)
 838:	18048d63          	beqz	s1,9d2 <vprintf+0x1bc>
 83c:	8aaa                	mv	s5,a0
 83e:	8b32                	mv	s6,a2
 840:	00158913          	addi	s2,a1,1
  state = 0;
 844:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 846:	02500a13          	li	s4,37
      if(c == 'd'){
 84a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 84e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 852:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 856:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 85a:	00000b97          	auipc	s7,0x0
 85e:	3a6b8b93          	addi	s7,s7,934 # c00 <digits>
 862:	a839                	j	880 <vprintf+0x6a>
        putc(fd, c);
 864:	85a6                	mv	a1,s1
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	e36080e7          	jalr	-458(ra) # 69e <putc>
 870:	a019                	j	876 <vprintf+0x60>
    } else if(state == '%'){
 872:	01498f63          	beq	s3,s4,890 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 876:	0905                	addi	s2,s2,1
 878:	fff94483          	lbu	s1,-1(s2)
 87c:	14048b63          	beqz	s1,9d2 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 880:	0004879b          	sext.w	a5,s1
    if(state == 0){
 884:	fe0997e3          	bnez	s3,872 <vprintf+0x5c>
      if(c == '%'){
 888:	fd479ee3          	bne	a5,s4,864 <vprintf+0x4e>
        state = '%';
 88c:	89be                	mv	s3,a5
 88e:	b7e5                	j	876 <vprintf+0x60>
      if(c == 'd'){
 890:	05878063          	beq	a5,s8,8d0 <vprintf+0xba>
      } else if(c == 'l') {
 894:	05978c63          	beq	a5,s9,8ec <vprintf+0xd6>
      } else if(c == 'x') {
 898:	07a78863          	beq	a5,s10,908 <vprintf+0xf2>
      } else if(c == 'p') {
 89c:	09b78463          	beq	a5,s11,924 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8a0:	07300713          	li	a4,115
 8a4:	0ce78563          	beq	a5,a4,96e <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8a8:	06300713          	li	a4,99
 8ac:	0ee78c63          	beq	a5,a4,9a4 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8b0:	11478663          	beq	a5,s4,9bc <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8b4:	85d2                	mv	a1,s4
 8b6:	8556                	mv	a0,s5
 8b8:	00000097          	auipc	ra,0x0
 8bc:	de6080e7          	jalr	-538(ra) # 69e <putc>
        putc(fd, c);
 8c0:	85a6                	mv	a1,s1
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	dda080e7          	jalr	-550(ra) # 69e <putc>
      }
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b765                	j	876 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8d0:	008b0493          	addi	s1,s6,8
 8d4:	4685                	li	a3,1
 8d6:	4629                	li	a2,10
 8d8:	000b2583          	lw	a1,0(s6)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	e46080e7          	jalr	-442(ra) # 724 <printint>
 8e6:	8b26                	mv	s6,s1
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b771                	j	876 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ec:	008b0493          	addi	s1,s6,8
 8f0:	4681                	li	a3,0
 8f2:	4629                	li	a2,10
 8f4:	000b2583          	lw	a1,0(s6)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e2a080e7          	jalr	-470(ra) # 724 <printint>
 902:	8b26                	mv	s6,s1
      state = 0;
 904:	4981                	li	s3,0
 906:	bf85                	j	876 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 908:	008b0493          	addi	s1,s6,8
 90c:	4681                	li	a3,0
 90e:	4641                	li	a2,16
 910:	000b2583          	lw	a1,0(s6)
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	e0e080e7          	jalr	-498(ra) # 724 <printint>
 91e:	8b26                	mv	s6,s1
      state = 0;
 920:	4981                	li	s3,0
 922:	bf91                	j	876 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 924:	008b0793          	addi	a5,s6,8
 928:	f8f43423          	sd	a5,-120(s0)
 92c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 930:	03000593          	li	a1,48
 934:	8556                	mv	a0,s5
 936:	00000097          	auipc	ra,0x0
 93a:	d68080e7          	jalr	-664(ra) # 69e <putc>
  putc(fd, 'x');
 93e:	85ea                	mv	a1,s10
 940:	8556                	mv	a0,s5
 942:	00000097          	auipc	ra,0x0
 946:	d5c080e7          	jalr	-676(ra) # 69e <putc>
 94a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 94c:	03c9d793          	srli	a5,s3,0x3c
 950:	97de                	add	a5,a5,s7
 952:	0007c583          	lbu	a1,0(a5)
 956:	8556                	mv	a0,s5
 958:	00000097          	auipc	ra,0x0
 95c:	d46080e7          	jalr	-698(ra) # 69e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 960:	0992                	slli	s3,s3,0x4
 962:	34fd                	addiw	s1,s1,-1
 964:	f4e5                	bnez	s1,94c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 966:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 96a:	4981                	li	s3,0
 96c:	b729                	j	876 <vprintf+0x60>
        s = va_arg(ap, char*);
 96e:	008b0993          	addi	s3,s6,8
 972:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 976:	c085                	beqz	s1,996 <vprintf+0x180>
        while(*s != 0){
 978:	0004c583          	lbu	a1,0(s1)
 97c:	c9a1                	beqz	a1,9cc <vprintf+0x1b6>
          putc(fd, *s);
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	d1e080e7          	jalr	-738(ra) # 69e <putc>
          s++;
 988:	0485                	addi	s1,s1,1
        while(*s != 0){
 98a:	0004c583          	lbu	a1,0(s1)
 98e:	f9e5                	bnez	a1,97e <vprintf+0x168>
        s = va_arg(ap, char*);
 990:	8b4e                	mv	s6,s3
      state = 0;
 992:	4981                	li	s3,0
 994:	b5cd                	j	876 <vprintf+0x60>
          s = "(null)";
 996:	00000497          	auipc	s1,0x0
 99a:	28248493          	addi	s1,s1,642 # c18 <digits+0x18>
        while(*s != 0){
 99e:	02800593          	li	a1,40
 9a2:	bff1                	j	97e <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 9a4:	008b0493          	addi	s1,s6,8
 9a8:	000b4583          	lbu	a1,0(s6)
 9ac:	8556                	mv	a0,s5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	cf0080e7          	jalr	-784(ra) # 69e <putc>
 9b6:	8b26                	mv	s6,s1
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	bd75                	j	876 <vprintf+0x60>
        putc(fd, c);
 9bc:	85d2                	mv	a1,s4
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	cde080e7          	jalr	-802(ra) # 69e <putc>
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	b575                	j	876 <vprintf+0x60>
        s = va_arg(ap, char*);
 9cc:	8b4e                	mv	s6,s3
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	b55d                	j	876 <vprintf+0x60>
    }
  }
}
 9d2:	70e6                	ld	ra,120(sp)
 9d4:	7446                	ld	s0,112(sp)
 9d6:	74a6                	ld	s1,104(sp)
 9d8:	7906                	ld	s2,96(sp)
 9da:	69e6                	ld	s3,88(sp)
 9dc:	6a46                	ld	s4,80(sp)
 9de:	6aa6                	ld	s5,72(sp)
 9e0:	6b06                	ld	s6,64(sp)
 9e2:	7be2                	ld	s7,56(sp)
 9e4:	7c42                	ld	s8,48(sp)
 9e6:	7ca2                	ld	s9,40(sp)
 9e8:	7d02                	ld	s10,32(sp)
 9ea:	6de2                	ld	s11,24(sp)
 9ec:	6109                	addi	sp,sp,128
 9ee:	8082                	ret

00000000000009f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f0:	715d                	addi	sp,sp,-80
 9f2:	ec06                	sd	ra,24(sp)
 9f4:	e822                	sd	s0,16(sp)
 9f6:	1000                	addi	s0,sp,32
 9f8:	e010                	sd	a2,0(s0)
 9fa:	e414                	sd	a3,8(s0)
 9fc:	e818                	sd	a4,16(s0)
 9fe:	ec1c                	sd	a5,24(s0)
 a00:	03043023          	sd	a6,32(s0)
 a04:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a08:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a0c:	8622                	mv	a2,s0
 a0e:	00000097          	auipc	ra,0x0
 a12:	e08080e7          	jalr	-504(ra) # 816 <vprintf>
}
 a16:	60e2                	ld	ra,24(sp)
 a18:	6442                	ld	s0,16(sp)
 a1a:	6161                	addi	sp,sp,80
 a1c:	8082                	ret

0000000000000a1e <printf>:

void
printf(const char *fmt, ...)
{
 a1e:	711d                	addi	sp,sp,-96
 a20:	ec06                	sd	ra,24(sp)
 a22:	e822                	sd	s0,16(sp)
 a24:	1000                	addi	s0,sp,32
 a26:	e40c                	sd	a1,8(s0)
 a28:	e810                	sd	a2,16(s0)
 a2a:	ec14                	sd	a3,24(s0)
 a2c:	f018                	sd	a4,32(s0)
 a2e:	f41c                	sd	a5,40(s0)
 a30:	03043823          	sd	a6,48(s0)
 a34:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a38:	00840613          	addi	a2,s0,8
 a3c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a40:	85aa                	mv	a1,a0
 a42:	4505                	li	a0,1
 a44:	00000097          	auipc	ra,0x0
 a48:	dd2080e7          	jalr	-558(ra) # 816 <vprintf>
}
 a4c:	60e2                	ld	ra,24(sp)
 a4e:	6442                	ld	s0,16(sp)
 a50:	6125                	addi	sp,sp,96
 a52:	8082                	ret

0000000000000a54 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a54:	1141                	addi	sp,sp,-16
 a56:	e422                	sd	s0,8(sp)
 a58:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a5a:	ff050693          	addi	a3,a0,-16 # ff0 <buf+0x3c8>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5e:	00000797          	auipc	a5,0x0
 a62:	1c278793          	addi	a5,a5,450 # c20 <__bss_start>
 a66:	639c                	ld	a5,0(a5)
 a68:	a805                	j	a98 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a6a:	4618                	lw	a4,8(a2)
 a6c:	9db9                	addw	a1,a1,a4
 a6e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a72:	6398                	ld	a4,0(a5)
 a74:	6318                	ld	a4,0(a4)
 a76:	fee53823          	sd	a4,-16(a0)
 a7a:	a091                	j	abe <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7c:	ff852703          	lw	a4,-8(a0)
 a80:	9e39                	addw	a2,a2,a4
 a82:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a84:	ff053703          	ld	a4,-16(a0)
 a88:	e398                	sd	a4,0(a5)
 a8a:	a099                	j	ad0 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8c:	6398                	ld	a4,0(a5)
 a8e:	00e7e463          	bltu	a5,a4,a96 <free+0x42>
 a92:	00e6ea63          	bltu	a3,a4,aa6 <free+0x52>
{
 a96:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	fed7fae3          	bleu	a3,a5,a8c <free+0x38>
 a9c:	6398                	ld	a4,0(a5)
 a9e:	00e6e463          	bltu	a3,a4,aa6 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	fee7eae3          	bltu	a5,a4,a96 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 aa6:	ff852583          	lw	a1,-8(a0)
 aaa:	6390                	ld	a2,0(a5)
 aac:	02059713          	slli	a4,a1,0x20
 ab0:	9301                	srli	a4,a4,0x20
 ab2:	0712                	slli	a4,a4,0x4
 ab4:	9736                	add	a4,a4,a3
 ab6:	fae60ae3          	beq	a2,a4,a6a <free+0x16>
    bp->s.ptr = p->s.ptr;
 aba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 abe:	4790                	lw	a2,8(a5)
 ac0:	02061713          	slli	a4,a2,0x20
 ac4:	9301                	srli	a4,a4,0x20
 ac6:	0712                	slli	a4,a4,0x4
 ac8:	973e                	add	a4,a4,a5
 aca:	fae689e3          	beq	a3,a4,a7c <free+0x28>
  } else
    p->s.ptr = bp;
 ace:	e394                	sd	a3,0(a5)
  freep = p;
 ad0:	00000717          	auipc	a4,0x0
 ad4:	14f73823          	sd	a5,336(a4) # c20 <__bss_start>
}
 ad8:	6422                	ld	s0,8(sp)
 ada:	0141                	addi	sp,sp,16
 adc:	8082                	ret

0000000000000ade <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ade:	7139                	addi	sp,sp,-64
 ae0:	fc06                	sd	ra,56(sp)
 ae2:	f822                	sd	s0,48(sp)
 ae4:	f426                	sd	s1,40(sp)
 ae6:	f04a                	sd	s2,32(sp)
 ae8:	ec4e                	sd	s3,24(sp)
 aea:	e852                	sd	s4,16(sp)
 aec:	e456                	sd	s5,8(sp)
 aee:	e05a                	sd	s6,0(sp)
 af0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af2:	02051993          	slli	s3,a0,0x20
 af6:	0209d993          	srli	s3,s3,0x20
 afa:	09bd                	addi	s3,s3,15
 afc:	0049d993          	srli	s3,s3,0x4
 b00:	2985                	addiw	s3,s3,1
 b02:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 b06:	00000797          	auipc	a5,0x0
 b0a:	11a78793          	addi	a5,a5,282 # c20 <__bss_start>
 b0e:	6388                	ld	a0,0(a5)
 b10:	c515                	beqz	a0,b3c <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b12:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b14:	4798                	lw	a4,8(a5)
 b16:	03277f63          	bleu	s2,a4,b54 <malloc+0x76>
 b1a:	8a4e                	mv	s4,s3
 b1c:	0009871b          	sext.w	a4,s3
 b20:	6685                	lui	a3,0x1
 b22:	00d77363          	bleu	a3,a4,b28 <malloc+0x4a>
 b26:	6a05                	lui	s4,0x1
 b28:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 b2c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b30:	00000497          	auipc	s1,0x0
 b34:	0f048493          	addi	s1,s1,240 # c20 <__bss_start>
  if(p == (char*)-1)
 b38:	5b7d                	li	s6,-1
 b3a:	a885                	j	baa <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 b3c:	00001797          	auipc	a5,0x1
 b40:	99c78793          	addi	a5,a5,-1636 # 14d8 <base>
 b44:	00000717          	auipc	a4,0x0
 b48:	0cf73e23          	sd	a5,220(a4) # c20 <__bss_start>
 b4c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b4e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b52:	b7e1                	j	b1a <malloc+0x3c>
      if(p->s.size == nunits)
 b54:	02e90b63          	beq	s2,a4,b8a <malloc+0xac>
        p->s.size -= nunits;
 b58:	4137073b          	subw	a4,a4,s3
 b5c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b5e:	1702                	slli	a4,a4,0x20
 b60:	9301                	srli	a4,a4,0x20
 b62:	0712                	slli	a4,a4,0x4
 b64:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b66:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b6a:	00000717          	auipc	a4,0x0
 b6e:	0aa73b23          	sd	a0,182(a4) # c20 <__bss_start>
      return (void*)(p + 1);
 b72:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b76:	70e2                	ld	ra,56(sp)
 b78:	7442                	ld	s0,48(sp)
 b7a:	74a2                	ld	s1,40(sp)
 b7c:	7902                	ld	s2,32(sp)
 b7e:	69e2                	ld	s3,24(sp)
 b80:	6a42                	ld	s4,16(sp)
 b82:	6aa2                	ld	s5,8(sp)
 b84:	6b02                	ld	s6,0(sp)
 b86:	6121                	addi	sp,sp,64
 b88:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b8a:	6398                	ld	a4,0(a5)
 b8c:	e118                	sd	a4,0(a0)
 b8e:	bff1                	j	b6a <malloc+0x8c>
  hp->s.size = nu;
 b90:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 b94:	0541                	addi	a0,a0,16
 b96:	00000097          	auipc	ra,0x0
 b9a:	ebe080e7          	jalr	-322(ra) # a54 <free>
  return freep;
 b9e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ba0:	d979                	beqz	a0,b76 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ba4:	4798                	lw	a4,8(a5)
 ba6:	fb2777e3          	bleu	s2,a4,b54 <malloc+0x76>
    if(p == freep)
 baa:	6098                	ld	a4,0(s1)
 bac:	853e                	mv	a0,a5
 bae:	fef71ae3          	bne	a4,a5,ba2 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 bb2:	8552                	mv	a0,s4
 bb4:	00000097          	auipc	ra,0x0
 bb8:	a5c080e7          	jalr	-1444(ra) # 610 <sbrk>
  if(p == (char*)-1)
 bbc:	fd651ae3          	bne	a0,s6,b90 <malloc+0xb2>
        return 0;
 bc0:	4501                	li	a0,0
 bc2:	bf55                	j	b76 <malloc+0x98>
