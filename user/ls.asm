
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	31c080e7          	jalr	796(ra) # 32c <strlen>
  18:	1502                	slli	a0,a0,0x20
  1a:	9101                	srli	a0,a0,0x20
  1c:	9526                	add	a0,a0,s1
  1e:	02956163          	bltu	a0,s1,40 <fmtname+0x40>
  22:	00054703          	lbu	a4,0(a0)
  26:	02f00793          	li	a5,47
  2a:	00f70b63          	beq	a4,a5,40 <fmtname+0x40>
  2e:	02f00713          	li	a4,47
  32:	157d                	addi	a0,a0,-1
  34:	00956663          	bltu	a0,s1,40 <fmtname+0x40>
  38:	00054783          	lbu	a5,0(a0)
  3c:	fee79be3          	bne	a5,a4,32 <fmtname+0x32>
    ;
  p++;
  40:	00150493          	addi	s1,a0,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  44:	8526                	mv	a0,s1
  46:	00000097          	auipc	ra,0x0
  4a:	2e6080e7          	jalr	742(ra) # 32c <strlen>
  4e:	2501                	sext.w	a0,a0
  50:	47b5                	li	a5,13
  52:	00a7fa63          	bleu	a0,a5,66 <fmtname+0x66>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  56:	8526                	mv	a0,s1
  58:	70a2                	ld	ra,40(sp)
  5a:	7402                	ld	s0,32(sp)
  5c:	64e2                	ld	s1,24(sp)
  5e:	6942                	ld	s2,16(sp)
  60:	69a2                	ld	s3,8(sp)
  62:	6145                	addi	sp,sp,48
  64:	8082                	ret
  memmove(buf, p, strlen(p));
  66:	8526                	mv	a0,s1
  68:	00000097          	auipc	ra,0x0
  6c:	2c4080e7          	jalr	708(ra) # 32c <strlen>
  70:	00001917          	auipc	s2,0x1
  74:	c2090913          	addi	s2,s2,-992 # c90 <buf.1152>
  78:	0005061b          	sext.w	a2,a0
  7c:	85a6                	mv	a1,s1
  7e:	854a                	mv	a0,s2
  80:	00000097          	auipc	ra,0x0
  84:	3e4080e7          	jalr	996(ra) # 464 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	2a2080e7          	jalr	674(ra) # 32c <strlen>
  92:	0005099b          	sext.w	s3,a0
  96:	8526                	mv	a0,s1
  98:	00000097          	auipc	ra,0x0
  9c:	294080e7          	jalr	660(ra) # 32c <strlen>
  a0:	1982                	slli	s3,s3,0x20
  a2:	0209d993          	srli	s3,s3,0x20
  a6:	4639                	li	a2,14
  a8:	9e09                	subw	a2,a2,a0
  aa:	02000593          	li	a1,32
  ae:	01390533          	add	a0,s2,s3
  b2:	00000097          	auipc	ra,0x0
  b6:	2a4080e7          	jalr	676(ra) # 356 <memset>
  return buf;
  ba:	84ca                	mv	s1,s2
  bc:	bf69                	j	56 <fmtname+0x56>

00000000000000be <ls>:

void
ls(char *path)
{
  be:	d9010113          	addi	sp,sp,-624
  c2:	26113423          	sd	ra,616(sp)
  c6:	26813023          	sd	s0,608(sp)
  ca:	24913c23          	sd	s1,600(sp)
  ce:	25213823          	sd	s2,592(sp)
  d2:	25313423          	sd	s3,584(sp)
  d6:	25413023          	sd	s4,576(sp)
  da:	23513c23          	sd	s5,568(sp)
  de:	1c80                	addi	s0,sp,624
  e0:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  e2:	4581                	li	a1,0
  e4:	00000097          	auipc	ra,0x0
  e8:	516080e7          	jalr	1302(ra) # 5fa <open>
  ec:	06054f63          	bltz	a0,16a <ls+0xac>
  f0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  f2:	d9840593          	addi	a1,s0,-616
  f6:	00000097          	auipc	ra,0x0
  fa:	51c080e7          	jalr	1308(ra) # 612 <fstat>
  fe:	08054163          	bltz	a0,180 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 102:	da041783          	lh	a5,-608(s0)
 106:	0007869b          	sext.w	a3,a5
 10a:	4705                	li	a4,1
 10c:	08e68a63          	beq	a3,a4,1a0 <ls+0xe2>
 110:	4709                	li	a4,2
 112:	02e69663          	bne	a3,a4,13e <ls+0x80>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 116:	854a                	mv	a0,s2
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <fmtname>
 120:	da843703          	ld	a4,-600(s0)
 124:	d9c42683          	lw	a3,-612(s0)
 128:	da041603          	lh	a2,-608(s0)
 12c:	85aa                	mv	a1,a0
 12e:	00001517          	auipc	a0,0x1
 132:	afa50513          	addi	a0,a0,-1286 # c28 <malloc+0x118>
 136:	00001097          	auipc	ra,0x1
 13a:	91a080e7          	jalr	-1766(ra) # a50 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 13e:	8526                	mv	a0,s1
 140:	00000097          	auipc	ra,0x0
 144:	3de080e7          	jalr	990(ra) # 51e <close>
}
 148:	26813083          	ld	ra,616(sp)
 14c:	26013403          	ld	s0,608(sp)
 150:	25813483          	ld	s1,600(sp)
 154:	25013903          	ld	s2,592(sp)
 158:	24813983          	ld	s3,584(sp)
 15c:	24013a03          	ld	s4,576(sp)
 160:	23813a83          	ld	s5,568(sp)
 164:	27010113          	addi	sp,sp,624
 168:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 16a:	864a                	mv	a2,s2
 16c:	00001597          	auipc	a1,0x1
 170:	a8c58593          	addi	a1,a1,-1396 # bf8 <malloc+0xe8>
 174:	4509                	li	a0,2
 176:	00001097          	auipc	ra,0x1
 17a:	8ac080e7          	jalr	-1876(ra) # a22 <fprintf>
    return;
 17e:	b7e9                	j	148 <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 180:	864a                	mv	a2,s2
 182:	00001597          	auipc	a1,0x1
 186:	a8e58593          	addi	a1,a1,-1394 # c10 <malloc+0x100>
 18a:	4509                	li	a0,2
 18c:	00001097          	auipc	ra,0x1
 190:	896080e7          	jalr	-1898(ra) # a22 <fprintf>
    close(fd);
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	388080e7          	jalr	904(ra) # 51e <close>
    return;
 19e:	b76d                	j	148 <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	854a                	mv	a0,s2
 1a2:	00000097          	auipc	ra,0x0
 1a6:	18a080e7          	jalr	394(ra) # 32c <strlen>
 1aa:	2541                	addiw	a0,a0,16
 1ac:	20000793          	li	a5,512
 1b0:	00a7fb63          	bleu	a0,a5,1c6 <ls+0x108>
      printf("ls: path too long\n");
 1b4:	00001517          	auipc	a0,0x1
 1b8:	a8450513          	addi	a0,a0,-1404 # c38 <malloc+0x128>
 1bc:	00001097          	auipc	ra,0x1
 1c0:	894080e7          	jalr	-1900(ra) # a50 <printf>
      break;
 1c4:	bfad                	j	13e <ls+0x80>
    strcpy(buf, path);
 1c6:	85ca                	mv	a1,s2
 1c8:	dc040513          	addi	a0,s0,-576
 1cc:	00000097          	auipc	ra,0x0
 1d0:	110080e7          	jalr	272(ra) # 2dc <strcpy>
    p = buf+strlen(buf);
 1d4:	dc040513          	addi	a0,s0,-576
 1d8:	00000097          	auipc	ra,0x0
 1dc:	154080e7          	jalr	340(ra) # 32c <strlen>
 1e0:	1502                	slli	a0,a0,0x20
 1e2:	9101                	srli	a0,a0,0x20
 1e4:	dc040793          	addi	a5,s0,-576
 1e8:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1ec:	00190993          	addi	s3,s2,1
 1f0:	02f00793          	li	a5,47
 1f4:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1f8:	00001a17          	auipc	s4,0x1
 1fc:	a58a0a13          	addi	s4,s4,-1448 # c50 <malloc+0x140>
        printf("ls: cannot stat %s\n", buf);
 200:	00001a97          	auipc	s5,0x1
 204:	a10a8a93          	addi	s5,s5,-1520 # c10 <malloc+0x100>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 208:	a01d                	j	22e <ls+0x170>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 20a:	dc040513          	addi	a0,s0,-576
 20e:	00000097          	auipc	ra,0x0
 212:	df2080e7          	jalr	-526(ra) # 0 <fmtname>
 216:	da843703          	ld	a4,-600(s0)
 21a:	d9c42683          	lw	a3,-612(s0)
 21e:	da041603          	lh	a2,-608(s0)
 222:	85aa                	mv	a1,a0
 224:	8552                	mv	a0,s4
 226:	00001097          	auipc	ra,0x1
 22a:	82a080e7          	jalr	-2006(ra) # a50 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 22e:	4641                	li	a2,16
 230:	db040593          	addi	a1,s0,-592
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	39c080e7          	jalr	924(ra) # 5d2 <read>
 23e:	47c1                	li	a5,16
 240:	eef51fe3          	bne	a0,a5,13e <ls+0x80>
      if(de.inum == 0)
 244:	db045783          	lhu	a5,-592(s0)
 248:	d3fd                	beqz	a5,22e <ls+0x170>
      memmove(p, de.name, DIRSIZ);
 24a:	4639                	li	a2,14
 24c:	db240593          	addi	a1,s0,-590
 250:	854e                	mv	a0,s3
 252:	00000097          	auipc	ra,0x0
 256:	212080e7          	jalr	530(ra) # 464 <memmove>
      p[DIRSIZ] = 0;
 25a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 25e:	d9840593          	addi	a1,s0,-616
 262:	dc040513          	addi	a0,s0,-576
 266:	00000097          	auipc	ra,0x0
 26a:	306080e7          	jalr	774(ra) # 56c <stat>
 26e:	f8055ee3          	bgez	a0,20a <ls+0x14c>
        printf("ls: cannot stat %s\n", buf);
 272:	dc040593          	addi	a1,s0,-576
 276:	8556                	mv	a0,s5
 278:	00000097          	auipc	ra,0x0
 27c:	7d8080e7          	jalr	2008(ra) # a50 <printf>
        continue;
 280:	b77d                	j	22e <ls+0x170>

0000000000000282 <main>:

int
main(int argc, char *argv[])
{
 282:	1101                	addi	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 28e:	4785                	li	a5,1
 290:	02a7d963          	ble	a0,a5,2c2 <main+0x40>
 294:	00858493          	addi	s1,a1,8
 298:	ffe5091b          	addiw	s2,a0,-2
 29c:	1902                	slli	s2,s2,0x20
 29e:	02095913          	srli	s2,s2,0x20
 2a2:	090e                	slli	s2,s2,0x3
 2a4:	05c1                	addi	a1,a1,16
 2a6:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a8:	6088                	ld	a0,0(s1)
 2aa:	00000097          	auipc	ra,0x0
 2ae:	e14080e7          	jalr	-492(ra) # be <ls>
  for(i=1; i<argc; i++)
 2b2:	04a1                	addi	s1,s1,8
 2b4:	ff249ae3          	bne	s1,s2,2a8 <main+0x26>
  exit(0);
 2b8:	4501                	li	a0,0
 2ba:	00000097          	auipc	ra,0x0
 2be:	300080e7          	jalr	768(ra) # 5ba <exit>
    ls(".");
 2c2:	00001517          	auipc	a0,0x1
 2c6:	99e50513          	addi	a0,a0,-1634 # c60 <malloc+0x150>
 2ca:	00000097          	auipc	ra,0x0
 2ce:	df4080e7          	jalr	-524(ra) # be <ls>
    exit(0);
 2d2:	4501                	li	a0,0
 2d4:	00000097          	auipc	ra,0x0
 2d8:	2e6080e7          	jalr	742(ra) # 5ba <exit>

00000000000002dc <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e2:	87aa                	mv	a5,a0
 2e4:	0585                	addi	a1,a1,1
 2e6:	0785                	addi	a5,a5,1
 2e8:	fff5c703          	lbu	a4,-1(a1)
 2ec:	fee78fa3          	sb	a4,-1(a5)
 2f0:	fb75                	bnez	a4,2e4 <strcpy+0x8>
    ;
  return os;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	cf91                	beqz	a5,31e <strcmp+0x26>
 304:	0005c703          	lbu	a4,0(a1)
 308:	00f71b63          	bne	a4,a5,31e <strcmp+0x26>
    p++, q++;
 30c:	0505                	addi	a0,a0,1
 30e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 310:	00054783          	lbu	a5,0(a0)
 314:	c789                	beqz	a5,31e <strcmp+0x26>
 316:	0005c703          	lbu	a4,0(a1)
 31a:	fef709e3          	beq	a4,a5,30c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 31e:	0005c503          	lbu	a0,0(a1)
}
 322:	40a7853b          	subw	a0,a5,a0
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <strlen>:

uint
strlen(const char *s)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 332:	00054783          	lbu	a5,0(a0)
 336:	cf91                	beqz	a5,352 <strlen+0x26>
 338:	0505                	addi	a0,a0,1
 33a:	87aa                	mv	a5,a0
 33c:	4685                	li	a3,1
 33e:	9e89                	subw	a3,a3,a0
 340:	00f6853b          	addw	a0,a3,a5
 344:	0785                	addi	a5,a5,1
 346:	fff7c703          	lbu	a4,-1(a5)
 34a:	fb7d                	bnez	a4,340 <strlen+0x14>
    ;
  return n;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
  for(n = 0; s[n]; n++)
 352:	4501                	li	a0,0
 354:	bfe5                	j	34c <strlen+0x20>

0000000000000356 <memset>:

void*
memset(void *dst, int c, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 35c:	ce09                	beqz	a2,376 <memset+0x20>
 35e:	87aa                	mv	a5,a0
 360:	fff6071b          	addiw	a4,a2,-1
 364:	1702                	slli	a4,a4,0x20
 366:	9301                	srli	a4,a4,0x20
 368:	0705                	addi	a4,a4,1
 36a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 36c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 370:	0785                	addi	a5,a5,1
 372:	fee79de3          	bne	a5,a4,36c <memset+0x16>
  }
  return dst;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <strchr>:

char*
strchr(const char *s, char c)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  for(; *s; s++)
 382:	00054783          	lbu	a5,0(a0)
 386:	cf91                	beqz	a5,3a2 <strchr+0x26>
    if(*s == c)
 388:	00f58a63          	beq	a1,a5,39c <strchr+0x20>
  for(; *s; s++)
 38c:	0505                	addi	a0,a0,1
 38e:	00054783          	lbu	a5,0(a0)
 392:	c781                	beqz	a5,39a <strchr+0x1e>
    if(*s == c)
 394:	feb79ce3          	bne	a5,a1,38c <strchr+0x10>
 398:	a011                	j	39c <strchr+0x20>
      return (char*)s;
  return 0;
 39a:	4501                	li	a0,0
}
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
  return 0;
 3a2:	4501                	li	a0,0
 3a4:	bfe5                	j	39c <strchr+0x20>

00000000000003a6 <gets>:

char*
gets(char *buf, int max)
{
 3a6:	711d                	addi	sp,sp,-96
 3a8:	ec86                	sd	ra,88(sp)
 3aa:	e8a2                	sd	s0,80(sp)
 3ac:	e4a6                	sd	s1,72(sp)
 3ae:	e0ca                	sd	s2,64(sp)
 3b0:	fc4e                	sd	s3,56(sp)
 3b2:	f852                	sd	s4,48(sp)
 3b4:	f456                	sd	s5,40(sp)
 3b6:	f05a                	sd	s6,32(sp)
 3b8:	ec5e                	sd	s7,24(sp)
 3ba:	1080                	addi	s0,sp,96
 3bc:	8baa                	mv	s7,a0
 3be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c0:	892a                	mv	s2,a0
 3c2:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c4:	4aa9                	li	s5,10
 3c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3c8:	0019849b          	addiw	s1,s3,1
 3cc:	0344d863          	ble	s4,s1,3fc <gets+0x56>
    cc = read(0, &c, 1);
 3d0:	4605                	li	a2,1
 3d2:	faf40593          	addi	a1,s0,-81
 3d6:	4501                	li	a0,0
 3d8:	00000097          	auipc	ra,0x0
 3dc:	1fa080e7          	jalr	506(ra) # 5d2 <read>
    if(cc < 1)
 3e0:	00a05e63          	blez	a0,3fc <gets+0x56>
    buf[i++] = c;
 3e4:	faf44783          	lbu	a5,-81(s0)
 3e8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ec:	01578763          	beq	a5,s5,3fa <gets+0x54>
 3f0:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3f2:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3f4:	fd679ae3          	bne	a5,s6,3c8 <gets+0x22>
 3f8:	a011                	j	3fc <gets+0x56>
  for(i=0; i+1 < max; ){
 3fa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3fc:	99de                	add	s3,s3,s7
 3fe:	00098023          	sb	zero,0(s3)
  return buf;
}
 402:	855e                	mv	a0,s7
 404:	60e6                	ld	ra,88(sp)
 406:	6446                	ld	s0,80(sp)
 408:	64a6                	ld	s1,72(sp)
 40a:	6906                	ld	s2,64(sp)
 40c:	79e2                	ld	s3,56(sp)
 40e:	7a42                	ld	s4,48(sp)
 410:	7aa2                	ld	s5,40(sp)
 412:	7b02                	ld	s6,32(sp)
 414:	6be2                	ld	s7,24(sp)
 416:	6125                	addi	sp,sp,96
 418:	8082                	ret

000000000000041a <atoi>:
  return r;
}

int
atoi(const char *s)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 420:	00054683          	lbu	a3,0(a0)
 424:	fd06879b          	addiw	a5,a3,-48
 428:	0ff7f793          	andi	a5,a5,255
 42c:	4725                	li	a4,9
 42e:	02f76963          	bltu	a4,a5,460 <atoi+0x46>
 432:	862a                	mv	a2,a0
  n = 0;
 434:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 436:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 438:	0605                	addi	a2,a2,1
 43a:	0025179b          	slliw	a5,a0,0x2
 43e:	9fa9                	addw	a5,a5,a0
 440:	0017979b          	slliw	a5,a5,0x1
 444:	9fb5                	addw	a5,a5,a3
 446:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 44a:	00064683          	lbu	a3,0(a2)
 44e:	fd06871b          	addiw	a4,a3,-48
 452:	0ff77713          	andi	a4,a4,255
 456:	fee5f1e3          	bleu	a4,a1,438 <atoi+0x1e>
  return n;
}
 45a:	6422                	ld	s0,8(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret
  n = 0;
 460:	4501                	li	a0,0
 462:	bfe5                	j	45a <atoi+0x40>

0000000000000464 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 46a:	02b57663          	bleu	a1,a0,496 <memmove+0x32>
    while(n-- > 0)
 46e:	02c05163          	blez	a2,490 <memmove+0x2c>
 472:	fff6079b          	addiw	a5,a2,-1
 476:	1782                	slli	a5,a5,0x20
 478:	9381                	srli	a5,a5,0x20
 47a:	0785                	addi	a5,a5,1
 47c:	97aa                	add	a5,a5,a0
  dst = vdst;
 47e:	872a                	mv	a4,a0
      *dst++ = *src++;
 480:	0585                	addi	a1,a1,1
 482:	0705                	addi	a4,a4,1
 484:	fff5c683          	lbu	a3,-1(a1)
 488:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 48c:	fee79ae3          	bne	a5,a4,480 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret
    dst += n;
 496:	00c50733          	add	a4,a0,a2
    src += n;
 49a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 49c:	fec05ae3          	blez	a2,490 <memmove+0x2c>
 4a0:	fff6079b          	addiw	a5,a2,-1
 4a4:	1782                	slli	a5,a5,0x20
 4a6:	9381                	srli	a5,a5,0x20
 4a8:	fff7c793          	not	a5,a5
 4ac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4ae:	15fd                	addi	a1,a1,-1
 4b0:	177d                	addi	a4,a4,-1
 4b2:	0005c683          	lbu	a3,0(a1)
 4b6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ba:	fef71ae3          	bne	a4,a5,4ae <memmove+0x4a>
 4be:	bfc9                	j	490 <memmove+0x2c>

00000000000004c0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4c6:	ce15                	beqz	a2,502 <memcmp+0x42>
 4c8:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 4cc:	00054783          	lbu	a5,0(a0)
 4d0:	0005c703          	lbu	a4,0(a1)
 4d4:	02e79063          	bne	a5,a4,4f4 <memcmp+0x34>
 4d8:	1682                	slli	a3,a3,0x20
 4da:	9281                	srli	a3,a3,0x20
 4dc:	0685                	addi	a3,a3,1
 4de:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 4e0:	0505                	addi	a0,a0,1
    p2++;
 4e2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4e4:	00d50d63          	beq	a0,a3,4fe <memcmp+0x3e>
    if (*p1 != *p2) {
 4e8:	00054783          	lbu	a5,0(a0)
 4ec:	0005c703          	lbu	a4,0(a1)
 4f0:	fee788e3          	beq	a5,a4,4e0 <memcmp+0x20>
      return *p1 - *p2;
 4f4:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 4f8:	6422                	ld	s0,8(sp)
 4fa:	0141                	addi	sp,sp,16
 4fc:	8082                	ret
  return 0;
 4fe:	4501                	li	a0,0
 500:	bfe5                	j	4f8 <memcmp+0x38>
 502:	4501                	li	a0,0
 504:	bfd5                	j	4f8 <memcmp+0x38>

0000000000000506 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 506:	1141                	addi	sp,sp,-16
 508:	e406                	sd	ra,8(sp)
 50a:	e022                	sd	s0,0(sp)
 50c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 50e:	00000097          	auipc	ra,0x0
 512:	f56080e7          	jalr	-170(ra) # 464 <memmove>
}
 516:	60a2                	ld	ra,8(sp)
 518:	6402                	ld	s0,0(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret

000000000000051e <close>:

int close(int fd){
 51e:	1101                	addi	sp,sp,-32
 520:	ec06                	sd	ra,24(sp)
 522:	e822                	sd	s0,16(sp)
 524:	e426                	sd	s1,8(sp)
 526:	1000                	addi	s0,sp,32
 528:	84aa                	mv	s1,a0
  fflush(fd);
 52a:	00000097          	auipc	ra,0x0
 52e:	2da080e7          	jalr	730(ra) # 804 <fflush>
  char* buf = get_putc_buf(fd);
 532:	8526                	mv	a0,s1
 534:	00000097          	auipc	ra,0x0
 538:	14e080e7          	jalr	334(ra) # 682 <get_putc_buf>
  if(buf){
 53c:	cd11                	beqz	a0,558 <close+0x3a>
    free(buf);
 53e:	00000097          	auipc	ra,0x0
 542:	548080e7          	jalr	1352(ra) # a86 <free>
    putc_buf[fd] = 0;
 546:	00349713          	slli	a4,s1,0x3
 54a:	00000797          	auipc	a5,0x0
 54e:	75678793          	addi	a5,a5,1878 # ca0 <putc_buf>
 552:	97ba                	add	a5,a5,a4
 554:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
 558:	8526                	mv	a0,s1
 55a:	00000097          	auipc	ra,0x0
 55e:	088080e7          	jalr	136(ra) # 5e2 <sclose>
}
 562:	60e2                	ld	ra,24(sp)
 564:	6442                	ld	s0,16(sp)
 566:	64a2                	ld	s1,8(sp)
 568:	6105                	addi	sp,sp,32
 56a:	8082                	ret

000000000000056c <stat>:
{
 56c:	1101                	addi	sp,sp,-32
 56e:	ec06                	sd	ra,24(sp)
 570:	e822                	sd	s0,16(sp)
 572:	e426                	sd	s1,8(sp)
 574:	e04a                	sd	s2,0(sp)
 576:	1000                	addi	s0,sp,32
 578:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
 57a:	4581                	li	a1,0
 57c:	00000097          	auipc	ra,0x0
 580:	07e080e7          	jalr	126(ra) # 5fa <open>
  if(fd < 0)
 584:	02054563          	bltz	a0,5ae <stat+0x42>
 588:	84aa                	mv	s1,a0
  r = fstat(fd, st);
 58a:	85ca                	mv	a1,s2
 58c:	00000097          	auipc	ra,0x0
 590:	086080e7          	jalr	134(ra) # 612 <fstat>
 594:	892a                	mv	s2,a0
  close(fd);
 596:	8526                	mv	a0,s1
 598:	00000097          	auipc	ra,0x0
 59c:	f86080e7          	jalr	-122(ra) # 51e <close>
}
 5a0:	854a                	mv	a0,s2
 5a2:	60e2                	ld	ra,24(sp)
 5a4:	6442                	ld	s0,16(sp)
 5a6:	64a2                	ld	s1,8(sp)
 5a8:	6902                	ld	s2,0(sp)
 5aa:	6105                	addi	sp,sp,32
 5ac:	8082                	ret
    return -1;
 5ae:	597d                	li	s2,-1
 5b0:	bfc5                	j	5a0 <stat+0x34>

00000000000005b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b2:	4885                	li	a7,1
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ba:	4889                	li	a7,2
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c2:	488d                	li	a7,3
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ca:	4891                	li	a7,4
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <read>:
.global read
read:
 li a7, SYS_read
 5d2:	4895                	li	a7,5
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <write>:
.global write
write:
 li a7, SYS_write
 5da:	48c1                	li	a7,16
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
 5e2:	48d5                	li	a7,21
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ea:	4899                	li	a7,6
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f2:	489d                	li	a7,7
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <open>:
.global open
open:
 li a7, SYS_open
 5fa:	48bd                	li	a7,15
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 602:	48c5                	li	a7,17
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 60a:	48c9                	li	a7,18
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 612:	48a1                	li	a7,8
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <link>:
.global link
link:
 li a7, SYS_link
 61a:	48cd                	li	a7,19
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 622:	48d1                	li	a7,20
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 62a:	48a5                	li	a7,9
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <dup>:
.global dup
dup:
 li a7, SYS_dup
 632:	48a9                	li	a7,10
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 63a:	48ad                	li	a7,11
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 642:	48b1                	li	a7,12
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 64a:	48b5                	li	a7,13
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 652:	48b9                	li	a7,14
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
 65a:	48d9                	li	a7,22
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <nice>:
.global nice
nice:
 li a7, SYS_nice
 662:	48dd                	li	a7,23
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
 66a:	48e1                	li	a7,24
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
 672:	48e5                	li	a7,25
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
 67a:	48e9                	li	a7,26
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
 682:	1101                	addi	sp,sp,-32
 684:	ec06                	sd	ra,24(sp)
 686:	e822                	sd	s0,16(sp)
 688:	e426                	sd	s1,8(sp)
 68a:	1000                	addi	s0,sp,32
 68c:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
 68e:	00351693          	slli	a3,a0,0x3
 692:	00000797          	auipc	a5,0x0
 696:	60e78793          	addi	a5,a5,1550 # ca0 <putc_buf>
 69a:	97b6                	add	a5,a5,a3
 69c:	6388                	ld	a0,0(a5)
  if(buf) {
 69e:	c511                	beqz	a0,6aa <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
 6a0:	60e2                	ld	ra,24(sp)
 6a2:	6442                	ld	s0,16(sp)
 6a4:	64a2                	ld	s1,8(sp)
 6a6:	6105                	addi	sp,sp,32
 6a8:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
 6aa:	6505                	lui	a0,0x1
 6ac:	00000097          	auipc	ra,0x0
 6b0:	464080e7          	jalr	1124(ra) # b10 <malloc>
  putc_buf[fd] = buf;
 6b4:	00000797          	auipc	a5,0x0
 6b8:	5ec78793          	addi	a5,a5,1516 # ca0 <putc_buf>
 6bc:	00349713          	slli	a4,s1,0x3
 6c0:	973e                	add	a4,a4,a5
 6c2:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
 6c4:	00249713          	slli	a4,s1,0x2
 6c8:	973e                	add	a4,a4,a5
 6ca:	32072023          	sw	zero,800(a4)
  return buf;
 6ce:	bfc9                	j	6a0 <get_putc_buf+0x1e>

00000000000006d0 <putc>:

static void
putc(int fd, char c)
{
 6d0:	1101                	addi	sp,sp,-32
 6d2:	ec06                	sd	ra,24(sp)
 6d4:	e822                	sd	s0,16(sp)
 6d6:	e426                	sd	s1,8(sp)
 6d8:	e04a                	sd	s2,0(sp)
 6da:	1000                	addi	s0,sp,32
 6dc:	84aa                	mv	s1,a0
 6de:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
 6e0:	00000097          	auipc	ra,0x0
 6e4:	fa2080e7          	jalr	-94(ra) # 682 <get_putc_buf>
  buf[putc_index[fd]++] = c;
 6e8:	00249793          	slli	a5,s1,0x2
 6ec:	00000717          	auipc	a4,0x0
 6f0:	5b470713          	addi	a4,a4,1460 # ca0 <putc_buf>
 6f4:	973e                	add	a4,a4,a5
 6f6:	32072783          	lw	a5,800(a4)
 6fa:	0017869b          	addiw	a3,a5,1
 6fe:	32d72023          	sw	a3,800(a4)
 702:	97aa                	add	a5,a5,a0
 704:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
 708:	47a9                	li	a5,10
 70a:	02f90463          	beq	s2,a5,732 <putc+0x62>
 70e:	00249713          	slli	a4,s1,0x2
 712:	00000797          	auipc	a5,0x0
 716:	58e78793          	addi	a5,a5,1422 # ca0 <putc_buf>
 71a:	97ba                	add	a5,a5,a4
 71c:	3207a703          	lw	a4,800(a5)
 720:	6785                	lui	a5,0x1
 722:	00f70863          	beq	a4,a5,732 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
 726:	60e2                	ld	ra,24(sp)
 728:	6442                	ld	s0,16(sp)
 72a:	64a2                	ld	s1,8(sp)
 72c:	6902                	ld	s2,0(sp)
 72e:	6105                	addi	sp,sp,32
 730:	8082                	ret
    write(fd, buf, putc_index[fd]);
 732:	00249793          	slli	a5,s1,0x2
 736:	00000917          	auipc	s2,0x0
 73a:	56a90913          	addi	s2,s2,1386 # ca0 <putc_buf>
 73e:	993e                	add	s2,s2,a5
 740:	32092603          	lw	a2,800(s2)
 744:	85aa                	mv	a1,a0
 746:	8526                	mv	a0,s1
 748:	00000097          	auipc	ra,0x0
 74c:	e92080e7          	jalr	-366(ra) # 5da <write>
    putc_index[fd] = 0;
 750:	32092023          	sw	zero,800(s2)
}
 754:	bfc9                	j	726 <putc+0x56>

0000000000000756 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
 756:	7139                	addi	sp,sp,-64
 758:	fc06                	sd	ra,56(sp)
 75a:	f822                	sd	s0,48(sp)
 75c:	f426                	sd	s1,40(sp)
 75e:	f04a                	sd	s2,32(sp)
 760:	ec4e                	sd	s3,24(sp)
 762:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 764:	c299                	beqz	a3,76a <printint+0x14>
 766:	0005cd63          	bltz	a1,780 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 76a:	2581                	sext.w	a1,a1
  neg = 0;
 76c:	4301                	li	t1,0
 76e:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 772:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 774:	2601                	sext.w	a2,a2
 776:	00000897          	auipc	a7,0x0
 77a:	4f288893          	addi	a7,a7,1266 # c68 <digits>
 77e:	a801                	j	78e <printint+0x38>
    x = -xx;
 780:	40b005bb          	negw	a1,a1
 784:	2581                	sext.w	a1,a1
    neg = 1;
 786:	4305                	li	t1,1
    x = -xx;
 788:	b7dd                	j	76e <printint+0x18>
  }while((x /= base) != 0);
 78a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 78c:	8836                	mv	a6,a3
 78e:	0018069b          	addiw	a3,a6,1
 792:	02c5f7bb          	remuw	a5,a1,a2
 796:	1782                	slli	a5,a5,0x20
 798:	9381                	srli	a5,a5,0x20
 79a:	97c6                	add	a5,a5,a7
 79c:	0007c783          	lbu	a5,0(a5) # 1000 <putc_index+0x40>
 7a0:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
 7a4:	0705                	addi	a4,a4,1
 7a6:	02c5d7bb          	divuw	a5,a1,a2
 7aa:	fec5f0e3          	bleu	a2,a1,78a <printint+0x34>
  if(neg)
 7ae:	00030b63          	beqz	t1,7c4 <printint+0x6e>
    buf[i++] = '-';
 7b2:	fd040793          	addi	a5,s0,-48
 7b6:	96be                	add	a3,a3,a5
 7b8:	02d00793          	li	a5,45
 7bc:	fef68823          	sb	a5,-16(a3)
 7c0:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 7c4:	02d05963          	blez	a3,7f6 <printint+0xa0>
 7c8:	89aa                	mv	s3,a0
 7ca:	fc040793          	addi	a5,s0,-64
 7ce:	00d784b3          	add	s1,a5,a3
 7d2:	fff78913          	addi	s2,a5,-1
 7d6:	9936                	add	s2,s2,a3
 7d8:	36fd                	addiw	a3,a3,-1
 7da:	1682                	slli	a3,a3,0x20
 7dc:	9281                	srli	a3,a3,0x20
 7de:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 7e2:	fff4c583          	lbu	a1,-1(s1)
 7e6:	854e                	mv	a0,s3
 7e8:	00000097          	auipc	ra,0x0
 7ec:	ee8080e7          	jalr	-280(ra) # 6d0 <putc>
  while(--i >= 0)
 7f0:	14fd                	addi	s1,s1,-1
 7f2:	ff2498e3          	bne	s1,s2,7e2 <printint+0x8c>
}
 7f6:	70e2                	ld	ra,56(sp)
 7f8:	7442                	ld	s0,48(sp)
 7fa:	74a2                	ld	s1,40(sp)
 7fc:	7902                	ld	s2,32(sp)
 7fe:	69e2                	ld	s3,24(sp)
 800:	6121                	addi	sp,sp,64
 802:	8082                	ret

0000000000000804 <fflush>:
void fflush(int fd){
 804:	1101                	addi	sp,sp,-32
 806:	ec06                	sd	ra,24(sp)
 808:	e822                	sd	s0,16(sp)
 80a:	e426                	sd	s1,8(sp)
 80c:	e04a                	sd	s2,0(sp)
 80e:	1000                	addi	s0,sp,32
 810:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
 812:	00000097          	auipc	ra,0x0
 816:	e70080e7          	jalr	-400(ra) # 682 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
 81a:	00291793          	slli	a5,s2,0x2
 81e:	00000497          	auipc	s1,0x0
 822:	48248493          	addi	s1,s1,1154 # ca0 <putc_buf>
 826:	94be                	add	s1,s1,a5
 828:	3204a603          	lw	a2,800(s1)
 82c:	85aa                	mv	a1,a0
 82e:	854a                	mv	a0,s2
 830:	00000097          	auipc	ra,0x0
 834:	daa080e7          	jalr	-598(ra) # 5da <write>
  putc_index[fd] = 0;
 838:	3204a023          	sw	zero,800(s1)
}
 83c:	60e2                	ld	ra,24(sp)
 83e:	6442                	ld	s0,16(sp)
 840:	64a2                	ld	s1,8(sp)
 842:	6902                	ld	s2,0(sp)
 844:	6105                	addi	sp,sp,32
 846:	8082                	ret

0000000000000848 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 848:	7119                	addi	sp,sp,-128
 84a:	fc86                	sd	ra,120(sp)
 84c:	f8a2                	sd	s0,112(sp)
 84e:	f4a6                	sd	s1,104(sp)
 850:	f0ca                	sd	s2,96(sp)
 852:	ecce                	sd	s3,88(sp)
 854:	e8d2                	sd	s4,80(sp)
 856:	e4d6                	sd	s5,72(sp)
 858:	e0da                	sd	s6,64(sp)
 85a:	fc5e                	sd	s7,56(sp)
 85c:	f862                	sd	s8,48(sp)
 85e:	f466                	sd	s9,40(sp)
 860:	f06a                	sd	s10,32(sp)
 862:	ec6e                	sd	s11,24(sp)
 864:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 866:	0005c483          	lbu	s1,0(a1)
 86a:	18048d63          	beqz	s1,a04 <vprintf+0x1bc>
 86e:	8aaa                	mv	s5,a0
 870:	8b32                	mv	s6,a2
 872:	00158913          	addi	s2,a1,1
  state = 0;
 876:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 878:	02500a13          	li	s4,37
      if(c == 'd'){
 87c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 880:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 884:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 888:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 88c:	00000b97          	auipc	s7,0x0
 890:	3dcb8b93          	addi	s7,s7,988 # c68 <digits>
 894:	a839                	j	8b2 <vprintf+0x6a>
        putc(fd, c);
 896:	85a6                	mv	a1,s1
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	e36080e7          	jalr	-458(ra) # 6d0 <putc>
 8a2:	a019                	j	8a8 <vprintf+0x60>
    } else if(state == '%'){
 8a4:	01498f63          	beq	s3,s4,8c2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 8a8:	0905                	addi	s2,s2,1
 8aa:	fff94483          	lbu	s1,-1(s2)
 8ae:	14048b63          	beqz	s1,a04 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 8b2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 8b6:	fe0997e3          	bnez	s3,8a4 <vprintf+0x5c>
      if(c == '%'){
 8ba:	fd479ee3          	bne	a5,s4,896 <vprintf+0x4e>
        state = '%';
 8be:	89be                	mv	s3,a5
 8c0:	b7e5                	j	8a8 <vprintf+0x60>
      if(c == 'd'){
 8c2:	05878063          	beq	a5,s8,902 <vprintf+0xba>
      } else if(c == 'l') {
 8c6:	05978c63          	beq	a5,s9,91e <vprintf+0xd6>
      } else if(c == 'x') {
 8ca:	07a78863          	beq	a5,s10,93a <vprintf+0xf2>
      } else if(c == 'p') {
 8ce:	09b78463          	beq	a5,s11,956 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8d2:	07300713          	li	a4,115
 8d6:	0ce78563          	beq	a5,a4,9a0 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8da:	06300713          	li	a4,99
 8de:	0ee78c63          	beq	a5,a4,9d6 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8e2:	11478663          	beq	a5,s4,9ee <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8e6:	85d2                	mv	a1,s4
 8e8:	8556                	mv	a0,s5
 8ea:	00000097          	auipc	ra,0x0
 8ee:	de6080e7          	jalr	-538(ra) # 6d0 <putc>
        putc(fd, c);
 8f2:	85a6                	mv	a1,s1
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	dda080e7          	jalr	-550(ra) # 6d0 <putc>
      }
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b765                	j	8a8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 902:	008b0493          	addi	s1,s6,8
 906:	4685                	li	a3,1
 908:	4629                	li	a2,10
 90a:	000b2583          	lw	a1,0(s6)
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	e46080e7          	jalr	-442(ra) # 756 <printint>
 918:	8b26                	mv	s6,s1
      state = 0;
 91a:	4981                	li	s3,0
 91c:	b771                	j	8a8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 91e:	008b0493          	addi	s1,s6,8
 922:	4681                	li	a3,0
 924:	4629                	li	a2,10
 926:	000b2583          	lw	a1,0(s6)
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	e2a080e7          	jalr	-470(ra) # 756 <printint>
 934:	8b26                	mv	s6,s1
      state = 0;
 936:	4981                	li	s3,0
 938:	bf85                	j	8a8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 93a:	008b0493          	addi	s1,s6,8
 93e:	4681                	li	a3,0
 940:	4641                	li	a2,16
 942:	000b2583          	lw	a1,0(s6)
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	e0e080e7          	jalr	-498(ra) # 756 <printint>
 950:	8b26                	mv	s6,s1
      state = 0;
 952:	4981                	li	s3,0
 954:	bf91                	j	8a8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 956:	008b0793          	addi	a5,s6,8
 95a:	f8f43423          	sd	a5,-120(s0)
 95e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 962:	03000593          	li	a1,48
 966:	8556                	mv	a0,s5
 968:	00000097          	auipc	ra,0x0
 96c:	d68080e7          	jalr	-664(ra) # 6d0 <putc>
  putc(fd, 'x');
 970:	85ea                	mv	a1,s10
 972:	8556                	mv	a0,s5
 974:	00000097          	auipc	ra,0x0
 978:	d5c080e7          	jalr	-676(ra) # 6d0 <putc>
 97c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 97e:	03c9d793          	srli	a5,s3,0x3c
 982:	97de                	add	a5,a5,s7
 984:	0007c583          	lbu	a1,0(a5)
 988:	8556                	mv	a0,s5
 98a:	00000097          	auipc	ra,0x0
 98e:	d46080e7          	jalr	-698(ra) # 6d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 992:	0992                	slli	s3,s3,0x4
 994:	34fd                	addiw	s1,s1,-1
 996:	f4e5                	bnez	s1,97e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 998:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 99c:	4981                	li	s3,0
 99e:	b729                	j	8a8 <vprintf+0x60>
        s = va_arg(ap, char*);
 9a0:	008b0993          	addi	s3,s6,8
 9a4:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 9a8:	c085                	beqz	s1,9c8 <vprintf+0x180>
        while(*s != 0){
 9aa:	0004c583          	lbu	a1,0(s1)
 9ae:	c9a1                	beqz	a1,9fe <vprintf+0x1b6>
          putc(fd, *s);
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	d1e080e7          	jalr	-738(ra) # 6d0 <putc>
          s++;
 9ba:	0485                	addi	s1,s1,1
        while(*s != 0){
 9bc:	0004c583          	lbu	a1,0(s1)
 9c0:	f9e5                	bnez	a1,9b0 <vprintf+0x168>
        s = va_arg(ap, char*);
 9c2:	8b4e                	mv	s6,s3
      state = 0;
 9c4:	4981                	li	s3,0
 9c6:	b5cd                	j	8a8 <vprintf+0x60>
          s = "(null)";
 9c8:	00000497          	auipc	s1,0x0
 9cc:	2b848493          	addi	s1,s1,696 # c80 <digits+0x18>
        while(*s != 0){
 9d0:	02800593          	li	a1,40
 9d4:	bff1                	j	9b0 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 9d6:	008b0493          	addi	s1,s6,8
 9da:	000b4583          	lbu	a1,0(s6)
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	cf0080e7          	jalr	-784(ra) # 6d0 <putc>
 9e8:	8b26                	mv	s6,s1
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	bd75                	j	8a8 <vprintf+0x60>
        putc(fd, c);
 9ee:	85d2                	mv	a1,s4
 9f0:	8556                	mv	a0,s5
 9f2:	00000097          	auipc	ra,0x0
 9f6:	cde080e7          	jalr	-802(ra) # 6d0 <putc>
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	b575                	j	8a8 <vprintf+0x60>
        s = va_arg(ap, char*);
 9fe:	8b4e                	mv	s6,s3
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b55d                	j	8a8 <vprintf+0x60>
    }
  }
}
 a04:	70e6                	ld	ra,120(sp)
 a06:	7446                	ld	s0,112(sp)
 a08:	74a6                	ld	s1,104(sp)
 a0a:	7906                	ld	s2,96(sp)
 a0c:	69e6                	ld	s3,88(sp)
 a0e:	6a46                	ld	s4,80(sp)
 a10:	6aa6                	ld	s5,72(sp)
 a12:	6b06                	ld	s6,64(sp)
 a14:	7be2                	ld	s7,56(sp)
 a16:	7c42                	ld	s8,48(sp)
 a18:	7ca2                	ld	s9,40(sp)
 a1a:	7d02                	ld	s10,32(sp)
 a1c:	6de2                	ld	s11,24(sp)
 a1e:	6109                	addi	sp,sp,128
 a20:	8082                	ret

0000000000000a22 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a22:	715d                	addi	sp,sp,-80
 a24:	ec06                	sd	ra,24(sp)
 a26:	e822                	sd	s0,16(sp)
 a28:	1000                	addi	s0,sp,32
 a2a:	e010                	sd	a2,0(s0)
 a2c:	e414                	sd	a3,8(s0)
 a2e:	e818                	sd	a4,16(s0)
 a30:	ec1c                	sd	a5,24(s0)
 a32:	03043023          	sd	a6,32(s0)
 a36:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a3a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a3e:	8622                	mv	a2,s0
 a40:	00000097          	auipc	ra,0x0
 a44:	e08080e7          	jalr	-504(ra) # 848 <vprintf>
}
 a48:	60e2                	ld	ra,24(sp)
 a4a:	6442                	ld	s0,16(sp)
 a4c:	6161                	addi	sp,sp,80
 a4e:	8082                	ret

0000000000000a50 <printf>:

void
printf(const char *fmt, ...)
{
 a50:	711d                	addi	sp,sp,-96
 a52:	ec06                	sd	ra,24(sp)
 a54:	e822                	sd	s0,16(sp)
 a56:	1000                	addi	s0,sp,32
 a58:	e40c                	sd	a1,8(s0)
 a5a:	e810                	sd	a2,16(s0)
 a5c:	ec14                	sd	a3,24(s0)
 a5e:	f018                	sd	a4,32(s0)
 a60:	f41c                	sd	a5,40(s0)
 a62:	03043823          	sd	a6,48(s0)
 a66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a6a:	00840613          	addi	a2,s0,8
 a6e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a72:	85aa                	mv	a1,a0
 a74:	4505                	li	a0,1
 a76:	00000097          	auipc	ra,0x0
 a7a:	dd2080e7          	jalr	-558(ra) # 848 <vprintf>
}
 a7e:	60e2                	ld	ra,24(sp)
 a80:	6442                	ld	s0,16(sp)
 a82:	6125                	addi	sp,sp,96
 a84:	8082                	ret

0000000000000a86 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a86:	1141                	addi	sp,sp,-16
 a88:	e422                	sd	s0,8(sp)
 a8a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a8c:	ff050693          	addi	a3,a0,-16 # ff0 <putc_index+0x30>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a90:	00000797          	auipc	a5,0x0
 a94:	1f878793          	addi	a5,a5,504 # c88 <__bss_start>
 a98:	639c                	ld	a5,0(a5)
 a9a:	a805                	j	aca <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a9c:	4618                	lw	a4,8(a2)
 a9e:	9db9                	addw	a1,a1,a4
 aa0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 aa4:	6398                	ld	a4,0(a5)
 aa6:	6318                	ld	a4,0(a4)
 aa8:	fee53823          	sd	a4,-16(a0)
 aac:	a091                	j	af0 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 aae:	ff852703          	lw	a4,-8(a0)
 ab2:	9e39                	addw	a2,a2,a4
 ab4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 ab6:	ff053703          	ld	a4,-16(a0)
 aba:	e398                	sd	a4,0(a5)
 abc:	a099                	j	b02 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 abe:	6398                	ld	a4,0(a5)
 ac0:	00e7e463          	bltu	a5,a4,ac8 <free+0x42>
 ac4:	00e6ea63          	bltu	a3,a4,ad8 <free+0x52>
{
 ac8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aca:	fed7fae3          	bleu	a3,a5,abe <free+0x38>
 ace:	6398                	ld	a4,0(a5)
 ad0:	00e6e463          	bltu	a3,a4,ad8 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad4:	fee7eae3          	bltu	a5,a4,ac8 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 ad8:	ff852583          	lw	a1,-8(a0)
 adc:	6390                	ld	a2,0(a5)
 ade:	02059713          	slli	a4,a1,0x20
 ae2:	9301                	srli	a4,a4,0x20
 ae4:	0712                	slli	a4,a4,0x4
 ae6:	9736                	add	a4,a4,a3
 ae8:	fae60ae3          	beq	a2,a4,a9c <free+0x16>
    bp->s.ptr = p->s.ptr;
 aec:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 af0:	4790                	lw	a2,8(a5)
 af2:	02061713          	slli	a4,a2,0x20
 af6:	9301                	srli	a4,a4,0x20
 af8:	0712                	slli	a4,a4,0x4
 afa:	973e                	add	a4,a4,a5
 afc:	fae689e3          	beq	a3,a4,aae <free+0x28>
  } else
    p->s.ptr = bp;
 b00:	e394                	sd	a3,0(a5)
  freep = p;
 b02:	00000717          	auipc	a4,0x0
 b06:	18f73323          	sd	a5,390(a4) # c88 <__bss_start>
}
 b0a:	6422                	ld	s0,8(sp)
 b0c:	0141                	addi	sp,sp,16
 b0e:	8082                	ret

0000000000000b10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b10:	7139                	addi	sp,sp,-64
 b12:	fc06                	sd	ra,56(sp)
 b14:	f822                	sd	s0,48(sp)
 b16:	f426                	sd	s1,40(sp)
 b18:	f04a                	sd	s2,32(sp)
 b1a:	ec4e                	sd	s3,24(sp)
 b1c:	e852                	sd	s4,16(sp)
 b1e:	e456                	sd	s5,8(sp)
 b20:	e05a                	sd	s6,0(sp)
 b22:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b24:	02051993          	slli	s3,a0,0x20
 b28:	0209d993          	srli	s3,s3,0x20
 b2c:	09bd                	addi	s3,s3,15
 b2e:	0049d993          	srli	s3,s3,0x4
 b32:	2985                	addiw	s3,s3,1
 b34:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 b38:	00000797          	auipc	a5,0x0
 b3c:	15078793          	addi	a5,a5,336 # c88 <__bss_start>
 b40:	6388                	ld	a0,0(a5)
 b42:	c515                	beqz	a0,b6e <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b44:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b46:	4798                	lw	a4,8(a5)
 b48:	03277f63          	bleu	s2,a4,b86 <malloc+0x76>
 b4c:	8a4e                	mv	s4,s3
 b4e:	0009871b          	sext.w	a4,s3
 b52:	6685                	lui	a3,0x1
 b54:	00d77363          	bleu	a3,a4,b5a <malloc+0x4a>
 b58:	6a05                	lui	s4,0x1
 b5a:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 b5e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b62:	00000497          	auipc	s1,0x0
 b66:	12648493          	addi	s1,s1,294 # c88 <__bss_start>
  if(p == (char*)-1)
 b6a:	5b7d                	li	s6,-1
 b6c:	a885                	j	bdc <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 b6e:	00000797          	auipc	a5,0x0
 b72:	5e278793          	addi	a5,a5,1506 # 1150 <base>
 b76:	00000717          	auipc	a4,0x0
 b7a:	10f73923          	sd	a5,274(a4) # c88 <__bss_start>
 b7e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b80:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b84:	b7e1                	j	b4c <malloc+0x3c>
      if(p->s.size == nunits)
 b86:	02e90b63          	beq	s2,a4,bbc <malloc+0xac>
        p->s.size -= nunits;
 b8a:	4137073b          	subw	a4,a4,s3
 b8e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b90:	1702                	slli	a4,a4,0x20
 b92:	9301                	srli	a4,a4,0x20
 b94:	0712                	slli	a4,a4,0x4
 b96:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b98:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b9c:	00000717          	auipc	a4,0x0
 ba0:	0ea73623          	sd	a0,236(a4) # c88 <__bss_start>
      return (void*)(p + 1);
 ba4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ba8:	70e2                	ld	ra,56(sp)
 baa:	7442                	ld	s0,48(sp)
 bac:	74a2                	ld	s1,40(sp)
 bae:	7902                	ld	s2,32(sp)
 bb0:	69e2                	ld	s3,24(sp)
 bb2:	6a42                	ld	s4,16(sp)
 bb4:	6aa2                	ld	s5,8(sp)
 bb6:	6b02                	ld	s6,0(sp)
 bb8:	6121                	addi	sp,sp,64
 bba:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 bbc:	6398                	ld	a4,0(a5)
 bbe:	e118                	sd	a4,0(a0)
 bc0:	bff1                	j	b9c <malloc+0x8c>
  hp->s.size = nu;
 bc2:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 bc6:	0541                	addi	a0,a0,16
 bc8:	00000097          	auipc	ra,0x0
 bcc:	ebe080e7          	jalr	-322(ra) # a86 <free>
  return freep;
 bd0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 bd2:	d979                	beqz	a0,ba8 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bd6:	4798                	lw	a4,8(a5)
 bd8:	fb2777e3          	bleu	s2,a4,b86 <malloc+0x76>
    if(p == freep)
 bdc:	6098                	ld	a4,0(s1)
 bde:	853e                	mv	a0,a5
 be0:	fef71ae3          	bne	a4,a5,bd4 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 be4:	8552                	mv	a0,s4
 be6:	00000097          	auipc	ra,0x0
 bea:	a5c080e7          	jalr	-1444(ra) # 642 <sbrk>
  if(p == (char*)-1)
 bee:	fd651ae3          	bne	a0,s6,bc2 <malloc+0xb2>
        return 0;
 bf2:	4501                	li	a0,0
 bf4:	bf55                	j	ba8 <malloc+0x98>
