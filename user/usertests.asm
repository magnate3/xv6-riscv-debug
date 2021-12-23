
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <bsstest>:
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
       0:	00007797          	auipc	a5,0x7
       4:	cd07c783          	lbu	a5,-816(a5) # 6cd0 <uninit>
       8:	e385                	bnez	a5,28 <bsstest+0x28>
       a:	00007797          	auipc	a5,0x7
       e:	cc778793          	addi	a5,a5,-825 # 6cd1 <uninit+0x1>
      12:	00009697          	auipc	a3,0x9
      16:	3ce68693          	addi	a3,a3,974 # 93e0 <buf>
      1a:	0007c703          	lbu	a4,0(a5)
      1e:	e709                	bnez	a4,28 <bsstest+0x28>
  for(i = 0; i < sizeof(uninit); i++){
      20:	0785                	addi	a5,a5,1
      22:	fed79ce3          	bne	a5,a3,1a <bsstest+0x1a>
      26:	8082                	ret
{
      28:	1141                	addi	sp,sp,-16
      2a:	e406                	sd	ra,8(sp)
      2c:	e022                	sd	s0,0(sp)
      2e:	0800                	addi	s0,sp,16
      30:	85aa                	mv	a1,a0
      printf("%s: bss test failed\n", s);
      32:	00005517          	auipc	a0,0x5
      36:	db650513          	addi	a0,a0,-586 # 4de8 <malloc+0x3d6>
      3a:	00005097          	auipc	ra,0x5
      3e:	918080e7          	jalr	-1768(ra) # 4952 <printf>
      exit(1);
      42:	4505                	li	a0,1
      44:	00004097          	auipc	ra,0x4
      48:	478080e7          	jalr	1144(ra) # 44bc <exit>

000000000000004c <iputtest>:
{
      4c:	1101                	addi	sp,sp,-32
      4e:	ec06                	sd	ra,24(sp)
      50:	e822                	sd	s0,16(sp)
      52:	e426                	sd	s1,8(sp)
      54:	1000                	addi	s0,sp,32
      56:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
      58:	00005517          	auipc	a0,0x5
      5c:	da850513          	addi	a0,a0,-600 # 4e00 <malloc+0x3ee>
      60:	00004097          	auipc	ra,0x4
      64:	4c4080e7          	jalr	1220(ra) # 4524 <mkdir>
      68:	04054563          	bltz	a0,b2 <iputtest+0x66>
  if(chdir("iputdir") < 0){
      6c:	00005517          	auipc	a0,0x5
      70:	d9450513          	addi	a0,a0,-620 # 4e00 <malloc+0x3ee>
      74:	00004097          	auipc	ra,0x4
      78:	4b8080e7          	jalr	1208(ra) # 452c <chdir>
      7c:	04054963          	bltz	a0,ce <iputtest+0x82>
  if(unlink("../iputdir") < 0){
      80:	00005517          	auipc	a0,0x5
      84:	dc050513          	addi	a0,a0,-576 # 4e40 <malloc+0x42e>
      88:	00004097          	auipc	ra,0x4
      8c:	484080e7          	jalr	1156(ra) # 450c <unlink>
      90:	04054d63          	bltz	a0,ea <iputtest+0x9e>
  if(chdir("/") < 0){
      94:	00005517          	auipc	a0,0x5
      98:	ddc50513          	addi	a0,a0,-548 # 4e70 <malloc+0x45e>
      9c:	00004097          	auipc	ra,0x4
      a0:	490080e7          	jalr	1168(ra) # 452c <chdir>
      a4:	06054163          	bltz	a0,106 <iputtest+0xba>
}
      a8:	60e2                	ld	ra,24(sp)
      aa:	6442                	ld	s0,16(sp)
      ac:	64a2                	ld	s1,8(sp)
      ae:	6105                	addi	sp,sp,32
      b0:	8082                	ret
    printf("%s: mkdir failed\n", s);
      b2:	85a6                	mv	a1,s1
      b4:	00005517          	auipc	a0,0x5
      b8:	d5450513          	addi	a0,a0,-684 # 4e08 <malloc+0x3f6>
      bc:	00005097          	auipc	ra,0x5
      c0:	896080e7          	jalr	-1898(ra) # 4952 <printf>
    exit(1);
      c4:	4505                	li	a0,1
      c6:	00004097          	auipc	ra,0x4
      ca:	3f6080e7          	jalr	1014(ra) # 44bc <exit>
    printf("%s: chdir iputdir failed\n", s);
      ce:	85a6                	mv	a1,s1
      d0:	00005517          	auipc	a0,0x5
      d4:	d5050513          	addi	a0,a0,-688 # 4e20 <malloc+0x40e>
      d8:	00005097          	auipc	ra,0x5
      dc:	87a080e7          	jalr	-1926(ra) # 4952 <printf>
    exit(1);
      e0:	4505                	li	a0,1
      e2:	00004097          	auipc	ra,0x4
      e6:	3da080e7          	jalr	986(ra) # 44bc <exit>
    printf("%s: unlink ../iputdir failed\n", s);
      ea:	85a6                	mv	a1,s1
      ec:	00005517          	auipc	a0,0x5
      f0:	d6450513          	addi	a0,a0,-668 # 4e50 <malloc+0x43e>
      f4:	00005097          	auipc	ra,0x5
      f8:	85e080e7          	jalr	-1954(ra) # 4952 <printf>
    exit(1);
      fc:	4505                	li	a0,1
      fe:	00004097          	auipc	ra,0x4
     102:	3be080e7          	jalr	958(ra) # 44bc <exit>
    printf("%s: chdir / failed\n", s);
     106:	85a6                	mv	a1,s1
     108:	00005517          	auipc	a0,0x5
     10c:	d7050513          	addi	a0,a0,-656 # 4e78 <malloc+0x466>
     110:	00005097          	auipc	ra,0x5
     114:	842080e7          	jalr	-1982(ra) # 4952 <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	00004097          	auipc	ra,0x4
     11e:	3a2080e7          	jalr	930(ra) # 44bc <exit>

0000000000000122 <rmdot>:
{
     122:	1101                	addi	sp,sp,-32
     124:	ec06                	sd	ra,24(sp)
     126:	e822                	sd	s0,16(sp)
     128:	e426                	sd	s1,8(sp)
     12a:	1000                	addi	s0,sp,32
     12c:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
     12e:	00005517          	auipc	a0,0x5
     132:	d6250513          	addi	a0,a0,-670 # 4e90 <malloc+0x47e>
     136:	00004097          	auipc	ra,0x4
     13a:	3ee080e7          	jalr	1006(ra) # 4524 <mkdir>
     13e:	e549                	bnez	a0,1c8 <rmdot+0xa6>
  if(chdir("dots") != 0){
     140:	00005517          	auipc	a0,0x5
     144:	d5050513          	addi	a0,a0,-688 # 4e90 <malloc+0x47e>
     148:	00004097          	auipc	ra,0x4
     14c:	3e4080e7          	jalr	996(ra) # 452c <chdir>
     150:	e951                	bnez	a0,1e4 <rmdot+0xc2>
  if(unlink(".") == 0){
     152:	00005517          	auipc	a0,0x5
     156:	d7650513          	addi	a0,a0,-650 # 4ec8 <malloc+0x4b6>
     15a:	00004097          	auipc	ra,0x4
     15e:	3b2080e7          	jalr	946(ra) # 450c <unlink>
     162:	cd59                	beqz	a0,200 <rmdot+0xde>
  if(unlink("..") == 0){
     164:	00005517          	auipc	a0,0x5
     168:	d8450513          	addi	a0,a0,-636 # 4ee8 <malloc+0x4d6>
     16c:	00004097          	auipc	ra,0x4
     170:	3a0080e7          	jalr	928(ra) # 450c <unlink>
     174:	c545                	beqz	a0,21c <rmdot+0xfa>
  if(chdir("/") != 0){
     176:	00005517          	auipc	a0,0x5
     17a:	cfa50513          	addi	a0,a0,-774 # 4e70 <malloc+0x45e>
     17e:	00004097          	auipc	ra,0x4
     182:	3ae080e7          	jalr	942(ra) # 452c <chdir>
     186:	e94d                	bnez	a0,238 <rmdot+0x116>
  if(unlink("dots/.") == 0){
     188:	00005517          	auipc	a0,0x5
     18c:	d8050513          	addi	a0,a0,-640 # 4f08 <malloc+0x4f6>
     190:	00004097          	auipc	ra,0x4
     194:	37c080e7          	jalr	892(ra) # 450c <unlink>
     198:	cd55                	beqz	a0,254 <rmdot+0x132>
  if(unlink("dots/..") == 0){
     19a:	00005517          	auipc	a0,0x5
     19e:	d9650513          	addi	a0,a0,-618 # 4f30 <malloc+0x51e>
     1a2:	00004097          	auipc	ra,0x4
     1a6:	36a080e7          	jalr	874(ra) # 450c <unlink>
     1aa:	c179                	beqz	a0,270 <rmdot+0x14e>
  if(unlink("dots") != 0){
     1ac:	00005517          	auipc	a0,0x5
     1b0:	ce450513          	addi	a0,a0,-796 # 4e90 <malloc+0x47e>
     1b4:	00004097          	auipc	ra,0x4
     1b8:	358080e7          	jalr	856(ra) # 450c <unlink>
     1bc:	e961                	bnez	a0,28c <rmdot+0x16a>
}
     1be:	60e2                	ld	ra,24(sp)
     1c0:	6442                	ld	s0,16(sp)
     1c2:	64a2                	ld	s1,8(sp)
     1c4:	6105                	addi	sp,sp,32
     1c6:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
     1c8:	85a6                	mv	a1,s1
     1ca:	00005517          	auipc	a0,0x5
     1ce:	cce50513          	addi	a0,a0,-818 # 4e98 <malloc+0x486>
     1d2:	00004097          	auipc	ra,0x4
     1d6:	780080e7          	jalr	1920(ra) # 4952 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00004097          	auipc	ra,0x4
     1e0:	2e0080e7          	jalr	736(ra) # 44bc <exit>
    printf("%s: chdir dots failed\n", s);
     1e4:	85a6                	mv	a1,s1
     1e6:	00005517          	auipc	a0,0x5
     1ea:	cca50513          	addi	a0,a0,-822 # 4eb0 <malloc+0x49e>
     1ee:	00004097          	auipc	ra,0x4
     1f2:	764080e7          	jalr	1892(ra) # 4952 <printf>
    exit(1);
     1f6:	4505                	li	a0,1
     1f8:	00004097          	auipc	ra,0x4
     1fc:	2c4080e7          	jalr	708(ra) # 44bc <exit>
    printf("%s: rm . worked!\n", s);
     200:	85a6                	mv	a1,s1
     202:	00005517          	auipc	a0,0x5
     206:	cce50513          	addi	a0,a0,-818 # 4ed0 <malloc+0x4be>
     20a:	00004097          	auipc	ra,0x4
     20e:	748080e7          	jalr	1864(ra) # 4952 <printf>
    exit(1);
     212:	4505                	li	a0,1
     214:	00004097          	auipc	ra,0x4
     218:	2a8080e7          	jalr	680(ra) # 44bc <exit>
    printf("%s: rm .. worked!\n", s);
     21c:	85a6                	mv	a1,s1
     21e:	00005517          	auipc	a0,0x5
     222:	cd250513          	addi	a0,a0,-814 # 4ef0 <malloc+0x4de>
     226:	00004097          	auipc	ra,0x4
     22a:	72c080e7          	jalr	1836(ra) # 4952 <printf>
    exit(1);
     22e:	4505                	li	a0,1
     230:	00004097          	auipc	ra,0x4
     234:	28c080e7          	jalr	652(ra) # 44bc <exit>
    printf("%s: chdir / failed\n", s);
     238:	85a6                	mv	a1,s1
     23a:	00005517          	auipc	a0,0x5
     23e:	c3e50513          	addi	a0,a0,-962 # 4e78 <malloc+0x466>
     242:	00004097          	auipc	ra,0x4
     246:	710080e7          	jalr	1808(ra) # 4952 <printf>
    exit(1);
     24a:	4505                	li	a0,1
     24c:	00004097          	auipc	ra,0x4
     250:	270080e7          	jalr	624(ra) # 44bc <exit>
    printf("%s: unlink dots/. worked!\n", s);
     254:	85a6                	mv	a1,s1
     256:	00005517          	auipc	a0,0x5
     25a:	cba50513          	addi	a0,a0,-838 # 4f10 <malloc+0x4fe>
     25e:	00004097          	auipc	ra,0x4
     262:	6f4080e7          	jalr	1780(ra) # 4952 <printf>
    exit(1);
     266:	4505                	li	a0,1
     268:	00004097          	auipc	ra,0x4
     26c:	254080e7          	jalr	596(ra) # 44bc <exit>
    printf("%s: unlink dots/.. worked!\n", s);
     270:	85a6                	mv	a1,s1
     272:	00005517          	auipc	a0,0x5
     276:	cc650513          	addi	a0,a0,-826 # 4f38 <malloc+0x526>
     27a:	00004097          	auipc	ra,0x4
     27e:	6d8080e7          	jalr	1752(ra) # 4952 <printf>
    exit(1);
     282:	4505                	li	a0,1
     284:	00004097          	auipc	ra,0x4
     288:	238080e7          	jalr	568(ra) # 44bc <exit>
    printf("%s: unlink dots failed!\n", s);
     28c:	85a6                	mv	a1,s1
     28e:	00005517          	auipc	a0,0x5
     292:	cca50513          	addi	a0,a0,-822 # 4f58 <malloc+0x546>
     296:	00004097          	auipc	ra,0x4
     29a:	6bc080e7          	jalr	1724(ra) # 4952 <printf>
    exit(1);
     29e:	4505                	li	a0,1
     2a0:	00004097          	auipc	ra,0x4
     2a4:	21c080e7          	jalr	540(ra) # 44bc <exit>

00000000000002a8 <exitiputtest>:
{
     2a8:	7179                	addi	sp,sp,-48
     2aa:	f406                	sd	ra,40(sp)
     2ac:	f022                	sd	s0,32(sp)
     2ae:	ec26                	sd	s1,24(sp)
     2b0:	1800                	addi	s0,sp,48
     2b2:	84aa                	mv	s1,a0
  pid = fork();
     2b4:	00004097          	auipc	ra,0x4
     2b8:	200080e7          	jalr	512(ra) # 44b4 <fork>
  if(pid < 0){
     2bc:	04054663          	bltz	a0,308 <exitiputtest+0x60>
  if(pid == 0){
     2c0:	ed45                	bnez	a0,378 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
     2c2:	00005517          	auipc	a0,0x5
     2c6:	b3e50513          	addi	a0,a0,-1218 # 4e00 <malloc+0x3ee>
     2ca:	00004097          	auipc	ra,0x4
     2ce:	25a080e7          	jalr	602(ra) # 4524 <mkdir>
     2d2:	04054963          	bltz	a0,324 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
     2d6:	00005517          	auipc	a0,0x5
     2da:	b2a50513          	addi	a0,a0,-1238 # 4e00 <malloc+0x3ee>
     2de:	00004097          	auipc	ra,0x4
     2e2:	24e080e7          	jalr	590(ra) # 452c <chdir>
     2e6:	04054d63          	bltz	a0,340 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
     2ea:	00005517          	auipc	a0,0x5
     2ee:	b5650513          	addi	a0,a0,-1194 # 4e40 <malloc+0x42e>
     2f2:	00004097          	auipc	ra,0x4
     2f6:	21a080e7          	jalr	538(ra) # 450c <unlink>
     2fa:	06054163          	bltz	a0,35c <exitiputtest+0xb4>
    exit(0);
     2fe:	4501                	li	a0,0
     300:	00004097          	auipc	ra,0x4
     304:	1bc080e7          	jalr	444(ra) # 44bc <exit>
    printf("%s: fork failed\n", s);
     308:	85a6                	mv	a1,s1
     30a:	00005517          	auipc	a0,0x5
     30e:	c6e50513          	addi	a0,a0,-914 # 4f78 <malloc+0x566>
     312:	00004097          	auipc	ra,0x4
     316:	640080e7          	jalr	1600(ra) # 4952 <printf>
    exit(1);
     31a:	4505                	li	a0,1
     31c:	00004097          	auipc	ra,0x4
     320:	1a0080e7          	jalr	416(ra) # 44bc <exit>
      printf("%s: mkdir failed\n", s);
     324:	85a6                	mv	a1,s1
     326:	00005517          	auipc	a0,0x5
     32a:	ae250513          	addi	a0,a0,-1310 # 4e08 <malloc+0x3f6>
     32e:	00004097          	auipc	ra,0x4
     332:	624080e7          	jalr	1572(ra) # 4952 <printf>
      exit(1);
     336:	4505                	li	a0,1
     338:	00004097          	auipc	ra,0x4
     33c:	184080e7          	jalr	388(ra) # 44bc <exit>
      printf("%s: child chdir failed\n", s);
     340:	85a6                	mv	a1,s1
     342:	00005517          	auipc	a0,0x5
     346:	c4e50513          	addi	a0,a0,-946 # 4f90 <malloc+0x57e>
     34a:	00004097          	auipc	ra,0x4
     34e:	608080e7          	jalr	1544(ra) # 4952 <printf>
      exit(1);
     352:	4505                	li	a0,1
     354:	00004097          	auipc	ra,0x4
     358:	168080e7          	jalr	360(ra) # 44bc <exit>
      printf("%s: unlink ../iputdir failed\n", s);
     35c:	85a6                	mv	a1,s1
     35e:	00005517          	auipc	a0,0x5
     362:	af250513          	addi	a0,a0,-1294 # 4e50 <malloc+0x43e>
     366:	00004097          	auipc	ra,0x4
     36a:	5ec080e7          	jalr	1516(ra) # 4952 <printf>
      exit(1);
     36e:	4505                	li	a0,1
     370:	00004097          	auipc	ra,0x4
     374:	14c080e7          	jalr	332(ra) # 44bc <exit>
  wait(&xstatus);
     378:	fdc40513          	addi	a0,s0,-36
     37c:	00004097          	auipc	ra,0x4
     380:	148080e7          	jalr	328(ra) # 44c4 <wait>
  exit(xstatus);
     384:	fdc42503          	lw	a0,-36(s0)
     388:	00004097          	auipc	ra,0x4
     38c:	134080e7          	jalr	308(ra) # 44bc <exit>

0000000000000390 <exitwait>:
{
     390:	7139                	addi	sp,sp,-64
     392:	fc06                	sd	ra,56(sp)
     394:	f822                	sd	s0,48(sp)
     396:	f426                	sd	s1,40(sp)
     398:	f04a                	sd	s2,32(sp)
     39a:	ec4e                	sd	s3,24(sp)
     39c:	e852                	sd	s4,16(sp)
     39e:	0080                	addi	s0,sp,64
     3a0:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
     3a2:	4481                	li	s1,0
     3a4:	06400993          	li	s3,100
    pid = fork();
     3a8:	00004097          	auipc	ra,0x4
     3ac:	10c080e7          	jalr	268(ra) # 44b4 <fork>
     3b0:	892a                	mv	s2,a0
    if(pid < 0){
     3b2:	02054a63          	bltz	a0,3e6 <exitwait+0x56>
    if(pid){
     3b6:	c151                	beqz	a0,43a <exitwait+0xaa>
      if(wait(&xstate) != pid){
     3b8:	fcc40513          	addi	a0,s0,-52
     3bc:	00004097          	auipc	ra,0x4
     3c0:	108080e7          	jalr	264(ra) # 44c4 <wait>
     3c4:	03251f63          	bne	a0,s2,402 <exitwait+0x72>
      if(i != xstate) {
     3c8:	fcc42783          	lw	a5,-52(s0)
     3cc:	04979963          	bne	a5,s1,41e <exitwait+0x8e>
  for(i = 0; i < 100; i++){
     3d0:	2485                	addiw	s1,s1,1
     3d2:	fd349be3          	bne	s1,s3,3a8 <exitwait+0x18>
}
     3d6:	70e2                	ld	ra,56(sp)
     3d8:	7442                	ld	s0,48(sp)
     3da:	74a2                	ld	s1,40(sp)
     3dc:	7902                	ld	s2,32(sp)
     3de:	69e2                	ld	s3,24(sp)
     3e0:	6a42                	ld	s4,16(sp)
     3e2:	6121                	addi	sp,sp,64
     3e4:	8082                	ret
      printf("%s: fork failed\n", s);
     3e6:	85d2                	mv	a1,s4
     3e8:	00005517          	auipc	a0,0x5
     3ec:	b9050513          	addi	a0,a0,-1136 # 4f78 <malloc+0x566>
     3f0:	00004097          	auipc	ra,0x4
     3f4:	562080e7          	jalr	1378(ra) # 4952 <printf>
      exit(1);
     3f8:	4505                	li	a0,1
     3fa:	00004097          	auipc	ra,0x4
     3fe:	0c2080e7          	jalr	194(ra) # 44bc <exit>
        printf("%s: wait wrong pid\n", s);
     402:	85d2                	mv	a1,s4
     404:	00005517          	auipc	a0,0x5
     408:	ba450513          	addi	a0,a0,-1116 # 4fa8 <malloc+0x596>
     40c:	00004097          	auipc	ra,0x4
     410:	546080e7          	jalr	1350(ra) # 4952 <printf>
        exit(1);
     414:	4505                	li	a0,1
     416:	00004097          	auipc	ra,0x4
     41a:	0a6080e7          	jalr	166(ra) # 44bc <exit>
        printf("%s: wait wrong exit status\n", s);
     41e:	85d2                	mv	a1,s4
     420:	00005517          	auipc	a0,0x5
     424:	ba050513          	addi	a0,a0,-1120 # 4fc0 <malloc+0x5ae>
     428:	00004097          	auipc	ra,0x4
     42c:	52a080e7          	jalr	1322(ra) # 4952 <printf>
        exit(1);
     430:	4505                	li	a0,1
     432:	00004097          	auipc	ra,0x4
     436:	08a080e7          	jalr	138(ra) # 44bc <exit>
      exit(i);
     43a:	8526                	mv	a0,s1
     43c:	00004097          	auipc	ra,0x4
     440:	080080e7          	jalr	128(ra) # 44bc <exit>

0000000000000444 <twochildren>:
{
     444:	1101                	addi	sp,sp,-32
     446:	ec06                	sd	ra,24(sp)
     448:	e822                	sd	s0,16(sp)
     44a:	e426                	sd	s1,8(sp)
     44c:	e04a                	sd	s2,0(sp)
     44e:	1000                	addi	s0,sp,32
     450:	892a                	mv	s2,a0
     452:	3e800493          	li	s1,1000
    int pid1 = fork();
     456:	00004097          	auipc	ra,0x4
     45a:	05e080e7          	jalr	94(ra) # 44b4 <fork>
    if(pid1 < 0){
     45e:	02054c63          	bltz	a0,496 <twochildren+0x52>
    if(pid1 == 0){
     462:	c921                	beqz	a0,4b2 <twochildren+0x6e>
      int pid2 = fork();
     464:	00004097          	auipc	ra,0x4
     468:	050080e7          	jalr	80(ra) # 44b4 <fork>
      if(pid2 < 0){
     46c:	04054763          	bltz	a0,4ba <twochildren+0x76>
      if(pid2 == 0){
     470:	c13d                	beqz	a0,4d6 <twochildren+0x92>
        wait(0);
     472:	4501                	li	a0,0
     474:	00004097          	auipc	ra,0x4
     478:	050080e7          	jalr	80(ra) # 44c4 <wait>
        wait(0);
     47c:	4501                	li	a0,0
     47e:	00004097          	auipc	ra,0x4
     482:	046080e7          	jalr	70(ra) # 44c4 <wait>
  for(int i = 0; i < 1000; i++){
     486:	34fd                	addiw	s1,s1,-1
     488:	f4f9                	bnez	s1,456 <twochildren+0x12>
}
     48a:	60e2                	ld	ra,24(sp)
     48c:	6442                	ld	s0,16(sp)
     48e:	64a2                	ld	s1,8(sp)
     490:	6902                	ld	s2,0(sp)
     492:	6105                	addi	sp,sp,32
     494:	8082                	ret
      printf("%s: fork failed\n", s);
     496:	85ca                	mv	a1,s2
     498:	00005517          	auipc	a0,0x5
     49c:	ae050513          	addi	a0,a0,-1312 # 4f78 <malloc+0x566>
     4a0:	00004097          	auipc	ra,0x4
     4a4:	4b2080e7          	jalr	1202(ra) # 4952 <printf>
      exit(1);
     4a8:	4505                	li	a0,1
     4aa:	00004097          	auipc	ra,0x4
     4ae:	012080e7          	jalr	18(ra) # 44bc <exit>
      exit(0);
     4b2:	00004097          	auipc	ra,0x4
     4b6:	00a080e7          	jalr	10(ra) # 44bc <exit>
        printf("%s: fork failed\n", s);
     4ba:	85ca                	mv	a1,s2
     4bc:	00005517          	auipc	a0,0x5
     4c0:	abc50513          	addi	a0,a0,-1348 # 4f78 <malloc+0x566>
     4c4:	00004097          	auipc	ra,0x4
     4c8:	48e080e7          	jalr	1166(ra) # 4952 <printf>
        exit(1);
     4cc:	4505                	li	a0,1
     4ce:	00004097          	auipc	ra,0x4
     4d2:	fee080e7          	jalr	-18(ra) # 44bc <exit>
        exit(0);
     4d6:	00004097          	auipc	ra,0x4
     4da:	fe6080e7          	jalr	-26(ra) # 44bc <exit>

00000000000004de <forkfork>:
{
     4de:	7179                	addi	sp,sp,-48
     4e0:	f406                	sd	ra,40(sp)
     4e2:	f022                	sd	s0,32(sp)
     4e4:	ec26                	sd	s1,24(sp)
     4e6:	1800                	addi	s0,sp,48
     4e8:	84aa                	mv	s1,a0
    int pid = fork();
     4ea:	00004097          	auipc	ra,0x4
     4ee:	fca080e7          	jalr	-54(ra) # 44b4 <fork>
    if(pid < 0){
     4f2:	04054163          	bltz	a0,534 <forkfork+0x56>
    if(pid == 0){
     4f6:	cd29                	beqz	a0,550 <forkfork+0x72>
    int pid = fork();
     4f8:	00004097          	auipc	ra,0x4
     4fc:	fbc080e7          	jalr	-68(ra) # 44b4 <fork>
    if(pid < 0){
     500:	02054a63          	bltz	a0,534 <forkfork+0x56>
    if(pid == 0){
     504:	c531                	beqz	a0,550 <forkfork+0x72>
    wait(&xstatus);
     506:	fdc40513          	addi	a0,s0,-36
     50a:	00004097          	auipc	ra,0x4
     50e:	fba080e7          	jalr	-70(ra) # 44c4 <wait>
    if(xstatus != 0) {
     512:	fdc42783          	lw	a5,-36(s0)
     516:	ebbd                	bnez	a5,58c <forkfork+0xae>
    wait(&xstatus);
     518:	fdc40513          	addi	a0,s0,-36
     51c:	00004097          	auipc	ra,0x4
     520:	fa8080e7          	jalr	-88(ra) # 44c4 <wait>
    if(xstatus != 0) {
     524:	fdc42783          	lw	a5,-36(s0)
     528:	e3b5                	bnez	a5,58c <forkfork+0xae>
}
     52a:	70a2                	ld	ra,40(sp)
     52c:	7402                	ld	s0,32(sp)
     52e:	64e2                	ld	s1,24(sp)
     530:	6145                	addi	sp,sp,48
     532:	8082                	ret
      printf("%s: fork failed", s);
     534:	85a6                	mv	a1,s1
     536:	00005517          	auipc	a0,0x5
     53a:	aaa50513          	addi	a0,a0,-1366 # 4fe0 <malloc+0x5ce>
     53e:	00004097          	auipc	ra,0x4
     542:	414080e7          	jalr	1044(ra) # 4952 <printf>
      exit(1);
     546:	4505                	li	a0,1
     548:	00004097          	auipc	ra,0x4
     54c:	f74080e7          	jalr	-140(ra) # 44bc <exit>
{
     550:	0c800493          	li	s1,200
        int pid1 = fork();
     554:	00004097          	auipc	ra,0x4
     558:	f60080e7          	jalr	-160(ra) # 44b4 <fork>
        if(pid1 < 0){
     55c:	00054f63          	bltz	a0,57a <forkfork+0x9c>
        if(pid1 == 0){
     560:	c115                	beqz	a0,584 <forkfork+0xa6>
        wait(0);
     562:	4501                	li	a0,0
     564:	00004097          	auipc	ra,0x4
     568:	f60080e7          	jalr	-160(ra) # 44c4 <wait>
      for(int j = 0; j < 200; j++){
     56c:	34fd                	addiw	s1,s1,-1
     56e:	f0fd                	bnez	s1,554 <forkfork+0x76>
      exit(0);
     570:	4501                	li	a0,0
     572:	00004097          	auipc	ra,0x4
     576:	f4a080e7          	jalr	-182(ra) # 44bc <exit>
          exit(1);
     57a:	4505                	li	a0,1
     57c:	00004097          	auipc	ra,0x4
     580:	f40080e7          	jalr	-192(ra) # 44bc <exit>
          exit(0);
     584:	00004097          	auipc	ra,0x4
     588:	f38080e7          	jalr	-200(ra) # 44bc <exit>
      printf("%s: fork in child failed", s);
     58c:	85a6                	mv	a1,s1
     58e:	00005517          	auipc	a0,0x5
     592:	a6250513          	addi	a0,a0,-1438 # 4ff0 <malloc+0x5de>
     596:	00004097          	auipc	ra,0x4
     59a:	3bc080e7          	jalr	956(ra) # 4952 <printf>
      exit(1);
     59e:	4505                	li	a0,1
     5a0:	00004097          	auipc	ra,0x4
     5a4:	f1c080e7          	jalr	-228(ra) # 44bc <exit>

00000000000005a8 <reparent2>:
{
     5a8:	1101                	addi	sp,sp,-32
     5aa:	ec06                	sd	ra,24(sp)
     5ac:	e822                	sd	s0,16(sp)
     5ae:	e426                	sd	s1,8(sp)
     5b0:	1000                	addi	s0,sp,32
     5b2:	32000493          	li	s1,800
    int pid1 = fork();
     5b6:	00004097          	auipc	ra,0x4
     5ba:	efe080e7          	jalr	-258(ra) # 44b4 <fork>
    if(pid1 < 0){
     5be:	00054f63          	bltz	a0,5dc <reparent2+0x34>
    if(pid1 == 0){
     5c2:	c915                	beqz	a0,5f6 <reparent2+0x4e>
    wait(0);
     5c4:	4501                	li	a0,0
     5c6:	00004097          	auipc	ra,0x4
     5ca:	efe080e7          	jalr	-258(ra) # 44c4 <wait>
  for(int i = 0; i < 800; i++){
     5ce:	34fd                	addiw	s1,s1,-1
     5d0:	f0fd                	bnez	s1,5b6 <reparent2+0xe>
  exit(0);
     5d2:	4501                	li	a0,0
     5d4:	00004097          	auipc	ra,0x4
     5d8:	ee8080e7          	jalr	-280(ra) # 44bc <exit>
      printf("fork failed\n");
     5dc:	00005517          	auipc	a0,0x5
     5e0:	2bc50513          	addi	a0,a0,700 # 5898 <malloc+0xe86>
     5e4:	00004097          	auipc	ra,0x4
     5e8:	36e080e7          	jalr	878(ra) # 4952 <printf>
      exit(1);
     5ec:	4505                	li	a0,1
     5ee:	00004097          	auipc	ra,0x4
     5f2:	ece080e7          	jalr	-306(ra) # 44bc <exit>
      fork();
     5f6:	00004097          	auipc	ra,0x4
     5fa:	ebe080e7          	jalr	-322(ra) # 44b4 <fork>
      fork();
     5fe:	00004097          	auipc	ra,0x4
     602:	eb6080e7          	jalr	-330(ra) # 44b4 <fork>
      exit(0);
     606:	4501                	li	a0,0
     608:	00004097          	auipc	ra,0x4
     60c:	eb4080e7          	jalr	-332(ra) # 44bc <exit>

0000000000000610 <forktest>:
{
     610:	7179                	addi	sp,sp,-48
     612:	f406                	sd	ra,40(sp)
     614:	f022                	sd	s0,32(sp)
     616:	ec26                	sd	s1,24(sp)
     618:	e84a                	sd	s2,16(sp)
     61a:	e44e                	sd	s3,8(sp)
     61c:	1800                	addi	s0,sp,48
     61e:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
     620:	4481                	li	s1,0
     622:	3e800913          	li	s2,1000
    pid = fork();
     626:	00004097          	auipc	ra,0x4
     62a:	e8e080e7          	jalr	-370(ra) # 44b4 <fork>
    if(pid < 0)
     62e:	02054863          	bltz	a0,65e <forktest+0x4e>
    if(pid == 0)
     632:	c115                	beqz	a0,656 <forktest+0x46>
  for(n=0; n<N; n++){
     634:	2485                	addiw	s1,s1,1
     636:	ff2498e3          	bne	s1,s2,626 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
     63a:	85ce                	mv	a1,s3
     63c:	00005517          	auipc	a0,0x5
     640:	9ec50513          	addi	a0,a0,-1556 # 5028 <malloc+0x616>
     644:	00004097          	auipc	ra,0x4
     648:	30e080e7          	jalr	782(ra) # 4952 <printf>
    exit(1);
     64c:	4505                	li	a0,1
     64e:	00004097          	auipc	ra,0x4
     652:	e6e080e7          	jalr	-402(ra) # 44bc <exit>
      exit(0);
     656:	00004097          	auipc	ra,0x4
     65a:	e66080e7          	jalr	-410(ra) # 44bc <exit>
  if (n == 0) {
     65e:	cc9d                	beqz	s1,69c <forktest+0x8c>
  if(n == N){
     660:	3e800793          	li	a5,1000
     664:	fcf48be3          	beq	s1,a5,63a <forktest+0x2a>
  for(; n > 0; n--){
     668:	00905b63          	blez	s1,67e <forktest+0x6e>
    if(wait(0) < 0){
     66c:	4501                	li	a0,0
     66e:	00004097          	auipc	ra,0x4
     672:	e56080e7          	jalr	-426(ra) # 44c4 <wait>
     676:	04054163          	bltz	a0,6b8 <forktest+0xa8>
  for(; n > 0; n--){
     67a:	34fd                	addiw	s1,s1,-1
     67c:	f8e5                	bnez	s1,66c <forktest+0x5c>
  if(wait(0) != -1){
     67e:	4501                	li	a0,0
     680:	00004097          	auipc	ra,0x4
     684:	e44080e7          	jalr	-444(ra) # 44c4 <wait>
     688:	57fd                	li	a5,-1
     68a:	04f51563          	bne	a0,a5,6d4 <forktest+0xc4>
}
     68e:	70a2                	ld	ra,40(sp)
     690:	7402                	ld	s0,32(sp)
     692:	64e2                	ld	s1,24(sp)
     694:	6942                	ld	s2,16(sp)
     696:	69a2                	ld	s3,8(sp)
     698:	6145                	addi	sp,sp,48
     69a:	8082                	ret
    printf("%s: no fork at all!\n", s);
     69c:	85ce                	mv	a1,s3
     69e:	00005517          	auipc	a0,0x5
     6a2:	97250513          	addi	a0,a0,-1678 # 5010 <malloc+0x5fe>
     6a6:	00004097          	auipc	ra,0x4
     6aa:	2ac080e7          	jalr	684(ra) # 4952 <printf>
    exit(1);
     6ae:	4505                	li	a0,1
     6b0:	00004097          	auipc	ra,0x4
     6b4:	e0c080e7          	jalr	-500(ra) # 44bc <exit>
      printf("%s: wait stopped early\n", s);
     6b8:	85ce                	mv	a1,s3
     6ba:	00005517          	auipc	a0,0x5
     6be:	99650513          	addi	a0,a0,-1642 # 5050 <malloc+0x63e>
     6c2:	00004097          	auipc	ra,0x4
     6c6:	290080e7          	jalr	656(ra) # 4952 <printf>
      exit(1);
     6ca:	4505                	li	a0,1
     6cc:	00004097          	auipc	ra,0x4
     6d0:	df0080e7          	jalr	-528(ra) # 44bc <exit>
    printf("%s: wait got too many\n", s);
     6d4:	85ce                	mv	a1,s3
     6d6:	00005517          	auipc	a0,0x5
     6da:	99250513          	addi	a0,a0,-1646 # 5068 <malloc+0x656>
     6de:	00004097          	auipc	ra,0x4
     6e2:	274080e7          	jalr	628(ra) # 4952 <printf>
    exit(1);
     6e6:	4505                	li	a0,1
     6e8:	00004097          	auipc	ra,0x4
     6ec:	dd4080e7          	jalr	-556(ra) # 44bc <exit>

00000000000006f0 <kernmem>:
{
     6f0:	715d                	addi	sp,sp,-80
     6f2:	e486                	sd	ra,72(sp)
     6f4:	e0a2                	sd	s0,64(sp)
     6f6:	fc26                	sd	s1,56(sp)
     6f8:	f84a                	sd	s2,48(sp)
     6fa:	f44e                	sd	s3,40(sp)
     6fc:	f052                	sd	s4,32(sp)
     6fe:	ec56                	sd	s5,24(sp)
     700:	0880                	addi	s0,sp,80
     702:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     704:	4485                	li	s1,1
     706:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
     708:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     70a:	69b1                	lui	s3,0xc
     70c:	35098993          	addi	s3,s3,848 # c350 <buf+0x2f70>
     710:	1003d937          	lui	s2,0x1003d
     714:	090e                	slli	s2,s2,0x3
     716:	48090913          	addi	s2,s2,1152 # 1003d480 <_end+0x10030be0>
    pid = fork();
     71a:	00004097          	auipc	ra,0x4
     71e:	d9a080e7          	jalr	-614(ra) # 44b4 <fork>
    if(pid < 0){
     722:	02054963          	bltz	a0,754 <kernmem+0x64>
    if(pid == 0){
     726:	c529                	beqz	a0,770 <kernmem+0x80>
    wait(&xstatus);
     728:	fbc40513          	addi	a0,s0,-68
     72c:	00004097          	auipc	ra,0x4
     730:	d98080e7          	jalr	-616(ra) # 44c4 <wait>
    if(xstatus != -1)  // did kernel kill child?
     734:	fbc42783          	lw	a5,-68(s0)
     738:	05479c63          	bne	a5,s4,790 <kernmem+0xa0>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
     73c:	94ce                	add	s1,s1,s3
     73e:	fd249ee3          	bne	s1,s2,71a <kernmem+0x2a>
}
     742:	60a6                	ld	ra,72(sp)
     744:	6406                	ld	s0,64(sp)
     746:	74e2                	ld	s1,56(sp)
     748:	7942                	ld	s2,48(sp)
     74a:	79a2                	ld	s3,40(sp)
     74c:	7a02                	ld	s4,32(sp)
     74e:	6ae2                	ld	s5,24(sp)
     750:	6161                	addi	sp,sp,80
     752:	8082                	ret
      printf("%s: fork failed\n", s);
     754:	85d6                	mv	a1,s5
     756:	00005517          	auipc	a0,0x5
     75a:	82250513          	addi	a0,a0,-2014 # 4f78 <malloc+0x566>
     75e:	00004097          	auipc	ra,0x4
     762:	1f4080e7          	jalr	500(ra) # 4952 <printf>
      exit(1);
     766:	4505                	li	a0,1
     768:	00004097          	auipc	ra,0x4
     76c:	d54080e7          	jalr	-684(ra) # 44bc <exit>
      printf("%s: oops could read %x = %x\n", a, *a);
     770:	0004c603          	lbu	a2,0(s1)
     774:	85a6                	mv	a1,s1
     776:	00005517          	auipc	a0,0x5
     77a:	90a50513          	addi	a0,a0,-1782 # 5080 <malloc+0x66e>
     77e:	00004097          	auipc	ra,0x4
     782:	1d4080e7          	jalr	468(ra) # 4952 <printf>
      exit(1);
     786:	4505                	li	a0,1
     788:	00004097          	auipc	ra,0x4
     78c:	d34080e7          	jalr	-716(ra) # 44bc <exit>
      exit(1);
     790:	4505                	li	a0,1
     792:	00004097          	auipc	ra,0x4
     796:	d2a080e7          	jalr	-726(ra) # 44bc <exit>

000000000000079a <stacktest>:

// check that there's an invalid page beneath
// the user stack, to catch stack overflow.
void
stacktest(char *s)
{
     79a:	7179                	addi	sp,sp,-48
     79c:	f406                	sd	ra,40(sp)
     79e:	f022                	sd	s0,32(sp)
     7a0:	ec26                	sd	s1,24(sp)
     7a2:	1800                	addi	s0,sp,48
     7a4:	84aa                	mv	s1,a0
  int pid;
  int xstatus;
  
  pid = fork();
     7a6:	00004097          	auipc	ra,0x4
     7aa:	d0e080e7          	jalr	-754(ra) # 44b4 <fork>
  if(pid == 0) {
     7ae:	c115                	beqz	a0,7d2 <stacktest+0x38>
    char *sp = (char *) r_sp();
    sp -= PGSIZE;
    // the *sp should cause a trap.
    printf("%s: stacktest: read below stack %p\n", *sp);
    exit(1);
  } else if(pid < 0){
     7b0:	04054363          	bltz	a0,7f6 <stacktest+0x5c>
    printf("%s: fork failed\n", s);
    exit(1);
  }
  wait(&xstatus);
     7b4:	fdc40513          	addi	a0,s0,-36
     7b8:	00004097          	auipc	ra,0x4
     7bc:	d0c080e7          	jalr	-756(ra) # 44c4 <wait>
  if(xstatus == -1)  // kernel killed child?
     7c0:	fdc42503          	lw	a0,-36(s0)
     7c4:	57fd                	li	a5,-1
     7c6:	04f50663          	beq	a0,a5,812 <stacktest+0x78>
    exit(0);
  else
    exit(xstatus);
     7ca:	00004097          	auipc	ra,0x4
     7ce:	cf2080e7          	jalr	-782(ra) # 44bc <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
     7d2:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", *sp);
     7d4:	77fd                	lui	a5,0xfffff
     7d6:	97ba                	add	a5,a5,a4
     7d8:	0007c583          	lbu	a1,0(a5) # fffffffffffff000 <_end+0xffffffffffff2760>
     7dc:	00005517          	auipc	a0,0x5
     7e0:	8c450513          	addi	a0,a0,-1852 # 50a0 <malloc+0x68e>
     7e4:	00004097          	auipc	ra,0x4
     7e8:	16e080e7          	jalr	366(ra) # 4952 <printf>
    exit(1);
     7ec:	4505                	li	a0,1
     7ee:	00004097          	auipc	ra,0x4
     7f2:	cce080e7          	jalr	-818(ra) # 44bc <exit>
    printf("%s: fork failed\n", s);
     7f6:	85a6                	mv	a1,s1
     7f8:	00004517          	auipc	a0,0x4
     7fc:	78050513          	addi	a0,a0,1920 # 4f78 <malloc+0x566>
     800:	00004097          	auipc	ra,0x4
     804:	152080e7          	jalr	338(ra) # 4952 <printf>
    exit(1);
     808:	4505                	li	a0,1
     80a:	00004097          	auipc	ra,0x4
     80e:	cb2080e7          	jalr	-846(ra) # 44bc <exit>
    exit(0);
     812:	4501                	li	a0,0
     814:	00004097          	auipc	ra,0x4
     818:	ca8080e7          	jalr	-856(ra) # 44bc <exit>

000000000000081c <openiputtest>:
{
     81c:	7179                	addi	sp,sp,-48
     81e:	f406                	sd	ra,40(sp)
     820:	f022                	sd	s0,32(sp)
     822:	ec26                	sd	s1,24(sp)
     824:	1800                	addi	s0,sp,48
     826:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
     828:	00005517          	auipc	a0,0x5
     82c:	8a050513          	addi	a0,a0,-1888 # 50c8 <malloc+0x6b6>
     830:	00004097          	auipc	ra,0x4
     834:	cf4080e7          	jalr	-780(ra) # 4524 <mkdir>
     838:	04054263          	bltz	a0,87c <openiputtest+0x60>
  pid = fork();
     83c:	00004097          	auipc	ra,0x4
     840:	c78080e7          	jalr	-904(ra) # 44b4 <fork>
  if(pid < 0){
     844:	04054a63          	bltz	a0,898 <openiputtest+0x7c>
  if(pid == 0){
     848:	e93d                	bnez	a0,8be <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
     84a:	4589                	li	a1,2
     84c:	00005517          	auipc	a0,0x5
     850:	87c50513          	addi	a0,a0,-1924 # 50c8 <malloc+0x6b6>
     854:	00004097          	auipc	ra,0x4
     858:	ca8080e7          	jalr	-856(ra) # 44fc <open>
    if(fd >= 0){
     85c:	04054c63          	bltz	a0,8b4 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
     860:	85a6                	mv	a1,s1
     862:	00005517          	auipc	a0,0x5
     866:	88650513          	addi	a0,a0,-1914 # 50e8 <malloc+0x6d6>
     86a:	00004097          	auipc	ra,0x4
     86e:	0e8080e7          	jalr	232(ra) # 4952 <printf>
      exit(1);
     872:	4505                	li	a0,1
     874:	00004097          	auipc	ra,0x4
     878:	c48080e7          	jalr	-952(ra) # 44bc <exit>
    printf("%s: mkdir oidir failed\n", s);
     87c:	85a6                	mv	a1,s1
     87e:	00005517          	auipc	a0,0x5
     882:	85250513          	addi	a0,a0,-1966 # 50d0 <malloc+0x6be>
     886:	00004097          	auipc	ra,0x4
     88a:	0cc080e7          	jalr	204(ra) # 4952 <printf>
    exit(1);
     88e:	4505                	li	a0,1
     890:	00004097          	auipc	ra,0x4
     894:	c2c080e7          	jalr	-980(ra) # 44bc <exit>
    printf("%s: fork failed\n", s);
     898:	85a6                	mv	a1,s1
     89a:	00004517          	auipc	a0,0x4
     89e:	6de50513          	addi	a0,a0,1758 # 4f78 <malloc+0x566>
     8a2:	00004097          	auipc	ra,0x4
     8a6:	0b0080e7          	jalr	176(ra) # 4952 <printf>
    exit(1);
     8aa:	4505                	li	a0,1
     8ac:	00004097          	auipc	ra,0x4
     8b0:	c10080e7          	jalr	-1008(ra) # 44bc <exit>
    exit(0);
     8b4:	4501                	li	a0,0
     8b6:	00004097          	auipc	ra,0x4
     8ba:	c06080e7          	jalr	-1018(ra) # 44bc <exit>
  sleep(1);
     8be:	4505                	li	a0,1
     8c0:	00004097          	auipc	ra,0x4
     8c4:	c8c080e7          	jalr	-884(ra) # 454c <sleep>
  if(unlink("oidir") != 0){
     8c8:	00005517          	auipc	a0,0x5
     8cc:	80050513          	addi	a0,a0,-2048 # 50c8 <malloc+0x6b6>
     8d0:	00004097          	auipc	ra,0x4
     8d4:	c3c080e7          	jalr	-964(ra) # 450c <unlink>
     8d8:	cd19                	beqz	a0,8f6 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
     8da:	85a6                	mv	a1,s1
     8dc:	00005517          	auipc	a0,0x5
     8e0:	83450513          	addi	a0,a0,-1996 # 5110 <malloc+0x6fe>
     8e4:	00004097          	auipc	ra,0x4
     8e8:	06e080e7          	jalr	110(ra) # 4952 <printf>
    exit(1);
     8ec:	4505                	li	a0,1
     8ee:	00004097          	auipc	ra,0x4
     8f2:	bce080e7          	jalr	-1074(ra) # 44bc <exit>
  wait(&xstatus);
     8f6:	fdc40513          	addi	a0,s0,-36
     8fa:	00004097          	auipc	ra,0x4
     8fe:	bca080e7          	jalr	-1078(ra) # 44c4 <wait>
  exit(xstatus);
     902:	fdc42503          	lw	a0,-36(s0)
     906:	00004097          	auipc	ra,0x4
     90a:	bb6080e7          	jalr	-1098(ra) # 44bc <exit>

000000000000090e <opentest>:
{
     90e:	1101                	addi	sp,sp,-32
     910:	ec06                	sd	ra,24(sp)
     912:	e822                	sd	s0,16(sp)
     914:	e426                	sd	s1,8(sp)
     916:	1000                	addi	s0,sp,32
     918:	84aa                	mv	s1,a0
  fd = open("echo", 0);
     91a:	4581                	li	a1,0
     91c:	00005517          	auipc	a0,0x5
     920:	80c50513          	addi	a0,a0,-2036 # 5128 <malloc+0x716>
     924:	00004097          	auipc	ra,0x4
     928:	bd8080e7          	jalr	-1064(ra) # 44fc <open>
  if(fd < 0){
     92c:	02054663          	bltz	a0,958 <opentest+0x4a>
  close(fd);
     930:	00004097          	auipc	ra,0x4
     934:	af0080e7          	jalr	-1296(ra) # 4420 <close>
  fd = open("doesnotexist", 0);
     938:	4581                	li	a1,0
     93a:	00005517          	auipc	a0,0x5
     93e:	80e50513          	addi	a0,a0,-2034 # 5148 <malloc+0x736>
     942:	00004097          	auipc	ra,0x4
     946:	bba080e7          	jalr	-1094(ra) # 44fc <open>
  if(fd >= 0){
     94a:	02055563          	bgez	a0,974 <opentest+0x66>
}
     94e:	60e2                	ld	ra,24(sp)
     950:	6442                	ld	s0,16(sp)
     952:	64a2                	ld	s1,8(sp)
     954:	6105                	addi	sp,sp,32
     956:	8082                	ret
    printf("%s: open echo failed!\n", s);
     958:	85a6                	mv	a1,s1
     95a:	00004517          	auipc	a0,0x4
     95e:	7d650513          	addi	a0,a0,2006 # 5130 <malloc+0x71e>
     962:	00004097          	auipc	ra,0x4
     966:	ff0080e7          	jalr	-16(ra) # 4952 <printf>
    exit(1);
     96a:	4505                	li	a0,1
     96c:	00004097          	auipc	ra,0x4
     970:	b50080e7          	jalr	-1200(ra) # 44bc <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     974:	85a6                	mv	a1,s1
     976:	00004517          	auipc	a0,0x4
     97a:	7e250513          	addi	a0,a0,2018 # 5158 <malloc+0x746>
     97e:	00004097          	auipc	ra,0x4
     982:	fd4080e7          	jalr	-44(ra) # 4952 <printf>
    exit(1);
     986:	4505                	li	a0,1
     988:	00004097          	auipc	ra,0x4
     98c:	b34080e7          	jalr	-1228(ra) # 44bc <exit>

0000000000000990 <createtest>:
{
     990:	7179                	addi	sp,sp,-48
     992:	f406                	sd	ra,40(sp)
     994:	f022                	sd	s0,32(sp)
     996:	ec26                	sd	s1,24(sp)
     998:	e84a                	sd	s2,16(sp)
     99a:	e44e                	sd	s3,8(sp)
     99c:	1800                	addi	s0,sp,48
  name[0] = 'a';
     99e:	00006797          	auipc	a5,0x6
     9a2:	22278793          	addi	a5,a5,546 # 6bc0 <_edata>
     9a6:	06100713          	li	a4,97
     9aa:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     9ae:	00078123          	sb	zero,2(a5)
     9b2:	03000493          	li	s1,48
    name[1] = '0' + i;
     9b6:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     9b8:	06400993          	li	s3,100
    name[1] = '0' + i;
     9bc:	009900a3          	sb	s1,1(s2)
    fd = open(name, O_CREATE|O_RDWR);
     9c0:	20200593          	li	a1,514
     9c4:	854a                	mv	a0,s2
     9c6:	00004097          	auipc	ra,0x4
     9ca:	b36080e7          	jalr	-1226(ra) # 44fc <open>
    close(fd);
     9ce:	00004097          	auipc	ra,0x4
     9d2:	a52080e7          	jalr	-1454(ra) # 4420 <close>
  for(i = 0; i < N; i++){
     9d6:	2485                	addiw	s1,s1,1
     9d8:	0ff4f493          	andi	s1,s1,255
     9dc:	ff3490e3          	bne	s1,s3,9bc <createtest+0x2c>
  name[0] = 'a';
     9e0:	00006797          	auipc	a5,0x6
     9e4:	1e078793          	addi	a5,a5,480 # 6bc0 <_edata>
     9e8:	06100713          	li	a4,97
     9ec:	00e78023          	sb	a4,0(a5)
  name[2] = '\0';
     9f0:	00078123          	sb	zero,2(a5)
     9f4:	03000493          	li	s1,48
    name[1] = '0' + i;
     9f8:	893e                	mv	s2,a5
  for(i = 0; i < N; i++){
     9fa:	06400993          	li	s3,100
    name[1] = '0' + i;
     9fe:	009900a3          	sb	s1,1(s2)
    unlink(name);
     a02:	854a                	mv	a0,s2
     a04:	00004097          	auipc	ra,0x4
     a08:	b08080e7          	jalr	-1272(ra) # 450c <unlink>
  for(i = 0; i < N; i++){
     a0c:	2485                	addiw	s1,s1,1
     a0e:	0ff4f493          	andi	s1,s1,255
     a12:	ff3496e3          	bne	s1,s3,9fe <createtest+0x6e>
}
     a16:	70a2                	ld	ra,40(sp)
     a18:	7402                	ld	s0,32(sp)
     a1a:	64e2                	ld	s1,24(sp)
     a1c:	6942                	ld	s2,16(sp)
     a1e:	69a2                	ld	s3,8(sp)
     a20:	6145                	addi	sp,sp,48
     a22:	8082                	ret

0000000000000a24 <forkforkfork>:
{
     a24:	1101                	addi	sp,sp,-32
     a26:	ec06                	sd	ra,24(sp)
     a28:	e822                	sd	s0,16(sp)
     a2a:	e426                	sd	s1,8(sp)
     a2c:	1000                	addi	s0,sp,32
     a2e:	84aa                	mv	s1,a0
  unlink("stopforking");
     a30:	00004517          	auipc	a0,0x4
     a34:	75050513          	addi	a0,a0,1872 # 5180 <malloc+0x76e>
     a38:	00004097          	auipc	ra,0x4
     a3c:	ad4080e7          	jalr	-1324(ra) # 450c <unlink>
  int pid = fork();
     a40:	00004097          	auipc	ra,0x4
     a44:	a74080e7          	jalr	-1420(ra) # 44b4 <fork>
  if(pid < 0){
     a48:	04054563          	bltz	a0,a92 <forkforkfork+0x6e>
  if(pid == 0){
     a4c:	c12d                	beqz	a0,aae <forkforkfork+0x8a>
  sleep(20); // two seconds
     a4e:	4551                	li	a0,20
     a50:	00004097          	auipc	ra,0x4
     a54:	afc080e7          	jalr	-1284(ra) # 454c <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
     a58:	20200593          	li	a1,514
     a5c:	00004517          	auipc	a0,0x4
     a60:	72450513          	addi	a0,a0,1828 # 5180 <malloc+0x76e>
     a64:	00004097          	auipc	ra,0x4
     a68:	a98080e7          	jalr	-1384(ra) # 44fc <open>
     a6c:	00004097          	auipc	ra,0x4
     a70:	9b4080e7          	jalr	-1612(ra) # 4420 <close>
  wait(0);
     a74:	4501                	li	a0,0
     a76:	00004097          	auipc	ra,0x4
     a7a:	a4e080e7          	jalr	-1458(ra) # 44c4 <wait>
  sleep(10); // one second
     a7e:	4529                	li	a0,10
     a80:	00004097          	auipc	ra,0x4
     a84:	acc080e7          	jalr	-1332(ra) # 454c <sleep>
}
     a88:	60e2                	ld	ra,24(sp)
     a8a:	6442                	ld	s0,16(sp)
     a8c:	64a2                	ld	s1,8(sp)
     a8e:	6105                	addi	sp,sp,32
     a90:	8082                	ret
    printf("%s: fork failed", s);
     a92:	85a6                	mv	a1,s1
     a94:	00004517          	auipc	a0,0x4
     a98:	54c50513          	addi	a0,a0,1356 # 4fe0 <malloc+0x5ce>
     a9c:	00004097          	auipc	ra,0x4
     aa0:	eb6080e7          	jalr	-330(ra) # 4952 <printf>
    exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00004097          	auipc	ra,0x4
     aaa:	a16080e7          	jalr	-1514(ra) # 44bc <exit>
      int fd = open("stopforking", 0);
     aae:	00004497          	auipc	s1,0x4
     ab2:	6d248493          	addi	s1,s1,1746 # 5180 <malloc+0x76e>
     ab6:	4581                	li	a1,0
     ab8:	8526                	mv	a0,s1
     aba:	00004097          	auipc	ra,0x4
     abe:	a42080e7          	jalr	-1470(ra) # 44fc <open>
      if(fd >= 0){
     ac2:	02055463          	bgez	a0,aea <forkforkfork+0xc6>
      if(fork() < 0){
     ac6:	00004097          	auipc	ra,0x4
     aca:	9ee080e7          	jalr	-1554(ra) # 44b4 <fork>
     ace:	fe0554e3          	bgez	a0,ab6 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
     ad2:	20200593          	li	a1,514
     ad6:	8526                	mv	a0,s1
     ad8:	00004097          	auipc	ra,0x4
     adc:	a24080e7          	jalr	-1500(ra) # 44fc <open>
     ae0:	00004097          	auipc	ra,0x4
     ae4:	940080e7          	jalr	-1728(ra) # 4420 <close>
     ae8:	b7f9                	j	ab6 <forkforkfork+0x92>
        exit(0);
     aea:	4501                	li	a0,0
     aec:	00004097          	auipc	ra,0x4
     af0:	9d0080e7          	jalr	-1584(ra) # 44bc <exit>

0000000000000af4 <createdelete>:
{
     af4:	7175                	addi	sp,sp,-144
     af6:	e506                	sd	ra,136(sp)
     af8:	e122                	sd	s0,128(sp)
     afa:	fca6                	sd	s1,120(sp)
     afc:	f8ca                	sd	s2,112(sp)
     afe:	f4ce                	sd	s3,104(sp)
     b00:	f0d2                	sd	s4,96(sp)
     b02:	ecd6                	sd	s5,88(sp)
     b04:	e8da                	sd	s6,80(sp)
     b06:	e4de                	sd	s7,72(sp)
     b08:	e0e2                	sd	s8,64(sp)
     b0a:	fc66                	sd	s9,56(sp)
     b0c:	0900                	addi	s0,sp,144
     b0e:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
     b10:	4901                	li	s2,0
     b12:	4991                	li	s3,4
    pid = fork();
     b14:	00004097          	auipc	ra,0x4
     b18:	9a0080e7          	jalr	-1632(ra) # 44b4 <fork>
     b1c:	84aa                	mv	s1,a0
    if(pid < 0){
     b1e:	02054f63          	bltz	a0,b5c <createdelete+0x68>
    if(pid == 0){
     b22:	c939                	beqz	a0,b78 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
     b24:	2905                	addiw	s2,s2,1
     b26:	ff3917e3          	bne	s2,s3,b14 <createdelete+0x20>
     b2a:	4491                	li	s1,4
    wait(&xstatus);
     b2c:	f7c40513          	addi	a0,s0,-132
     b30:	00004097          	auipc	ra,0x4
     b34:	994080e7          	jalr	-1644(ra) # 44c4 <wait>
    if(xstatus != 0)
     b38:	f7c42903          	lw	s2,-132(s0)
     b3c:	0e091263          	bnez	s2,c20 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
     b40:	34fd                	addiw	s1,s1,-1
     b42:	f4ed                	bnez	s1,b2c <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
     b44:	f8040123          	sb	zero,-126(s0)
     b48:	03000993          	li	s3,48
     b4c:	5a7d                	li	s4,-1
     b4e:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
     b52:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
     b54:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
     b56:	07400a93          	li	s5,116
     b5a:	a29d                	j	cc0 <createdelete+0x1cc>
      printf("fork failed\n", s);
     b5c:	85e6                	mv	a1,s9
     b5e:	00005517          	auipc	a0,0x5
     b62:	d3a50513          	addi	a0,a0,-710 # 5898 <malloc+0xe86>
     b66:	00004097          	auipc	ra,0x4
     b6a:	dec080e7          	jalr	-532(ra) # 4952 <printf>
      exit(1);
     b6e:	4505                	li	a0,1
     b70:	00004097          	auipc	ra,0x4
     b74:	94c080e7          	jalr	-1716(ra) # 44bc <exit>
      name[0] = 'p' + pi;
     b78:	0709091b          	addiw	s2,s2,112
     b7c:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
     b80:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
     b84:	4951                	li	s2,20
     b86:	a015                	j	baa <createdelete+0xb6>
          printf("%s: create failed\n", s);
     b88:	85e6                	mv	a1,s9
     b8a:	00004517          	auipc	a0,0x4
     b8e:	60650513          	addi	a0,a0,1542 # 5190 <malloc+0x77e>
     b92:	00004097          	auipc	ra,0x4
     b96:	dc0080e7          	jalr	-576(ra) # 4952 <printf>
          exit(1);
     b9a:	4505                	li	a0,1
     b9c:	00004097          	auipc	ra,0x4
     ba0:	920080e7          	jalr	-1760(ra) # 44bc <exit>
      for(i = 0; i < N; i++){
     ba4:	2485                	addiw	s1,s1,1
     ba6:	07248863          	beq	s1,s2,c16 <createdelete+0x122>
        name[1] = '0' + i;
     baa:	0304879b          	addiw	a5,s1,48
     bae:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
     bb2:	20200593          	li	a1,514
     bb6:	f8040513          	addi	a0,s0,-128
     bba:	00004097          	auipc	ra,0x4
     bbe:	942080e7          	jalr	-1726(ra) # 44fc <open>
        if(fd < 0){
     bc2:	fc0543e3          	bltz	a0,b88 <createdelete+0x94>
        close(fd);
     bc6:	00004097          	auipc	ra,0x4
     bca:	85a080e7          	jalr	-1958(ra) # 4420 <close>
        if(i > 0 && (i % 2 ) == 0){
     bce:	fc905be3          	blez	s1,ba4 <createdelete+0xb0>
     bd2:	0014f793          	andi	a5,s1,1
     bd6:	f7f9                	bnez	a5,ba4 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
     bd8:	01f4d79b          	srliw	a5,s1,0x1f
     bdc:	9fa5                	addw	a5,a5,s1
     bde:	4017d79b          	sraiw	a5,a5,0x1
     be2:	0307879b          	addiw	a5,a5,48
     be6:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
     bea:	f8040513          	addi	a0,s0,-128
     bee:	00004097          	auipc	ra,0x4
     bf2:	91e080e7          	jalr	-1762(ra) # 450c <unlink>
     bf6:	fa0557e3          	bgez	a0,ba4 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
     bfa:	85e6                	mv	a1,s9
     bfc:	00004517          	auipc	a0,0x4
     c00:	51450513          	addi	a0,a0,1300 # 5110 <malloc+0x6fe>
     c04:	00004097          	auipc	ra,0x4
     c08:	d4e080e7          	jalr	-690(ra) # 4952 <printf>
            exit(1);
     c0c:	4505                	li	a0,1
     c0e:	00004097          	auipc	ra,0x4
     c12:	8ae080e7          	jalr	-1874(ra) # 44bc <exit>
      exit(0);
     c16:	4501                	li	a0,0
     c18:	00004097          	auipc	ra,0x4
     c1c:	8a4080e7          	jalr	-1884(ra) # 44bc <exit>
      exit(1);
     c20:	4505                	li	a0,1
     c22:	00004097          	auipc	ra,0x4
     c26:	89a080e7          	jalr	-1894(ra) # 44bc <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
     c2a:	f8040613          	addi	a2,s0,-128
     c2e:	85e6                	mv	a1,s9
     c30:	00004517          	auipc	a0,0x4
     c34:	57850513          	addi	a0,a0,1400 # 51a8 <malloc+0x796>
     c38:	00004097          	auipc	ra,0x4
     c3c:	d1a080e7          	jalr	-742(ra) # 4952 <printf>
        exit(1);
     c40:	4505                	li	a0,1
     c42:	00004097          	auipc	ra,0x4
     c46:	87a080e7          	jalr	-1926(ra) # 44bc <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c4a:	054b7163          	bleu	s4,s6,c8c <createdelete+0x198>
      if(fd >= 0)
     c4e:	02055a63          	bgez	a0,c82 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
     c52:	2485                	addiw	s1,s1,1
     c54:	0ff4f493          	andi	s1,s1,255
     c58:	05548c63          	beq	s1,s5,cb0 <createdelete+0x1bc>
      name[0] = 'p' + pi;
     c5c:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
     c60:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
     c64:	4581                	li	a1,0
     c66:	f8040513          	addi	a0,s0,-128
     c6a:	00004097          	auipc	ra,0x4
     c6e:	892080e7          	jalr	-1902(ra) # 44fc <open>
      if((i == 0 || i >= N/2) && fd < 0){
     c72:	00090463          	beqz	s2,c7a <createdelete+0x186>
     c76:	fd2bdae3          	ble	s2,s7,c4a <createdelete+0x156>
     c7a:	fa0548e3          	bltz	a0,c2a <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c7e:	014b7963          	bleu	s4,s6,c90 <createdelete+0x19c>
        close(fd);
     c82:	00003097          	auipc	ra,0x3
     c86:	79e080e7          	jalr	1950(ra) # 4420 <close>
     c8a:	b7e1                	j	c52 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     c8c:	fc0543e3          	bltz	a0,c52 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
     c90:	f8040613          	addi	a2,s0,-128
     c94:	85e6                	mv	a1,s9
     c96:	00004517          	auipc	a0,0x4
     c9a:	53a50513          	addi	a0,a0,1338 # 51d0 <malloc+0x7be>
     c9e:	00004097          	auipc	ra,0x4
     ca2:	cb4080e7          	jalr	-844(ra) # 4952 <printf>
        exit(1);
     ca6:	4505                	li	a0,1
     ca8:	00004097          	auipc	ra,0x4
     cac:	814080e7          	jalr	-2028(ra) # 44bc <exit>
  for(i = 0; i < N; i++){
     cb0:	2905                	addiw	s2,s2,1
     cb2:	2a05                	addiw	s4,s4,1
     cb4:	2985                	addiw	s3,s3,1
     cb6:	0ff9f993          	andi	s3,s3,255
     cba:	47d1                	li	a5,20
     cbc:	02f90a63          	beq	s2,a5,cf0 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
     cc0:	84e2                	mv	s1,s8
     cc2:	bf69                	j	c5c <createdelete+0x168>
  for(i = 0; i < N; i++){
     cc4:	2905                	addiw	s2,s2,1
     cc6:	0ff97913          	andi	s2,s2,255
     cca:	2985                	addiw	s3,s3,1
     ccc:	0ff9f993          	andi	s3,s3,255
     cd0:	03490863          	beq	s2,s4,d00 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
     cd4:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
     cd6:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
     cda:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
     cde:	f8040513          	addi	a0,s0,-128
     ce2:	00004097          	auipc	ra,0x4
     ce6:	82a080e7          	jalr	-2006(ra) # 450c <unlink>
    for(pi = 0; pi < NCHILD; pi++){
     cea:	34fd                	addiw	s1,s1,-1
     cec:	f4ed                	bnez	s1,cd6 <createdelete+0x1e2>
     cee:	bfd9                	j	cc4 <createdelete+0x1d0>
     cf0:	03000993          	li	s3,48
     cf4:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
     cf8:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
     cfa:	08400a13          	li	s4,132
     cfe:	bfd9                	j	cd4 <createdelete+0x1e0>
}
     d00:	60aa                	ld	ra,136(sp)
     d02:	640a                	ld	s0,128(sp)
     d04:	74e6                	ld	s1,120(sp)
     d06:	7946                	ld	s2,112(sp)
     d08:	79a6                	ld	s3,104(sp)
     d0a:	7a06                	ld	s4,96(sp)
     d0c:	6ae6                	ld	s5,88(sp)
     d0e:	6b46                	ld	s6,80(sp)
     d10:	6ba6                	ld	s7,72(sp)
     d12:	6c06                	ld	s8,64(sp)
     d14:	7ce2                	ld	s9,56(sp)
     d16:	6149                	addi	sp,sp,144
     d18:	8082                	ret

0000000000000d1a <fourteen>:
{
     d1a:	1101                	addi	sp,sp,-32
     d1c:	ec06                	sd	ra,24(sp)
     d1e:	e822                	sd	s0,16(sp)
     d20:	e426                	sd	s1,8(sp)
     d22:	1000                	addi	s0,sp,32
     d24:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
     d26:	00004517          	auipc	a0,0x4
     d2a:	6a250513          	addi	a0,a0,1698 # 53c8 <malloc+0x9b6>
     d2e:	00003097          	auipc	ra,0x3
     d32:	7f6080e7          	jalr	2038(ra) # 4524 <mkdir>
     d36:	e141                	bnez	a0,db6 <fourteen+0x9c>
  if(mkdir("12345678901234/123456789012345") != 0){
     d38:	00004517          	auipc	a0,0x4
     d3c:	4e850513          	addi	a0,a0,1256 # 5220 <malloc+0x80e>
     d40:	00003097          	auipc	ra,0x3
     d44:	7e4080e7          	jalr	2020(ra) # 4524 <mkdir>
     d48:	e549                	bnez	a0,dd2 <fourteen+0xb8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     d4a:	20000593          	li	a1,512
     d4e:	00004517          	auipc	a0,0x4
     d52:	52a50513          	addi	a0,a0,1322 # 5278 <malloc+0x866>
     d56:	00003097          	auipc	ra,0x3
     d5a:	7a6080e7          	jalr	1958(ra) # 44fc <open>
  if(fd < 0){
     d5e:	08054863          	bltz	a0,dee <fourteen+0xd4>
  close(fd);
     d62:	00003097          	auipc	ra,0x3
     d66:	6be080e7          	jalr	1726(ra) # 4420 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     d6a:	4581                	li	a1,0
     d6c:	00004517          	auipc	a0,0x4
     d70:	58450513          	addi	a0,a0,1412 # 52f0 <malloc+0x8de>
     d74:	00003097          	auipc	ra,0x3
     d78:	788080e7          	jalr	1928(ra) # 44fc <open>
  if(fd < 0){
     d7c:	08054763          	bltz	a0,e0a <fourteen+0xf0>
  close(fd);
     d80:	00003097          	auipc	ra,0x3
     d84:	6a0080e7          	jalr	1696(ra) # 4420 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
     d88:	00004517          	auipc	a0,0x4
     d8c:	5d850513          	addi	a0,a0,1496 # 5360 <malloc+0x94e>
     d90:	00003097          	auipc	ra,0x3
     d94:	794080e7          	jalr	1940(ra) # 4524 <mkdir>
     d98:	c559                	beqz	a0,e26 <fourteen+0x10c>
  if(mkdir("123456789012345/12345678901234") == 0){
     d9a:	00004517          	auipc	a0,0x4
     d9e:	61e50513          	addi	a0,a0,1566 # 53b8 <malloc+0x9a6>
     da2:	00003097          	auipc	ra,0x3
     da6:	782080e7          	jalr	1922(ra) # 4524 <mkdir>
     daa:	cd41                	beqz	a0,e42 <fourteen+0x128>
}
     dac:	60e2                	ld	ra,24(sp)
     dae:	6442                	ld	s0,16(sp)
     db0:	64a2                	ld	s1,8(sp)
     db2:	6105                	addi	sp,sp,32
     db4:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
     db6:	85a6                	mv	a1,s1
     db8:	00004517          	auipc	a0,0x4
     dbc:	44050513          	addi	a0,a0,1088 # 51f8 <malloc+0x7e6>
     dc0:	00004097          	auipc	ra,0x4
     dc4:	b92080e7          	jalr	-1134(ra) # 4952 <printf>
    exit(1);
     dc8:	4505                	li	a0,1
     dca:	00003097          	auipc	ra,0x3
     dce:	6f2080e7          	jalr	1778(ra) # 44bc <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
     dd2:	85a6                	mv	a1,s1
     dd4:	00004517          	auipc	a0,0x4
     dd8:	46c50513          	addi	a0,a0,1132 # 5240 <malloc+0x82e>
     ddc:	00004097          	auipc	ra,0x4
     de0:	b76080e7          	jalr	-1162(ra) # 4952 <printf>
    exit(1);
     de4:	4505                	li	a0,1
     de6:	00003097          	auipc	ra,0x3
     dea:	6d6080e7          	jalr	1750(ra) # 44bc <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
     dee:	85a6                	mv	a1,s1
     df0:	00004517          	auipc	a0,0x4
     df4:	4b850513          	addi	a0,a0,1208 # 52a8 <malloc+0x896>
     df8:	00004097          	auipc	ra,0x4
     dfc:	b5a080e7          	jalr	-1190(ra) # 4952 <printf>
    exit(1);
     e00:	4505                	li	a0,1
     e02:	00003097          	auipc	ra,0x3
     e06:	6ba080e7          	jalr	1722(ra) # 44bc <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
     e0a:	85a6                	mv	a1,s1
     e0c:	00004517          	auipc	a0,0x4
     e10:	51450513          	addi	a0,a0,1300 # 5320 <malloc+0x90e>
     e14:	00004097          	auipc	ra,0x4
     e18:	b3e080e7          	jalr	-1218(ra) # 4952 <printf>
    exit(1);
     e1c:	4505                	li	a0,1
     e1e:	00003097          	auipc	ra,0x3
     e22:	69e080e7          	jalr	1694(ra) # 44bc <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
     e26:	85a6                	mv	a1,s1
     e28:	00004517          	auipc	a0,0x4
     e2c:	55850513          	addi	a0,a0,1368 # 5380 <malloc+0x96e>
     e30:	00004097          	auipc	ra,0x4
     e34:	b22080e7          	jalr	-1246(ra) # 4952 <printf>
    exit(1);
     e38:	4505                	li	a0,1
     e3a:	00003097          	auipc	ra,0x3
     e3e:	682080e7          	jalr	1666(ra) # 44bc <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
     e42:	85a6                	mv	a1,s1
     e44:	00004517          	auipc	a0,0x4
     e48:	59450513          	addi	a0,a0,1428 # 53d8 <malloc+0x9c6>
     e4c:	00004097          	auipc	ra,0x4
     e50:	b06080e7          	jalr	-1274(ra) # 4952 <printf>
    exit(1);
     e54:	4505                	li	a0,1
     e56:	00003097          	auipc	ra,0x3
     e5a:	666080e7          	jalr	1638(ra) # 44bc <exit>

0000000000000e5e <bigwrite>:
{
     e5e:	715d                	addi	sp,sp,-80
     e60:	e486                	sd	ra,72(sp)
     e62:	e0a2                	sd	s0,64(sp)
     e64:	fc26                	sd	s1,56(sp)
     e66:	f84a                	sd	s2,48(sp)
     e68:	f44e                	sd	s3,40(sp)
     e6a:	f052                	sd	s4,32(sp)
     e6c:	ec56                	sd	s5,24(sp)
     e6e:	e85a                	sd	s6,16(sp)
     e70:	e45e                	sd	s7,8(sp)
     e72:	0880                	addi	s0,sp,80
     e74:	8baa                	mv	s7,a0
  unlink("bigwrite");
     e76:	00004517          	auipc	a0,0x4
     e7a:	59a50513          	addi	a0,a0,1434 # 5410 <malloc+0x9fe>
     e7e:	00003097          	auipc	ra,0x3
     e82:	68e080e7          	jalr	1678(ra) # 450c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     e86:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     e8a:	00004a17          	auipc	s4,0x4
     e8e:	586a0a13          	addi	s4,s4,1414 # 5410 <malloc+0x9fe>
      int cc = write(fd, buf, sz);
     e92:	00008997          	auipc	s3,0x8
     e96:	54e98993          	addi	s3,s3,1358 # 93e0 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     e9a:	6b0d                	lui	s6,0x3
     e9c:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirfile+0xd>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     ea0:	20200593          	li	a1,514
     ea4:	8552                	mv	a0,s4
     ea6:	00003097          	auipc	ra,0x3
     eaa:	656080e7          	jalr	1622(ra) # 44fc <open>
     eae:	892a                	mv	s2,a0
    if(fd < 0){
     eb0:	04054d63          	bltz	a0,f0a <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     eb4:	8626                	mv	a2,s1
     eb6:	85ce                	mv	a1,s3
     eb8:	00003097          	auipc	ra,0x3
     ebc:	624080e7          	jalr	1572(ra) # 44dc <write>
     ec0:	8aaa                	mv	s5,a0
      if(cc != sz){
     ec2:	06a49463          	bne	s1,a0,f2a <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     ec6:	8626                	mv	a2,s1
     ec8:	85ce                	mv	a1,s3
     eca:	854a                	mv	a0,s2
     ecc:	00003097          	auipc	ra,0x3
     ed0:	610080e7          	jalr	1552(ra) # 44dc <write>
      if(cc != sz){
     ed4:	04951963          	bne	a0,s1,f26 <bigwrite+0xc8>
    close(fd);
     ed8:	854a                	mv	a0,s2
     eda:	00003097          	auipc	ra,0x3
     ede:	546080e7          	jalr	1350(ra) # 4420 <close>
    unlink("bigwrite");
     ee2:	8552                	mv	a0,s4
     ee4:	00003097          	auipc	ra,0x3
     ee8:	628080e7          	jalr	1576(ra) # 450c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     eec:	1d74849b          	addiw	s1,s1,471
     ef0:	fb6498e3          	bne	s1,s6,ea0 <bigwrite+0x42>
}
     ef4:	60a6                	ld	ra,72(sp)
     ef6:	6406                	ld	s0,64(sp)
     ef8:	74e2                	ld	s1,56(sp)
     efa:	7942                	ld	s2,48(sp)
     efc:	79a2                	ld	s3,40(sp)
     efe:	7a02                	ld	s4,32(sp)
     f00:	6ae2                	ld	s5,24(sp)
     f02:	6b42                	ld	s6,16(sp)
     f04:	6ba2                	ld	s7,8(sp)
     f06:	6161                	addi	sp,sp,80
     f08:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     f0a:	85de                	mv	a1,s7
     f0c:	00004517          	auipc	a0,0x4
     f10:	51450513          	addi	a0,a0,1300 # 5420 <malloc+0xa0e>
     f14:	00004097          	auipc	ra,0x4
     f18:	a3e080e7          	jalr	-1474(ra) # 4952 <printf>
      exit(1);
     f1c:	4505                	li	a0,1
     f1e:	00003097          	auipc	ra,0x3
     f22:	59e080e7          	jalr	1438(ra) # 44bc <exit>
     f26:	84d6                	mv	s1,s5
      int cc = write(fd, buf, sz);
     f28:	8aaa                	mv	s5,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     f2a:	86d6                	mv	a3,s5
     f2c:	8626                	mv	a2,s1
     f2e:	85de                	mv	a1,s7
     f30:	00004517          	auipc	a0,0x4
     f34:	51050513          	addi	a0,a0,1296 # 5440 <malloc+0xa2e>
     f38:	00004097          	auipc	ra,0x4
     f3c:	a1a080e7          	jalr	-1510(ra) # 4952 <printf>
        exit(1);
     f40:	4505                	li	a0,1
     f42:	00003097          	auipc	ra,0x3
     f46:	57a080e7          	jalr	1402(ra) # 44bc <exit>

0000000000000f4a <writetest>:
{
     f4a:	7139                	addi	sp,sp,-64
     f4c:	fc06                	sd	ra,56(sp)
     f4e:	f822                	sd	s0,48(sp)
     f50:	f426                	sd	s1,40(sp)
     f52:	f04a                	sd	s2,32(sp)
     f54:	ec4e                	sd	s3,24(sp)
     f56:	e852                	sd	s4,16(sp)
     f58:	e456                	sd	s5,8(sp)
     f5a:	e05a                	sd	s6,0(sp)
     f5c:	0080                	addi	s0,sp,64
     f5e:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     f60:	20200593          	li	a1,514
     f64:	00004517          	auipc	a0,0x4
     f68:	4f450513          	addi	a0,a0,1268 # 5458 <malloc+0xa46>
     f6c:	00003097          	auipc	ra,0x3
     f70:	590080e7          	jalr	1424(ra) # 44fc <open>
  if(fd < 0){
     f74:	0a054d63          	bltz	a0,102e <writetest+0xe4>
     f78:	892a                	mv	s2,a0
     f7a:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     f7c:	00004997          	auipc	s3,0x4
     f80:	50498993          	addi	s3,s3,1284 # 5480 <malloc+0xa6e>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     f84:	00004a97          	auipc	s5,0x4
     f88:	534a8a93          	addi	s5,s5,1332 # 54b8 <malloc+0xaa6>
  for(i = 0; i < N; i++){
     f8c:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     f90:	4629                	li	a2,10
     f92:	85ce                	mv	a1,s3
     f94:	854a                	mv	a0,s2
     f96:	00003097          	auipc	ra,0x3
     f9a:	546080e7          	jalr	1350(ra) # 44dc <write>
     f9e:	47a9                	li	a5,10
     fa0:	0af51563          	bne	a0,a5,104a <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     fa4:	4629                	li	a2,10
     fa6:	85d6                	mv	a1,s5
     fa8:	854a                	mv	a0,s2
     faa:	00003097          	auipc	ra,0x3
     fae:	532080e7          	jalr	1330(ra) # 44dc <write>
     fb2:	47a9                	li	a5,10
     fb4:	0af51963          	bne	a0,a5,1066 <writetest+0x11c>
  for(i = 0; i < N; i++){
     fb8:	2485                	addiw	s1,s1,1
     fba:	fd449be3          	bne	s1,s4,f90 <writetest+0x46>
  close(fd);
     fbe:	854a                	mv	a0,s2
     fc0:	00003097          	auipc	ra,0x3
     fc4:	460080e7          	jalr	1120(ra) # 4420 <close>
  fd = open("small", O_RDONLY);
     fc8:	4581                	li	a1,0
     fca:	00004517          	auipc	a0,0x4
     fce:	48e50513          	addi	a0,a0,1166 # 5458 <malloc+0xa46>
     fd2:	00003097          	auipc	ra,0x3
     fd6:	52a080e7          	jalr	1322(ra) # 44fc <open>
     fda:	84aa                	mv	s1,a0
  if(fd < 0){
     fdc:	0a054363          	bltz	a0,1082 <writetest+0x138>
  i = read(fd, buf, N*SZ*2);
     fe0:	7d000613          	li	a2,2000
     fe4:	00008597          	auipc	a1,0x8
     fe8:	3fc58593          	addi	a1,a1,1020 # 93e0 <buf>
     fec:	00003097          	auipc	ra,0x3
     ff0:	4e8080e7          	jalr	1256(ra) # 44d4 <read>
  if(i != N*SZ*2){
     ff4:	7d000793          	li	a5,2000
     ff8:	0af51363          	bne	a0,a5,109e <writetest+0x154>
  close(fd);
     ffc:	8526                	mv	a0,s1
     ffe:	00003097          	auipc	ra,0x3
    1002:	422080e7          	jalr	1058(ra) # 4420 <close>
  if(unlink("small") < 0){
    1006:	00004517          	auipc	a0,0x4
    100a:	45250513          	addi	a0,a0,1106 # 5458 <malloc+0xa46>
    100e:	00003097          	auipc	ra,0x3
    1012:	4fe080e7          	jalr	1278(ra) # 450c <unlink>
    1016:	0a054263          	bltz	a0,10ba <writetest+0x170>
}
    101a:	70e2                	ld	ra,56(sp)
    101c:	7442                	ld	s0,48(sp)
    101e:	74a2                	ld	s1,40(sp)
    1020:	7902                	ld	s2,32(sp)
    1022:	69e2                	ld	s3,24(sp)
    1024:	6a42                	ld	s4,16(sp)
    1026:	6aa2                	ld	s5,8(sp)
    1028:	6b02                	ld	s6,0(sp)
    102a:	6121                	addi	sp,sp,64
    102c:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
    102e:	85da                	mv	a1,s6
    1030:	00004517          	auipc	a0,0x4
    1034:	43050513          	addi	a0,a0,1072 # 5460 <malloc+0xa4e>
    1038:	00004097          	auipc	ra,0x4
    103c:	91a080e7          	jalr	-1766(ra) # 4952 <printf>
    exit(1);
    1040:	4505                	li	a0,1
    1042:	00003097          	auipc	ra,0x3
    1046:	47a080e7          	jalr	1146(ra) # 44bc <exit>
      printf("%s: error: write aa %d new file failed\n", i);
    104a:	85a6                	mv	a1,s1
    104c:	00004517          	auipc	a0,0x4
    1050:	44450513          	addi	a0,a0,1092 # 5490 <malloc+0xa7e>
    1054:	00004097          	auipc	ra,0x4
    1058:	8fe080e7          	jalr	-1794(ra) # 4952 <printf>
      exit(1);
    105c:	4505                	li	a0,1
    105e:	00003097          	auipc	ra,0x3
    1062:	45e080e7          	jalr	1118(ra) # 44bc <exit>
      printf("%s: error: write bb %d new file failed\n", i);
    1066:	85a6                	mv	a1,s1
    1068:	00004517          	auipc	a0,0x4
    106c:	46050513          	addi	a0,a0,1120 # 54c8 <malloc+0xab6>
    1070:	00004097          	auipc	ra,0x4
    1074:	8e2080e7          	jalr	-1822(ra) # 4952 <printf>
      exit(1);
    1078:	4505                	li	a0,1
    107a:	00003097          	auipc	ra,0x3
    107e:	442080e7          	jalr	1090(ra) # 44bc <exit>
    printf("%s: error: open small failed!\n", s);
    1082:	85da                	mv	a1,s6
    1084:	00004517          	auipc	a0,0x4
    1088:	46c50513          	addi	a0,a0,1132 # 54f0 <malloc+0xade>
    108c:	00004097          	auipc	ra,0x4
    1090:	8c6080e7          	jalr	-1850(ra) # 4952 <printf>
    exit(1);
    1094:	4505                	li	a0,1
    1096:	00003097          	auipc	ra,0x3
    109a:	426080e7          	jalr	1062(ra) # 44bc <exit>
    printf("%s: read failed\n", s);
    109e:	85da                	mv	a1,s6
    10a0:	00004517          	auipc	a0,0x4
    10a4:	47050513          	addi	a0,a0,1136 # 5510 <malloc+0xafe>
    10a8:	00004097          	auipc	ra,0x4
    10ac:	8aa080e7          	jalr	-1878(ra) # 4952 <printf>
    exit(1);
    10b0:	4505                	li	a0,1
    10b2:	00003097          	auipc	ra,0x3
    10b6:	40a080e7          	jalr	1034(ra) # 44bc <exit>
    printf("%s: unlink small failed\n", s);
    10ba:	85da                	mv	a1,s6
    10bc:	00004517          	auipc	a0,0x4
    10c0:	46c50513          	addi	a0,a0,1132 # 5528 <malloc+0xb16>
    10c4:	00004097          	auipc	ra,0x4
    10c8:	88e080e7          	jalr	-1906(ra) # 4952 <printf>
    exit(1);
    10cc:	4505                	li	a0,1
    10ce:	00003097          	auipc	ra,0x3
    10d2:	3ee080e7          	jalr	1006(ra) # 44bc <exit>

00000000000010d6 <writebig>:
{
    10d6:	7139                	addi	sp,sp,-64
    10d8:	fc06                	sd	ra,56(sp)
    10da:	f822                	sd	s0,48(sp)
    10dc:	f426                	sd	s1,40(sp)
    10de:	f04a                	sd	s2,32(sp)
    10e0:	ec4e                	sd	s3,24(sp)
    10e2:	e852                	sd	s4,16(sp)
    10e4:	e456                	sd	s5,8(sp)
    10e6:	0080                	addi	s0,sp,64
    10e8:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
    10ea:	20200593          	li	a1,514
    10ee:	00004517          	auipc	a0,0x4
    10f2:	45a50513          	addi	a0,a0,1114 # 5548 <malloc+0xb36>
    10f6:	00003097          	auipc	ra,0x3
    10fa:	406080e7          	jalr	1030(ra) # 44fc <open>
    10fe:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
    1100:	4481                	li	s1,0
    ((int*)buf)[0] = i;
    1102:	00008917          	auipc	s2,0x8
    1106:	2de90913          	addi	s2,s2,734 # 93e0 <buf>
  for(i = 0; i < MAXFILE; i++){
    110a:	10c00a13          	li	s4,268
  if(fd < 0){
    110e:	06054c63          	bltz	a0,1186 <writebig+0xb0>
    ((int*)buf)[0] = i;
    1112:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
    1116:	40000613          	li	a2,1024
    111a:	85ca                	mv	a1,s2
    111c:	854e                	mv	a0,s3
    111e:	00003097          	auipc	ra,0x3
    1122:	3be080e7          	jalr	958(ra) # 44dc <write>
    1126:	40000793          	li	a5,1024
    112a:	06f51c63          	bne	a0,a5,11a2 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
    112e:	2485                	addiw	s1,s1,1
    1130:	ff4491e3          	bne	s1,s4,1112 <writebig+0x3c>
  close(fd);
    1134:	854e                	mv	a0,s3
    1136:	00003097          	auipc	ra,0x3
    113a:	2ea080e7          	jalr	746(ra) # 4420 <close>
  fd = open("big", O_RDONLY);
    113e:	4581                	li	a1,0
    1140:	00004517          	auipc	a0,0x4
    1144:	40850513          	addi	a0,a0,1032 # 5548 <malloc+0xb36>
    1148:	00003097          	auipc	ra,0x3
    114c:	3b4080e7          	jalr	948(ra) # 44fc <open>
    1150:	89aa                	mv	s3,a0
  n = 0;
    1152:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
    1154:	00008917          	auipc	s2,0x8
    1158:	28c90913          	addi	s2,s2,652 # 93e0 <buf>
  if(fd < 0){
    115c:	06054163          	bltz	a0,11be <writebig+0xe8>
    i = read(fd, buf, BSIZE);
    1160:	40000613          	li	a2,1024
    1164:	85ca                	mv	a1,s2
    1166:	854e                	mv	a0,s3
    1168:	00003097          	auipc	ra,0x3
    116c:	36c080e7          	jalr	876(ra) # 44d4 <read>
    if(i == 0){
    1170:	c52d                	beqz	a0,11da <writebig+0x104>
    } else if(i != BSIZE){
    1172:	40000793          	li	a5,1024
    1176:	0af51d63          	bne	a0,a5,1230 <writebig+0x15a>
    if(((int*)buf)[0] != n){
    117a:	00092603          	lw	a2,0(s2)
    117e:	0c961763          	bne	a2,s1,124c <writebig+0x176>
    n++;
    1182:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
    1184:	bff1                	j	1160 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
    1186:	85d6                	mv	a1,s5
    1188:	00004517          	auipc	a0,0x4
    118c:	3c850513          	addi	a0,a0,968 # 5550 <malloc+0xb3e>
    1190:	00003097          	auipc	ra,0x3
    1194:	7c2080e7          	jalr	1986(ra) # 4952 <printf>
    exit(1);
    1198:	4505                	li	a0,1
    119a:	00003097          	auipc	ra,0x3
    119e:	322080e7          	jalr	802(ra) # 44bc <exit>
      printf("%s: error: write big file failed\n", i);
    11a2:	85a6                	mv	a1,s1
    11a4:	00004517          	auipc	a0,0x4
    11a8:	3cc50513          	addi	a0,a0,972 # 5570 <malloc+0xb5e>
    11ac:	00003097          	auipc	ra,0x3
    11b0:	7a6080e7          	jalr	1958(ra) # 4952 <printf>
      exit(1);
    11b4:	4505                	li	a0,1
    11b6:	00003097          	auipc	ra,0x3
    11ba:	306080e7          	jalr	774(ra) # 44bc <exit>
    printf("%s: error: open big failed!\n", s);
    11be:	85d6                	mv	a1,s5
    11c0:	00004517          	auipc	a0,0x4
    11c4:	3d850513          	addi	a0,a0,984 # 5598 <malloc+0xb86>
    11c8:	00003097          	auipc	ra,0x3
    11cc:	78a080e7          	jalr	1930(ra) # 4952 <printf>
    exit(1);
    11d0:	4505                	li	a0,1
    11d2:	00003097          	auipc	ra,0x3
    11d6:	2ea080e7          	jalr	746(ra) # 44bc <exit>
      if(n == MAXFILE - 1){
    11da:	10b00793          	li	a5,267
    11de:	02f48a63          	beq	s1,a5,1212 <writebig+0x13c>
  close(fd);
    11e2:	854e                	mv	a0,s3
    11e4:	00003097          	auipc	ra,0x3
    11e8:	23c080e7          	jalr	572(ra) # 4420 <close>
  if(unlink("big") < 0){
    11ec:	00004517          	auipc	a0,0x4
    11f0:	35c50513          	addi	a0,a0,860 # 5548 <malloc+0xb36>
    11f4:	00003097          	auipc	ra,0x3
    11f8:	318080e7          	jalr	792(ra) # 450c <unlink>
    11fc:	06054663          	bltz	a0,1268 <writebig+0x192>
}
    1200:	70e2                	ld	ra,56(sp)
    1202:	7442                	ld	s0,48(sp)
    1204:	74a2                	ld	s1,40(sp)
    1206:	7902                	ld	s2,32(sp)
    1208:	69e2                	ld	s3,24(sp)
    120a:	6a42                	ld	s4,16(sp)
    120c:	6aa2                	ld	s5,8(sp)
    120e:	6121                	addi	sp,sp,64
    1210:	8082                	ret
        printf("%s: read only %d blocks from big", n);
    1212:	10b00593          	li	a1,267
    1216:	00004517          	auipc	a0,0x4
    121a:	3a250513          	addi	a0,a0,930 # 55b8 <malloc+0xba6>
    121e:	00003097          	auipc	ra,0x3
    1222:	734080e7          	jalr	1844(ra) # 4952 <printf>
        exit(1);
    1226:	4505                	li	a0,1
    1228:	00003097          	auipc	ra,0x3
    122c:	294080e7          	jalr	660(ra) # 44bc <exit>
      printf("%s: read failed %d\n", i);
    1230:	85aa                	mv	a1,a0
    1232:	00004517          	auipc	a0,0x4
    1236:	3ae50513          	addi	a0,a0,942 # 55e0 <malloc+0xbce>
    123a:	00003097          	auipc	ra,0x3
    123e:	718080e7          	jalr	1816(ra) # 4952 <printf>
      exit(1);
    1242:	4505                	li	a0,1
    1244:	00003097          	auipc	ra,0x3
    1248:	278080e7          	jalr	632(ra) # 44bc <exit>
      printf("%s: read content of block %d is %d\n",
    124c:	85a6                	mv	a1,s1
    124e:	00004517          	auipc	a0,0x4
    1252:	3aa50513          	addi	a0,a0,938 # 55f8 <malloc+0xbe6>
    1256:	00003097          	auipc	ra,0x3
    125a:	6fc080e7          	jalr	1788(ra) # 4952 <printf>
      exit(1);
    125e:	4505                	li	a0,1
    1260:	00003097          	auipc	ra,0x3
    1264:	25c080e7          	jalr	604(ra) # 44bc <exit>
    printf("%s: unlink big failed\n", s);
    1268:	85d6                	mv	a1,s5
    126a:	00004517          	auipc	a0,0x4
    126e:	3b650513          	addi	a0,a0,950 # 5620 <malloc+0xc0e>
    1272:	00003097          	auipc	ra,0x3
    1276:	6e0080e7          	jalr	1760(ra) # 4952 <printf>
    exit(1);
    127a:	4505                	li	a0,1
    127c:	00003097          	auipc	ra,0x3
    1280:	240080e7          	jalr	576(ra) # 44bc <exit>

0000000000001284 <unlinkread>:
{
    1284:	7179                	addi	sp,sp,-48
    1286:	f406                	sd	ra,40(sp)
    1288:	f022                	sd	s0,32(sp)
    128a:	ec26                	sd	s1,24(sp)
    128c:	e84a                	sd	s2,16(sp)
    128e:	e44e                	sd	s3,8(sp)
    1290:	1800                	addi	s0,sp,48
    1292:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1294:	20200593          	li	a1,514
    1298:	00004517          	auipc	a0,0x4
    129c:	3a050513          	addi	a0,a0,928 # 5638 <malloc+0xc26>
    12a0:	00003097          	auipc	ra,0x3
    12a4:	25c080e7          	jalr	604(ra) # 44fc <open>
  if(fd < 0){
    12a8:	0e054563          	bltz	a0,1392 <unlinkread+0x10e>
    12ac:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
    12ae:	4615                	li	a2,5
    12b0:	00004597          	auipc	a1,0x4
    12b4:	3b858593          	addi	a1,a1,952 # 5668 <malloc+0xc56>
    12b8:	00003097          	auipc	ra,0x3
    12bc:	224080e7          	jalr	548(ra) # 44dc <write>
  close(fd);
    12c0:	8526                	mv	a0,s1
    12c2:	00003097          	auipc	ra,0x3
    12c6:	15e080e7          	jalr	350(ra) # 4420 <close>
  fd = open("unlinkread", O_RDWR);
    12ca:	4589                	li	a1,2
    12cc:	00004517          	auipc	a0,0x4
    12d0:	36c50513          	addi	a0,a0,876 # 5638 <malloc+0xc26>
    12d4:	00003097          	auipc	ra,0x3
    12d8:	228080e7          	jalr	552(ra) # 44fc <open>
    12dc:	84aa                	mv	s1,a0
  if(fd < 0){
    12de:	0c054863          	bltz	a0,13ae <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
    12e2:	00004517          	auipc	a0,0x4
    12e6:	35650513          	addi	a0,a0,854 # 5638 <malloc+0xc26>
    12ea:	00003097          	auipc	ra,0x3
    12ee:	222080e7          	jalr	546(ra) # 450c <unlink>
    12f2:	ed61                	bnez	a0,13ca <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    12f4:	20200593          	li	a1,514
    12f8:	00004517          	auipc	a0,0x4
    12fc:	34050513          	addi	a0,a0,832 # 5638 <malloc+0xc26>
    1300:	00003097          	auipc	ra,0x3
    1304:	1fc080e7          	jalr	508(ra) # 44fc <open>
    1308:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
    130a:	460d                	li	a2,3
    130c:	00004597          	auipc	a1,0x4
    1310:	3a458593          	addi	a1,a1,932 # 56b0 <malloc+0xc9e>
    1314:	00003097          	auipc	ra,0x3
    1318:	1c8080e7          	jalr	456(ra) # 44dc <write>
  close(fd1);
    131c:	854a                	mv	a0,s2
    131e:	00003097          	auipc	ra,0x3
    1322:	102080e7          	jalr	258(ra) # 4420 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
    1326:	660d                	lui	a2,0x3
    1328:	00008597          	auipc	a1,0x8
    132c:	0b858593          	addi	a1,a1,184 # 93e0 <buf>
    1330:	8526                	mv	a0,s1
    1332:	00003097          	auipc	ra,0x3
    1336:	1a2080e7          	jalr	418(ra) # 44d4 <read>
    133a:	4795                	li	a5,5
    133c:	0af51563          	bne	a0,a5,13e6 <unlinkread+0x162>
  if(buf[0] != 'h'){
    1340:	00008717          	auipc	a4,0x8
    1344:	0a074703          	lbu	a4,160(a4) # 93e0 <buf>
    1348:	06800793          	li	a5,104
    134c:	0af71b63          	bne	a4,a5,1402 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
    1350:	4629                	li	a2,10
    1352:	00008597          	auipc	a1,0x8
    1356:	08e58593          	addi	a1,a1,142 # 93e0 <buf>
    135a:	8526                	mv	a0,s1
    135c:	00003097          	auipc	ra,0x3
    1360:	180080e7          	jalr	384(ra) # 44dc <write>
    1364:	47a9                	li	a5,10
    1366:	0af51c63          	bne	a0,a5,141e <unlinkread+0x19a>
  close(fd);
    136a:	8526                	mv	a0,s1
    136c:	00003097          	auipc	ra,0x3
    1370:	0b4080e7          	jalr	180(ra) # 4420 <close>
  unlink("unlinkread");
    1374:	00004517          	auipc	a0,0x4
    1378:	2c450513          	addi	a0,a0,708 # 5638 <malloc+0xc26>
    137c:	00003097          	auipc	ra,0x3
    1380:	190080e7          	jalr	400(ra) # 450c <unlink>
}
    1384:	70a2                	ld	ra,40(sp)
    1386:	7402                	ld	s0,32(sp)
    1388:	64e2                	ld	s1,24(sp)
    138a:	6942                	ld	s2,16(sp)
    138c:	69a2                	ld	s3,8(sp)
    138e:	6145                	addi	sp,sp,48
    1390:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
    1392:	85ce                	mv	a1,s3
    1394:	00004517          	auipc	a0,0x4
    1398:	2b450513          	addi	a0,a0,692 # 5648 <malloc+0xc36>
    139c:	00003097          	auipc	ra,0x3
    13a0:	5b6080e7          	jalr	1462(ra) # 4952 <printf>
    exit(1);
    13a4:	4505                	li	a0,1
    13a6:	00003097          	auipc	ra,0x3
    13aa:	116080e7          	jalr	278(ra) # 44bc <exit>
    printf("%s: open unlinkread failed\n", s);
    13ae:	85ce                	mv	a1,s3
    13b0:	00004517          	auipc	a0,0x4
    13b4:	2c050513          	addi	a0,a0,704 # 5670 <malloc+0xc5e>
    13b8:	00003097          	auipc	ra,0x3
    13bc:	59a080e7          	jalr	1434(ra) # 4952 <printf>
    exit(1);
    13c0:	4505                	li	a0,1
    13c2:	00003097          	auipc	ra,0x3
    13c6:	0fa080e7          	jalr	250(ra) # 44bc <exit>
    printf("%s: unlink unlinkread failed\n", s);
    13ca:	85ce                	mv	a1,s3
    13cc:	00004517          	auipc	a0,0x4
    13d0:	2c450513          	addi	a0,a0,708 # 5690 <malloc+0xc7e>
    13d4:	00003097          	auipc	ra,0x3
    13d8:	57e080e7          	jalr	1406(ra) # 4952 <printf>
    exit(1);
    13dc:	4505                	li	a0,1
    13de:	00003097          	auipc	ra,0x3
    13e2:	0de080e7          	jalr	222(ra) # 44bc <exit>
    printf("%s: unlinkread read failed", s);
    13e6:	85ce                	mv	a1,s3
    13e8:	00004517          	auipc	a0,0x4
    13ec:	2d050513          	addi	a0,a0,720 # 56b8 <malloc+0xca6>
    13f0:	00003097          	auipc	ra,0x3
    13f4:	562080e7          	jalr	1378(ra) # 4952 <printf>
    exit(1);
    13f8:	4505                	li	a0,1
    13fa:	00003097          	auipc	ra,0x3
    13fe:	0c2080e7          	jalr	194(ra) # 44bc <exit>
    printf("%s: unlinkread wrong data\n", s);
    1402:	85ce                	mv	a1,s3
    1404:	00004517          	auipc	a0,0x4
    1408:	2d450513          	addi	a0,a0,724 # 56d8 <malloc+0xcc6>
    140c:	00003097          	auipc	ra,0x3
    1410:	546080e7          	jalr	1350(ra) # 4952 <printf>
    exit(1);
    1414:	4505                	li	a0,1
    1416:	00003097          	auipc	ra,0x3
    141a:	0a6080e7          	jalr	166(ra) # 44bc <exit>
    printf("%s: unlinkread write failed\n", s);
    141e:	85ce                	mv	a1,s3
    1420:	00004517          	auipc	a0,0x4
    1424:	2d850513          	addi	a0,a0,728 # 56f8 <malloc+0xce6>
    1428:	00003097          	auipc	ra,0x3
    142c:	52a080e7          	jalr	1322(ra) # 4952 <printf>
    exit(1);
    1430:	4505                	li	a0,1
    1432:	00003097          	auipc	ra,0x3
    1436:	08a080e7          	jalr	138(ra) # 44bc <exit>

000000000000143a <exectest>:
{
    143a:	715d                	addi	sp,sp,-80
    143c:	e486                	sd	ra,72(sp)
    143e:	e0a2                	sd	s0,64(sp)
    1440:	fc26                	sd	s1,56(sp)
    1442:	f84a                	sd	s2,48(sp)
    1444:	0880                	addi	s0,sp,80
    1446:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1448:	00004797          	auipc	a5,0x4
    144c:	ce078793          	addi	a5,a5,-800 # 5128 <malloc+0x716>
    1450:	fcf43023          	sd	a5,-64(s0)
    1454:	00004797          	auipc	a5,0x4
    1458:	2c478793          	addi	a5,a5,708 # 5718 <malloc+0xd06>
    145c:	fcf43423          	sd	a5,-56(s0)
    1460:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1464:	00004517          	auipc	a0,0x4
    1468:	2bc50513          	addi	a0,a0,700 # 5720 <malloc+0xd0e>
    146c:	00003097          	auipc	ra,0x3
    1470:	0a0080e7          	jalr	160(ra) # 450c <unlink>
  pid = fork();
    1474:	00003097          	auipc	ra,0x3
    1478:	040080e7          	jalr	64(ra) # 44b4 <fork>
  if(pid < 0) {
    147c:	04054663          	bltz	a0,14c8 <exectest+0x8e>
    1480:	84aa                	mv	s1,a0
  if(pid == 0) {
    1482:	e959                	bnez	a0,1518 <exectest+0xde>
    close(1);
    1484:	4505                	li	a0,1
    1486:	00003097          	auipc	ra,0x3
    148a:	f9a080e7          	jalr	-102(ra) # 4420 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    148e:	20100593          	li	a1,513
    1492:	00004517          	auipc	a0,0x4
    1496:	28e50513          	addi	a0,a0,654 # 5720 <malloc+0xd0e>
    149a:	00003097          	auipc	ra,0x3
    149e:	062080e7          	jalr	98(ra) # 44fc <open>
    if(fd < 0) {
    14a2:	04054163          	bltz	a0,14e4 <exectest+0xaa>
    if(fd != 1) {
    14a6:	4785                	li	a5,1
    14a8:	04f50c63          	beq	a0,a5,1500 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    14ac:	85ca                	mv	a1,s2
    14ae:	00004517          	auipc	a0,0x4
    14b2:	27a50513          	addi	a0,a0,634 # 5728 <malloc+0xd16>
    14b6:	00003097          	auipc	ra,0x3
    14ba:	49c080e7          	jalr	1180(ra) # 4952 <printf>
      exit(1);
    14be:	4505                	li	a0,1
    14c0:	00003097          	auipc	ra,0x3
    14c4:	ffc080e7          	jalr	-4(ra) # 44bc <exit>
     printf("%s: fork failed\n", s);
    14c8:	85ca                	mv	a1,s2
    14ca:	00004517          	auipc	a0,0x4
    14ce:	aae50513          	addi	a0,a0,-1362 # 4f78 <malloc+0x566>
    14d2:	00003097          	auipc	ra,0x3
    14d6:	480080e7          	jalr	1152(ra) # 4952 <printf>
     exit(1);
    14da:	4505                	li	a0,1
    14dc:	00003097          	auipc	ra,0x3
    14e0:	fe0080e7          	jalr	-32(ra) # 44bc <exit>
      printf("%s: create failed\n", s);
    14e4:	85ca                	mv	a1,s2
    14e6:	00004517          	auipc	a0,0x4
    14ea:	caa50513          	addi	a0,a0,-854 # 5190 <malloc+0x77e>
    14ee:	00003097          	auipc	ra,0x3
    14f2:	464080e7          	jalr	1124(ra) # 4952 <printf>
      exit(1);
    14f6:	4505                	li	a0,1
    14f8:	00003097          	auipc	ra,0x3
    14fc:	fc4080e7          	jalr	-60(ra) # 44bc <exit>
    if(exec("echo", echoargv) < 0){
    1500:	fc040593          	addi	a1,s0,-64
    1504:	00004517          	auipc	a0,0x4
    1508:	c2450513          	addi	a0,a0,-988 # 5128 <malloc+0x716>
    150c:	00003097          	auipc	ra,0x3
    1510:	fe8080e7          	jalr	-24(ra) # 44f4 <exec>
    1514:	02054163          	bltz	a0,1536 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1518:	fdc40513          	addi	a0,s0,-36
    151c:	00003097          	auipc	ra,0x3
    1520:	fa8080e7          	jalr	-88(ra) # 44c4 <wait>
    1524:	02951763          	bne	a0,s1,1552 <exectest+0x118>
  if(xstatus != 0)
    1528:	fdc42503          	lw	a0,-36(s0)
    152c:	cd0d                	beqz	a0,1566 <exectest+0x12c>
    exit(xstatus);
    152e:	00003097          	auipc	ra,0x3
    1532:	f8e080e7          	jalr	-114(ra) # 44bc <exit>
      printf("%s: exec echo failed\n", s);
    1536:	85ca                	mv	a1,s2
    1538:	00004517          	auipc	a0,0x4
    153c:	20050513          	addi	a0,a0,512 # 5738 <malloc+0xd26>
    1540:	00003097          	auipc	ra,0x3
    1544:	412080e7          	jalr	1042(ra) # 4952 <printf>
      exit(1);
    1548:	4505                	li	a0,1
    154a:	00003097          	auipc	ra,0x3
    154e:	f72080e7          	jalr	-142(ra) # 44bc <exit>
    printf("%s: wait failed!\n", s);
    1552:	85ca                	mv	a1,s2
    1554:	00004517          	auipc	a0,0x4
    1558:	1fc50513          	addi	a0,a0,508 # 5750 <malloc+0xd3e>
    155c:	00003097          	auipc	ra,0x3
    1560:	3f6080e7          	jalr	1014(ra) # 4952 <printf>
    1564:	b7d1                	j	1528 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1566:	4581                	li	a1,0
    1568:	00004517          	auipc	a0,0x4
    156c:	1b850513          	addi	a0,a0,440 # 5720 <malloc+0xd0e>
    1570:	00003097          	auipc	ra,0x3
    1574:	f8c080e7          	jalr	-116(ra) # 44fc <open>
  if(fd < 0) {
    1578:	02054a63          	bltz	a0,15ac <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    157c:	4609                	li	a2,2
    157e:	fb840593          	addi	a1,s0,-72
    1582:	00003097          	auipc	ra,0x3
    1586:	f52080e7          	jalr	-174(ra) # 44d4 <read>
    158a:	4789                	li	a5,2
    158c:	02f50e63          	beq	a0,a5,15c8 <exectest+0x18e>
    printf("%s: read failed\n", s);
    1590:	85ca                	mv	a1,s2
    1592:	00004517          	auipc	a0,0x4
    1596:	f7e50513          	addi	a0,a0,-130 # 5510 <malloc+0xafe>
    159a:	00003097          	auipc	ra,0x3
    159e:	3b8080e7          	jalr	952(ra) # 4952 <printf>
    exit(1);
    15a2:	4505                	li	a0,1
    15a4:	00003097          	auipc	ra,0x3
    15a8:	f18080e7          	jalr	-232(ra) # 44bc <exit>
    printf("%s: open failed\n", s);
    15ac:	85ca                	mv	a1,s2
    15ae:	00004517          	auipc	a0,0x4
    15b2:	1ba50513          	addi	a0,a0,442 # 5768 <malloc+0xd56>
    15b6:	00003097          	auipc	ra,0x3
    15ba:	39c080e7          	jalr	924(ra) # 4952 <printf>
    exit(1);
    15be:	4505                	li	a0,1
    15c0:	00003097          	auipc	ra,0x3
    15c4:	efc080e7          	jalr	-260(ra) # 44bc <exit>
  unlink("echo-ok");
    15c8:	00004517          	auipc	a0,0x4
    15cc:	15850513          	addi	a0,a0,344 # 5720 <malloc+0xd0e>
    15d0:	00003097          	auipc	ra,0x3
    15d4:	f3c080e7          	jalr	-196(ra) # 450c <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    15d8:	fb844703          	lbu	a4,-72(s0)
    15dc:	04f00793          	li	a5,79
    15e0:	00f71863          	bne	a4,a5,15f0 <exectest+0x1b6>
    15e4:	fb944703          	lbu	a4,-71(s0)
    15e8:	04b00793          	li	a5,75
    15ec:	02f70063          	beq	a4,a5,160c <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    15f0:	85ca                	mv	a1,s2
    15f2:	00004517          	auipc	a0,0x4
    15f6:	18e50513          	addi	a0,a0,398 # 5780 <malloc+0xd6e>
    15fa:	00003097          	auipc	ra,0x3
    15fe:	358080e7          	jalr	856(ra) # 4952 <printf>
    exit(1);
    1602:	4505                	li	a0,1
    1604:	00003097          	auipc	ra,0x3
    1608:	eb8080e7          	jalr	-328(ra) # 44bc <exit>
    exit(0);
    160c:	4501                	li	a0,0
    160e:	00003097          	auipc	ra,0x3
    1612:	eae080e7          	jalr	-338(ra) # 44bc <exit>

0000000000001616 <bigargtest>:
{
    1616:	7179                	addi	sp,sp,-48
    1618:	f406                	sd	ra,40(sp)
    161a:	f022                	sd	s0,32(sp)
    161c:	ec26                	sd	s1,24(sp)
    161e:	1800                	addi	s0,sp,48
    1620:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    1622:	00004517          	auipc	a0,0x4
    1626:	17650513          	addi	a0,a0,374 # 5798 <malloc+0xd86>
    162a:	00003097          	auipc	ra,0x3
    162e:	ee2080e7          	jalr	-286(ra) # 450c <unlink>
  pid = fork();
    1632:	00003097          	auipc	ra,0x3
    1636:	e82080e7          	jalr	-382(ra) # 44b4 <fork>
  if(pid == 0){
    163a:	c121                	beqz	a0,167a <bigargtest+0x64>
  } else if(pid < 0){
    163c:	0a054063          	bltz	a0,16dc <bigargtest+0xc6>
  wait(&xstatus);
    1640:	fdc40513          	addi	a0,s0,-36
    1644:	00003097          	auipc	ra,0x3
    1648:	e80080e7          	jalr	-384(ra) # 44c4 <wait>
  if(xstatus != 0)
    164c:	fdc42503          	lw	a0,-36(s0)
    1650:	e545                	bnez	a0,16f8 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    1652:	4581                	li	a1,0
    1654:	00004517          	auipc	a0,0x4
    1658:	14450513          	addi	a0,a0,324 # 5798 <malloc+0xd86>
    165c:	00003097          	auipc	ra,0x3
    1660:	ea0080e7          	jalr	-352(ra) # 44fc <open>
  if(fd < 0){
    1664:	08054e63          	bltz	a0,1700 <bigargtest+0xea>
  close(fd);
    1668:	00003097          	auipc	ra,0x3
    166c:	db8080e7          	jalr	-584(ra) # 4420 <close>
}
    1670:	70a2                	ld	ra,40(sp)
    1672:	7402                	ld	s0,32(sp)
    1674:	64e2                	ld	s1,24(sp)
    1676:	6145                	addi	sp,sp,48
    1678:	8082                	ret
    167a:	00005797          	auipc	a5,0x5
    167e:	55678793          	addi	a5,a5,1366 # 6bd0 <args.1743>
    1682:	00005697          	auipc	a3,0x5
    1686:	64668693          	addi	a3,a3,1606 # 6cc8 <args.1743+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    168a:	00004717          	auipc	a4,0x4
    168e:	11e70713          	addi	a4,a4,286 # 57a8 <malloc+0xd96>
    1692:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    1694:	07a1                	addi	a5,a5,8
    1696:	fed79ee3          	bne	a5,a3,1692 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    169a:	00005597          	auipc	a1,0x5
    169e:	53658593          	addi	a1,a1,1334 # 6bd0 <args.1743>
    16a2:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    16a6:	00004517          	auipc	a0,0x4
    16aa:	a8250513          	addi	a0,a0,-1406 # 5128 <malloc+0x716>
    16ae:	00003097          	auipc	ra,0x3
    16b2:	e46080e7          	jalr	-442(ra) # 44f4 <exec>
    fd = open("bigarg-ok", O_CREATE);
    16b6:	20000593          	li	a1,512
    16ba:	00004517          	auipc	a0,0x4
    16be:	0de50513          	addi	a0,a0,222 # 5798 <malloc+0xd86>
    16c2:	00003097          	auipc	ra,0x3
    16c6:	e3a080e7          	jalr	-454(ra) # 44fc <open>
    close(fd);
    16ca:	00003097          	auipc	ra,0x3
    16ce:	d56080e7          	jalr	-682(ra) # 4420 <close>
    exit(0);
    16d2:	4501                	li	a0,0
    16d4:	00003097          	auipc	ra,0x3
    16d8:	de8080e7          	jalr	-536(ra) # 44bc <exit>
    printf("%s: bigargtest: fork failed\n", s);
    16dc:	85a6                	mv	a1,s1
    16de:	00004517          	auipc	a0,0x4
    16e2:	1aa50513          	addi	a0,a0,426 # 5888 <malloc+0xe76>
    16e6:	00003097          	auipc	ra,0x3
    16ea:	26c080e7          	jalr	620(ra) # 4952 <printf>
    exit(1);
    16ee:	4505                	li	a0,1
    16f0:	00003097          	auipc	ra,0x3
    16f4:	dcc080e7          	jalr	-564(ra) # 44bc <exit>
    exit(xstatus);
    16f8:	00003097          	auipc	ra,0x3
    16fc:	dc4080e7          	jalr	-572(ra) # 44bc <exit>
    printf("%s: bigarg test failed!\n", s);
    1700:	85a6                	mv	a1,s1
    1702:	00004517          	auipc	a0,0x4
    1706:	1a650513          	addi	a0,a0,422 # 58a8 <malloc+0xe96>
    170a:	00003097          	auipc	ra,0x3
    170e:	248080e7          	jalr	584(ra) # 4952 <printf>
    exit(1);
    1712:	4505                	li	a0,1
    1714:	00003097          	auipc	ra,0x3
    1718:	da8080e7          	jalr	-600(ra) # 44bc <exit>

000000000000171c <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    171c:	7139                	addi	sp,sp,-64
    171e:	fc06                	sd	ra,56(sp)
    1720:	f822                	sd	s0,48(sp)
    1722:	f426                	sd	s1,40(sp)
    1724:	f04a                	sd	s2,32(sp)
    1726:	ec4e                	sd	s3,24(sp)
    1728:	0080                	addi	s0,sp,64
    172a:	64b1                	lui	s1,0xc
    172c:	35048493          	addi	s1,s1,848 # c350 <buf+0x2f70>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1730:	597d                	li	s2,-1
    1732:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    1736:	00004997          	auipc	s3,0x4
    173a:	9f298993          	addi	s3,s3,-1550 # 5128 <malloc+0x716>
    argv[0] = (char*)0xffffffff;
    173e:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1742:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1746:	fc040593          	addi	a1,s0,-64
    174a:	854e                	mv	a0,s3
    174c:	00003097          	auipc	ra,0x3
    1750:	da8080e7          	jalr	-600(ra) # 44f4 <exec>
  for(int i = 0; i < 50000; i++){
    1754:	34fd                	addiw	s1,s1,-1
    1756:	f4e5                	bnez	s1,173e <badarg+0x22>
  }
  
  exit(0);
    1758:	4501                	li	a0,0
    175a:	00003097          	auipc	ra,0x3
    175e:	d62080e7          	jalr	-670(ra) # 44bc <exit>

0000000000001762 <pipe1>:
{
    1762:	715d                	addi	sp,sp,-80
    1764:	e486                	sd	ra,72(sp)
    1766:	e0a2                	sd	s0,64(sp)
    1768:	fc26                	sd	s1,56(sp)
    176a:	f84a                	sd	s2,48(sp)
    176c:	f44e                	sd	s3,40(sp)
    176e:	f052                	sd	s4,32(sp)
    1770:	ec56                	sd	s5,24(sp)
    1772:	e85a                	sd	s6,16(sp)
    1774:	0880                	addi	s0,sp,80
    1776:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    1778:	fb840513          	addi	a0,s0,-72
    177c:	00003097          	auipc	ra,0x3
    1780:	d50080e7          	jalr	-688(ra) # 44cc <pipe>
    1784:	e935                	bnez	a0,17f8 <pipe1+0x96>
    1786:	84aa                	mv	s1,a0
  pid = fork();
    1788:	00003097          	auipc	ra,0x3
    178c:	d2c080e7          	jalr	-724(ra) # 44b4 <fork>
  if(pid == 0){
    1790:	c151                	beqz	a0,1814 <pipe1+0xb2>
  } else if(pid > 0){
    1792:	18a05963          	blez	a0,1924 <pipe1+0x1c2>
    close(fds[1]);
    1796:	fbc42503          	lw	a0,-68(s0)
    179a:	00003097          	auipc	ra,0x3
    179e:	c86080e7          	jalr	-890(ra) # 4420 <close>
    total = 0;
    17a2:	8aa6                	mv	s5,s1
    cc = 1;
    17a4:	4a05                	li	s4,1
    while((n = read(fds[0], buf, cc)) > 0){
    17a6:	00008917          	auipc	s2,0x8
    17aa:	c3a90913          	addi	s2,s2,-966 # 93e0 <buf>
      if(cc > sizeof(buf))
    17ae:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    17b0:	8652                	mv	a2,s4
    17b2:	85ca                	mv	a1,s2
    17b4:	fb842503          	lw	a0,-72(s0)
    17b8:	00003097          	auipc	ra,0x3
    17bc:	d1c080e7          	jalr	-740(ra) # 44d4 <read>
    17c0:	10a05d63          	blez	a0,18da <pipe1+0x178>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17c4:	0014879b          	addiw	a5,s1,1
    17c8:	00094683          	lbu	a3,0(s2)
    17cc:	0ff4f713          	andi	a4,s1,255
    17d0:	0ce69863          	bne	a3,a4,18a0 <pipe1+0x13e>
    17d4:	00008717          	auipc	a4,0x8
    17d8:	c0d70713          	addi	a4,a4,-1011 # 93e1 <buf+0x1>
    17dc:	9ca9                	addw	s1,s1,a0
      for(i = 0; i < n; i++){
    17de:	0e978463          	beq	a5,s1,18c6 <pipe1+0x164>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17e2:	00074683          	lbu	a3,0(a4)
    17e6:	0017861b          	addiw	a2,a5,1
    17ea:	0705                	addi	a4,a4,1
    17ec:	0ff7f793          	andi	a5,a5,255
    17f0:	0af69863          	bne	a3,a5,18a0 <pipe1+0x13e>
    17f4:	87b2                	mv	a5,a2
    17f6:	b7e5                	j	17de <pipe1+0x7c>
    printf("%s: pipe() failed\n", s);
    17f8:	85ce                	mv	a1,s3
    17fa:	00004517          	auipc	a0,0x4
    17fe:	0ce50513          	addi	a0,a0,206 # 58c8 <malloc+0xeb6>
    1802:	00003097          	auipc	ra,0x3
    1806:	150080e7          	jalr	336(ra) # 4952 <printf>
    exit(1);
    180a:	4505                	li	a0,1
    180c:	00003097          	auipc	ra,0x3
    1810:	cb0080e7          	jalr	-848(ra) # 44bc <exit>
    close(fds[0]);
    1814:	fb842503          	lw	a0,-72(s0)
    1818:	00003097          	auipc	ra,0x3
    181c:	c08080e7          	jalr	-1016(ra) # 4420 <close>
    for(n = 0; n < N; n++){
    1820:	00008a97          	auipc	s5,0x8
    1824:	bc0a8a93          	addi	s5,s5,-1088 # 93e0 <buf>
    1828:	0ffaf793          	andi	a5,s5,255
    182c:	40f004b3          	neg	s1,a5
    1830:	0ff4f493          	andi	s1,s1,255
    1834:	02d00a13          	li	s4,45
    1838:	40fa0a3b          	subw	s4,s4,a5
    183c:	0ffa7a13          	andi	s4,s4,255
    1840:	409a8913          	addi	s2,s5,1033
      if(write(fds[1], buf, SZ) != SZ){
    1844:	8b56                	mv	s6,s5
{
    1846:	87d6                	mv	a5,s5
        buf[i] = seq++;
    1848:	0097873b          	addw	a4,a5,s1
    184c:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1850:	0785                	addi	a5,a5,1
    1852:	fef91be3          	bne	s2,a5,1848 <pipe1+0xe6>
      if(write(fds[1], buf, SZ) != SZ){
    1856:	40900613          	li	a2,1033
    185a:	85da                	mv	a1,s6
    185c:	fbc42503          	lw	a0,-68(s0)
    1860:	00003097          	auipc	ra,0x3
    1864:	c7c080e7          	jalr	-900(ra) # 44dc <write>
    1868:	40900793          	li	a5,1033
    186c:	00f51c63          	bne	a0,a5,1884 <pipe1+0x122>
    for(n = 0; n < N; n++){
    1870:	24a5                	addiw	s1,s1,9
    1872:	0ff4f493          	andi	s1,s1,255
    1876:	fd4498e3          	bne	s1,s4,1846 <pipe1+0xe4>
    exit(0);
    187a:	4501                	li	a0,0
    187c:	00003097          	auipc	ra,0x3
    1880:	c40080e7          	jalr	-960(ra) # 44bc <exit>
        printf("%s: pipe1 oops 1\n", s);
    1884:	85ce                	mv	a1,s3
    1886:	00004517          	auipc	a0,0x4
    188a:	05a50513          	addi	a0,a0,90 # 58e0 <malloc+0xece>
    188e:	00003097          	auipc	ra,0x3
    1892:	0c4080e7          	jalr	196(ra) # 4952 <printf>
        exit(1);
    1896:	4505                	li	a0,1
    1898:	00003097          	auipc	ra,0x3
    189c:	c24080e7          	jalr	-988(ra) # 44bc <exit>
          printf("%s: pipe1 oops 2\n", s);
    18a0:	85ce                	mv	a1,s3
    18a2:	00004517          	auipc	a0,0x4
    18a6:	05650513          	addi	a0,a0,86 # 58f8 <malloc+0xee6>
    18aa:	00003097          	auipc	ra,0x3
    18ae:	0a8080e7          	jalr	168(ra) # 4952 <printf>
}
    18b2:	60a6                	ld	ra,72(sp)
    18b4:	6406                	ld	s0,64(sp)
    18b6:	74e2                	ld	s1,56(sp)
    18b8:	7942                	ld	s2,48(sp)
    18ba:	79a2                	ld	s3,40(sp)
    18bc:	7a02                	ld	s4,32(sp)
    18be:	6ae2                	ld	s5,24(sp)
    18c0:	6b42                	ld	s6,16(sp)
    18c2:	6161                	addi	sp,sp,80
    18c4:	8082                	ret
      total += n;
    18c6:	00aa8abb          	addw	s5,s5,a0
      cc = cc * 2;
    18ca:	001a179b          	slliw	a5,s4,0x1
    18ce:	00078a1b          	sext.w	s4,a5
      if(cc > sizeof(buf))
    18d2:	ed4b7fe3          	bleu	s4,s6,17b0 <pipe1+0x4e>
        cc = sizeof(buf);
    18d6:	8a5a                	mv	s4,s6
    18d8:	bde1                	j	17b0 <pipe1+0x4e>
    if(total != N * SZ){
    18da:	6785                	lui	a5,0x1
    18dc:	42d78793          	addi	a5,a5,1069 # 142d <unlinkread+0x1a9>
    18e0:	02fa8063          	beq	s5,a5,1900 <pipe1+0x19e>
      printf("%s: pipe1 oops 3 total %d\n", total);
    18e4:	85d6                	mv	a1,s5
    18e6:	00004517          	auipc	a0,0x4
    18ea:	02a50513          	addi	a0,a0,42 # 5910 <malloc+0xefe>
    18ee:	00003097          	auipc	ra,0x3
    18f2:	064080e7          	jalr	100(ra) # 4952 <printf>
      exit(1);
    18f6:	4505                	li	a0,1
    18f8:	00003097          	auipc	ra,0x3
    18fc:	bc4080e7          	jalr	-1084(ra) # 44bc <exit>
    close(fds[0]);
    1900:	fb842503          	lw	a0,-72(s0)
    1904:	00003097          	auipc	ra,0x3
    1908:	b1c080e7          	jalr	-1252(ra) # 4420 <close>
    wait(&xstatus);
    190c:	fb440513          	addi	a0,s0,-76
    1910:	00003097          	auipc	ra,0x3
    1914:	bb4080e7          	jalr	-1100(ra) # 44c4 <wait>
    exit(xstatus);
    1918:	fb442503          	lw	a0,-76(s0)
    191c:	00003097          	auipc	ra,0x3
    1920:	ba0080e7          	jalr	-1120(ra) # 44bc <exit>
    printf("%s: fork() failed\n", s);
    1924:	85ce                	mv	a1,s3
    1926:	00004517          	auipc	a0,0x4
    192a:	00a50513          	addi	a0,a0,10 # 5930 <malloc+0xf1e>
    192e:	00003097          	auipc	ra,0x3
    1932:	024080e7          	jalr	36(ra) # 4952 <printf>
    exit(1);
    1936:	4505                	li	a0,1
    1938:	00003097          	auipc	ra,0x3
    193c:	b84080e7          	jalr	-1148(ra) # 44bc <exit>

0000000000001940 <pgbug>:
{
    1940:	7179                	addi	sp,sp,-48
    1942:	f406                	sd	ra,40(sp)
    1944:	f022                	sd	s0,32(sp)
    1946:	ec26                	sd	s1,24(sp)
    1948:	1800                	addi	s0,sp,48
  argv[0] = 0;
    194a:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    194e:	00005797          	auipc	a5,0x5
    1952:	26278793          	addi	a5,a5,610 # 6bb0 <digits+0x20>
    1956:	6384                	ld	s1,0(a5)
    1958:	fd840593          	addi	a1,s0,-40
    195c:	8526                	mv	a0,s1
    195e:	00003097          	auipc	ra,0x3
    1962:	b96080e7          	jalr	-1130(ra) # 44f4 <exec>
  pipe((int*)0xeaeb0b5b00002f5e);
    1966:	8526                	mv	a0,s1
    1968:	00003097          	auipc	ra,0x3
    196c:	b64080e7          	jalr	-1180(ra) # 44cc <pipe>
  exit(0);
    1970:	4501                	li	a0,0
    1972:	00003097          	auipc	ra,0x3
    1976:	b4a080e7          	jalr	-1206(ra) # 44bc <exit>

000000000000197a <preempt>:
{
    197a:	7139                	addi	sp,sp,-64
    197c:	fc06                	sd	ra,56(sp)
    197e:	f822                	sd	s0,48(sp)
    1980:	f426                	sd	s1,40(sp)
    1982:	f04a                	sd	s2,32(sp)
    1984:	ec4e                	sd	s3,24(sp)
    1986:	e852                	sd	s4,16(sp)
    1988:	0080                	addi	s0,sp,64
    198a:	8a2a                	mv	s4,a0
  pid1 = fork();
    198c:	00003097          	auipc	ra,0x3
    1990:	b28080e7          	jalr	-1240(ra) # 44b4 <fork>
  if(pid1 < 0) {
    1994:	00054563          	bltz	a0,199e <preempt+0x24>
    1998:	89aa                	mv	s3,a0
  if(pid1 == 0)
    199a:	ed19                	bnez	a0,19b8 <preempt+0x3e>
    for(;;)
    199c:	a001                	j	199c <preempt+0x22>
    printf("%s: fork failed");
    199e:	00003517          	auipc	a0,0x3
    19a2:	64250513          	addi	a0,a0,1602 # 4fe0 <malloc+0x5ce>
    19a6:	00003097          	auipc	ra,0x3
    19aa:	fac080e7          	jalr	-84(ra) # 4952 <printf>
    exit(1);
    19ae:	4505                	li	a0,1
    19b0:	00003097          	auipc	ra,0x3
    19b4:	b0c080e7          	jalr	-1268(ra) # 44bc <exit>
  pid2 = fork();
    19b8:	00003097          	auipc	ra,0x3
    19bc:	afc080e7          	jalr	-1284(ra) # 44b4 <fork>
    19c0:	892a                	mv	s2,a0
  if(pid2 < 0) {
    19c2:	00054463          	bltz	a0,19ca <preempt+0x50>
  if(pid2 == 0)
    19c6:	e105                	bnez	a0,19e6 <preempt+0x6c>
    for(;;)
    19c8:	a001                	j	19c8 <preempt+0x4e>
    printf("%s: fork failed\n", s);
    19ca:	85d2                	mv	a1,s4
    19cc:	00003517          	auipc	a0,0x3
    19d0:	5ac50513          	addi	a0,a0,1452 # 4f78 <malloc+0x566>
    19d4:	00003097          	auipc	ra,0x3
    19d8:	f7e080e7          	jalr	-130(ra) # 4952 <printf>
    exit(1);
    19dc:	4505                	li	a0,1
    19de:	00003097          	auipc	ra,0x3
    19e2:	ade080e7          	jalr	-1314(ra) # 44bc <exit>
  pipe(pfds);
    19e6:	fc840513          	addi	a0,s0,-56
    19ea:	00003097          	auipc	ra,0x3
    19ee:	ae2080e7          	jalr	-1310(ra) # 44cc <pipe>
  pid3 = fork();
    19f2:	00003097          	auipc	ra,0x3
    19f6:	ac2080e7          	jalr	-1342(ra) # 44b4 <fork>
    19fa:	84aa                	mv	s1,a0
  if(pid3 < 0) {
    19fc:	02054e63          	bltz	a0,1a38 <preempt+0xbe>
  if(pid3 == 0){
    1a00:	e13d                	bnez	a0,1a66 <preempt+0xec>
    close(pfds[0]);
    1a02:	fc842503          	lw	a0,-56(s0)
    1a06:	00003097          	auipc	ra,0x3
    1a0a:	a1a080e7          	jalr	-1510(ra) # 4420 <close>
    if(write(pfds[1], "x", 1) != 1)
    1a0e:	4605                	li	a2,1
    1a10:	00004597          	auipc	a1,0x4
    1a14:	f3858593          	addi	a1,a1,-200 # 5948 <malloc+0xf36>
    1a18:	fcc42503          	lw	a0,-52(s0)
    1a1c:	00003097          	auipc	ra,0x3
    1a20:	ac0080e7          	jalr	-1344(ra) # 44dc <write>
    1a24:	4785                	li	a5,1
    1a26:	02f51763          	bne	a0,a5,1a54 <preempt+0xda>
    close(pfds[1]);
    1a2a:	fcc42503          	lw	a0,-52(s0)
    1a2e:	00003097          	auipc	ra,0x3
    1a32:	9f2080e7          	jalr	-1550(ra) # 4420 <close>
    for(;;)
    1a36:	a001                	j	1a36 <preempt+0xbc>
     printf("%s: fork failed\n", s);
    1a38:	85d2                	mv	a1,s4
    1a3a:	00003517          	auipc	a0,0x3
    1a3e:	53e50513          	addi	a0,a0,1342 # 4f78 <malloc+0x566>
    1a42:	00003097          	auipc	ra,0x3
    1a46:	f10080e7          	jalr	-240(ra) # 4952 <printf>
     exit(1);
    1a4a:	4505                	li	a0,1
    1a4c:	00003097          	auipc	ra,0x3
    1a50:	a70080e7          	jalr	-1424(ra) # 44bc <exit>
      printf("%s: preempt write error");
    1a54:	00004517          	auipc	a0,0x4
    1a58:	efc50513          	addi	a0,a0,-260 # 5950 <malloc+0xf3e>
    1a5c:	00003097          	auipc	ra,0x3
    1a60:	ef6080e7          	jalr	-266(ra) # 4952 <printf>
    1a64:	b7d9                	j	1a2a <preempt+0xb0>
  close(pfds[1]);
    1a66:	fcc42503          	lw	a0,-52(s0)
    1a6a:	00003097          	auipc	ra,0x3
    1a6e:	9b6080e7          	jalr	-1610(ra) # 4420 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1a72:	660d                	lui	a2,0x3
    1a74:	00008597          	auipc	a1,0x8
    1a78:	96c58593          	addi	a1,a1,-1684 # 93e0 <buf>
    1a7c:	fc842503          	lw	a0,-56(s0)
    1a80:	00003097          	auipc	ra,0x3
    1a84:	a54080e7          	jalr	-1452(ra) # 44d4 <read>
    1a88:	4785                	li	a5,1
    1a8a:	02f50263          	beq	a0,a5,1aae <preempt+0x134>
    printf("%s: preempt read error");
    1a8e:	00004517          	auipc	a0,0x4
    1a92:	eda50513          	addi	a0,a0,-294 # 5968 <malloc+0xf56>
    1a96:	00003097          	auipc	ra,0x3
    1a9a:	ebc080e7          	jalr	-324(ra) # 4952 <printf>
}
    1a9e:	70e2                	ld	ra,56(sp)
    1aa0:	7442                	ld	s0,48(sp)
    1aa2:	74a2                	ld	s1,40(sp)
    1aa4:	7902                	ld	s2,32(sp)
    1aa6:	69e2                	ld	s3,24(sp)
    1aa8:	6a42                	ld	s4,16(sp)
    1aaa:	6121                	addi	sp,sp,64
    1aac:	8082                	ret
  close(pfds[0]);
    1aae:	fc842503          	lw	a0,-56(s0)
    1ab2:	00003097          	auipc	ra,0x3
    1ab6:	96e080e7          	jalr	-1682(ra) # 4420 <close>
  printf("kill... ");
    1aba:	00004517          	auipc	a0,0x4
    1abe:	ec650513          	addi	a0,a0,-314 # 5980 <malloc+0xf6e>
    1ac2:	00003097          	auipc	ra,0x3
    1ac6:	e90080e7          	jalr	-368(ra) # 4952 <printf>
  kill(pid1);
    1aca:	854e                	mv	a0,s3
    1acc:	00003097          	auipc	ra,0x3
    1ad0:	a20080e7          	jalr	-1504(ra) # 44ec <kill>
  kill(pid2);
    1ad4:	854a                	mv	a0,s2
    1ad6:	00003097          	auipc	ra,0x3
    1ada:	a16080e7          	jalr	-1514(ra) # 44ec <kill>
  kill(pid3);
    1ade:	8526                	mv	a0,s1
    1ae0:	00003097          	auipc	ra,0x3
    1ae4:	a0c080e7          	jalr	-1524(ra) # 44ec <kill>
  printf("wait... ");
    1ae8:	00004517          	auipc	a0,0x4
    1aec:	ea850513          	addi	a0,a0,-344 # 5990 <malloc+0xf7e>
    1af0:	00003097          	auipc	ra,0x3
    1af4:	e62080e7          	jalr	-414(ra) # 4952 <printf>
  wait(0);
    1af8:	4501                	li	a0,0
    1afa:	00003097          	auipc	ra,0x3
    1afe:	9ca080e7          	jalr	-1590(ra) # 44c4 <wait>
  wait(0);
    1b02:	4501                	li	a0,0
    1b04:	00003097          	auipc	ra,0x3
    1b08:	9c0080e7          	jalr	-1600(ra) # 44c4 <wait>
  wait(0);
    1b0c:	4501                	li	a0,0
    1b0e:	00003097          	auipc	ra,0x3
    1b12:	9b6080e7          	jalr	-1610(ra) # 44c4 <wait>
    1b16:	b761                	j	1a9e <preempt+0x124>

0000000000001b18 <reparent>:
{
    1b18:	7179                	addi	sp,sp,-48
    1b1a:	f406                	sd	ra,40(sp)
    1b1c:	f022                	sd	s0,32(sp)
    1b1e:	ec26                	sd	s1,24(sp)
    1b20:	e84a                	sd	s2,16(sp)
    1b22:	e44e                	sd	s3,8(sp)
    1b24:	e052                	sd	s4,0(sp)
    1b26:	1800                	addi	s0,sp,48
    1b28:	89aa                	mv	s3,a0
  int master_pid = getpid();
    1b2a:	00003097          	auipc	ra,0x3
    1b2e:	a12080e7          	jalr	-1518(ra) # 453c <getpid>
    1b32:	8a2a                	mv	s4,a0
    1b34:	0c800913          	li	s2,200
    int pid = fork();
    1b38:	00003097          	auipc	ra,0x3
    1b3c:	97c080e7          	jalr	-1668(ra) # 44b4 <fork>
    1b40:	84aa                	mv	s1,a0
    if(pid < 0){
    1b42:	02054263          	bltz	a0,1b66 <reparent+0x4e>
    if(pid){
    1b46:	cd21                	beqz	a0,1b9e <reparent+0x86>
      if(wait(0) != pid){
    1b48:	4501                	li	a0,0
    1b4a:	00003097          	auipc	ra,0x3
    1b4e:	97a080e7          	jalr	-1670(ra) # 44c4 <wait>
    1b52:	02951863          	bne	a0,s1,1b82 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    1b56:	397d                	addiw	s2,s2,-1
    1b58:	fe0910e3          	bnez	s2,1b38 <reparent+0x20>
  exit(0);
    1b5c:	4501                	li	a0,0
    1b5e:	00003097          	auipc	ra,0x3
    1b62:	95e080e7          	jalr	-1698(ra) # 44bc <exit>
      printf("%s: fork failed\n", s);
    1b66:	85ce                	mv	a1,s3
    1b68:	00003517          	auipc	a0,0x3
    1b6c:	41050513          	addi	a0,a0,1040 # 4f78 <malloc+0x566>
    1b70:	00003097          	auipc	ra,0x3
    1b74:	de2080e7          	jalr	-542(ra) # 4952 <printf>
      exit(1);
    1b78:	4505                	li	a0,1
    1b7a:	00003097          	auipc	ra,0x3
    1b7e:	942080e7          	jalr	-1726(ra) # 44bc <exit>
        printf("%s: wait wrong pid\n", s);
    1b82:	85ce                	mv	a1,s3
    1b84:	00003517          	auipc	a0,0x3
    1b88:	42450513          	addi	a0,a0,1060 # 4fa8 <malloc+0x596>
    1b8c:	00003097          	auipc	ra,0x3
    1b90:	dc6080e7          	jalr	-570(ra) # 4952 <printf>
        exit(1);
    1b94:	4505                	li	a0,1
    1b96:	00003097          	auipc	ra,0x3
    1b9a:	926080e7          	jalr	-1754(ra) # 44bc <exit>
      int pid2 = fork();
    1b9e:	00003097          	auipc	ra,0x3
    1ba2:	916080e7          	jalr	-1770(ra) # 44b4 <fork>
      if(pid2 < 0){
    1ba6:	00054763          	bltz	a0,1bb4 <reparent+0x9c>
      exit(0);
    1baa:	4501                	li	a0,0
    1bac:	00003097          	auipc	ra,0x3
    1bb0:	910080e7          	jalr	-1776(ra) # 44bc <exit>
        kill(master_pid);
    1bb4:	8552                	mv	a0,s4
    1bb6:	00003097          	auipc	ra,0x3
    1bba:	936080e7          	jalr	-1738(ra) # 44ec <kill>
        exit(1);
    1bbe:	4505                	li	a0,1
    1bc0:	00003097          	auipc	ra,0x3
    1bc4:	8fc080e7          	jalr	-1796(ra) # 44bc <exit>

0000000000001bc8 <mem>:
{
    1bc8:	7139                	addi	sp,sp,-64
    1bca:	fc06                	sd	ra,56(sp)
    1bcc:	f822                	sd	s0,48(sp)
    1bce:	f426                	sd	s1,40(sp)
    1bd0:	f04a                	sd	s2,32(sp)
    1bd2:	ec4e                	sd	s3,24(sp)
    1bd4:	0080                	addi	s0,sp,64
    1bd6:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    1bd8:	00003097          	auipc	ra,0x3
    1bdc:	8dc080e7          	jalr	-1828(ra) # 44b4 <fork>
    m1 = 0;
    1be0:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    1be2:	6909                	lui	s2,0x2
    1be4:	71190913          	addi	s2,s2,1809 # 2711 <concreate+0x293>
  if((pid = fork()) == 0){
    1be8:	e135                	bnez	a0,1c4c <mem+0x84>
    while((m2 = malloc(10001)) != 0){
    1bea:	854a                	mv	a0,s2
    1bec:	00003097          	auipc	ra,0x3
    1bf0:	e26080e7          	jalr	-474(ra) # 4a12 <malloc>
    1bf4:	c501                	beqz	a0,1bfc <mem+0x34>
      *(char**)m2 = m1;
    1bf6:	e104                	sd	s1,0(a0)
      m1 = m2;
    1bf8:	84aa                	mv	s1,a0
    1bfa:	bfc5                	j	1bea <mem+0x22>
    while(m1){
    1bfc:	c899                	beqz	s1,1c12 <mem+0x4a>
      m2 = *(char**)m1;
    1bfe:	0004b903          	ld	s2,0(s1)
      free(m1);
    1c02:	8526                	mv	a0,s1
    1c04:	00003097          	auipc	ra,0x3
    1c08:	d84080e7          	jalr	-636(ra) # 4988 <free>
      m1 = m2;
    1c0c:	84ca                	mv	s1,s2
    while(m1){
    1c0e:	fe0918e3          	bnez	s2,1bfe <mem+0x36>
    m1 = malloc(1024*20);
    1c12:	6515                	lui	a0,0x5
    1c14:	00003097          	auipc	ra,0x3
    1c18:	dfe080e7          	jalr	-514(ra) # 4a12 <malloc>
    if(m1 == 0){
    1c1c:	c911                	beqz	a0,1c30 <mem+0x68>
    free(m1);
    1c1e:	00003097          	auipc	ra,0x3
    1c22:	d6a080e7          	jalr	-662(ra) # 4988 <free>
    exit(0);
    1c26:	4501                	li	a0,0
    1c28:	00003097          	auipc	ra,0x3
    1c2c:	894080e7          	jalr	-1900(ra) # 44bc <exit>
      printf("couldn't allocate mem?!!\n", s);
    1c30:	85ce                	mv	a1,s3
    1c32:	00004517          	auipc	a0,0x4
    1c36:	d6e50513          	addi	a0,a0,-658 # 59a0 <malloc+0xf8e>
    1c3a:	00003097          	auipc	ra,0x3
    1c3e:	d18080e7          	jalr	-744(ra) # 4952 <printf>
      exit(1);
    1c42:	4505                	li	a0,1
    1c44:	00003097          	auipc	ra,0x3
    1c48:	878080e7          	jalr	-1928(ra) # 44bc <exit>
    wait(&xstatus);
    1c4c:	fcc40513          	addi	a0,s0,-52
    1c50:	00003097          	auipc	ra,0x3
    1c54:	874080e7          	jalr	-1932(ra) # 44c4 <wait>
    exit(xstatus);
    1c58:	fcc42503          	lw	a0,-52(s0)
    1c5c:	00003097          	auipc	ra,0x3
    1c60:	860080e7          	jalr	-1952(ra) # 44bc <exit>

0000000000001c64 <sharedfd>:
{
    1c64:	7159                	addi	sp,sp,-112
    1c66:	f486                	sd	ra,104(sp)
    1c68:	f0a2                	sd	s0,96(sp)
    1c6a:	eca6                	sd	s1,88(sp)
    1c6c:	e8ca                	sd	s2,80(sp)
    1c6e:	e4ce                	sd	s3,72(sp)
    1c70:	e0d2                	sd	s4,64(sp)
    1c72:	fc56                	sd	s5,56(sp)
    1c74:	f85a                	sd	s6,48(sp)
    1c76:	f45e                	sd	s7,40(sp)
    1c78:	1880                	addi	s0,sp,112
    1c7a:	89aa                	mv	s3,a0
  unlink("sharedfd");
    1c7c:	00004517          	auipc	a0,0x4
    1c80:	d4450513          	addi	a0,a0,-700 # 59c0 <malloc+0xfae>
    1c84:	00003097          	auipc	ra,0x3
    1c88:	888080e7          	jalr	-1912(ra) # 450c <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1c8c:	20200593          	li	a1,514
    1c90:	00004517          	auipc	a0,0x4
    1c94:	d3050513          	addi	a0,a0,-720 # 59c0 <malloc+0xfae>
    1c98:	00003097          	auipc	ra,0x3
    1c9c:	864080e7          	jalr	-1948(ra) # 44fc <open>
  if(fd < 0){
    1ca0:	04054a63          	bltz	a0,1cf4 <sharedfd+0x90>
    1ca4:	892a                	mv	s2,a0
  pid = fork();
    1ca6:	00003097          	auipc	ra,0x3
    1caa:	80e080e7          	jalr	-2034(ra) # 44b4 <fork>
    1cae:	8a2a                	mv	s4,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1cb0:	06300593          	li	a1,99
    1cb4:	c119                	beqz	a0,1cba <sharedfd+0x56>
    1cb6:	07000593          	li	a1,112
    1cba:	4629                	li	a2,10
    1cbc:	fa040513          	addi	a0,s0,-96
    1cc0:	00002097          	auipc	ra,0x2
    1cc4:	598080e7          	jalr	1432(ra) # 4258 <memset>
    1cc8:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1ccc:	4629                	li	a2,10
    1cce:	fa040593          	addi	a1,s0,-96
    1cd2:	854a                	mv	a0,s2
    1cd4:	00003097          	auipc	ra,0x3
    1cd8:	808080e7          	jalr	-2040(ra) # 44dc <write>
    1cdc:	47a9                	li	a5,10
    1cde:	02f51963          	bne	a0,a5,1d10 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    1ce2:	34fd                	addiw	s1,s1,-1
    1ce4:	f4e5                	bnez	s1,1ccc <sharedfd+0x68>
  if(pid == 0) {
    1ce6:	040a1363          	bnez	s4,1d2c <sharedfd+0xc8>
    exit(0);
    1cea:	4501                	li	a0,0
    1cec:	00002097          	auipc	ra,0x2
    1cf0:	7d0080e7          	jalr	2000(ra) # 44bc <exit>
    printf("%s: cannot open sharedfd for writing", s);
    1cf4:	85ce                	mv	a1,s3
    1cf6:	00004517          	auipc	a0,0x4
    1cfa:	cda50513          	addi	a0,a0,-806 # 59d0 <malloc+0xfbe>
    1cfe:	00003097          	auipc	ra,0x3
    1d02:	c54080e7          	jalr	-940(ra) # 4952 <printf>
    exit(1);
    1d06:	4505                	li	a0,1
    1d08:	00002097          	auipc	ra,0x2
    1d0c:	7b4080e7          	jalr	1972(ra) # 44bc <exit>
      printf("%s: write sharedfd failed\n", s);
    1d10:	85ce                	mv	a1,s3
    1d12:	00004517          	auipc	a0,0x4
    1d16:	ce650513          	addi	a0,a0,-794 # 59f8 <malloc+0xfe6>
    1d1a:	00003097          	auipc	ra,0x3
    1d1e:	c38080e7          	jalr	-968(ra) # 4952 <printf>
      exit(1);
    1d22:	4505                	li	a0,1
    1d24:	00002097          	auipc	ra,0x2
    1d28:	798080e7          	jalr	1944(ra) # 44bc <exit>
    wait(&xstatus);
    1d2c:	f9c40513          	addi	a0,s0,-100
    1d30:	00002097          	auipc	ra,0x2
    1d34:	794080e7          	jalr	1940(ra) # 44c4 <wait>
    if(xstatus != 0)
    1d38:	f9c42a03          	lw	s4,-100(s0)
    1d3c:	000a0763          	beqz	s4,1d4a <sharedfd+0xe6>
      exit(xstatus);
    1d40:	8552                	mv	a0,s4
    1d42:	00002097          	auipc	ra,0x2
    1d46:	77a080e7          	jalr	1914(ra) # 44bc <exit>
  close(fd);
    1d4a:	854a                	mv	a0,s2
    1d4c:	00002097          	auipc	ra,0x2
    1d50:	6d4080e7          	jalr	1748(ra) # 4420 <close>
  fd = open("sharedfd", 0);
    1d54:	4581                	li	a1,0
    1d56:	00004517          	auipc	a0,0x4
    1d5a:	c6a50513          	addi	a0,a0,-918 # 59c0 <malloc+0xfae>
    1d5e:	00002097          	auipc	ra,0x2
    1d62:	79e080e7          	jalr	1950(ra) # 44fc <open>
    1d66:	8baa                	mv	s7,a0
  nc = np = 0;
    1d68:	8ad2                	mv	s5,s4
  if(fd < 0){
    1d6a:	02054563          	bltz	a0,1d94 <sharedfd+0x130>
    1d6e:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    1d72:	06300493          	li	s1,99
      if(buf[i] == 'p')
    1d76:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1d7a:	4629                	li	a2,10
    1d7c:	fa040593          	addi	a1,s0,-96
    1d80:	855e                	mv	a0,s7
    1d82:	00002097          	auipc	ra,0x2
    1d86:	752080e7          	jalr	1874(ra) # 44d4 <read>
    1d8a:	02a05f63          	blez	a0,1dc8 <sharedfd+0x164>
    1d8e:	fa040793          	addi	a5,s0,-96
    1d92:	a01d                	j	1db8 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    1d94:	85ce                	mv	a1,s3
    1d96:	00004517          	auipc	a0,0x4
    1d9a:	c8250513          	addi	a0,a0,-894 # 5a18 <malloc+0x1006>
    1d9e:	00003097          	auipc	ra,0x3
    1da2:	bb4080e7          	jalr	-1100(ra) # 4952 <printf>
    exit(1);
    1da6:	4505                	li	a0,1
    1da8:	00002097          	auipc	ra,0x2
    1dac:	714080e7          	jalr	1812(ra) # 44bc <exit>
        nc++;
    1db0:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    1db2:	0785                	addi	a5,a5,1
    1db4:	fd2783e3          	beq	a5,s2,1d7a <sharedfd+0x116>
      if(buf[i] == 'c')
    1db8:	0007c703          	lbu	a4,0(a5)
    1dbc:	fe970ae3          	beq	a4,s1,1db0 <sharedfd+0x14c>
      if(buf[i] == 'p')
    1dc0:	ff6719e3          	bne	a4,s6,1db2 <sharedfd+0x14e>
        np++;
    1dc4:	2a85                	addiw	s5,s5,1
    1dc6:	b7f5                	j	1db2 <sharedfd+0x14e>
  close(fd);
    1dc8:	855e                	mv	a0,s7
    1dca:	00002097          	auipc	ra,0x2
    1dce:	656080e7          	jalr	1622(ra) # 4420 <close>
  unlink("sharedfd");
    1dd2:	00004517          	auipc	a0,0x4
    1dd6:	bee50513          	addi	a0,a0,-1042 # 59c0 <malloc+0xfae>
    1dda:	00002097          	auipc	ra,0x2
    1dde:	732080e7          	jalr	1842(ra) # 450c <unlink>
  if(nc == N*SZ && np == N*SZ){
    1de2:	6789                	lui	a5,0x2
    1de4:	71078793          	addi	a5,a5,1808 # 2710 <concreate+0x292>
    1de8:	00fa1763          	bne	s4,a5,1df6 <sharedfd+0x192>
    1dec:	6789                	lui	a5,0x2
    1dee:	71078793          	addi	a5,a5,1808 # 2710 <concreate+0x292>
    1df2:	02fa8063          	beq	s5,a5,1e12 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    1df6:	85ce                	mv	a1,s3
    1df8:	00004517          	auipc	a0,0x4
    1dfc:	c4850513          	addi	a0,a0,-952 # 5a40 <malloc+0x102e>
    1e00:	00003097          	auipc	ra,0x3
    1e04:	b52080e7          	jalr	-1198(ra) # 4952 <printf>
    exit(1);
    1e08:	4505                	li	a0,1
    1e0a:	00002097          	auipc	ra,0x2
    1e0e:	6b2080e7          	jalr	1714(ra) # 44bc <exit>
    exit(0);
    1e12:	4501                	li	a0,0
    1e14:	00002097          	auipc	ra,0x2
    1e18:	6a8080e7          	jalr	1704(ra) # 44bc <exit>

0000000000001e1c <fourfiles>:
{
    1e1c:	7135                	addi	sp,sp,-160
    1e1e:	ed06                	sd	ra,152(sp)
    1e20:	e922                	sd	s0,144(sp)
    1e22:	e526                	sd	s1,136(sp)
    1e24:	e14a                	sd	s2,128(sp)
    1e26:	fcce                	sd	s3,120(sp)
    1e28:	f8d2                	sd	s4,112(sp)
    1e2a:	f4d6                	sd	s5,104(sp)
    1e2c:	f0da                	sd	s6,96(sp)
    1e2e:	ecde                	sd	s7,88(sp)
    1e30:	e8e2                	sd	s8,80(sp)
    1e32:	e4e6                	sd	s9,72(sp)
    1e34:	e0ea                	sd	s10,64(sp)
    1e36:	fc6e                	sd	s11,56(sp)
    1e38:	1100                	addi	s0,sp,160
    1e3a:	8d2a                	mv	s10,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e3c:	00004797          	auipc	a5,0x4
    1e40:	c1c78793          	addi	a5,a5,-996 # 5a58 <malloc+0x1046>
    1e44:	f6f43823          	sd	a5,-144(s0)
    1e48:	00004797          	auipc	a5,0x4
    1e4c:	c1878793          	addi	a5,a5,-1000 # 5a60 <malloc+0x104e>
    1e50:	f6f43c23          	sd	a5,-136(s0)
    1e54:	00004797          	auipc	a5,0x4
    1e58:	c1478793          	addi	a5,a5,-1004 # 5a68 <malloc+0x1056>
    1e5c:	f8f43023          	sd	a5,-128(s0)
    1e60:	00004797          	auipc	a5,0x4
    1e64:	c1078793          	addi	a5,a5,-1008 # 5a70 <malloc+0x105e>
    1e68:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    1e6c:	f7040b13          	addi	s6,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e70:	895a                	mv	s2,s6
  for(pi = 0; pi < NCHILD; pi++){
    1e72:	4481                	li	s1,0
    1e74:	4a11                	li	s4,4
    fname = names[pi];
    1e76:	00093983          	ld	s3,0(s2)
    unlink(fname);
    1e7a:	854e                	mv	a0,s3
    1e7c:	00002097          	auipc	ra,0x2
    1e80:	690080e7          	jalr	1680(ra) # 450c <unlink>
    pid = fork();
    1e84:	00002097          	auipc	ra,0x2
    1e88:	630080e7          	jalr	1584(ra) # 44b4 <fork>
    if(pid < 0){
    1e8c:	04054063          	bltz	a0,1ecc <fourfiles+0xb0>
    if(pid == 0){
    1e90:	cd21                	beqz	a0,1ee8 <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    1e92:	2485                	addiw	s1,s1,1
    1e94:	0921                	addi	s2,s2,8
    1e96:	ff4490e3          	bne	s1,s4,1e76 <fourfiles+0x5a>
    1e9a:	4491                	li	s1,4
    wait(&xstatus);
    1e9c:	f6c40513          	addi	a0,s0,-148
    1ea0:	00002097          	auipc	ra,0x2
    1ea4:	624080e7          	jalr	1572(ra) # 44c4 <wait>
    if(xstatus != 0)
    1ea8:	f6c42503          	lw	a0,-148(s0)
    1eac:	e961                	bnez	a0,1f7c <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    1eae:	34fd                	addiw	s1,s1,-1
    1eb0:	f4f5                	bnez	s1,1e9c <fourfiles+0x80>
    1eb2:	03000a93          	li	s5,48
    total = 0;
    1eb6:	8daa                	mv	s11,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1eb8:	00007997          	auipc	s3,0x7
    1ebc:	52898993          	addi	s3,s3,1320 # 93e0 <buf>
    if(total != N*SZ){
    1ec0:	6c05                	lui	s8,0x1
    1ec2:	770c0c13          	addi	s8,s8,1904 # 1770 <pipe1+0xe>
  for(i = 0; i < NCHILD; i++){
    1ec6:	03400c93          	li	s9,52
    1eca:	aa15                	j	1ffe <fourfiles+0x1e2>
      printf("fork failed\n", s);
    1ecc:	85ea                	mv	a1,s10
    1ece:	00004517          	auipc	a0,0x4
    1ed2:	9ca50513          	addi	a0,a0,-1590 # 5898 <malloc+0xe86>
    1ed6:	00003097          	auipc	ra,0x3
    1eda:	a7c080e7          	jalr	-1412(ra) # 4952 <printf>
      exit(1);
    1ede:	4505                	li	a0,1
    1ee0:	00002097          	auipc	ra,0x2
    1ee4:	5dc080e7          	jalr	1500(ra) # 44bc <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1ee8:	20200593          	li	a1,514
    1eec:	854e                	mv	a0,s3
    1eee:	00002097          	auipc	ra,0x2
    1ef2:	60e080e7          	jalr	1550(ra) # 44fc <open>
    1ef6:	892a                	mv	s2,a0
      if(fd < 0){
    1ef8:	04054663          	bltz	a0,1f44 <fourfiles+0x128>
      memset(buf, '0'+pi, SZ);
    1efc:	1f400613          	li	a2,500
    1f00:	0304859b          	addiw	a1,s1,48
    1f04:	00007517          	auipc	a0,0x7
    1f08:	4dc50513          	addi	a0,a0,1244 # 93e0 <buf>
    1f0c:	00002097          	auipc	ra,0x2
    1f10:	34c080e7          	jalr	844(ra) # 4258 <memset>
    1f14:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    1f16:	00007997          	auipc	s3,0x7
    1f1a:	4ca98993          	addi	s3,s3,1226 # 93e0 <buf>
    1f1e:	1f400613          	li	a2,500
    1f22:	85ce                	mv	a1,s3
    1f24:	854a                	mv	a0,s2
    1f26:	00002097          	auipc	ra,0x2
    1f2a:	5b6080e7          	jalr	1462(ra) # 44dc <write>
    1f2e:	1f400793          	li	a5,500
    1f32:	02f51763          	bne	a0,a5,1f60 <fourfiles+0x144>
      for(i = 0; i < N; i++){
    1f36:	34fd                	addiw	s1,s1,-1
    1f38:	f0fd                	bnez	s1,1f1e <fourfiles+0x102>
      exit(0);
    1f3a:	4501                	li	a0,0
    1f3c:	00002097          	auipc	ra,0x2
    1f40:	580080e7          	jalr	1408(ra) # 44bc <exit>
        printf("create failed\n", s);
    1f44:	85ea                	mv	a1,s10
    1f46:	00004517          	auipc	a0,0x4
    1f4a:	b3250513          	addi	a0,a0,-1230 # 5a78 <malloc+0x1066>
    1f4e:	00003097          	auipc	ra,0x3
    1f52:	a04080e7          	jalr	-1532(ra) # 4952 <printf>
        exit(1);
    1f56:	4505                	li	a0,1
    1f58:	00002097          	auipc	ra,0x2
    1f5c:	564080e7          	jalr	1380(ra) # 44bc <exit>
          printf("write failed %d\n", n);
    1f60:	85aa                	mv	a1,a0
    1f62:	00004517          	auipc	a0,0x4
    1f66:	b2650513          	addi	a0,a0,-1242 # 5a88 <malloc+0x1076>
    1f6a:	00003097          	auipc	ra,0x3
    1f6e:	9e8080e7          	jalr	-1560(ra) # 4952 <printf>
          exit(1);
    1f72:	4505                	li	a0,1
    1f74:	00002097          	auipc	ra,0x2
    1f78:	548080e7          	jalr	1352(ra) # 44bc <exit>
      exit(xstatus);
    1f7c:	00002097          	auipc	ra,0x2
    1f80:	540080e7          	jalr	1344(ra) # 44bc <exit>
      total += n;
    1f84:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1f88:	660d                	lui	a2,0x3
    1f8a:	85ce                	mv	a1,s3
    1f8c:	8552                	mv	a0,s4
    1f8e:	00002097          	auipc	ra,0x2
    1f92:	546080e7          	jalr	1350(ra) # 44d4 <read>
    1f96:	04a05463          	blez	a0,1fde <fourfiles+0x1c2>
        if(buf[j] != '0'+i){
    1f9a:	0009c783          	lbu	a5,0(s3)
    1f9e:	02979263          	bne	a5,s1,1fc2 <fourfiles+0x1a6>
    1fa2:	00007797          	auipc	a5,0x7
    1fa6:	43f78793          	addi	a5,a5,1087 # 93e1 <buf+0x1>
    1faa:	fff5069b          	addiw	a3,a0,-1
    1fae:	1682                	slli	a3,a3,0x20
    1fb0:	9281                	srli	a3,a3,0x20
    1fb2:	96be                	add	a3,a3,a5
      for(j = 0; j < n; j++){
    1fb4:	fcd788e3          	beq	a5,a3,1f84 <fourfiles+0x168>
        if(buf[j] != '0'+i){
    1fb8:	0007c703          	lbu	a4,0(a5)
    1fbc:	0785                	addi	a5,a5,1
    1fbe:	fe970be3          	beq	a4,s1,1fb4 <fourfiles+0x198>
          printf("wrong char\n", s);
    1fc2:	85ea                	mv	a1,s10
    1fc4:	00004517          	auipc	a0,0x4
    1fc8:	adc50513          	addi	a0,a0,-1316 # 5aa0 <malloc+0x108e>
    1fcc:	00003097          	auipc	ra,0x3
    1fd0:	986080e7          	jalr	-1658(ra) # 4952 <printf>
          exit(1);
    1fd4:	4505                	li	a0,1
    1fd6:	00002097          	auipc	ra,0x2
    1fda:	4e6080e7          	jalr	1254(ra) # 44bc <exit>
    close(fd);
    1fde:	8552                	mv	a0,s4
    1fe0:	00002097          	auipc	ra,0x2
    1fe4:	440080e7          	jalr	1088(ra) # 4420 <close>
    if(total != N*SZ){
    1fe8:	03891863          	bne	s2,s8,2018 <fourfiles+0x1fc>
    unlink(fname);
    1fec:	855e                	mv	a0,s7
    1fee:	00002097          	auipc	ra,0x2
    1ff2:	51e080e7          	jalr	1310(ra) # 450c <unlink>
  for(i = 0; i < NCHILD; i++){
    1ff6:	0b21                	addi	s6,s6,8
    1ff8:	2a85                	addiw	s5,s5,1
    1ffa:	039a8d63          	beq	s5,s9,2034 <fourfiles+0x218>
    fname = names[i];
    1ffe:	000b3b83          	ld	s7,0(s6) # 3000 <subdir+0x60a>
    fd = open(fname, 0);
    2002:	4581                	li	a1,0
    2004:	855e                	mv	a0,s7
    2006:	00002097          	auipc	ra,0x2
    200a:	4f6080e7          	jalr	1270(ra) # 44fc <open>
    200e:	8a2a                	mv	s4,a0
    total = 0;
    2010:	896e                	mv	s2,s11
    2012:	000a849b          	sext.w	s1,s5
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2016:	bf8d                	j	1f88 <fourfiles+0x16c>
      printf("wrong length %d\n", total);
    2018:	85ca                	mv	a1,s2
    201a:	00004517          	auipc	a0,0x4
    201e:	a9650513          	addi	a0,a0,-1386 # 5ab0 <malloc+0x109e>
    2022:	00003097          	auipc	ra,0x3
    2026:	930080e7          	jalr	-1744(ra) # 4952 <printf>
      exit(1);
    202a:	4505                	li	a0,1
    202c:	00002097          	auipc	ra,0x2
    2030:	490080e7          	jalr	1168(ra) # 44bc <exit>
}
    2034:	60ea                	ld	ra,152(sp)
    2036:	644a                	ld	s0,144(sp)
    2038:	64aa                	ld	s1,136(sp)
    203a:	690a                	ld	s2,128(sp)
    203c:	79e6                	ld	s3,120(sp)
    203e:	7a46                	ld	s4,112(sp)
    2040:	7aa6                	ld	s5,104(sp)
    2042:	7b06                	ld	s6,96(sp)
    2044:	6be6                	ld	s7,88(sp)
    2046:	6c46                	ld	s8,80(sp)
    2048:	6ca6                	ld	s9,72(sp)
    204a:	6d06                	ld	s10,64(sp)
    204c:	7de2                	ld	s11,56(sp)
    204e:	610d                	addi	sp,sp,160
    2050:	8082                	ret

0000000000002052 <bigfile>:
{
    2052:	7139                	addi	sp,sp,-64
    2054:	fc06                	sd	ra,56(sp)
    2056:	f822                	sd	s0,48(sp)
    2058:	f426                	sd	s1,40(sp)
    205a:	f04a                	sd	s2,32(sp)
    205c:	ec4e                	sd	s3,24(sp)
    205e:	e852                	sd	s4,16(sp)
    2060:	e456                	sd	s5,8(sp)
    2062:	0080                	addi	s0,sp,64
    2064:	8aaa                	mv	s5,a0
  unlink("bigfile.test");
    2066:	00004517          	auipc	a0,0x4
    206a:	a6250513          	addi	a0,a0,-1438 # 5ac8 <malloc+0x10b6>
    206e:	00002097          	auipc	ra,0x2
    2072:	49e080e7          	jalr	1182(ra) # 450c <unlink>
  fd = open("bigfile.test", O_CREATE | O_RDWR);
    2076:	20200593          	li	a1,514
    207a:	00004517          	auipc	a0,0x4
    207e:	a4e50513          	addi	a0,a0,-1458 # 5ac8 <malloc+0x10b6>
    2082:	00002097          	auipc	ra,0x2
    2086:	47a080e7          	jalr	1146(ra) # 44fc <open>
    208a:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    208c:	4481                	li	s1,0
    memset(buf, i, SZ);
    208e:	00007917          	auipc	s2,0x7
    2092:	35290913          	addi	s2,s2,850 # 93e0 <buf>
  for(i = 0; i < N; i++){
    2096:	4a51                	li	s4,20
  if(fd < 0){
    2098:	0a054063          	bltz	a0,2138 <bigfile+0xe6>
    memset(buf, i, SZ);
    209c:	25800613          	li	a2,600
    20a0:	85a6                	mv	a1,s1
    20a2:	854a                	mv	a0,s2
    20a4:	00002097          	auipc	ra,0x2
    20a8:	1b4080e7          	jalr	436(ra) # 4258 <memset>
    if(write(fd, buf, SZ) != SZ){
    20ac:	25800613          	li	a2,600
    20b0:	85ca                	mv	a1,s2
    20b2:	854e                	mv	a0,s3
    20b4:	00002097          	auipc	ra,0x2
    20b8:	428080e7          	jalr	1064(ra) # 44dc <write>
    20bc:	25800793          	li	a5,600
    20c0:	08f51a63          	bne	a0,a5,2154 <bigfile+0x102>
  for(i = 0; i < N; i++){
    20c4:	2485                	addiw	s1,s1,1
    20c6:	fd449be3          	bne	s1,s4,209c <bigfile+0x4a>
  close(fd);
    20ca:	854e                	mv	a0,s3
    20cc:	00002097          	auipc	ra,0x2
    20d0:	354080e7          	jalr	852(ra) # 4420 <close>
  fd = open("bigfile.test", 0);
    20d4:	4581                	li	a1,0
    20d6:	00004517          	auipc	a0,0x4
    20da:	9f250513          	addi	a0,a0,-1550 # 5ac8 <malloc+0x10b6>
    20de:	00002097          	auipc	ra,0x2
    20e2:	41e080e7          	jalr	1054(ra) # 44fc <open>
    20e6:	8a2a                	mv	s4,a0
  total = 0;
    20e8:	4981                	li	s3,0
  for(i = 0; ; i++){
    20ea:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    20ec:	00007917          	auipc	s2,0x7
    20f0:	2f490913          	addi	s2,s2,756 # 93e0 <buf>
  if(fd < 0){
    20f4:	06054e63          	bltz	a0,2170 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    20f8:	12c00613          	li	a2,300
    20fc:	85ca                	mv	a1,s2
    20fe:	8552                	mv	a0,s4
    2100:	00002097          	auipc	ra,0x2
    2104:	3d4080e7          	jalr	980(ra) # 44d4 <read>
    if(cc < 0){
    2108:	08054263          	bltz	a0,218c <bigfile+0x13a>
    if(cc == 0)
    210c:	c971                	beqz	a0,21e0 <bigfile+0x18e>
    if(cc != SZ/2){
    210e:	12c00793          	li	a5,300
    2112:	08f51b63          	bne	a0,a5,21a8 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    2116:	01f4d79b          	srliw	a5,s1,0x1f
    211a:	9fa5                	addw	a5,a5,s1
    211c:	4017d79b          	sraiw	a5,a5,0x1
    2120:	00094703          	lbu	a4,0(s2)
    2124:	0af71063          	bne	a4,a5,21c4 <bigfile+0x172>
    2128:	12b94703          	lbu	a4,299(s2)
    212c:	08f71c63          	bne	a4,a5,21c4 <bigfile+0x172>
    total += cc;
    2130:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    2134:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    2136:	b7c9                	j	20f8 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    2138:	85d6                	mv	a1,s5
    213a:	00004517          	auipc	a0,0x4
    213e:	99e50513          	addi	a0,a0,-1634 # 5ad8 <malloc+0x10c6>
    2142:	00003097          	auipc	ra,0x3
    2146:	810080e7          	jalr	-2032(ra) # 4952 <printf>
    exit(1);
    214a:	4505                	li	a0,1
    214c:	00002097          	auipc	ra,0x2
    2150:	370080e7          	jalr	880(ra) # 44bc <exit>
      printf("%s: write bigfile failed\n", s);
    2154:	85d6                	mv	a1,s5
    2156:	00004517          	auipc	a0,0x4
    215a:	9a250513          	addi	a0,a0,-1630 # 5af8 <malloc+0x10e6>
    215e:	00002097          	auipc	ra,0x2
    2162:	7f4080e7          	jalr	2036(ra) # 4952 <printf>
      exit(1);
    2166:	4505                	li	a0,1
    2168:	00002097          	auipc	ra,0x2
    216c:	354080e7          	jalr	852(ra) # 44bc <exit>
    printf("%s: cannot open bigfile\n", s);
    2170:	85d6                	mv	a1,s5
    2172:	00004517          	auipc	a0,0x4
    2176:	9a650513          	addi	a0,a0,-1626 # 5b18 <malloc+0x1106>
    217a:	00002097          	auipc	ra,0x2
    217e:	7d8080e7          	jalr	2008(ra) # 4952 <printf>
    exit(1);
    2182:	4505                	li	a0,1
    2184:	00002097          	auipc	ra,0x2
    2188:	338080e7          	jalr	824(ra) # 44bc <exit>
      printf("%s: read bigfile failed\n", s);
    218c:	85d6                	mv	a1,s5
    218e:	00004517          	auipc	a0,0x4
    2192:	9aa50513          	addi	a0,a0,-1622 # 5b38 <malloc+0x1126>
    2196:	00002097          	auipc	ra,0x2
    219a:	7bc080e7          	jalr	1980(ra) # 4952 <printf>
      exit(1);
    219e:	4505                	li	a0,1
    21a0:	00002097          	auipc	ra,0x2
    21a4:	31c080e7          	jalr	796(ra) # 44bc <exit>
      printf("%s: short read bigfile\n", s);
    21a8:	85d6                	mv	a1,s5
    21aa:	00004517          	auipc	a0,0x4
    21ae:	9ae50513          	addi	a0,a0,-1618 # 5b58 <malloc+0x1146>
    21b2:	00002097          	auipc	ra,0x2
    21b6:	7a0080e7          	jalr	1952(ra) # 4952 <printf>
      exit(1);
    21ba:	4505                	li	a0,1
    21bc:	00002097          	auipc	ra,0x2
    21c0:	300080e7          	jalr	768(ra) # 44bc <exit>
      printf("%s: read bigfile wrong data\n", s);
    21c4:	85d6                	mv	a1,s5
    21c6:	00004517          	auipc	a0,0x4
    21ca:	9aa50513          	addi	a0,a0,-1622 # 5b70 <malloc+0x115e>
    21ce:	00002097          	auipc	ra,0x2
    21d2:	784080e7          	jalr	1924(ra) # 4952 <printf>
      exit(1);
    21d6:	4505                	li	a0,1
    21d8:	00002097          	auipc	ra,0x2
    21dc:	2e4080e7          	jalr	740(ra) # 44bc <exit>
  close(fd);
    21e0:	8552                	mv	a0,s4
    21e2:	00002097          	auipc	ra,0x2
    21e6:	23e080e7          	jalr	574(ra) # 4420 <close>
  if(total != N*SZ){
    21ea:	678d                	lui	a5,0x3
    21ec:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x4ea>
    21f0:	02f99363          	bne	s3,a5,2216 <bigfile+0x1c4>
  unlink("bigfile.test");
    21f4:	00004517          	auipc	a0,0x4
    21f8:	8d450513          	addi	a0,a0,-1836 # 5ac8 <malloc+0x10b6>
    21fc:	00002097          	auipc	ra,0x2
    2200:	310080e7          	jalr	784(ra) # 450c <unlink>
}
    2204:	70e2                	ld	ra,56(sp)
    2206:	7442                	ld	s0,48(sp)
    2208:	74a2                	ld	s1,40(sp)
    220a:	7902                	ld	s2,32(sp)
    220c:	69e2                	ld	s3,24(sp)
    220e:	6a42                	ld	s4,16(sp)
    2210:	6aa2                	ld	s5,8(sp)
    2212:	6121                	addi	sp,sp,64
    2214:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    2216:	85d6                	mv	a1,s5
    2218:	00004517          	auipc	a0,0x4
    221c:	97850513          	addi	a0,a0,-1672 # 5b90 <malloc+0x117e>
    2220:	00002097          	auipc	ra,0x2
    2224:	732080e7          	jalr	1842(ra) # 4952 <printf>
    exit(1);
    2228:	4505                	li	a0,1
    222a:	00002097          	auipc	ra,0x2
    222e:	292080e7          	jalr	658(ra) # 44bc <exit>

0000000000002232 <linktest>:
{
    2232:	1101                	addi	sp,sp,-32
    2234:	ec06                	sd	ra,24(sp)
    2236:	e822                	sd	s0,16(sp)
    2238:	e426                	sd	s1,8(sp)
    223a:	e04a                	sd	s2,0(sp)
    223c:	1000                	addi	s0,sp,32
    223e:	892a                	mv	s2,a0
  unlink("lf1");
    2240:	00004517          	auipc	a0,0x4
    2244:	97050513          	addi	a0,a0,-1680 # 5bb0 <malloc+0x119e>
    2248:	00002097          	auipc	ra,0x2
    224c:	2c4080e7          	jalr	708(ra) # 450c <unlink>
  unlink("lf2");
    2250:	00004517          	auipc	a0,0x4
    2254:	96850513          	addi	a0,a0,-1688 # 5bb8 <malloc+0x11a6>
    2258:	00002097          	auipc	ra,0x2
    225c:	2b4080e7          	jalr	692(ra) # 450c <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    2260:	20200593          	li	a1,514
    2264:	00004517          	auipc	a0,0x4
    2268:	94c50513          	addi	a0,a0,-1716 # 5bb0 <malloc+0x119e>
    226c:	00002097          	auipc	ra,0x2
    2270:	290080e7          	jalr	656(ra) # 44fc <open>
  if(fd < 0){
    2274:	10054763          	bltz	a0,2382 <linktest+0x150>
    2278:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
    227a:	4615                	li	a2,5
    227c:	00003597          	auipc	a1,0x3
    2280:	3ec58593          	addi	a1,a1,1004 # 5668 <malloc+0xc56>
    2284:	00002097          	auipc	ra,0x2
    2288:	258080e7          	jalr	600(ra) # 44dc <write>
    228c:	4795                	li	a5,5
    228e:	10f51863          	bne	a0,a5,239e <linktest+0x16c>
  close(fd);
    2292:	8526                	mv	a0,s1
    2294:	00002097          	auipc	ra,0x2
    2298:	18c080e7          	jalr	396(ra) # 4420 <close>
  if(link("lf1", "lf2") < 0){
    229c:	00004597          	auipc	a1,0x4
    22a0:	91c58593          	addi	a1,a1,-1764 # 5bb8 <malloc+0x11a6>
    22a4:	00004517          	auipc	a0,0x4
    22a8:	90c50513          	addi	a0,a0,-1780 # 5bb0 <malloc+0x119e>
    22ac:	00002097          	auipc	ra,0x2
    22b0:	270080e7          	jalr	624(ra) # 451c <link>
    22b4:	10054363          	bltz	a0,23ba <linktest+0x188>
  unlink("lf1");
    22b8:	00004517          	auipc	a0,0x4
    22bc:	8f850513          	addi	a0,a0,-1800 # 5bb0 <malloc+0x119e>
    22c0:	00002097          	auipc	ra,0x2
    22c4:	24c080e7          	jalr	588(ra) # 450c <unlink>
  if(open("lf1", 0) >= 0){
    22c8:	4581                	li	a1,0
    22ca:	00004517          	auipc	a0,0x4
    22ce:	8e650513          	addi	a0,a0,-1818 # 5bb0 <malloc+0x119e>
    22d2:	00002097          	auipc	ra,0x2
    22d6:	22a080e7          	jalr	554(ra) # 44fc <open>
    22da:	0e055e63          	bgez	a0,23d6 <linktest+0x1a4>
  fd = open("lf2", 0);
    22de:	4581                	li	a1,0
    22e0:	00004517          	auipc	a0,0x4
    22e4:	8d850513          	addi	a0,a0,-1832 # 5bb8 <malloc+0x11a6>
    22e8:	00002097          	auipc	ra,0x2
    22ec:	214080e7          	jalr	532(ra) # 44fc <open>
    22f0:	84aa                	mv	s1,a0
  if(fd < 0){
    22f2:	10054063          	bltz	a0,23f2 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
    22f6:	660d                	lui	a2,0x3
    22f8:	00007597          	auipc	a1,0x7
    22fc:	0e858593          	addi	a1,a1,232 # 93e0 <buf>
    2300:	00002097          	auipc	ra,0x2
    2304:	1d4080e7          	jalr	468(ra) # 44d4 <read>
    2308:	4795                	li	a5,5
    230a:	10f51263          	bne	a0,a5,240e <linktest+0x1dc>
  close(fd);
    230e:	8526                	mv	a0,s1
    2310:	00002097          	auipc	ra,0x2
    2314:	110080e7          	jalr	272(ra) # 4420 <close>
  if(link("lf2", "lf2") >= 0){
    2318:	00004597          	auipc	a1,0x4
    231c:	8a058593          	addi	a1,a1,-1888 # 5bb8 <malloc+0x11a6>
    2320:	852e                	mv	a0,a1
    2322:	00002097          	auipc	ra,0x2
    2326:	1fa080e7          	jalr	506(ra) # 451c <link>
    232a:	10055063          	bgez	a0,242a <linktest+0x1f8>
  unlink("lf2");
    232e:	00004517          	auipc	a0,0x4
    2332:	88a50513          	addi	a0,a0,-1910 # 5bb8 <malloc+0x11a6>
    2336:	00002097          	auipc	ra,0x2
    233a:	1d6080e7          	jalr	470(ra) # 450c <unlink>
  if(link("lf2", "lf1") >= 0){
    233e:	00004597          	auipc	a1,0x4
    2342:	87258593          	addi	a1,a1,-1934 # 5bb0 <malloc+0x119e>
    2346:	00004517          	auipc	a0,0x4
    234a:	87250513          	addi	a0,a0,-1934 # 5bb8 <malloc+0x11a6>
    234e:	00002097          	auipc	ra,0x2
    2352:	1ce080e7          	jalr	462(ra) # 451c <link>
    2356:	0e055863          	bgez	a0,2446 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    235a:	00004597          	auipc	a1,0x4
    235e:	85658593          	addi	a1,a1,-1962 # 5bb0 <malloc+0x119e>
    2362:	00003517          	auipc	a0,0x3
    2366:	b6650513          	addi	a0,a0,-1178 # 4ec8 <malloc+0x4b6>
    236a:	00002097          	auipc	ra,0x2
    236e:	1b2080e7          	jalr	434(ra) # 451c <link>
    2372:	0e055863          	bgez	a0,2462 <linktest+0x230>
}
    2376:	60e2                	ld	ra,24(sp)
    2378:	6442                	ld	s0,16(sp)
    237a:	64a2                	ld	s1,8(sp)
    237c:	6902                	ld	s2,0(sp)
    237e:	6105                	addi	sp,sp,32
    2380:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    2382:	85ca                	mv	a1,s2
    2384:	00004517          	auipc	a0,0x4
    2388:	83c50513          	addi	a0,a0,-1988 # 5bc0 <malloc+0x11ae>
    238c:	00002097          	auipc	ra,0x2
    2390:	5c6080e7          	jalr	1478(ra) # 4952 <printf>
    exit(1);
    2394:	4505                	li	a0,1
    2396:	00002097          	auipc	ra,0x2
    239a:	126080e7          	jalr	294(ra) # 44bc <exit>
    printf("%s: write lf1 failed\n", s);
    239e:	85ca                	mv	a1,s2
    23a0:	00004517          	auipc	a0,0x4
    23a4:	83850513          	addi	a0,a0,-1992 # 5bd8 <malloc+0x11c6>
    23a8:	00002097          	auipc	ra,0x2
    23ac:	5aa080e7          	jalr	1450(ra) # 4952 <printf>
    exit(1);
    23b0:	4505                	li	a0,1
    23b2:	00002097          	auipc	ra,0x2
    23b6:	10a080e7          	jalr	266(ra) # 44bc <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    23ba:	85ca                	mv	a1,s2
    23bc:	00004517          	auipc	a0,0x4
    23c0:	83450513          	addi	a0,a0,-1996 # 5bf0 <malloc+0x11de>
    23c4:	00002097          	auipc	ra,0x2
    23c8:	58e080e7          	jalr	1422(ra) # 4952 <printf>
    exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00002097          	auipc	ra,0x2
    23d2:	0ee080e7          	jalr	238(ra) # 44bc <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    23d6:	85ca                	mv	a1,s2
    23d8:	00004517          	auipc	a0,0x4
    23dc:	83850513          	addi	a0,a0,-1992 # 5c10 <malloc+0x11fe>
    23e0:	00002097          	auipc	ra,0x2
    23e4:	572080e7          	jalr	1394(ra) # 4952 <printf>
    exit(1);
    23e8:	4505                	li	a0,1
    23ea:	00002097          	auipc	ra,0x2
    23ee:	0d2080e7          	jalr	210(ra) # 44bc <exit>
    printf("%s: open lf2 failed\n", s);
    23f2:	85ca                	mv	a1,s2
    23f4:	00004517          	auipc	a0,0x4
    23f8:	84c50513          	addi	a0,a0,-1972 # 5c40 <malloc+0x122e>
    23fc:	00002097          	auipc	ra,0x2
    2400:	556080e7          	jalr	1366(ra) # 4952 <printf>
    exit(1);
    2404:	4505                	li	a0,1
    2406:	00002097          	auipc	ra,0x2
    240a:	0b6080e7          	jalr	182(ra) # 44bc <exit>
    printf("%s: read lf2 failed\n", s);
    240e:	85ca                	mv	a1,s2
    2410:	00004517          	auipc	a0,0x4
    2414:	84850513          	addi	a0,a0,-1976 # 5c58 <malloc+0x1246>
    2418:	00002097          	auipc	ra,0x2
    241c:	53a080e7          	jalr	1338(ra) # 4952 <printf>
    exit(1);
    2420:	4505                	li	a0,1
    2422:	00002097          	auipc	ra,0x2
    2426:	09a080e7          	jalr	154(ra) # 44bc <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    242a:	85ca                	mv	a1,s2
    242c:	00004517          	auipc	a0,0x4
    2430:	84450513          	addi	a0,a0,-1980 # 5c70 <malloc+0x125e>
    2434:	00002097          	auipc	ra,0x2
    2438:	51e080e7          	jalr	1310(ra) # 4952 <printf>
    exit(1);
    243c:	4505                	li	a0,1
    243e:	00002097          	auipc	ra,0x2
    2442:	07e080e7          	jalr	126(ra) # 44bc <exit>
    printf("%s: link non-existant succeeded! oops\n", s);
    2446:	85ca                	mv	a1,s2
    2448:	00004517          	auipc	a0,0x4
    244c:	85050513          	addi	a0,a0,-1968 # 5c98 <malloc+0x1286>
    2450:	00002097          	auipc	ra,0x2
    2454:	502080e7          	jalr	1282(ra) # 4952 <printf>
    exit(1);
    2458:	4505                	li	a0,1
    245a:	00002097          	auipc	ra,0x2
    245e:	062080e7          	jalr	98(ra) # 44bc <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    2462:	85ca                	mv	a1,s2
    2464:	00004517          	auipc	a0,0x4
    2468:	85c50513          	addi	a0,a0,-1956 # 5cc0 <malloc+0x12ae>
    246c:	00002097          	auipc	ra,0x2
    2470:	4e6080e7          	jalr	1254(ra) # 4952 <printf>
    exit(1);
    2474:	4505                	li	a0,1
    2476:	00002097          	auipc	ra,0x2
    247a:	046080e7          	jalr	70(ra) # 44bc <exit>

000000000000247e <concreate>:
{
    247e:	7135                	addi	sp,sp,-160
    2480:	ed06                	sd	ra,152(sp)
    2482:	e922                	sd	s0,144(sp)
    2484:	e526                	sd	s1,136(sp)
    2486:	e14a                	sd	s2,128(sp)
    2488:	fcce                	sd	s3,120(sp)
    248a:	f8d2                	sd	s4,112(sp)
    248c:	f4d6                	sd	s5,104(sp)
    248e:	f0da                	sd	s6,96(sp)
    2490:	ecde                	sd	s7,88(sp)
    2492:	1100                	addi	s0,sp,160
    2494:	89aa                	mv	s3,a0
  file[0] = 'C';
    2496:	04300793          	li	a5,67
    249a:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    249e:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    24a2:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    24a4:	4b0d                	li	s6,3
    24a6:	4a85                	li	s5,1
      link("C0", file);
    24a8:	00004b97          	auipc	s7,0x4
    24ac:	838b8b93          	addi	s7,s7,-1992 # 5ce0 <malloc+0x12ce>
  for(i = 0; i < N; i++){
    24b0:	02800a13          	li	s4,40
    24b4:	a471                	j	2740 <concreate+0x2c2>
      link("C0", file);
    24b6:	fa840593          	addi	a1,s0,-88
    24ba:	855e                	mv	a0,s7
    24bc:	00002097          	auipc	ra,0x2
    24c0:	060080e7          	jalr	96(ra) # 451c <link>
    if(pid == 0) {
    24c4:	a48d                	j	2726 <concreate+0x2a8>
    } else if(pid == 0 && (i % 5) == 1){
    24c6:	4795                	li	a5,5
    24c8:	02f9693b          	remw	s2,s2,a5
    24cc:	4785                	li	a5,1
    24ce:	02f90b63          	beq	s2,a5,2504 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    24d2:	20200593          	li	a1,514
    24d6:	fa840513          	addi	a0,s0,-88
    24da:	00002097          	auipc	ra,0x2
    24de:	022080e7          	jalr	34(ra) # 44fc <open>
      if(fd < 0){
    24e2:	22055963          	bgez	a0,2714 <concreate+0x296>
        printf("concreate create %s failed\n", file);
    24e6:	fa840593          	addi	a1,s0,-88
    24ea:	00003517          	auipc	a0,0x3
    24ee:	7fe50513          	addi	a0,a0,2046 # 5ce8 <malloc+0x12d6>
    24f2:	00002097          	auipc	ra,0x2
    24f6:	460080e7          	jalr	1120(ra) # 4952 <printf>
        exit(1);
    24fa:	4505                	li	a0,1
    24fc:	00002097          	auipc	ra,0x2
    2500:	fc0080e7          	jalr	-64(ra) # 44bc <exit>
      link("C0", file);
    2504:	fa840593          	addi	a1,s0,-88
    2508:	00003517          	auipc	a0,0x3
    250c:	7d850513          	addi	a0,a0,2008 # 5ce0 <malloc+0x12ce>
    2510:	00002097          	auipc	ra,0x2
    2514:	00c080e7          	jalr	12(ra) # 451c <link>
      exit(0);
    2518:	4501                	li	a0,0
    251a:	00002097          	auipc	ra,0x2
    251e:	fa2080e7          	jalr	-94(ra) # 44bc <exit>
        exit(1);
    2522:	4505                	li	a0,1
    2524:	00002097          	auipc	ra,0x2
    2528:	f98080e7          	jalr	-104(ra) # 44bc <exit>
  memset(fa, 0, sizeof(fa));
    252c:	02800613          	li	a2,40
    2530:	4581                	li	a1,0
    2532:	f8040513          	addi	a0,s0,-128
    2536:	00002097          	auipc	ra,0x2
    253a:	d22080e7          	jalr	-734(ra) # 4258 <memset>
  fd = open(".", 0);
    253e:	4581                	li	a1,0
    2540:	00003517          	auipc	a0,0x3
    2544:	98850513          	addi	a0,a0,-1656 # 4ec8 <malloc+0x4b6>
    2548:	00002097          	auipc	ra,0x2
    254c:	fb4080e7          	jalr	-76(ra) # 44fc <open>
    2550:	892a                	mv	s2,a0
  n = 0;
    2552:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2554:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    2558:	02700b13          	li	s6,39
      fa[i] = 1;
    255c:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    255e:	4641                	li	a2,16
    2560:	f7040593          	addi	a1,s0,-144
    2564:	854a                	mv	a0,s2
    2566:	00002097          	auipc	ra,0x2
    256a:	f6e080e7          	jalr	-146(ra) # 44d4 <read>
    256e:	08a05163          	blez	a0,25f0 <concreate+0x172>
    if(de.inum == 0)
    2572:	f7045783          	lhu	a5,-144(s0)
    2576:	d7e5                	beqz	a5,255e <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2578:	f7244783          	lbu	a5,-142(s0)
    257c:	ff4791e3          	bne	a5,s4,255e <concreate+0xe0>
    2580:	f7444783          	lbu	a5,-140(s0)
    2584:	ffe9                	bnez	a5,255e <concreate+0xe0>
      i = de.name[1] - '0';
    2586:	f7344783          	lbu	a5,-141(s0)
    258a:	fd07879b          	addiw	a5,a5,-48
    258e:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    2592:	00eb6f63          	bltu	s6,a4,25b0 <concreate+0x132>
      if(fa[i]){
    2596:	fb040793          	addi	a5,s0,-80
    259a:	97ba                	add	a5,a5,a4
    259c:	fd07c783          	lbu	a5,-48(a5)
    25a0:	eb85                	bnez	a5,25d0 <concreate+0x152>
      fa[i] = 1;
    25a2:	fb040793          	addi	a5,s0,-80
    25a6:	973e                	add	a4,a4,a5
    25a8:	fd770823          	sb	s7,-48(a4)
      n++;
    25ac:	2a85                	addiw	s5,s5,1
    25ae:	bf45                	j	255e <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    25b0:	f7240613          	addi	a2,s0,-142
    25b4:	85ce                	mv	a1,s3
    25b6:	00003517          	auipc	a0,0x3
    25ba:	75250513          	addi	a0,a0,1874 # 5d08 <malloc+0x12f6>
    25be:	00002097          	auipc	ra,0x2
    25c2:	394080e7          	jalr	916(ra) # 4952 <printf>
        exit(1);
    25c6:	4505                	li	a0,1
    25c8:	00002097          	auipc	ra,0x2
    25cc:	ef4080e7          	jalr	-268(ra) # 44bc <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    25d0:	f7240613          	addi	a2,s0,-142
    25d4:	85ce                	mv	a1,s3
    25d6:	00003517          	auipc	a0,0x3
    25da:	75250513          	addi	a0,a0,1874 # 5d28 <malloc+0x1316>
    25de:	00002097          	auipc	ra,0x2
    25e2:	374080e7          	jalr	884(ra) # 4952 <printf>
        exit(1);
    25e6:	4505                	li	a0,1
    25e8:	00002097          	auipc	ra,0x2
    25ec:	ed4080e7          	jalr	-300(ra) # 44bc <exit>
  close(fd);
    25f0:	854a                	mv	a0,s2
    25f2:	00002097          	auipc	ra,0x2
    25f6:	e2e080e7          	jalr	-466(ra) # 4420 <close>
  if(n != N){
    25fa:	02800793          	li	a5,40
    25fe:	00fa9763          	bne	s5,a5,260c <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    2602:	4a8d                	li	s5,3
    2604:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    2606:	02800a13          	li	s4,40
    260a:	a05d                	j	26b0 <concreate+0x232>
    printf("%s: concreate not enough files in directory listing\n", s);
    260c:	85ce                	mv	a1,s3
    260e:	00003517          	auipc	a0,0x3
    2612:	74250513          	addi	a0,a0,1858 # 5d50 <malloc+0x133e>
    2616:	00002097          	auipc	ra,0x2
    261a:	33c080e7          	jalr	828(ra) # 4952 <printf>
    exit(1);
    261e:	4505                	li	a0,1
    2620:	00002097          	auipc	ra,0x2
    2624:	e9c080e7          	jalr	-356(ra) # 44bc <exit>
      printf("%s: fork failed\n", s);
    2628:	85ce                	mv	a1,s3
    262a:	00003517          	auipc	a0,0x3
    262e:	94e50513          	addi	a0,a0,-1714 # 4f78 <malloc+0x566>
    2632:	00002097          	auipc	ra,0x2
    2636:	320080e7          	jalr	800(ra) # 4952 <printf>
      exit(1);
    263a:	4505                	li	a0,1
    263c:	00002097          	auipc	ra,0x2
    2640:	e80080e7          	jalr	-384(ra) # 44bc <exit>
      close(open(file, 0));
    2644:	4581                	li	a1,0
    2646:	fa840513          	addi	a0,s0,-88
    264a:	00002097          	auipc	ra,0x2
    264e:	eb2080e7          	jalr	-334(ra) # 44fc <open>
    2652:	00002097          	auipc	ra,0x2
    2656:	dce080e7          	jalr	-562(ra) # 4420 <close>
      close(open(file, 0));
    265a:	4581                	li	a1,0
    265c:	fa840513          	addi	a0,s0,-88
    2660:	00002097          	auipc	ra,0x2
    2664:	e9c080e7          	jalr	-356(ra) # 44fc <open>
    2668:	00002097          	auipc	ra,0x2
    266c:	db8080e7          	jalr	-584(ra) # 4420 <close>
      close(open(file, 0));
    2670:	4581                	li	a1,0
    2672:	fa840513          	addi	a0,s0,-88
    2676:	00002097          	auipc	ra,0x2
    267a:	e86080e7          	jalr	-378(ra) # 44fc <open>
    267e:	00002097          	auipc	ra,0x2
    2682:	da2080e7          	jalr	-606(ra) # 4420 <close>
      close(open(file, 0));
    2686:	4581                	li	a1,0
    2688:	fa840513          	addi	a0,s0,-88
    268c:	00002097          	auipc	ra,0x2
    2690:	e70080e7          	jalr	-400(ra) # 44fc <open>
    2694:	00002097          	auipc	ra,0x2
    2698:	d8c080e7          	jalr	-628(ra) # 4420 <close>
    if(pid == 0)
    269c:	06090763          	beqz	s2,270a <concreate+0x28c>
      wait(0);
    26a0:	4501                	li	a0,0
    26a2:	00002097          	auipc	ra,0x2
    26a6:	e22080e7          	jalr	-478(ra) # 44c4 <wait>
  for(i = 0; i < N; i++){
    26aa:	2485                	addiw	s1,s1,1
    26ac:	0d448963          	beq	s1,s4,277e <concreate+0x300>
    file[1] = '0' + i;
    26b0:	0304879b          	addiw	a5,s1,48
    26b4:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    26b8:	00002097          	auipc	ra,0x2
    26bc:	dfc080e7          	jalr	-516(ra) # 44b4 <fork>
    26c0:	892a                	mv	s2,a0
    if(pid < 0){
    26c2:	f60543e3          	bltz	a0,2628 <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    26c6:	0354e73b          	remw	a4,s1,s5
    26ca:	00a767b3          	or	a5,a4,a0
    26ce:	2781                	sext.w	a5,a5
    26d0:	dbb5                	beqz	a5,2644 <concreate+0x1c6>
    26d2:	01671363          	bne	a4,s6,26d8 <concreate+0x25a>
       ((i % 3) == 1 && pid != 0)){
    26d6:	f53d                	bnez	a0,2644 <concreate+0x1c6>
      unlink(file);
    26d8:	fa840513          	addi	a0,s0,-88
    26dc:	00002097          	auipc	ra,0x2
    26e0:	e30080e7          	jalr	-464(ra) # 450c <unlink>
      unlink(file);
    26e4:	fa840513          	addi	a0,s0,-88
    26e8:	00002097          	auipc	ra,0x2
    26ec:	e24080e7          	jalr	-476(ra) # 450c <unlink>
      unlink(file);
    26f0:	fa840513          	addi	a0,s0,-88
    26f4:	00002097          	auipc	ra,0x2
    26f8:	e18080e7          	jalr	-488(ra) # 450c <unlink>
      unlink(file);
    26fc:	fa840513          	addi	a0,s0,-88
    2700:	00002097          	auipc	ra,0x2
    2704:	e0c080e7          	jalr	-500(ra) # 450c <unlink>
    2708:	bf51                	j	269c <concreate+0x21e>
      exit(0);
    270a:	4501                	li	a0,0
    270c:	00002097          	auipc	ra,0x2
    2710:	db0080e7          	jalr	-592(ra) # 44bc <exit>
      close(fd);
    2714:	00002097          	auipc	ra,0x2
    2718:	d0c080e7          	jalr	-756(ra) # 4420 <close>
    if(pid == 0) {
    271c:	bbf5                	j	2518 <concreate+0x9a>
      close(fd);
    271e:	00002097          	auipc	ra,0x2
    2722:	d02080e7          	jalr	-766(ra) # 4420 <close>
      wait(&xstatus);
    2726:	f6c40513          	addi	a0,s0,-148
    272a:	00002097          	auipc	ra,0x2
    272e:	d9a080e7          	jalr	-614(ra) # 44c4 <wait>
      if(xstatus != 0)
    2732:	f6c42483          	lw	s1,-148(s0)
    2736:	de0496e3          	bnez	s1,2522 <concreate+0xa4>
  for(i = 0; i < N; i++){
    273a:	2905                	addiw	s2,s2,1
    273c:	df4908e3          	beq	s2,s4,252c <concreate+0xae>
    file[1] = '0' + i;
    2740:	0309079b          	addiw	a5,s2,48
    2744:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    2748:	fa840513          	addi	a0,s0,-88
    274c:	00002097          	auipc	ra,0x2
    2750:	dc0080e7          	jalr	-576(ra) # 450c <unlink>
    pid = fork();
    2754:	00002097          	auipc	ra,0x2
    2758:	d60080e7          	jalr	-672(ra) # 44b4 <fork>
    if(pid && (i % 3) == 1){
    275c:	d60505e3          	beqz	a0,24c6 <concreate+0x48>
    2760:	036967bb          	remw	a5,s2,s6
    2764:	d55789e3          	beq	a5,s5,24b6 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    2768:	20200593          	li	a1,514
    276c:	fa840513          	addi	a0,s0,-88
    2770:	00002097          	auipc	ra,0x2
    2774:	d8c080e7          	jalr	-628(ra) # 44fc <open>
      if(fd < 0){
    2778:	fa0553e3          	bgez	a0,271e <concreate+0x2a0>
    277c:	b3ad                	j	24e6 <concreate+0x68>
}
    277e:	60ea                	ld	ra,152(sp)
    2780:	644a                	ld	s0,144(sp)
    2782:	64aa                	ld	s1,136(sp)
    2784:	690a                	ld	s2,128(sp)
    2786:	79e6                	ld	s3,120(sp)
    2788:	7a46                	ld	s4,112(sp)
    278a:	7aa6                	ld	s5,104(sp)
    278c:	7b06                	ld	s6,96(sp)
    278e:	6be6                	ld	s7,88(sp)
    2790:	610d                	addi	sp,sp,160
    2792:	8082                	ret

0000000000002794 <linkunlink>:
{
    2794:	711d                	addi	sp,sp,-96
    2796:	ec86                	sd	ra,88(sp)
    2798:	e8a2                	sd	s0,80(sp)
    279a:	e4a6                	sd	s1,72(sp)
    279c:	e0ca                	sd	s2,64(sp)
    279e:	fc4e                	sd	s3,56(sp)
    27a0:	f852                	sd	s4,48(sp)
    27a2:	f456                	sd	s5,40(sp)
    27a4:	f05a                	sd	s6,32(sp)
    27a6:	ec5e                	sd	s7,24(sp)
    27a8:	e862                	sd	s8,16(sp)
    27aa:	e466                	sd	s9,8(sp)
    27ac:	1080                	addi	s0,sp,96
    27ae:	84aa                	mv	s1,a0
  unlink("x");
    27b0:	00003517          	auipc	a0,0x3
    27b4:	19850513          	addi	a0,a0,408 # 5948 <malloc+0xf36>
    27b8:	00002097          	auipc	ra,0x2
    27bc:	d54080e7          	jalr	-684(ra) # 450c <unlink>
  pid = fork();
    27c0:	00002097          	auipc	ra,0x2
    27c4:	cf4080e7          	jalr	-780(ra) # 44b4 <fork>
  if(pid < 0){
    27c8:	02054b63          	bltz	a0,27fe <linkunlink+0x6a>
    27cc:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    27ce:	4c85                	li	s9,1
    27d0:	e119                	bnez	a0,27d6 <linkunlink+0x42>
    27d2:	06100c93          	li	s9,97
    27d6:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    27da:	41c659b7          	lui	s3,0x41c65
    27de:	e6d9899b          	addiw	s3,s3,-403
    27e2:	690d                	lui	s2,0x3
    27e4:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    27e8:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    27ea:	4b05                	li	s6,1
      unlink("x");
    27ec:	00003a97          	auipc	s5,0x3
    27f0:	15ca8a93          	addi	s5,s5,348 # 5948 <malloc+0xf36>
      link("cat", "x");
    27f4:	00003b97          	auipc	s7,0x3
    27f8:	594b8b93          	addi	s7,s7,1428 # 5d88 <malloc+0x1376>
    27fc:	a091                	j	2840 <linkunlink+0xac>
    printf("%s: fork failed\n", s);
    27fe:	85a6                	mv	a1,s1
    2800:	00002517          	auipc	a0,0x2
    2804:	77850513          	addi	a0,a0,1912 # 4f78 <malloc+0x566>
    2808:	00002097          	auipc	ra,0x2
    280c:	14a080e7          	jalr	330(ra) # 4952 <printf>
    exit(1);
    2810:	4505                	li	a0,1
    2812:	00002097          	auipc	ra,0x2
    2816:	caa080e7          	jalr	-854(ra) # 44bc <exit>
      close(open("x", O_RDWR | O_CREATE));
    281a:	20200593          	li	a1,514
    281e:	8556                	mv	a0,s5
    2820:	00002097          	auipc	ra,0x2
    2824:	cdc080e7          	jalr	-804(ra) # 44fc <open>
    2828:	00002097          	auipc	ra,0x2
    282c:	bf8080e7          	jalr	-1032(ra) # 4420 <close>
    2830:	a031                	j	283c <linkunlink+0xa8>
      unlink("x");
    2832:	8556                	mv	a0,s5
    2834:	00002097          	auipc	ra,0x2
    2838:	cd8080e7          	jalr	-808(ra) # 450c <unlink>
  for(i = 0; i < 100; i++){
    283c:	34fd                	addiw	s1,s1,-1
    283e:	c09d                	beqz	s1,2864 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    2840:	033c87bb          	mulw	a5,s9,s3
    2844:	012787bb          	addw	a5,a5,s2
    2848:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    284c:	0347f7bb          	remuw	a5,a5,s4
    2850:	d7e9                	beqz	a5,281a <linkunlink+0x86>
    } else if((x % 3) == 1){
    2852:	ff6790e3          	bne	a5,s6,2832 <linkunlink+0x9e>
      link("cat", "x");
    2856:	85d6                	mv	a1,s5
    2858:	855e                	mv	a0,s7
    285a:	00002097          	auipc	ra,0x2
    285e:	cc2080e7          	jalr	-830(ra) # 451c <link>
    2862:	bfe9                	j	283c <linkunlink+0xa8>
  if(pid)
    2864:	020c0463          	beqz	s8,288c <linkunlink+0xf8>
    wait(0);
    2868:	4501                	li	a0,0
    286a:	00002097          	auipc	ra,0x2
    286e:	c5a080e7          	jalr	-934(ra) # 44c4 <wait>
}
    2872:	60e6                	ld	ra,88(sp)
    2874:	6446                	ld	s0,80(sp)
    2876:	64a6                	ld	s1,72(sp)
    2878:	6906                	ld	s2,64(sp)
    287a:	79e2                	ld	s3,56(sp)
    287c:	7a42                	ld	s4,48(sp)
    287e:	7aa2                	ld	s5,40(sp)
    2880:	7b02                	ld	s6,32(sp)
    2882:	6be2                	ld	s7,24(sp)
    2884:	6c42                	ld	s8,16(sp)
    2886:	6ca2                	ld	s9,8(sp)
    2888:	6125                	addi	sp,sp,96
    288a:	8082                	ret
    exit(0);
    288c:	4501                	li	a0,0
    288e:	00002097          	auipc	ra,0x2
    2892:	c2e080e7          	jalr	-978(ra) # 44bc <exit>

0000000000002896 <bigdir>:
{
    2896:	715d                	addi	sp,sp,-80
    2898:	e486                	sd	ra,72(sp)
    289a:	e0a2                	sd	s0,64(sp)
    289c:	fc26                	sd	s1,56(sp)
    289e:	f84a                	sd	s2,48(sp)
    28a0:	f44e                	sd	s3,40(sp)
    28a2:	f052                	sd	s4,32(sp)
    28a4:	ec56                	sd	s5,24(sp)
    28a6:	e85a                	sd	s6,16(sp)
    28a8:	0880                	addi	s0,sp,80
    28aa:	89aa                	mv	s3,a0
  unlink("bd");
    28ac:	00003517          	auipc	a0,0x3
    28b0:	4e450513          	addi	a0,a0,1252 # 5d90 <malloc+0x137e>
    28b4:	00002097          	auipc	ra,0x2
    28b8:	c58080e7          	jalr	-936(ra) # 450c <unlink>
  fd = open("bd", O_CREATE);
    28bc:	20000593          	li	a1,512
    28c0:	00003517          	auipc	a0,0x3
    28c4:	4d050513          	addi	a0,a0,1232 # 5d90 <malloc+0x137e>
    28c8:	00002097          	auipc	ra,0x2
    28cc:	c34080e7          	jalr	-972(ra) # 44fc <open>
  if(fd < 0){
    28d0:	0c054963          	bltz	a0,29a2 <bigdir+0x10c>
  close(fd);
    28d4:	00002097          	auipc	ra,0x2
    28d8:	b4c080e7          	jalr	-1204(ra) # 4420 <close>
  for(i = 0; i < N; i++){
    28dc:	4901                	li	s2,0
    name[0] = 'x';
    28de:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    28e2:	00003a17          	auipc	s4,0x3
    28e6:	4aea0a13          	addi	s4,s4,1198 # 5d90 <malloc+0x137e>
  for(i = 0; i < N; i++){
    28ea:	1f400b13          	li	s6,500
    name[0] = 'x';
    28ee:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    28f2:	41f9579b          	sraiw	a5,s2,0x1f
    28f6:	01a7d71b          	srliw	a4,a5,0x1a
    28fa:	012707bb          	addw	a5,a4,s2
    28fe:	4067d69b          	sraiw	a3,a5,0x6
    2902:	0306869b          	addiw	a3,a3,48
    2906:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    290a:	03f7f793          	andi	a5,a5,63
    290e:	9f99                	subw	a5,a5,a4
    2910:	0307879b          	addiw	a5,a5,48
    2914:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    2918:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    291c:	fb040593          	addi	a1,s0,-80
    2920:	8552                	mv	a0,s4
    2922:	00002097          	auipc	ra,0x2
    2926:	bfa080e7          	jalr	-1030(ra) # 451c <link>
    292a:	84aa                	mv	s1,a0
    292c:	e949                	bnez	a0,29be <bigdir+0x128>
  for(i = 0; i < N; i++){
    292e:	2905                	addiw	s2,s2,1
    2930:	fb691fe3          	bne	s2,s6,28ee <bigdir+0x58>
  unlink("bd");
    2934:	00003517          	auipc	a0,0x3
    2938:	45c50513          	addi	a0,a0,1116 # 5d90 <malloc+0x137e>
    293c:	00002097          	auipc	ra,0x2
    2940:	bd0080e7          	jalr	-1072(ra) # 450c <unlink>
    name[0] = 'x';
    2944:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    2948:	1f400a13          	li	s4,500
    name[0] = 'x';
    294c:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    2950:	41f4d79b          	sraiw	a5,s1,0x1f
    2954:	01a7d71b          	srliw	a4,a5,0x1a
    2958:	009707bb          	addw	a5,a4,s1
    295c:	4067d69b          	sraiw	a3,a5,0x6
    2960:	0306869b          	addiw	a3,a3,48
    2964:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    2968:	03f7f793          	andi	a5,a5,63
    296c:	9f99                	subw	a5,a5,a4
    296e:	0307879b          	addiw	a5,a5,48
    2972:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    2976:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    297a:	fb040513          	addi	a0,s0,-80
    297e:	00002097          	auipc	ra,0x2
    2982:	b8e080e7          	jalr	-1138(ra) # 450c <unlink>
    2986:	e931                	bnez	a0,29da <bigdir+0x144>
  for(i = 0; i < N; i++){
    2988:	2485                	addiw	s1,s1,1
    298a:	fd4491e3          	bne	s1,s4,294c <bigdir+0xb6>
}
    298e:	60a6                	ld	ra,72(sp)
    2990:	6406                	ld	s0,64(sp)
    2992:	74e2                	ld	s1,56(sp)
    2994:	7942                	ld	s2,48(sp)
    2996:	79a2                	ld	s3,40(sp)
    2998:	7a02                	ld	s4,32(sp)
    299a:	6ae2                	ld	s5,24(sp)
    299c:	6b42                	ld	s6,16(sp)
    299e:	6161                	addi	sp,sp,80
    29a0:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    29a2:	85ce                	mv	a1,s3
    29a4:	00003517          	auipc	a0,0x3
    29a8:	3f450513          	addi	a0,a0,1012 # 5d98 <malloc+0x1386>
    29ac:	00002097          	auipc	ra,0x2
    29b0:	fa6080e7          	jalr	-90(ra) # 4952 <printf>
    exit(1);
    29b4:	4505                	li	a0,1
    29b6:	00002097          	auipc	ra,0x2
    29ba:	b06080e7          	jalr	-1274(ra) # 44bc <exit>
      printf("%s: bigdir link failed\n", s);
    29be:	85ce                	mv	a1,s3
    29c0:	00003517          	auipc	a0,0x3
    29c4:	3f850513          	addi	a0,a0,1016 # 5db8 <malloc+0x13a6>
    29c8:	00002097          	auipc	ra,0x2
    29cc:	f8a080e7          	jalr	-118(ra) # 4952 <printf>
      exit(1);
    29d0:	4505                	li	a0,1
    29d2:	00002097          	auipc	ra,0x2
    29d6:	aea080e7          	jalr	-1302(ra) # 44bc <exit>
      printf("%s: bigdir unlink failed", s);
    29da:	85ce                	mv	a1,s3
    29dc:	00003517          	auipc	a0,0x3
    29e0:	3f450513          	addi	a0,a0,1012 # 5dd0 <malloc+0x13be>
    29e4:	00002097          	auipc	ra,0x2
    29e8:	f6e080e7          	jalr	-146(ra) # 4952 <printf>
      exit(1);
    29ec:	4505                	li	a0,1
    29ee:	00002097          	auipc	ra,0x2
    29f2:	ace080e7          	jalr	-1330(ra) # 44bc <exit>

00000000000029f6 <subdir>:
{
    29f6:	1101                	addi	sp,sp,-32
    29f8:	ec06                	sd	ra,24(sp)
    29fa:	e822                	sd	s0,16(sp)
    29fc:	e426                	sd	s1,8(sp)
    29fe:	e04a                	sd	s2,0(sp)
    2a00:	1000                	addi	s0,sp,32
    2a02:	892a                	mv	s2,a0
  unlink("ff");
    2a04:	00003517          	auipc	a0,0x3
    2a08:	51c50513          	addi	a0,a0,1308 # 5f20 <malloc+0x150e>
    2a0c:	00002097          	auipc	ra,0x2
    2a10:	b00080e7          	jalr	-1280(ra) # 450c <unlink>
  if(mkdir("dd") != 0){
    2a14:	00003517          	auipc	a0,0x3
    2a18:	3dc50513          	addi	a0,a0,988 # 5df0 <malloc+0x13de>
    2a1c:	00002097          	auipc	ra,0x2
    2a20:	b08080e7          	jalr	-1272(ra) # 4524 <mkdir>
    2a24:	38051663          	bnez	a0,2db0 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2a28:	20200593          	li	a1,514
    2a2c:	00003517          	auipc	a0,0x3
    2a30:	3e450513          	addi	a0,a0,996 # 5e10 <malloc+0x13fe>
    2a34:	00002097          	auipc	ra,0x2
    2a38:	ac8080e7          	jalr	-1336(ra) # 44fc <open>
    2a3c:	84aa                	mv	s1,a0
  if(fd < 0){
    2a3e:	38054763          	bltz	a0,2dcc <subdir+0x3d6>
  write(fd, "ff", 2);
    2a42:	4609                	li	a2,2
    2a44:	00003597          	auipc	a1,0x3
    2a48:	4dc58593          	addi	a1,a1,1244 # 5f20 <malloc+0x150e>
    2a4c:	00002097          	auipc	ra,0x2
    2a50:	a90080e7          	jalr	-1392(ra) # 44dc <write>
  close(fd);
    2a54:	8526                	mv	a0,s1
    2a56:	00002097          	auipc	ra,0x2
    2a5a:	9ca080e7          	jalr	-1590(ra) # 4420 <close>
  if(unlink("dd") >= 0){
    2a5e:	00003517          	auipc	a0,0x3
    2a62:	39250513          	addi	a0,a0,914 # 5df0 <malloc+0x13de>
    2a66:	00002097          	auipc	ra,0x2
    2a6a:	aa6080e7          	jalr	-1370(ra) # 450c <unlink>
    2a6e:	36055d63          	bgez	a0,2de8 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    2a72:	00003517          	auipc	a0,0x3
    2a76:	3f650513          	addi	a0,a0,1014 # 5e68 <malloc+0x1456>
    2a7a:	00002097          	auipc	ra,0x2
    2a7e:	aaa080e7          	jalr	-1366(ra) # 4524 <mkdir>
    2a82:	38051163          	bnez	a0,2e04 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2a86:	20200593          	li	a1,514
    2a8a:	00003517          	auipc	a0,0x3
    2a8e:	40650513          	addi	a0,a0,1030 # 5e90 <malloc+0x147e>
    2a92:	00002097          	auipc	ra,0x2
    2a96:	a6a080e7          	jalr	-1430(ra) # 44fc <open>
    2a9a:	84aa                	mv	s1,a0
  if(fd < 0){
    2a9c:	38054263          	bltz	a0,2e20 <subdir+0x42a>
  write(fd, "FF", 2);
    2aa0:	4609                	li	a2,2
    2aa2:	00003597          	auipc	a1,0x3
    2aa6:	41e58593          	addi	a1,a1,1054 # 5ec0 <malloc+0x14ae>
    2aaa:	00002097          	auipc	ra,0x2
    2aae:	a32080e7          	jalr	-1486(ra) # 44dc <write>
  close(fd);
    2ab2:	8526                	mv	a0,s1
    2ab4:	00002097          	auipc	ra,0x2
    2ab8:	96c080e7          	jalr	-1684(ra) # 4420 <close>
  fd = open("dd/dd/../ff", 0);
    2abc:	4581                	li	a1,0
    2abe:	00003517          	auipc	a0,0x3
    2ac2:	40a50513          	addi	a0,a0,1034 # 5ec8 <malloc+0x14b6>
    2ac6:	00002097          	auipc	ra,0x2
    2aca:	a36080e7          	jalr	-1482(ra) # 44fc <open>
    2ace:	84aa                	mv	s1,a0
  if(fd < 0){
    2ad0:	36054663          	bltz	a0,2e3c <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    2ad4:	660d                	lui	a2,0x3
    2ad6:	00007597          	auipc	a1,0x7
    2ada:	90a58593          	addi	a1,a1,-1782 # 93e0 <buf>
    2ade:	00002097          	auipc	ra,0x2
    2ae2:	9f6080e7          	jalr	-1546(ra) # 44d4 <read>
  if(cc != 2 || buf[0] != 'f'){
    2ae6:	4789                	li	a5,2
    2ae8:	36f51863          	bne	a0,a5,2e58 <subdir+0x462>
    2aec:	00007717          	auipc	a4,0x7
    2af0:	8f474703          	lbu	a4,-1804(a4) # 93e0 <buf>
    2af4:	06600793          	li	a5,102
    2af8:	36f71063          	bne	a4,a5,2e58 <subdir+0x462>
  close(fd);
    2afc:	8526                	mv	a0,s1
    2afe:	00002097          	auipc	ra,0x2
    2b02:	922080e7          	jalr	-1758(ra) # 4420 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2b06:	00003597          	auipc	a1,0x3
    2b0a:	41258593          	addi	a1,a1,1042 # 5f18 <malloc+0x1506>
    2b0e:	00003517          	auipc	a0,0x3
    2b12:	38250513          	addi	a0,a0,898 # 5e90 <malloc+0x147e>
    2b16:	00002097          	auipc	ra,0x2
    2b1a:	a06080e7          	jalr	-1530(ra) # 451c <link>
    2b1e:	34051b63          	bnez	a0,2e74 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    2b22:	00003517          	auipc	a0,0x3
    2b26:	36e50513          	addi	a0,a0,878 # 5e90 <malloc+0x147e>
    2b2a:	00002097          	auipc	ra,0x2
    2b2e:	9e2080e7          	jalr	-1566(ra) # 450c <unlink>
    2b32:	34051f63          	bnez	a0,2e90 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2b36:	4581                	li	a1,0
    2b38:	00003517          	auipc	a0,0x3
    2b3c:	35850513          	addi	a0,a0,856 # 5e90 <malloc+0x147e>
    2b40:	00002097          	auipc	ra,0x2
    2b44:	9bc080e7          	jalr	-1604(ra) # 44fc <open>
    2b48:	36055263          	bgez	a0,2eac <subdir+0x4b6>
  if(chdir("dd") != 0){
    2b4c:	00003517          	auipc	a0,0x3
    2b50:	2a450513          	addi	a0,a0,676 # 5df0 <malloc+0x13de>
    2b54:	00002097          	auipc	ra,0x2
    2b58:	9d8080e7          	jalr	-1576(ra) # 452c <chdir>
    2b5c:	36051663          	bnez	a0,2ec8 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    2b60:	00003517          	auipc	a0,0x3
    2b64:	45050513          	addi	a0,a0,1104 # 5fb0 <malloc+0x159e>
    2b68:	00002097          	auipc	ra,0x2
    2b6c:	9c4080e7          	jalr	-1596(ra) # 452c <chdir>
    2b70:	36051a63          	bnez	a0,2ee4 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    2b74:	00003517          	auipc	a0,0x3
    2b78:	46c50513          	addi	a0,a0,1132 # 5fe0 <malloc+0x15ce>
    2b7c:	00002097          	auipc	ra,0x2
    2b80:	9b0080e7          	jalr	-1616(ra) # 452c <chdir>
    2b84:	36051e63          	bnez	a0,2f00 <subdir+0x50a>
  if(chdir("./..") != 0){
    2b88:	00003517          	auipc	a0,0x3
    2b8c:	48850513          	addi	a0,a0,1160 # 6010 <malloc+0x15fe>
    2b90:	00002097          	auipc	ra,0x2
    2b94:	99c080e7          	jalr	-1636(ra) # 452c <chdir>
    2b98:	38051263          	bnez	a0,2f1c <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    2b9c:	4581                	li	a1,0
    2b9e:	00003517          	auipc	a0,0x3
    2ba2:	37a50513          	addi	a0,a0,890 # 5f18 <malloc+0x1506>
    2ba6:	00002097          	auipc	ra,0x2
    2baa:	956080e7          	jalr	-1706(ra) # 44fc <open>
    2bae:	84aa                	mv	s1,a0
  if(fd < 0){
    2bb0:	38054463          	bltz	a0,2f38 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    2bb4:	660d                	lui	a2,0x3
    2bb6:	00007597          	auipc	a1,0x7
    2bba:	82a58593          	addi	a1,a1,-2006 # 93e0 <buf>
    2bbe:	00002097          	auipc	ra,0x2
    2bc2:	916080e7          	jalr	-1770(ra) # 44d4 <read>
    2bc6:	4789                	li	a5,2
    2bc8:	38f51663          	bne	a0,a5,2f54 <subdir+0x55e>
  close(fd);
    2bcc:	8526                	mv	a0,s1
    2bce:	00002097          	auipc	ra,0x2
    2bd2:	852080e7          	jalr	-1966(ra) # 4420 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2bd6:	4581                	li	a1,0
    2bd8:	00003517          	auipc	a0,0x3
    2bdc:	2b850513          	addi	a0,a0,696 # 5e90 <malloc+0x147e>
    2be0:	00002097          	auipc	ra,0x2
    2be4:	91c080e7          	jalr	-1764(ra) # 44fc <open>
    2be8:	38055463          	bgez	a0,2f70 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2bec:	20200593          	li	a1,514
    2bf0:	00003517          	auipc	a0,0x3
    2bf4:	4b050513          	addi	a0,a0,1200 # 60a0 <malloc+0x168e>
    2bf8:	00002097          	auipc	ra,0x2
    2bfc:	904080e7          	jalr	-1788(ra) # 44fc <open>
    2c00:	38055663          	bgez	a0,2f8c <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2c04:	20200593          	li	a1,514
    2c08:	00003517          	auipc	a0,0x3
    2c0c:	4c850513          	addi	a0,a0,1224 # 60d0 <malloc+0x16be>
    2c10:	00002097          	auipc	ra,0x2
    2c14:	8ec080e7          	jalr	-1812(ra) # 44fc <open>
    2c18:	38055863          	bgez	a0,2fa8 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    2c1c:	20000593          	li	a1,512
    2c20:	00003517          	auipc	a0,0x3
    2c24:	1d050513          	addi	a0,a0,464 # 5df0 <malloc+0x13de>
    2c28:	00002097          	auipc	ra,0x2
    2c2c:	8d4080e7          	jalr	-1836(ra) # 44fc <open>
    2c30:	38055a63          	bgez	a0,2fc4 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    2c34:	4589                	li	a1,2
    2c36:	00003517          	auipc	a0,0x3
    2c3a:	1ba50513          	addi	a0,a0,442 # 5df0 <malloc+0x13de>
    2c3e:	00002097          	auipc	ra,0x2
    2c42:	8be080e7          	jalr	-1858(ra) # 44fc <open>
    2c46:	38055d63          	bgez	a0,2fe0 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    2c4a:	4585                	li	a1,1
    2c4c:	00003517          	auipc	a0,0x3
    2c50:	1a450513          	addi	a0,a0,420 # 5df0 <malloc+0x13de>
    2c54:	00002097          	auipc	ra,0x2
    2c58:	8a8080e7          	jalr	-1880(ra) # 44fc <open>
    2c5c:	3a055063          	bgez	a0,2ffc <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2c60:	00003597          	auipc	a1,0x3
    2c64:	50058593          	addi	a1,a1,1280 # 6160 <malloc+0x174e>
    2c68:	00003517          	auipc	a0,0x3
    2c6c:	43850513          	addi	a0,a0,1080 # 60a0 <malloc+0x168e>
    2c70:	00002097          	auipc	ra,0x2
    2c74:	8ac080e7          	jalr	-1876(ra) # 451c <link>
    2c78:	3a050063          	beqz	a0,3018 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2c7c:	00003597          	auipc	a1,0x3
    2c80:	4e458593          	addi	a1,a1,1252 # 6160 <malloc+0x174e>
    2c84:	00003517          	auipc	a0,0x3
    2c88:	44c50513          	addi	a0,a0,1100 # 60d0 <malloc+0x16be>
    2c8c:	00002097          	auipc	ra,0x2
    2c90:	890080e7          	jalr	-1904(ra) # 451c <link>
    2c94:	3a050063          	beqz	a0,3034 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2c98:	00003597          	auipc	a1,0x3
    2c9c:	28058593          	addi	a1,a1,640 # 5f18 <malloc+0x1506>
    2ca0:	00003517          	auipc	a0,0x3
    2ca4:	17050513          	addi	a0,a0,368 # 5e10 <malloc+0x13fe>
    2ca8:	00002097          	auipc	ra,0x2
    2cac:	874080e7          	jalr	-1932(ra) # 451c <link>
    2cb0:	3a050063          	beqz	a0,3050 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    2cb4:	00003517          	auipc	a0,0x3
    2cb8:	3ec50513          	addi	a0,a0,1004 # 60a0 <malloc+0x168e>
    2cbc:	00002097          	auipc	ra,0x2
    2cc0:	868080e7          	jalr	-1944(ra) # 4524 <mkdir>
    2cc4:	3a050463          	beqz	a0,306c <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    2cc8:	00003517          	auipc	a0,0x3
    2ccc:	40850513          	addi	a0,a0,1032 # 60d0 <malloc+0x16be>
    2cd0:	00002097          	auipc	ra,0x2
    2cd4:	854080e7          	jalr	-1964(ra) # 4524 <mkdir>
    2cd8:	3a050863          	beqz	a0,3088 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    2cdc:	00003517          	auipc	a0,0x3
    2ce0:	23c50513          	addi	a0,a0,572 # 5f18 <malloc+0x1506>
    2ce4:	00002097          	auipc	ra,0x2
    2ce8:	840080e7          	jalr	-1984(ra) # 4524 <mkdir>
    2cec:	3a050c63          	beqz	a0,30a4 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    2cf0:	00003517          	auipc	a0,0x3
    2cf4:	3e050513          	addi	a0,a0,992 # 60d0 <malloc+0x16be>
    2cf8:	00002097          	auipc	ra,0x2
    2cfc:	814080e7          	jalr	-2028(ra) # 450c <unlink>
    2d00:	3c050063          	beqz	a0,30c0 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    2d04:	00003517          	auipc	a0,0x3
    2d08:	39c50513          	addi	a0,a0,924 # 60a0 <malloc+0x168e>
    2d0c:	00002097          	auipc	ra,0x2
    2d10:	800080e7          	jalr	-2048(ra) # 450c <unlink>
    2d14:	3c050463          	beqz	a0,30dc <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    2d18:	00003517          	auipc	a0,0x3
    2d1c:	0f850513          	addi	a0,a0,248 # 5e10 <malloc+0x13fe>
    2d20:	00002097          	auipc	ra,0x2
    2d24:	80c080e7          	jalr	-2036(ra) # 452c <chdir>
    2d28:	3c050863          	beqz	a0,30f8 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    2d2c:	00003517          	auipc	a0,0x3
    2d30:	58450513          	addi	a0,a0,1412 # 62b0 <malloc+0x189e>
    2d34:	00001097          	auipc	ra,0x1
    2d38:	7f8080e7          	jalr	2040(ra) # 452c <chdir>
    2d3c:	3c050c63          	beqz	a0,3114 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    2d40:	00003517          	auipc	a0,0x3
    2d44:	1d850513          	addi	a0,a0,472 # 5f18 <malloc+0x1506>
    2d48:	00001097          	auipc	ra,0x1
    2d4c:	7c4080e7          	jalr	1988(ra) # 450c <unlink>
    2d50:	3e051063          	bnez	a0,3130 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    2d54:	00003517          	auipc	a0,0x3
    2d58:	0bc50513          	addi	a0,a0,188 # 5e10 <malloc+0x13fe>
    2d5c:	00001097          	auipc	ra,0x1
    2d60:	7b0080e7          	jalr	1968(ra) # 450c <unlink>
    2d64:	3e051463          	bnez	a0,314c <subdir+0x756>
  if(unlink("dd") == 0){
    2d68:	00003517          	auipc	a0,0x3
    2d6c:	08850513          	addi	a0,a0,136 # 5df0 <malloc+0x13de>
    2d70:	00001097          	auipc	ra,0x1
    2d74:	79c080e7          	jalr	1948(ra) # 450c <unlink>
    2d78:	3e050863          	beqz	a0,3168 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    2d7c:	00003517          	auipc	a0,0x3
    2d80:	5a450513          	addi	a0,a0,1444 # 6320 <malloc+0x190e>
    2d84:	00001097          	auipc	ra,0x1
    2d88:	788080e7          	jalr	1928(ra) # 450c <unlink>
    2d8c:	3e054c63          	bltz	a0,3184 <subdir+0x78e>
  if(unlink("dd") < 0){
    2d90:	00003517          	auipc	a0,0x3
    2d94:	06050513          	addi	a0,a0,96 # 5df0 <malloc+0x13de>
    2d98:	00001097          	auipc	ra,0x1
    2d9c:	774080e7          	jalr	1908(ra) # 450c <unlink>
    2da0:	40054063          	bltz	a0,31a0 <subdir+0x7aa>
}
    2da4:	60e2                	ld	ra,24(sp)
    2da6:	6442                	ld	s0,16(sp)
    2da8:	64a2                	ld	s1,8(sp)
    2daa:	6902                	ld	s2,0(sp)
    2dac:	6105                	addi	sp,sp,32
    2dae:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2db0:	85ca                	mv	a1,s2
    2db2:	00003517          	auipc	a0,0x3
    2db6:	04650513          	addi	a0,a0,70 # 5df8 <malloc+0x13e6>
    2dba:	00002097          	auipc	ra,0x2
    2dbe:	b98080e7          	jalr	-1128(ra) # 4952 <printf>
    exit(1);
    2dc2:	4505                	li	a0,1
    2dc4:	00001097          	auipc	ra,0x1
    2dc8:	6f8080e7          	jalr	1784(ra) # 44bc <exit>
    printf("%s: create dd/ff failed\n", s);
    2dcc:	85ca                	mv	a1,s2
    2dce:	00003517          	auipc	a0,0x3
    2dd2:	04a50513          	addi	a0,a0,74 # 5e18 <malloc+0x1406>
    2dd6:	00002097          	auipc	ra,0x2
    2dda:	b7c080e7          	jalr	-1156(ra) # 4952 <printf>
    exit(1);
    2dde:	4505                	li	a0,1
    2de0:	00001097          	auipc	ra,0x1
    2de4:	6dc080e7          	jalr	1756(ra) # 44bc <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2de8:	85ca                	mv	a1,s2
    2dea:	00003517          	auipc	a0,0x3
    2dee:	04e50513          	addi	a0,a0,78 # 5e38 <malloc+0x1426>
    2df2:	00002097          	auipc	ra,0x2
    2df6:	b60080e7          	jalr	-1184(ra) # 4952 <printf>
    exit(1);
    2dfa:	4505                	li	a0,1
    2dfc:	00001097          	auipc	ra,0x1
    2e00:	6c0080e7          	jalr	1728(ra) # 44bc <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    2e04:	85ca                	mv	a1,s2
    2e06:	00003517          	auipc	a0,0x3
    2e0a:	06a50513          	addi	a0,a0,106 # 5e70 <malloc+0x145e>
    2e0e:	00002097          	auipc	ra,0x2
    2e12:	b44080e7          	jalr	-1212(ra) # 4952 <printf>
    exit(1);
    2e16:	4505                	li	a0,1
    2e18:	00001097          	auipc	ra,0x1
    2e1c:	6a4080e7          	jalr	1700(ra) # 44bc <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2e20:	85ca                	mv	a1,s2
    2e22:	00003517          	auipc	a0,0x3
    2e26:	07e50513          	addi	a0,a0,126 # 5ea0 <malloc+0x148e>
    2e2a:	00002097          	auipc	ra,0x2
    2e2e:	b28080e7          	jalr	-1240(ra) # 4952 <printf>
    exit(1);
    2e32:	4505                	li	a0,1
    2e34:	00001097          	auipc	ra,0x1
    2e38:	688080e7          	jalr	1672(ra) # 44bc <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2e3c:	85ca                	mv	a1,s2
    2e3e:	00003517          	auipc	a0,0x3
    2e42:	09a50513          	addi	a0,a0,154 # 5ed8 <malloc+0x14c6>
    2e46:	00002097          	auipc	ra,0x2
    2e4a:	b0c080e7          	jalr	-1268(ra) # 4952 <printf>
    exit(1);
    2e4e:	4505                	li	a0,1
    2e50:	00001097          	auipc	ra,0x1
    2e54:	66c080e7          	jalr	1644(ra) # 44bc <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2e58:	85ca                	mv	a1,s2
    2e5a:	00003517          	auipc	a0,0x3
    2e5e:	09e50513          	addi	a0,a0,158 # 5ef8 <malloc+0x14e6>
    2e62:	00002097          	auipc	ra,0x2
    2e66:	af0080e7          	jalr	-1296(ra) # 4952 <printf>
    exit(1);
    2e6a:	4505                	li	a0,1
    2e6c:	00001097          	auipc	ra,0x1
    2e70:	650080e7          	jalr	1616(ra) # 44bc <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    2e74:	85ca                	mv	a1,s2
    2e76:	00003517          	auipc	a0,0x3
    2e7a:	0b250513          	addi	a0,a0,178 # 5f28 <malloc+0x1516>
    2e7e:	00002097          	auipc	ra,0x2
    2e82:	ad4080e7          	jalr	-1324(ra) # 4952 <printf>
    exit(1);
    2e86:	4505                	li	a0,1
    2e88:	00001097          	auipc	ra,0x1
    2e8c:	634080e7          	jalr	1588(ra) # 44bc <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2e90:	85ca                	mv	a1,s2
    2e92:	00003517          	auipc	a0,0x3
    2e96:	0be50513          	addi	a0,a0,190 # 5f50 <malloc+0x153e>
    2e9a:	00002097          	auipc	ra,0x2
    2e9e:	ab8080e7          	jalr	-1352(ra) # 4952 <printf>
    exit(1);
    2ea2:	4505                	li	a0,1
    2ea4:	00001097          	auipc	ra,0x1
    2ea8:	618080e7          	jalr	1560(ra) # 44bc <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2eac:	85ca                	mv	a1,s2
    2eae:	00003517          	auipc	a0,0x3
    2eb2:	0c250513          	addi	a0,a0,194 # 5f70 <malloc+0x155e>
    2eb6:	00002097          	auipc	ra,0x2
    2eba:	a9c080e7          	jalr	-1380(ra) # 4952 <printf>
    exit(1);
    2ebe:	4505                	li	a0,1
    2ec0:	00001097          	auipc	ra,0x1
    2ec4:	5fc080e7          	jalr	1532(ra) # 44bc <exit>
    printf("%s: chdir dd failed\n", s);
    2ec8:	85ca                	mv	a1,s2
    2eca:	00003517          	auipc	a0,0x3
    2ece:	0ce50513          	addi	a0,a0,206 # 5f98 <malloc+0x1586>
    2ed2:	00002097          	auipc	ra,0x2
    2ed6:	a80080e7          	jalr	-1408(ra) # 4952 <printf>
    exit(1);
    2eda:	4505                	li	a0,1
    2edc:	00001097          	auipc	ra,0x1
    2ee0:	5e0080e7          	jalr	1504(ra) # 44bc <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2ee4:	85ca                	mv	a1,s2
    2ee6:	00003517          	auipc	a0,0x3
    2eea:	0da50513          	addi	a0,a0,218 # 5fc0 <malloc+0x15ae>
    2eee:	00002097          	auipc	ra,0x2
    2ef2:	a64080e7          	jalr	-1436(ra) # 4952 <printf>
    exit(1);
    2ef6:	4505                	li	a0,1
    2ef8:	00001097          	auipc	ra,0x1
    2efc:	5c4080e7          	jalr	1476(ra) # 44bc <exit>
    printf("chdir dd/../../dd failed\n", s);
    2f00:	85ca                	mv	a1,s2
    2f02:	00003517          	auipc	a0,0x3
    2f06:	0ee50513          	addi	a0,a0,238 # 5ff0 <malloc+0x15de>
    2f0a:	00002097          	auipc	ra,0x2
    2f0e:	a48080e7          	jalr	-1464(ra) # 4952 <printf>
    exit(1);
    2f12:	4505                	li	a0,1
    2f14:	00001097          	auipc	ra,0x1
    2f18:	5a8080e7          	jalr	1448(ra) # 44bc <exit>
    printf("%s: chdir ./.. failed\n", s);
    2f1c:	85ca                	mv	a1,s2
    2f1e:	00003517          	auipc	a0,0x3
    2f22:	0fa50513          	addi	a0,a0,250 # 6018 <malloc+0x1606>
    2f26:	00002097          	auipc	ra,0x2
    2f2a:	a2c080e7          	jalr	-1492(ra) # 4952 <printf>
    exit(1);
    2f2e:	4505                	li	a0,1
    2f30:	00001097          	auipc	ra,0x1
    2f34:	58c080e7          	jalr	1420(ra) # 44bc <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2f38:	85ca                	mv	a1,s2
    2f3a:	00003517          	auipc	a0,0x3
    2f3e:	0f650513          	addi	a0,a0,246 # 6030 <malloc+0x161e>
    2f42:	00002097          	auipc	ra,0x2
    2f46:	a10080e7          	jalr	-1520(ra) # 4952 <printf>
    exit(1);
    2f4a:	4505                	li	a0,1
    2f4c:	00001097          	auipc	ra,0x1
    2f50:	570080e7          	jalr	1392(ra) # 44bc <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2f54:	85ca                	mv	a1,s2
    2f56:	00003517          	auipc	a0,0x3
    2f5a:	0fa50513          	addi	a0,a0,250 # 6050 <malloc+0x163e>
    2f5e:	00002097          	auipc	ra,0x2
    2f62:	9f4080e7          	jalr	-1548(ra) # 4952 <printf>
    exit(1);
    2f66:	4505                	li	a0,1
    2f68:	00001097          	auipc	ra,0x1
    2f6c:	554080e7          	jalr	1364(ra) # 44bc <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    2f70:	85ca                	mv	a1,s2
    2f72:	00003517          	auipc	a0,0x3
    2f76:	0fe50513          	addi	a0,a0,254 # 6070 <malloc+0x165e>
    2f7a:	00002097          	auipc	ra,0x2
    2f7e:	9d8080e7          	jalr	-1576(ra) # 4952 <printf>
    exit(1);
    2f82:	4505                	li	a0,1
    2f84:	00001097          	auipc	ra,0x1
    2f88:	538080e7          	jalr	1336(ra) # 44bc <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2f8c:	85ca                	mv	a1,s2
    2f8e:	00003517          	auipc	a0,0x3
    2f92:	12250513          	addi	a0,a0,290 # 60b0 <malloc+0x169e>
    2f96:	00002097          	auipc	ra,0x2
    2f9a:	9bc080e7          	jalr	-1604(ra) # 4952 <printf>
    exit(1);
    2f9e:	4505                	li	a0,1
    2fa0:	00001097          	auipc	ra,0x1
    2fa4:	51c080e7          	jalr	1308(ra) # 44bc <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2fa8:	85ca                	mv	a1,s2
    2faa:	00003517          	auipc	a0,0x3
    2fae:	13650513          	addi	a0,a0,310 # 60e0 <malloc+0x16ce>
    2fb2:	00002097          	auipc	ra,0x2
    2fb6:	9a0080e7          	jalr	-1632(ra) # 4952 <printf>
    exit(1);
    2fba:	4505                	li	a0,1
    2fbc:	00001097          	auipc	ra,0x1
    2fc0:	500080e7          	jalr	1280(ra) # 44bc <exit>
    printf("%s: create dd succeeded!\n", s);
    2fc4:	85ca                	mv	a1,s2
    2fc6:	00003517          	auipc	a0,0x3
    2fca:	13a50513          	addi	a0,a0,314 # 6100 <malloc+0x16ee>
    2fce:	00002097          	auipc	ra,0x2
    2fd2:	984080e7          	jalr	-1660(ra) # 4952 <printf>
    exit(1);
    2fd6:	4505                	li	a0,1
    2fd8:	00001097          	auipc	ra,0x1
    2fdc:	4e4080e7          	jalr	1252(ra) # 44bc <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    2fe0:	85ca                	mv	a1,s2
    2fe2:	00003517          	auipc	a0,0x3
    2fe6:	13e50513          	addi	a0,a0,318 # 6120 <malloc+0x170e>
    2fea:	00002097          	auipc	ra,0x2
    2fee:	968080e7          	jalr	-1688(ra) # 4952 <printf>
    exit(1);
    2ff2:	4505                	li	a0,1
    2ff4:	00001097          	auipc	ra,0x1
    2ff8:	4c8080e7          	jalr	1224(ra) # 44bc <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    2ffc:	85ca                	mv	a1,s2
    2ffe:	00003517          	auipc	a0,0x3
    3002:	14250513          	addi	a0,a0,322 # 6140 <malloc+0x172e>
    3006:	00002097          	auipc	ra,0x2
    300a:	94c080e7          	jalr	-1716(ra) # 4952 <printf>
    exit(1);
    300e:	4505                	li	a0,1
    3010:	00001097          	auipc	ra,0x1
    3014:	4ac080e7          	jalr	1196(ra) # 44bc <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3018:	85ca                	mv	a1,s2
    301a:	00003517          	auipc	a0,0x3
    301e:	15650513          	addi	a0,a0,342 # 6170 <malloc+0x175e>
    3022:	00002097          	auipc	ra,0x2
    3026:	930080e7          	jalr	-1744(ra) # 4952 <printf>
    exit(1);
    302a:	4505                	li	a0,1
    302c:	00001097          	auipc	ra,0x1
    3030:	490080e7          	jalr	1168(ra) # 44bc <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3034:	85ca                	mv	a1,s2
    3036:	00003517          	auipc	a0,0x3
    303a:	16250513          	addi	a0,a0,354 # 6198 <malloc+0x1786>
    303e:	00002097          	auipc	ra,0x2
    3042:	914080e7          	jalr	-1772(ra) # 4952 <printf>
    exit(1);
    3046:	4505                	li	a0,1
    3048:	00001097          	auipc	ra,0x1
    304c:	474080e7          	jalr	1140(ra) # 44bc <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3050:	85ca                	mv	a1,s2
    3052:	00003517          	auipc	a0,0x3
    3056:	16e50513          	addi	a0,a0,366 # 61c0 <malloc+0x17ae>
    305a:	00002097          	auipc	ra,0x2
    305e:	8f8080e7          	jalr	-1800(ra) # 4952 <printf>
    exit(1);
    3062:	4505                	li	a0,1
    3064:	00001097          	auipc	ra,0x1
    3068:	458080e7          	jalr	1112(ra) # 44bc <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    306c:	85ca                	mv	a1,s2
    306e:	00003517          	auipc	a0,0x3
    3072:	17a50513          	addi	a0,a0,378 # 61e8 <malloc+0x17d6>
    3076:	00002097          	auipc	ra,0x2
    307a:	8dc080e7          	jalr	-1828(ra) # 4952 <printf>
    exit(1);
    307e:	4505                	li	a0,1
    3080:	00001097          	auipc	ra,0x1
    3084:	43c080e7          	jalr	1084(ra) # 44bc <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3088:	85ca                	mv	a1,s2
    308a:	00003517          	auipc	a0,0x3
    308e:	17e50513          	addi	a0,a0,382 # 6208 <malloc+0x17f6>
    3092:	00002097          	auipc	ra,0x2
    3096:	8c0080e7          	jalr	-1856(ra) # 4952 <printf>
    exit(1);
    309a:	4505                	li	a0,1
    309c:	00001097          	auipc	ra,0x1
    30a0:	420080e7          	jalr	1056(ra) # 44bc <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    30a4:	85ca                	mv	a1,s2
    30a6:	00003517          	auipc	a0,0x3
    30aa:	18250513          	addi	a0,a0,386 # 6228 <malloc+0x1816>
    30ae:	00002097          	auipc	ra,0x2
    30b2:	8a4080e7          	jalr	-1884(ra) # 4952 <printf>
    exit(1);
    30b6:	4505                	li	a0,1
    30b8:	00001097          	auipc	ra,0x1
    30bc:	404080e7          	jalr	1028(ra) # 44bc <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    30c0:	85ca                	mv	a1,s2
    30c2:	00003517          	auipc	a0,0x3
    30c6:	18e50513          	addi	a0,a0,398 # 6250 <malloc+0x183e>
    30ca:	00002097          	auipc	ra,0x2
    30ce:	888080e7          	jalr	-1912(ra) # 4952 <printf>
    exit(1);
    30d2:	4505                	li	a0,1
    30d4:	00001097          	auipc	ra,0x1
    30d8:	3e8080e7          	jalr	1000(ra) # 44bc <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    30dc:	85ca                	mv	a1,s2
    30de:	00003517          	auipc	a0,0x3
    30e2:	19250513          	addi	a0,a0,402 # 6270 <malloc+0x185e>
    30e6:	00002097          	auipc	ra,0x2
    30ea:	86c080e7          	jalr	-1940(ra) # 4952 <printf>
    exit(1);
    30ee:	4505                	li	a0,1
    30f0:	00001097          	auipc	ra,0x1
    30f4:	3cc080e7          	jalr	972(ra) # 44bc <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    30f8:	85ca                	mv	a1,s2
    30fa:	00003517          	auipc	a0,0x3
    30fe:	19650513          	addi	a0,a0,406 # 6290 <malloc+0x187e>
    3102:	00002097          	auipc	ra,0x2
    3106:	850080e7          	jalr	-1968(ra) # 4952 <printf>
    exit(1);
    310a:	4505                	li	a0,1
    310c:	00001097          	auipc	ra,0x1
    3110:	3b0080e7          	jalr	944(ra) # 44bc <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3114:	85ca                	mv	a1,s2
    3116:	00003517          	auipc	a0,0x3
    311a:	1a250513          	addi	a0,a0,418 # 62b8 <malloc+0x18a6>
    311e:	00002097          	auipc	ra,0x2
    3122:	834080e7          	jalr	-1996(ra) # 4952 <printf>
    exit(1);
    3126:	4505                	li	a0,1
    3128:	00001097          	auipc	ra,0x1
    312c:	394080e7          	jalr	916(ra) # 44bc <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3130:	85ca                	mv	a1,s2
    3132:	00003517          	auipc	a0,0x3
    3136:	e1e50513          	addi	a0,a0,-482 # 5f50 <malloc+0x153e>
    313a:	00002097          	auipc	ra,0x2
    313e:	818080e7          	jalr	-2024(ra) # 4952 <printf>
    exit(1);
    3142:	4505                	li	a0,1
    3144:	00001097          	auipc	ra,0x1
    3148:	378080e7          	jalr	888(ra) # 44bc <exit>
    printf("%s: unlink dd/ff failed\n", s);
    314c:	85ca                	mv	a1,s2
    314e:	00003517          	auipc	a0,0x3
    3152:	18a50513          	addi	a0,a0,394 # 62d8 <malloc+0x18c6>
    3156:	00001097          	auipc	ra,0x1
    315a:	7fc080e7          	jalr	2044(ra) # 4952 <printf>
    exit(1);
    315e:	4505                	li	a0,1
    3160:	00001097          	auipc	ra,0x1
    3164:	35c080e7          	jalr	860(ra) # 44bc <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3168:	85ca                	mv	a1,s2
    316a:	00003517          	auipc	a0,0x3
    316e:	18e50513          	addi	a0,a0,398 # 62f8 <malloc+0x18e6>
    3172:	00001097          	auipc	ra,0x1
    3176:	7e0080e7          	jalr	2016(ra) # 4952 <printf>
    exit(1);
    317a:	4505                	li	a0,1
    317c:	00001097          	auipc	ra,0x1
    3180:	340080e7          	jalr	832(ra) # 44bc <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3184:	85ca                	mv	a1,s2
    3186:	00003517          	auipc	a0,0x3
    318a:	1a250513          	addi	a0,a0,418 # 6328 <malloc+0x1916>
    318e:	00001097          	auipc	ra,0x1
    3192:	7c4080e7          	jalr	1988(ra) # 4952 <printf>
    exit(1);
    3196:	4505                	li	a0,1
    3198:	00001097          	auipc	ra,0x1
    319c:	324080e7          	jalr	804(ra) # 44bc <exit>
    printf("%s: unlink dd failed\n", s);
    31a0:	85ca                	mv	a1,s2
    31a2:	00003517          	auipc	a0,0x3
    31a6:	1a650513          	addi	a0,a0,422 # 6348 <malloc+0x1936>
    31aa:	00001097          	auipc	ra,0x1
    31ae:	7a8080e7          	jalr	1960(ra) # 4952 <printf>
    exit(1);
    31b2:	4505                	li	a0,1
    31b4:	00001097          	auipc	ra,0x1
    31b8:	308080e7          	jalr	776(ra) # 44bc <exit>

00000000000031bc <dirfile>:
{
    31bc:	1101                	addi	sp,sp,-32
    31be:	ec06                	sd	ra,24(sp)
    31c0:	e822                	sd	s0,16(sp)
    31c2:	e426                	sd	s1,8(sp)
    31c4:	e04a                	sd	s2,0(sp)
    31c6:	1000                	addi	s0,sp,32
    31c8:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    31ca:	20000593          	li	a1,512
    31ce:	00003517          	auipc	a0,0x3
    31d2:	19250513          	addi	a0,a0,402 # 6360 <malloc+0x194e>
    31d6:	00001097          	auipc	ra,0x1
    31da:	326080e7          	jalr	806(ra) # 44fc <open>
  if(fd < 0){
    31de:	0e054d63          	bltz	a0,32d8 <dirfile+0x11c>
  close(fd);
    31e2:	00001097          	auipc	ra,0x1
    31e6:	23e080e7          	jalr	574(ra) # 4420 <close>
  if(chdir("dirfile") == 0){
    31ea:	00003517          	auipc	a0,0x3
    31ee:	17650513          	addi	a0,a0,374 # 6360 <malloc+0x194e>
    31f2:	00001097          	auipc	ra,0x1
    31f6:	33a080e7          	jalr	826(ra) # 452c <chdir>
    31fa:	cd6d                	beqz	a0,32f4 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    31fc:	4581                	li	a1,0
    31fe:	00003517          	auipc	a0,0x3
    3202:	1aa50513          	addi	a0,a0,426 # 63a8 <malloc+0x1996>
    3206:	00001097          	auipc	ra,0x1
    320a:	2f6080e7          	jalr	758(ra) # 44fc <open>
  if(fd >= 0){
    320e:	10055163          	bgez	a0,3310 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3212:	20000593          	li	a1,512
    3216:	00003517          	auipc	a0,0x3
    321a:	19250513          	addi	a0,a0,402 # 63a8 <malloc+0x1996>
    321e:	00001097          	auipc	ra,0x1
    3222:	2de080e7          	jalr	734(ra) # 44fc <open>
  if(fd >= 0){
    3226:	10055363          	bgez	a0,332c <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    322a:	00003517          	auipc	a0,0x3
    322e:	17e50513          	addi	a0,a0,382 # 63a8 <malloc+0x1996>
    3232:	00001097          	auipc	ra,0x1
    3236:	2f2080e7          	jalr	754(ra) # 4524 <mkdir>
    323a:	10050763          	beqz	a0,3348 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    323e:	00003517          	auipc	a0,0x3
    3242:	16a50513          	addi	a0,a0,362 # 63a8 <malloc+0x1996>
    3246:	00001097          	auipc	ra,0x1
    324a:	2c6080e7          	jalr	710(ra) # 450c <unlink>
    324e:	10050b63          	beqz	a0,3364 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3252:	00003597          	auipc	a1,0x3
    3256:	15658593          	addi	a1,a1,342 # 63a8 <malloc+0x1996>
    325a:	00003517          	auipc	a0,0x3
    325e:	1d650513          	addi	a0,a0,470 # 6430 <malloc+0x1a1e>
    3262:	00001097          	auipc	ra,0x1
    3266:	2ba080e7          	jalr	698(ra) # 451c <link>
    326a:	10050b63          	beqz	a0,3380 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    326e:	00003517          	auipc	a0,0x3
    3272:	0f250513          	addi	a0,a0,242 # 6360 <malloc+0x194e>
    3276:	00001097          	auipc	ra,0x1
    327a:	296080e7          	jalr	662(ra) # 450c <unlink>
    327e:	10051f63          	bnez	a0,339c <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3282:	4589                	li	a1,2
    3284:	00002517          	auipc	a0,0x2
    3288:	c4450513          	addi	a0,a0,-956 # 4ec8 <malloc+0x4b6>
    328c:	00001097          	auipc	ra,0x1
    3290:	270080e7          	jalr	624(ra) # 44fc <open>
  if(fd >= 0){
    3294:	12055263          	bgez	a0,33b8 <dirfile+0x1fc>
  fd = open(".", 0);
    3298:	4581                	li	a1,0
    329a:	00002517          	auipc	a0,0x2
    329e:	c2e50513          	addi	a0,a0,-978 # 4ec8 <malloc+0x4b6>
    32a2:	00001097          	auipc	ra,0x1
    32a6:	25a080e7          	jalr	602(ra) # 44fc <open>
    32aa:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    32ac:	4605                	li	a2,1
    32ae:	00002597          	auipc	a1,0x2
    32b2:	69a58593          	addi	a1,a1,1690 # 5948 <malloc+0xf36>
    32b6:	00001097          	auipc	ra,0x1
    32ba:	226080e7          	jalr	550(ra) # 44dc <write>
    32be:	10a04b63          	bgtz	a0,33d4 <dirfile+0x218>
  close(fd);
    32c2:	8526                	mv	a0,s1
    32c4:	00001097          	auipc	ra,0x1
    32c8:	15c080e7          	jalr	348(ra) # 4420 <close>
}
    32cc:	60e2                	ld	ra,24(sp)
    32ce:	6442                	ld	s0,16(sp)
    32d0:	64a2                	ld	s1,8(sp)
    32d2:	6902                	ld	s2,0(sp)
    32d4:	6105                	addi	sp,sp,32
    32d6:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    32d8:	85ca                	mv	a1,s2
    32da:	00003517          	auipc	a0,0x3
    32de:	08e50513          	addi	a0,a0,142 # 6368 <malloc+0x1956>
    32e2:	00001097          	auipc	ra,0x1
    32e6:	670080e7          	jalr	1648(ra) # 4952 <printf>
    exit(1);
    32ea:	4505                	li	a0,1
    32ec:	00001097          	auipc	ra,0x1
    32f0:	1d0080e7          	jalr	464(ra) # 44bc <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    32f4:	85ca                	mv	a1,s2
    32f6:	00003517          	auipc	a0,0x3
    32fa:	09250513          	addi	a0,a0,146 # 6388 <malloc+0x1976>
    32fe:	00001097          	auipc	ra,0x1
    3302:	654080e7          	jalr	1620(ra) # 4952 <printf>
    exit(1);
    3306:	4505                	li	a0,1
    3308:	00001097          	auipc	ra,0x1
    330c:	1b4080e7          	jalr	436(ra) # 44bc <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3310:	85ca                	mv	a1,s2
    3312:	00003517          	auipc	a0,0x3
    3316:	0a650513          	addi	a0,a0,166 # 63b8 <malloc+0x19a6>
    331a:	00001097          	auipc	ra,0x1
    331e:	638080e7          	jalr	1592(ra) # 4952 <printf>
    exit(1);
    3322:	4505                	li	a0,1
    3324:	00001097          	auipc	ra,0x1
    3328:	198080e7          	jalr	408(ra) # 44bc <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    332c:	85ca                	mv	a1,s2
    332e:	00003517          	auipc	a0,0x3
    3332:	08a50513          	addi	a0,a0,138 # 63b8 <malloc+0x19a6>
    3336:	00001097          	auipc	ra,0x1
    333a:	61c080e7          	jalr	1564(ra) # 4952 <printf>
    exit(1);
    333e:	4505                	li	a0,1
    3340:	00001097          	auipc	ra,0x1
    3344:	17c080e7          	jalr	380(ra) # 44bc <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3348:	85ca                	mv	a1,s2
    334a:	00003517          	auipc	a0,0x3
    334e:	09650513          	addi	a0,a0,150 # 63e0 <malloc+0x19ce>
    3352:	00001097          	auipc	ra,0x1
    3356:	600080e7          	jalr	1536(ra) # 4952 <printf>
    exit(1);
    335a:	4505                	li	a0,1
    335c:	00001097          	auipc	ra,0x1
    3360:	160080e7          	jalr	352(ra) # 44bc <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3364:	85ca                	mv	a1,s2
    3366:	00003517          	auipc	a0,0x3
    336a:	0a250513          	addi	a0,a0,162 # 6408 <malloc+0x19f6>
    336e:	00001097          	auipc	ra,0x1
    3372:	5e4080e7          	jalr	1508(ra) # 4952 <printf>
    exit(1);
    3376:	4505                	li	a0,1
    3378:	00001097          	auipc	ra,0x1
    337c:	144080e7          	jalr	324(ra) # 44bc <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3380:	85ca                	mv	a1,s2
    3382:	00003517          	auipc	a0,0x3
    3386:	0b650513          	addi	a0,a0,182 # 6438 <malloc+0x1a26>
    338a:	00001097          	auipc	ra,0x1
    338e:	5c8080e7          	jalr	1480(ra) # 4952 <printf>
    exit(1);
    3392:	4505                	li	a0,1
    3394:	00001097          	auipc	ra,0x1
    3398:	128080e7          	jalr	296(ra) # 44bc <exit>
    printf("%s: unlink dirfile failed!\n", s);
    339c:	85ca                	mv	a1,s2
    339e:	00003517          	auipc	a0,0x3
    33a2:	0c250513          	addi	a0,a0,194 # 6460 <malloc+0x1a4e>
    33a6:	00001097          	auipc	ra,0x1
    33aa:	5ac080e7          	jalr	1452(ra) # 4952 <printf>
    exit(1);
    33ae:	4505                	li	a0,1
    33b0:	00001097          	auipc	ra,0x1
    33b4:	10c080e7          	jalr	268(ra) # 44bc <exit>
    printf("%s: open . for writing succeeded!\n", s);
    33b8:	85ca                	mv	a1,s2
    33ba:	00003517          	auipc	a0,0x3
    33be:	0c650513          	addi	a0,a0,198 # 6480 <malloc+0x1a6e>
    33c2:	00001097          	auipc	ra,0x1
    33c6:	590080e7          	jalr	1424(ra) # 4952 <printf>
    exit(1);
    33ca:	4505                	li	a0,1
    33cc:	00001097          	auipc	ra,0x1
    33d0:	0f0080e7          	jalr	240(ra) # 44bc <exit>
    printf("%s: write . succeeded!\n", s);
    33d4:	85ca                	mv	a1,s2
    33d6:	00003517          	auipc	a0,0x3
    33da:	0d250513          	addi	a0,a0,210 # 64a8 <malloc+0x1a96>
    33de:	00001097          	auipc	ra,0x1
    33e2:	574080e7          	jalr	1396(ra) # 4952 <printf>
    exit(1);
    33e6:	4505                	li	a0,1
    33e8:	00001097          	auipc	ra,0x1
    33ec:	0d4080e7          	jalr	212(ra) # 44bc <exit>

00000000000033f0 <iref>:
{
    33f0:	7139                	addi	sp,sp,-64
    33f2:	fc06                	sd	ra,56(sp)
    33f4:	f822                	sd	s0,48(sp)
    33f6:	f426                	sd	s1,40(sp)
    33f8:	f04a                	sd	s2,32(sp)
    33fa:	ec4e                	sd	s3,24(sp)
    33fc:	e852                	sd	s4,16(sp)
    33fe:	e456                	sd	s5,8(sp)
    3400:	e05a                	sd	s6,0(sp)
    3402:	0080                	addi	s0,sp,64
    3404:	8b2a                	mv	s6,a0
    3406:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    340a:	00003a17          	auipc	s4,0x3
    340e:	0b6a0a13          	addi	s4,s4,182 # 64c0 <malloc+0x1aae>
    mkdir("");
    3412:	00003497          	auipc	s1,0x3
    3416:	c8648493          	addi	s1,s1,-890 # 6098 <malloc+0x1686>
    link("README", "");
    341a:	00003a97          	auipc	s5,0x3
    341e:	016a8a93          	addi	s5,s5,22 # 6430 <malloc+0x1a1e>
    fd = open("xx", O_CREATE);
    3422:	00003997          	auipc	s3,0x3
    3426:	f8e98993          	addi	s3,s3,-114 # 63b0 <malloc+0x199e>
    342a:	a891                	j	347e <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    342c:	85da                	mv	a1,s6
    342e:	00003517          	auipc	a0,0x3
    3432:	09a50513          	addi	a0,a0,154 # 64c8 <malloc+0x1ab6>
    3436:	00001097          	auipc	ra,0x1
    343a:	51c080e7          	jalr	1308(ra) # 4952 <printf>
      exit(1);
    343e:	4505                	li	a0,1
    3440:	00001097          	auipc	ra,0x1
    3444:	07c080e7          	jalr	124(ra) # 44bc <exit>
      printf("%s: chdir irefd failed\n", s);
    3448:	85da                	mv	a1,s6
    344a:	00003517          	auipc	a0,0x3
    344e:	09650513          	addi	a0,a0,150 # 64e0 <malloc+0x1ace>
    3452:	00001097          	auipc	ra,0x1
    3456:	500080e7          	jalr	1280(ra) # 4952 <printf>
      exit(1);
    345a:	4505                	li	a0,1
    345c:	00001097          	auipc	ra,0x1
    3460:	060080e7          	jalr	96(ra) # 44bc <exit>
      close(fd);
    3464:	00001097          	auipc	ra,0x1
    3468:	fbc080e7          	jalr	-68(ra) # 4420 <close>
    346c:	a889                	j	34be <iref+0xce>
    unlink("xx");
    346e:	854e                	mv	a0,s3
    3470:	00001097          	auipc	ra,0x1
    3474:	09c080e7          	jalr	156(ra) # 450c <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3478:	397d                	addiw	s2,s2,-1
    347a:	06090063          	beqz	s2,34da <iref+0xea>
    if(mkdir("irefd") != 0){
    347e:	8552                	mv	a0,s4
    3480:	00001097          	auipc	ra,0x1
    3484:	0a4080e7          	jalr	164(ra) # 4524 <mkdir>
    3488:	f155                	bnez	a0,342c <iref+0x3c>
    if(chdir("irefd") != 0){
    348a:	8552                	mv	a0,s4
    348c:	00001097          	auipc	ra,0x1
    3490:	0a0080e7          	jalr	160(ra) # 452c <chdir>
    3494:	f955                	bnez	a0,3448 <iref+0x58>
    mkdir("");
    3496:	8526                	mv	a0,s1
    3498:	00001097          	auipc	ra,0x1
    349c:	08c080e7          	jalr	140(ra) # 4524 <mkdir>
    link("README", "");
    34a0:	85a6                	mv	a1,s1
    34a2:	8556                	mv	a0,s5
    34a4:	00001097          	auipc	ra,0x1
    34a8:	078080e7          	jalr	120(ra) # 451c <link>
    fd = open("", O_CREATE);
    34ac:	20000593          	li	a1,512
    34b0:	8526                	mv	a0,s1
    34b2:	00001097          	auipc	ra,0x1
    34b6:	04a080e7          	jalr	74(ra) # 44fc <open>
    if(fd >= 0)
    34ba:	fa0555e3          	bgez	a0,3464 <iref+0x74>
    fd = open("xx", O_CREATE);
    34be:	20000593          	li	a1,512
    34c2:	854e                	mv	a0,s3
    34c4:	00001097          	auipc	ra,0x1
    34c8:	038080e7          	jalr	56(ra) # 44fc <open>
    if(fd >= 0)
    34cc:	fa0541e3          	bltz	a0,346e <iref+0x7e>
      close(fd);
    34d0:	00001097          	auipc	ra,0x1
    34d4:	f50080e7          	jalr	-176(ra) # 4420 <close>
    34d8:	bf59                	j	346e <iref+0x7e>
  chdir("/");
    34da:	00002517          	auipc	a0,0x2
    34de:	99650513          	addi	a0,a0,-1642 # 4e70 <malloc+0x45e>
    34e2:	00001097          	auipc	ra,0x1
    34e6:	04a080e7          	jalr	74(ra) # 452c <chdir>
}
    34ea:	70e2                	ld	ra,56(sp)
    34ec:	7442                	ld	s0,48(sp)
    34ee:	74a2                	ld	s1,40(sp)
    34f0:	7902                	ld	s2,32(sp)
    34f2:	69e2                	ld	s3,24(sp)
    34f4:	6a42                	ld	s4,16(sp)
    34f6:	6aa2                	ld	s5,8(sp)
    34f8:	6b02                	ld	s6,0(sp)
    34fa:	6121                	addi	sp,sp,64
    34fc:	8082                	ret

00000000000034fe <validatetest>:
{
    34fe:	7139                	addi	sp,sp,-64
    3500:	fc06                	sd	ra,56(sp)
    3502:	f822                	sd	s0,48(sp)
    3504:	f426                	sd	s1,40(sp)
    3506:	f04a                	sd	s2,32(sp)
    3508:	ec4e                	sd	s3,24(sp)
    350a:	e852                	sd	s4,16(sp)
    350c:	e456                	sd	s5,8(sp)
    350e:	e05a                	sd	s6,0(sp)
    3510:	0080                	addi	s0,sp,64
    3512:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    3514:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    3516:	00003997          	auipc	s3,0x3
    351a:	fe298993          	addi	s3,s3,-30 # 64f8 <malloc+0x1ae6>
    351e:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    3520:	6a85                	lui	s5,0x1
    3522:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    3526:	85a6                	mv	a1,s1
    3528:	854e                	mv	a0,s3
    352a:	00001097          	auipc	ra,0x1
    352e:	ff2080e7          	jalr	-14(ra) # 451c <link>
    3532:	01251f63          	bne	a0,s2,3550 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    3536:	94d6                	add	s1,s1,s5
    3538:	ff4497e3          	bne	s1,s4,3526 <validatetest+0x28>
}
    353c:	70e2                	ld	ra,56(sp)
    353e:	7442                	ld	s0,48(sp)
    3540:	74a2                	ld	s1,40(sp)
    3542:	7902                	ld	s2,32(sp)
    3544:	69e2                	ld	s3,24(sp)
    3546:	6a42                	ld	s4,16(sp)
    3548:	6aa2                	ld	s5,8(sp)
    354a:	6b02                	ld	s6,0(sp)
    354c:	6121                	addi	sp,sp,64
    354e:	8082                	ret
      printf("%s: link should not succeed\n", s);
    3550:	85da                	mv	a1,s6
    3552:	00003517          	auipc	a0,0x3
    3556:	fb650513          	addi	a0,a0,-74 # 6508 <malloc+0x1af6>
    355a:	00001097          	auipc	ra,0x1
    355e:	3f8080e7          	jalr	1016(ra) # 4952 <printf>
      exit(1);
    3562:	4505                	li	a0,1
    3564:	00001097          	auipc	ra,0x1
    3568:	f58080e7          	jalr	-168(ra) # 44bc <exit>

000000000000356c <sbrkbasic>:
{
    356c:	715d                	addi	sp,sp,-80
    356e:	e486                	sd	ra,72(sp)
    3570:	e0a2                	sd	s0,64(sp)
    3572:	fc26                	sd	s1,56(sp)
    3574:	f84a                	sd	s2,48(sp)
    3576:	f44e                	sd	s3,40(sp)
    3578:	f052                	sd	s4,32(sp)
    357a:	ec56                	sd	s5,24(sp)
    357c:	0880                	addi	s0,sp,80
    357e:	8aaa                	mv	s5,a0
  a = sbrk(TOOMUCH);
    3580:	40000537          	lui	a0,0x40000
    3584:	00001097          	auipc	ra,0x1
    3588:	fc0080e7          	jalr	-64(ra) # 4544 <sbrk>
  if(a != (char*)0xffffffffffffffffL){
    358c:	57fd                	li	a5,-1
    358e:	02f50063          	beq	a0,a5,35ae <sbrkbasic+0x42>
    printf("%s: sbrk(<toomuch>) returned %p\n", a);
    3592:	85aa                	mv	a1,a0
    3594:	00003517          	auipc	a0,0x3
    3598:	f9450513          	addi	a0,a0,-108 # 6528 <malloc+0x1b16>
    359c:	00001097          	auipc	ra,0x1
    35a0:	3b6080e7          	jalr	950(ra) # 4952 <printf>
    exit(1);
    35a4:	4505                	li	a0,1
    35a6:	00001097          	auipc	ra,0x1
    35aa:	f16080e7          	jalr	-234(ra) # 44bc <exit>
  a = sbrk(0);
    35ae:	4501                	li	a0,0
    35b0:	00001097          	auipc	ra,0x1
    35b4:	f94080e7          	jalr	-108(ra) # 4544 <sbrk>
    35b8:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    35ba:	4901                	li	s2,0
    *b = 1;
    35bc:	4a05                	li	s4,1
  for(i = 0; i < 5000; i++){
    35be:	6985                	lui	s3,0x1
    35c0:	38898993          	addi	s3,s3,904 # 1388 <unlinkread+0x104>
    35c4:	a011                	j	35c8 <sbrkbasic+0x5c>
    a = b + 1;
    35c6:	84be                	mv	s1,a5
    b = sbrk(1);
    35c8:	4505                	li	a0,1
    35ca:	00001097          	auipc	ra,0x1
    35ce:	f7a080e7          	jalr	-134(ra) # 4544 <sbrk>
    if(b != a){
    35d2:	04951b63          	bne	a0,s1,3628 <sbrkbasic+0xbc>
    *b = 1;
    35d6:	01448023          	sb	s4,0(s1)
    a = b + 1;
    35da:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    35de:	2905                	addiw	s2,s2,1
    35e0:	ff3913e3          	bne	s2,s3,35c6 <sbrkbasic+0x5a>
  pid = fork();
    35e4:	00001097          	auipc	ra,0x1
    35e8:	ed0080e7          	jalr	-304(ra) # 44b4 <fork>
    35ec:	892a                	mv	s2,a0
  if(pid < 0){
    35ee:	04054d63          	bltz	a0,3648 <sbrkbasic+0xdc>
  c = sbrk(1);
    35f2:	4505                	li	a0,1
    35f4:	00001097          	auipc	ra,0x1
    35f8:	f50080e7          	jalr	-176(ra) # 4544 <sbrk>
  c = sbrk(1);
    35fc:	4505                	li	a0,1
    35fe:	00001097          	auipc	ra,0x1
    3602:	f46080e7          	jalr	-186(ra) # 4544 <sbrk>
  if(c != a + 1){
    3606:	0489                	addi	s1,s1,2
    3608:	04a48e63          	beq	s1,a0,3664 <sbrkbasic+0xf8>
    printf("%s: sbrk test failed post-fork\n", s);
    360c:	85d6                	mv	a1,s5
    360e:	00003517          	auipc	a0,0x3
    3612:	f8250513          	addi	a0,a0,-126 # 6590 <malloc+0x1b7e>
    3616:	00001097          	auipc	ra,0x1
    361a:	33c080e7          	jalr	828(ra) # 4952 <printf>
    exit(1);
    361e:	4505                	li	a0,1
    3620:	00001097          	auipc	ra,0x1
    3624:	e9c080e7          	jalr	-356(ra) # 44bc <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    3628:	86aa                	mv	a3,a0
    362a:	8626                	mv	a2,s1
    362c:	85ca                	mv	a1,s2
    362e:	00003517          	auipc	a0,0x3
    3632:	f2250513          	addi	a0,a0,-222 # 6550 <malloc+0x1b3e>
    3636:	00001097          	auipc	ra,0x1
    363a:	31c080e7          	jalr	796(ra) # 4952 <printf>
      exit(1);
    363e:	4505                	li	a0,1
    3640:	00001097          	auipc	ra,0x1
    3644:	e7c080e7          	jalr	-388(ra) # 44bc <exit>
    printf("%s: sbrk test fork failed\n", s);
    3648:	85d6                	mv	a1,s5
    364a:	00003517          	auipc	a0,0x3
    364e:	f2650513          	addi	a0,a0,-218 # 6570 <malloc+0x1b5e>
    3652:	00001097          	auipc	ra,0x1
    3656:	300080e7          	jalr	768(ra) # 4952 <printf>
    exit(1);
    365a:	4505                	li	a0,1
    365c:	00001097          	auipc	ra,0x1
    3660:	e60080e7          	jalr	-416(ra) # 44bc <exit>
  if(pid == 0)
    3664:	00091763          	bnez	s2,3672 <sbrkbasic+0x106>
    exit(0);
    3668:	4501                	li	a0,0
    366a:	00001097          	auipc	ra,0x1
    366e:	e52080e7          	jalr	-430(ra) # 44bc <exit>
  wait(&xstatus);
    3672:	fbc40513          	addi	a0,s0,-68
    3676:	00001097          	auipc	ra,0x1
    367a:	e4e080e7          	jalr	-434(ra) # 44c4 <wait>
  exit(xstatus);
    367e:	fbc42503          	lw	a0,-68(s0)
    3682:	00001097          	auipc	ra,0x1
    3686:	e3a080e7          	jalr	-454(ra) # 44bc <exit>

000000000000368a <sbrkmuch>:
{
    368a:	7179                	addi	sp,sp,-48
    368c:	f406                	sd	ra,40(sp)
    368e:	f022                	sd	s0,32(sp)
    3690:	ec26                	sd	s1,24(sp)
    3692:	e84a                	sd	s2,16(sp)
    3694:	e44e                	sd	s3,8(sp)
    3696:	e052                	sd	s4,0(sp)
    3698:	1800                	addi	s0,sp,48
    369a:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    369c:	4501                	li	a0,0
    369e:	00001097          	auipc	ra,0x1
    36a2:	ea6080e7          	jalr	-346(ra) # 4544 <sbrk>
    36a6:	892a                	mv	s2,a0
  a = sbrk(0);
    36a8:	4501                	li	a0,0
    36aa:	00001097          	auipc	ra,0x1
    36ae:	e9a080e7          	jalr	-358(ra) # 4544 <sbrk>
    36b2:	84aa                	mv	s1,a0
  p = sbrk(amt);
    36b4:	06400537          	lui	a0,0x6400
    36b8:	9d05                	subw	a0,a0,s1
    36ba:	00001097          	auipc	ra,0x1
    36be:	e8a080e7          	jalr	-374(ra) # 4544 <sbrk>
  if (p != a) {
    36c2:	0aa49963          	bne	s1,a0,3774 <sbrkmuch+0xea>
  *lastaddr = 99;
    36c6:	064007b7          	lui	a5,0x6400
    36ca:	06300713          	li	a4,99
    36ce:	fee78fa3          	sb	a4,-1(a5) # 63fffff <_end+0x63f375f>
  a = sbrk(0);
    36d2:	4501                	li	a0,0
    36d4:	00001097          	auipc	ra,0x1
    36d8:	e70080e7          	jalr	-400(ra) # 4544 <sbrk>
    36dc:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    36de:	757d                	lui	a0,0xfffff
    36e0:	00001097          	auipc	ra,0x1
    36e4:	e64080e7          	jalr	-412(ra) # 4544 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    36e8:	57fd                	li	a5,-1
    36ea:	0af50363          	beq	a0,a5,3790 <sbrkmuch+0x106>
  c = sbrk(0);
    36ee:	4501                	li	a0,0
    36f0:	00001097          	auipc	ra,0x1
    36f4:	e54080e7          	jalr	-428(ra) # 4544 <sbrk>
  if(c != a - PGSIZE){
    36f8:	77fd                	lui	a5,0xfffff
    36fa:	97a6                	add	a5,a5,s1
    36fc:	0af51863          	bne	a0,a5,37ac <sbrkmuch+0x122>
  a = sbrk(0);
    3700:	4501                	li	a0,0
    3702:	00001097          	auipc	ra,0x1
    3706:	e42080e7          	jalr	-446(ra) # 4544 <sbrk>
    370a:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    370c:	6505                	lui	a0,0x1
    370e:	00001097          	auipc	ra,0x1
    3712:	e36080e7          	jalr	-458(ra) # 4544 <sbrk>
    3716:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    3718:	0aa49963          	bne	s1,a0,37ca <sbrkmuch+0x140>
    371c:	4501                	li	a0,0
    371e:	00001097          	auipc	ra,0x1
    3722:	e26080e7          	jalr	-474(ra) # 4544 <sbrk>
    3726:	6785                	lui	a5,0x1
    3728:	97a6                	add	a5,a5,s1
    372a:	0af51063          	bne	a0,a5,37ca <sbrkmuch+0x140>
  if(*lastaddr == 99){
    372e:	064007b7          	lui	a5,0x6400
    3732:	fff7c703          	lbu	a4,-1(a5) # 63fffff <_end+0x63f375f>
    3736:	06300793          	li	a5,99
    373a:	0af70763          	beq	a4,a5,37e8 <sbrkmuch+0x15e>
  a = sbrk(0);
    373e:	4501                	li	a0,0
    3740:	00001097          	auipc	ra,0x1
    3744:	e04080e7          	jalr	-508(ra) # 4544 <sbrk>
    3748:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    374a:	4501                	li	a0,0
    374c:	00001097          	auipc	ra,0x1
    3750:	df8080e7          	jalr	-520(ra) # 4544 <sbrk>
    3754:	40a9053b          	subw	a0,s2,a0
    3758:	00001097          	auipc	ra,0x1
    375c:	dec080e7          	jalr	-532(ra) # 4544 <sbrk>
  if(c != a){
    3760:	0aa49263          	bne	s1,a0,3804 <sbrkmuch+0x17a>
}
    3764:	70a2                	ld	ra,40(sp)
    3766:	7402                	ld	s0,32(sp)
    3768:	64e2                	ld	s1,24(sp)
    376a:	6942                	ld	s2,16(sp)
    376c:	69a2                	ld	s3,8(sp)
    376e:	6a02                	ld	s4,0(sp)
    3770:	6145                	addi	sp,sp,48
    3772:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    3774:	85ce                	mv	a1,s3
    3776:	00003517          	auipc	a0,0x3
    377a:	e3a50513          	addi	a0,a0,-454 # 65b0 <malloc+0x1b9e>
    377e:	00001097          	auipc	ra,0x1
    3782:	1d4080e7          	jalr	468(ra) # 4952 <printf>
    exit(1);
    3786:	4505                	li	a0,1
    3788:	00001097          	auipc	ra,0x1
    378c:	d34080e7          	jalr	-716(ra) # 44bc <exit>
    printf("%s: sbrk could not deallocate\n", s);
    3790:	85ce                	mv	a1,s3
    3792:	00003517          	auipc	a0,0x3
    3796:	e6650513          	addi	a0,a0,-410 # 65f8 <malloc+0x1be6>
    379a:	00001097          	auipc	ra,0x1
    379e:	1b8080e7          	jalr	440(ra) # 4952 <printf>
    exit(1);
    37a2:	4505                	li	a0,1
    37a4:	00001097          	auipc	ra,0x1
    37a8:	d18080e7          	jalr	-744(ra) # 44bc <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    37ac:	862a                	mv	a2,a0
    37ae:	85a6                	mv	a1,s1
    37b0:	00003517          	auipc	a0,0x3
    37b4:	e6850513          	addi	a0,a0,-408 # 6618 <malloc+0x1c06>
    37b8:	00001097          	auipc	ra,0x1
    37bc:	19a080e7          	jalr	410(ra) # 4952 <printf>
    exit(1);
    37c0:	4505                	li	a0,1
    37c2:	00001097          	auipc	ra,0x1
    37c6:	cfa080e7          	jalr	-774(ra) # 44bc <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", a, c);
    37ca:	8652                	mv	a2,s4
    37cc:	85a6                	mv	a1,s1
    37ce:	00003517          	auipc	a0,0x3
    37d2:	e8a50513          	addi	a0,a0,-374 # 6658 <malloc+0x1c46>
    37d6:	00001097          	auipc	ra,0x1
    37da:	17c080e7          	jalr	380(ra) # 4952 <printf>
    exit(1);
    37de:	4505                	li	a0,1
    37e0:	00001097          	auipc	ra,0x1
    37e4:	cdc080e7          	jalr	-804(ra) # 44bc <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    37e8:	85ce                	mv	a1,s3
    37ea:	00003517          	auipc	a0,0x3
    37ee:	e9e50513          	addi	a0,a0,-354 # 6688 <malloc+0x1c76>
    37f2:	00001097          	auipc	ra,0x1
    37f6:	160080e7          	jalr	352(ra) # 4952 <printf>
    exit(1);
    37fa:	4505                	li	a0,1
    37fc:	00001097          	auipc	ra,0x1
    3800:	cc0080e7          	jalr	-832(ra) # 44bc <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", a, c);
    3804:	862a                	mv	a2,a0
    3806:	85a6                	mv	a1,s1
    3808:	00003517          	auipc	a0,0x3
    380c:	eb850513          	addi	a0,a0,-328 # 66c0 <malloc+0x1cae>
    3810:	00001097          	auipc	ra,0x1
    3814:	142080e7          	jalr	322(ra) # 4952 <printf>
    exit(1);
    3818:	4505                	li	a0,1
    381a:	00001097          	auipc	ra,0x1
    381e:	ca2080e7          	jalr	-862(ra) # 44bc <exit>

0000000000003822 <sbrkfail>:
{
    3822:	7119                	addi	sp,sp,-128
    3824:	fc86                	sd	ra,120(sp)
    3826:	f8a2                	sd	s0,112(sp)
    3828:	f4a6                	sd	s1,104(sp)
    382a:	f0ca                	sd	s2,96(sp)
    382c:	ecce                	sd	s3,88(sp)
    382e:	e8d2                	sd	s4,80(sp)
    3830:	e4d6                	sd	s5,72(sp)
    3832:	0100                	addi	s0,sp,128
    3834:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    3836:	fb040513          	addi	a0,s0,-80
    383a:	00001097          	auipc	ra,0x1
    383e:	c92080e7          	jalr	-878(ra) # 44cc <pipe>
    3842:	e901                	bnez	a0,3852 <sbrkfail+0x30>
    3844:	f8040493          	addi	s1,s0,-128
    3848:	fa840993          	addi	s3,s0,-88
    384c:	8926                	mv	s2,s1
    if(pids[i] != -1)
    384e:	5a7d                	li	s4,-1
    3850:	a085                	j	38b0 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    3852:	85d6                	mv	a1,s5
    3854:	00002517          	auipc	a0,0x2
    3858:	07450513          	addi	a0,a0,116 # 58c8 <malloc+0xeb6>
    385c:	00001097          	auipc	ra,0x1
    3860:	0f6080e7          	jalr	246(ra) # 4952 <printf>
    exit(1);
    3864:	4505                	li	a0,1
    3866:	00001097          	auipc	ra,0x1
    386a:	c56080e7          	jalr	-938(ra) # 44bc <exit>
      sbrk(BIG - (uint64)sbrk(0));
    386e:	00001097          	auipc	ra,0x1
    3872:	cd6080e7          	jalr	-810(ra) # 4544 <sbrk>
    3876:	064007b7          	lui	a5,0x6400
    387a:	40a7853b          	subw	a0,a5,a0
    387e:	00001097          	auipc	ra,0x1
    3882:	cc6080e7          	jalr	-826(ra) # 4544 <sbrk>
      write(fds[1], "x", 1);
    3886:	4605                	li	a2,1
    3888:	00002597          	auipc	a1,0x2
    388c:	0c058593          	addi	a1,a1,192 # 5948 <malloc+0xf36>
    3890:	fb442503          	lw	a0,-76(s0)
    3894:	00001097          	auipc	ra,0x1
    3898:	c48080e7          	jalr	-952(ra) # 44dc <write>
      for(;;) sleep(1000);
    389c:	3e800513          	li	a0,1000
    38a0:	00001097          	auipc	ra,0x1
    38a4:	cac080e7          	jalr	-852(ra) # 454c <sleep>
    38a8:	bfd5                	j	389c <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    38aa:	0911                	addi	s2,s2,4
    38ac:	03390563          	beq	s2,s3,38d6 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    38b0:	00001097          	auipc	ra,0x1
    38b4:	c04080e7          	jalr	-1020(ra) # 44b4 <fork>
    38b8:	00a92023          	sw	a0,0(s2) # 3000 <subdir+0x60a>
    38bc:	d94d                	beqz	a0,386e <sbrkfail+0x4c>
    if(pids[i] != -1)
    38be:	ff4506e3          	beq	a0,s4,38aa <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    38c2:	4605                	li	a2,1
    38c4:	faf40593          	addi	a1,s0,-81
    38c8:	fb042503          	lw	a0,-80(s0)
    38cc:	00001097          	auipc	ra,0x1
    38d0:	c08080e7          	jalr	-1016(ra) # 44d4 <read>
    38d4:	bfd9                	j	38aa <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    38d6:	6505                	lui	a0,0x1
    38d8:	00001097          	auipc	ra,0x1
    38dc:	c6c080e7          	jalr	-916(ra) # 4544 <sbrk>
    38e0:	892a                	mv	s2,a0
    if(pids[i] == -1)
    38e2:	5a7d                	li	s4,-1
    38e4:	a021                	j	38ec <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    38e6:	0491                	addi	s1,s1,4
    38e8:	01348f63          	beq	s1,s3,3906 <sbrkfail+0xe4>
    if(pids[i] == -1)
    38ec:	4088                	lw	a0,0(s1)
    38ee:	ff450ce3          	beq	a0,s4,38e6 <sbrkfail+0xc4>
    kill(pids[i]);
    38f2:	00001097          	auipc	ra,0x1
    38f6:	bfa080e7          	jalr	-1030(ra) # 44ec <kill>
    wait(0);
    38fa:	4501                	li	a0,0
    38fc:	00001097          	auipc	ra,0x1
    3900:	bc8080e7          	jalr	-1080(ra) # 44c4 <wait>
    3904:	b7cd                	j	38e6 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    3906:	57fd                	li	a5,-1
    3908:	02f90e63          	beq	s2,a5,3944 <sbrkfail+0x122>
  pid = fork();
    390c:	00001097          	auipc	ra,0x1
    3910:	ba8080e7          	jalr	-1112(ra) # 44b4 <fork>
    3914:	84aa                	mv	s1,a0
  if(pid < 0){
    3916:	04054563          	bltz	a0,3960 <sbrkfail+0x13e>
  if(pid == 0){
    391a:	c12d                	beqz	a0,397c <sbrkfail+0x15a>
  wait(&xstatus);
    391c:	fbc40513          	addi	a0,s0,-68
    3920:	00001097          	auipc	ra,0x1
    3924:	ba4080e7          	jalr	-1116(ra) # 44c4 <wait>
  if(xstatus != -1)
    3928:	fbc42703          	lw	a4,-68(s0)
    392c:	57fd                	li	a5,-1
    392e:	08f71c63          	bne	a4,a5,39c6 <sbrkfail+0x1a4>
}
    3932:	70e6                	ld	ra,120(sp)
    3934:	7446                	ld	s0,112(sp)
    3936:	74a6                	ld	s1,104(sp)
    3938:	7906                	ld	s2,96(sp)
    393a:	69e6                	ld	s3,88(sp)
    393c:	6a46                	ld	s4,80(sp)
    393e:	6aa6                	ld	s5,72(sp)
    3940:	6109                	addi	sp,sp,128
    3942:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    3944:	85d6                	mv	a1,s5
    3946:	00003517          	auipc	a0,0x3
    394a:	da250513          	addi	a0,a0,-606 # 66e8 <malloc+0x1cd6>
    394e:	00001097          	auipc	ra,0x1
    3952:	004080e7          	jalr	4(ra) # 4952 <printf>
    exit(1);
    3956:	4505                	li	a0,1
    3958:	00001097          	auipc	ra,0x1
    395c:	b64080e7          	jalr	-1180(ra) # 44bc <exit>
    printf("%s: fork failed\n", s);
    3960:	85d6                	mv	a1,s5
    3962:	00001517          	auipc	a0,0x1
    3966:	61650513          	addi	a0,a0,1558 # 4f78 <malloc+0x566>
    396a:	00001097          	auipc	ra,0x1
    396e:	fe8080e7          	jalr	-24(ra) # 4952 <printf>
    exit(1);
    3972:	4505                	li	a0,1
    3974:	00001097          	auipc	ra,0x1
    3978:	b48080e7          	jalr	-1208(ra) # 44bc <exit>
    a = sbrk(0);
    397c:	4501                	li	a0,0
    397e:	00001097          	auipc	ra,0x1
    3982:	bc6080e7          	jalr	-1082(ra) # 4544 <sbrk>
    3986:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3988:	3e800537          	lui	a0,0x3e800
    398c:	00001097          	auipc	ra,0x1
    3990:	bb8080e7          	jalr	-1096(ra) # 4544 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3994:	874a                	mv	a4,s2
    3996:	3e8007b7          	lui	a5,0x3e800
    399a:	97ca                	add	a5,a5,s2
    399c:	6685                	lui	a3,0x1
      n += *(a+i);
    399e:	00074603          	lbu	a2,0(a4)
    39a2:	9cb1                	addw	s1,s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    39a4:	9736                	add	a4,a4,a3
    39a6:	fee79ce3          	bne	a5,a4,399e <sbrkfail+0x17c>
    printf("%s: allocate a lot of memory succeeded %d\n", n);
    39aa:	85a6                	mv	a1,s1
    39ac:	00003517          	auipc	a0,0x3
    39b0:	d5c50513          	addi	a0,a0,-676 # 6708 <malloc+0x1cf6>
    39b4:	00001097          	auipc	ra,0x1
    39b8:	f9e080e7          	jalr	-98(ra) # 4952 <printf>
    exit(1);
    39bc:	4505                	li	a0,1
    39be:	00001097          	auipc	ra,0x1
    39c2:	afe080e7          	jalr	-1282(ra) # 44bc <exit>
    exit(1);
    39c6:	4505                	li	a0,1
    39c8:	00001097          	auipc	ra,0x1
    39cc:	af4080e7          	jalr	-1292(ra) # 44bc <exit>

00000000000039d0 <sbrkarg>:
{
    39d0:	7179                	addi	sp,sp,-48
    39d2:	f406                	sd	ra,40(sp)
    39d4:	f022                	sd	s0,32(sp)
    39d6:	ec26                	sd	s1,24(sp)
    39d8:	e84a                	sd	s2,16(sp)
    39da:	e44e                	sd	s3,8(sp)
    39dc:	1800                	addi	s0,sp,48
    39de:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    39e0:	6505                	lui	a0,0x1
    39e2:	00001097          	auipc	ra,0x1
    39e6:	b62080e7          	jalr	-1182(ra) # 4544 <sbrk>
    39ea:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    39ec:	20100593          	li	a1,513
    39f0:	00003517          	auipc	a0,0x3
    39f4:	d4850513          	addi	a0,a0,-696 # 6738 <malloc+0x1d26>
    39f8:	00001097          	auipc	ra,0x1
    39fc:	b04080e7          	jalr	-1276(ra) # 44fc <open>
    3a00:	84aa                	mv	s1,a0
  unlink("sbrk");
    3a02:	00003517          	auipc	a0,0x3
    3a06:	d3650513          	addi	a0,a0,-714 # 6738 <malloc+0x1d26>
    3a0a:	00001097          	auipc	ra,0x1
    3a0e:	b02080e7          	jalr	-1278(ra) # 450c <unlink>
  if(fd < 0)  {
    3a12:	0404c163          	bltz	s1,3a54 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    3a16:	6605                	lui	a2,0x1
    3a18:	85ca                	mv	a1,s2
    3a1a:	8526                	mv	a0,s1
    3a1c:	00001097          	auipc	ra,0x1
    3a20:	ac0080e7          	jalr	-1344(ra) # 44dc <write>
    3a24:	04054663          	bltz	a0,3a70 <sbrkarg+0xa0>
  close(fd);
    3a28:	8526                	mv	a0,s1
    3a2a:	00001097          	auipc	ra,0x1
    3a2e:	9f6080e7          	jalr	-1546(ra) # 4420 <close>
  a = sbrk(PGSIZE);
    3a32:	6505                	lui	a0,0x1
    3a34:	00001097          	auipc	ra,0x1
    3a38:	b10080e7          	jalr	-1264(ra) # 4544 <sbrk>
  if(pipe((int *) a) != 0){
    3a3c:	00001097          	auipc	ra,0x1
    3a40:	a90080e7          	jalr	-1392(ra) # 44cc <pipe>
    3a44:	e521                	bnez	a0,3a8c <sbrkarg+0xbc>
}
    3a46:	70a2                	ld	ra,40(sp)
    3a48:	7402                	ld	s0,32(sp)
    3a4a:	64e2                	ld	s1,24(sp)
    3a4c:	6942                	ld	s2,16(sp)
    3a4e:	69a2                	ld	s3,8(sp)
    3a50:	6145                	addi	sp,sp,48
    3a52:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    3a54:	85ce                	mv	a1,s3
    3a56:	00003517          	auipc	a0,0x3
    3a5a:	cea50513          	addi	a0,a0,-790 # 6740 <malloc+0x1d2e>
    3a5e:	00001097          	auipc	ra,0x1
    3a62:	ef4080e7          	jalr	-268(ra) # 4952 <printf>
    exit(1);
    3a66:	4505                	li	a0,1
    3a68:	00001097          	auipc	ra,0x1
    3a6c:	a54080e7          	jalr	-1452(ra) # 44bc <exit>
    printf("%s: write sbrk failed\n", s);
    3a70:	85ce                	mv	a1,s3
    3a72:	00003517          	auipc	a0,0x3
    3a76:	ce650513          	addi	a0,a0,-794 # 6758 <malloc+0x1d46>
    3a7a:	00001097          	auipc	ra,0x1
    3a7e:	ed8080e7          	jalr	-296(ra) # 4952 <printf>
    exit(1);
    3a82:	4505                	li	a0,1
    3a84:	00001097          	auipc	ra,0x1
    3a88:	a38080e7          	jalr	-1480(ra) # 44bc <exit>
    printf("%s: pipe() failed\n", s);
    3a8c:	85ce                	mv	a1,s3
    3a8e:	00002517          	auipc	a0,0x2
    3a92:	e3a50513          	addi	a0,a0,-454 # 58c8 <malloc+0xeb6>
    3a96:	00001097          	auipc	ra,0x1
    3a9a:	ebc080e7          	jalr	-324(ra) # 4952 <printf>
    exit(1);
    3a9e:	4505                	li	a0,1
    3aa0:	00001097          	auipc	ra,0x1
    3aa4:	a1c080e7          	jalr	-1508(ra) # 44bc <exit>

0000000000003aa8 <argptest>:
{
    3aa8:	1101                	addi	sp,sp,-32
    3aaa:	ec06                	sd	ra,24(sp)
    3aac:	e822                	sd	s0,16(sp)
    3aae:	e426                	sd	s1,8(sp)
    3ab0:	e04a                	sd	s2,0(sp)
    3ab2:	1000                	addi	s0,sp,32
    3ab4:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    3ab6:	4581                	li	a1,0
    3ab8:	00003517          	auipc	a0,0x3
    3abc:	cb850513          	addi	a0,a0,-840 # 6770 <malloc+0x1d5e>
    3ac0:	00001097          	auipc	ra,0x1
    3ac4:	a3c080e7          	jalr	-1476(ra) # 44fc <open>
  if (fd < 0) {
    3ac8:	02054b63          	bltz	a0,3afe <argptest+0x56>
    3acc:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    3ace:	4501                	li	a0,0
    3ad0:	00001097          	auipc	ra,0x1
    3ad4:	a74080e7          	jalr	-1420(ra) # 4544 <sbrk>
    3ad8:	567d                	li	a2,-1
    3ada:	fff50593          	addi	a1,a0,-1
    3ade:	8526                	mv	a0,s1
    3ae0:	00001097          	auipc	ra,0x1
    3ae4:	9f4080e7          	jalr	-1548(ra) # 44d4 <read>
  close(fd);
    3ae8:	8526                	mv	a0,s1
    3aea:	00001097          	auipc	ra,0x1
    3aee:	936080e7          	jalr	-1738(ra) # 4420 <close>
}
    3af2:	60e2                	ld	ra,24(sp)
    3af4:	6442                	ld	s0,16(sp)
    3af6:	64a2                	ld	s1,8(sp)
    3af8:	6902                	ld	s2,0(sp)
    3afa:	6105                	addi	sp,sp,32
    3afc:	8082                	ret
    printf("%s: open failed\n", s);
    3afe:	85ca                	mv	a1,s2
    3b00:	00002517          	auipc	a0,0x2
    3b04:	c6850513          	addi	a0,a0,-920 # 5768 <malloc+0xd56>
    3b08:	00001097          	auipc	ra,0x1
    3b0c:	e4a080e7          	jalr	-438(ra) # 4952 <printf>
    exit(1);
    3b10:	4505                	li	a0,1
    3b12:	00001097          	auipc	ra,0x1
    3b16:	9aa080e7          	jalr	-1622(ra) # 44bc <exit>

0000000000003b1a <sbrkbugs>:
{
    3b1a:	1141                	addi	sp,sp,-16
    3b1c:	e406                	sd	ra,8(sp)
    3b1e:	e022                	sd	s0,0(sp)
    3b20:	0800                	addi	s0,sp,16
  int pid = fork();
    3b22:	00001097          	auipc	ra,0x1
    3b26:	992080e7          	jalr	-1646(ra) # 44b4 <fork>
  if(pid < 0){
    3b2a:	02054363          	bltz	a0,3b50 <sbrkbugs+0x36>
  if(pid == 0){
    3b2e:	ed15                	bnez	a0,3b6a <sbrkbugs+0x50>
    int sz = (uint64) sbrk(0);
    3b30:	00001097          	auipc	ra,0x1
    3b34:	a14080e7          	jalr	-1516(ra) # 4544 <sbrk>
    sbrk(-sz);
    3b38:	40a0053b          	negw	a0,a0
    3b3c:	2501                	sext.w	a0,a0
    3b3e:	00001097          	auipc	ra,0x1
    3b42:	a06080e7          	jalr	-1530(ra) # 4544 <sbrk>
    exit(0);
    3b46:	4501                	li	a0,0
    3b48:	00001097          	auipc	ra,0x1
    3b4c:	974080e7          	jalr	-1676(ra) # 44bc <exit>
    printf("fork failed\n");
    3b50:	00002517          	auipc	a0,0x2
    3b54:	d4850513          	addi	a0,a0,-696 # 5898 <malloc+0xe86>
    3b58:	00001097          	auipc	ra,0x1
    3b5c:	dfa080e7          	jalr	-518(ra) # 4952 <printf>
    exit(1);
    3b60:	4505                	li	a0,1
    3b62:	00001097          	auipc	ra,0x1
    3b66:	95a080e7          	jalr	-1702(ra) # 44bc <exit>
  wait(0);
    3b6a:	4501                	li	a0,0
    3b6c:	00001097          	auipc	ra,0x1
    3b70:	958080e7          	jalr	-1704(ra) # 44c4 <wait>
  pid = fork();
    3b74:	00001097          	auipc	ra,0x1
    3b78:	940080e7          	jalr	-1728(ra) # 44b4 <fork>
  if(pid < 0){
    3b7c:	02054563          	bltz	a0,3ba6 <sbrkbugs+0x8c>
  if(pid == 0){
    3b80:	e121                	bnez	a0,3bc0 <sbrkbugs+0xa6>
    int sz = (uint64) sbrk(0);
    3b82:	00001097          	auipc	ra,0x1
    3b86:	9c2080e7          	jalr	-1598(ra) # 4544 <sbrk>
    sbrk(-(sz - 3500));
    3b8a:	6785                	lui	a5,0x1
    3b8c:	dac7879b          	addiw	a5,a5,-596
    3b90:	40a7853b          	subw	a0,a5,a0
    3b94:	00001097          	auipc	ra,0x1
    3b98:	9b0080e7          	jalr	-1616(ra) # 4544 <sbrk>
    exit(0);
    3b9c:	4501                	li	a0,0
    3b9e:	00001097          	auipc	ra,0x1
    3ba2:	91e080e7          	jalr	-1762(ra) # 44bc <exit>
    printf("fork failed\n");
    3ba6:	00002517          	auipc	a0,0x2
    3baa:	cf250513          	addi	a0,a0,-782 # 5898 <malloc+0xe86>
    3bae:	00001097          	auipc	ra,0x1
    3bb2:	da4080e7          	jalr	-604(ra) # 4952 <printf>
    exit(1);
    3bb6:	4505                	li	a0,1
    3bb8:	00001097          	auipc	ra,0x1
    3bbc:	904080e7          	jalr	-1788(ra) # 44bc <exit>
  wait(0);
    3bc0:	4501                	li	a0,0
    3bc2:	00001097          	auipc	ra,0x1
    3bc6:	902080e7          	jalr	-1790(ra) # 44c4 <wait>
  pid = fork();
    3bca:	00001097          	auipc	ra,0x1
    3bce:	8ea080e7          	jalr	-1814(ra) # 44b4 <fork>
  if(pid < 0){
    3bd2:	02054a63          	bltz	a0,3c06 <sbrkbugs+0xec>
  if(pid == 0){
    3bd6:	e529                	bnez	a0,3c20 <sbrkbugs+0x106>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    3bd8:	00001097          	auipc	ra,0x1
    3bdc:	96c080e7          	jalr	-1684(ra) # 4544 <sbrk>
    3be0:	67ad                	lui	a5,0xb
    3be2:	8007879b          	addiw	a5,a5,-2048
    3be6:	40a7853b          	subw	a0,a5,a0
    3bea:	00001097          	auipc	ra,0x1
    3bee:	95a080e7          	jalr	-1702(ra) # 4544 <sbrk>
    sbrk(-10);
    3bf2:	5559                	li	a0,-10
    3bf4:	00001097          	auipc	ra,0x1
    3bf8:	950080e7          	jalr	-1712(ra) # 4544 <sbrk>
    exit(0);
    3bfc:	4501                	li	a0,0
    3bfe:	00001097          	auipc	ra,0x1
    3c02:	8be080e7          	jalr	-1858(ra) # 44bc <exit>
    printf("fork failed\n");
    3c06:	00002517          	auipc	a0,0x2
    3c0a:	c9250513          	addi	a0,a0,-878 # 5898 <malloc+0xe86>
    3c0e:	00001097          	auipc	ra,0x1
    3c12:	d44080e7          	jalr	-700(ra) # 4952 <printf>
    exit(1);
    3c16:	4505                	li	a0,1
    3c18:	00001097          	auipc	ra,0x1
    3c1c:	8a4080e7          	jalr	-1884(ra) # 44bc <exit>
  wait(0);
    3c20:	4501                	li	a0,0
    3c22:	00001097          	auipc	ra,0x1
    3c26:	8a2080e7          	jalr	-1886(ra) # 44c4 <wait>
  exit(0);
    3c2a:	4501                	li	a0,0
    3c2c:	00001097          	auipc	ra,0x1
    3c30:	890080e7          	jalr	-1904(ra) # 44bc <exit>

0000000000003c34 <dirtest>:
{
    3c34:	1101                	addi	sp,sp,-32
    3c36:	ec06                	sd	ra,24(sp)
    3c38:	e822                	sd	s0,16(sp)
    3c3a:	e426                	sd	s1,8(sp)
    3c3c:	1000                	addi	s0,sp,32
    3c3e:	84aa                	mv	s1,a0
  printf("mkdir test\n");
    3c40:	00003517          	auipc	a0,0x3
    3c44:	b3850513          	addi	a0,a0,-1224 # 6778 <malloc+0x1d66>
    3c48:	00001097          	auipc	ra,0x1
    3c4c:	d0a080e7          	jalr	-758(ra) # 4952 <printf>
  if(mkdir("dir0") < 0){
    3c50:	00003517          	auipc	a0,0x3
    3c54:	b3850513          	addi	a0,a0,-1224 # 6788 <malloc+0x1d76>
    3c58:	00001097          	auipc	ra,0x1
    3c5c:	8cc080e7          	jalr	-1844(ra) # 4524 <mkdir>
    3c60:	04054d63          	bltz	a0,3cba <dirtest+0x86>
  if(chdir("dir0") < 0){
    3c64:	00003517          	auipc	a0,0x3
    3c68:	b2450513          	addi	a0,a0,-1244 # 6788 <malloc+0x1d76>
    3c6c:	00001097          	auipc	ra,0x1
    3c70:	8c0080e7          	jalr	-1856(ra) # 452c <chdir>
    3c74:	06054163          	bltz	a0,3cd6 <dirtest+0xa2>
  if(chdir("..") < 0){
    3c78:	00001517          	auipc	a0,0x1
    3c7c:	27050513          	addi	a0,a0,624 # 4ee8 <malloc+0x4d6>
    3c80:	00001097          	auipc	ra,0x1
    3c84:	8ac080e7          	jalr	-1876(ra) # 452c <chdir>
    3c88:	06054563          	bltz	a0,3cf2 <dirtest+0xbe>
  if(unlink("dir0") < 0){
    3c8c:	00003517          	auipc	a0,0x3
    3c90:	afc50513          	addi	a0,a0,-1284 # 6788 <malloc+0x1d76>
    3c94:	00001097          	auipc	ra,0x1
    3c98:	878080e7          	jalr	-1928(ra) # 450c <unlink>
    3c9c:	06054963          	bltz	a0,3d0e <dirtest+0xda>
  printf("%s: mkdir test ok\n");
    3ca0:	00003517          	auipc	a0,0x3
    3ca4:	b3850513          	addi	a0,a0,-1224 # 67d8 <malloc+0x1dc6>
    3ca8:	00001097          	auipc	ra,0x1
    3cac:	caa080e7          	jalr	-854(ra) # 4952 <printf>
}
    3cb0:	60e2                	ld	ra,24(sp)
    3cb2:	6442                	ld	s0,16(sp)
    3cb4:	64a2                	ld	s1,8(sp)
    3cb6:	6105                	addi	sp,sp,32
    3cb8:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3cba:	85a6                	mv	a1,s1
    3cbc:	00001517          	auipc	a0,0x1
    3cc0:	14c50513          	addi	a0,a0,332 # 4e08 <malloc+0x3f6>
    3cc4:	00001097          	auipc	ra,0x1
    3cc8:	c8e080e7          	jalr	-882(ra) # 4952 <printf>
    exit(1);
    3ccc:	4505                	li	a0,1
    3cce:	00000097          	auipc	ra,0x0
    3cd2:	7ee080e7          	jalr	2030(ra) # 44bc <exit>
    printf("%s: chdir dir0 failed\n", s);
    3cd6:	85a6                	mv	a1,s1
    3cd8:	00003517          	auipc	a0,0x3
    3cdc:	ab850513          	addi	a0,a0,-1352 # 6790 <malloc+0x1d7e>
    3ce0:	00001097          	auipc	ra,0x1
    3ce4:	c72080e7          	jalr	-910(ra) # 4952 <printf>
    exit(1);
    3ce8:	4505                	li	a0,1
    3cea:	00000097          	auipc	ra,0x0
    3cee:	7d2080e7          	jalr	2002(ra) # 44bc <exit>
    printf("%s: chdir .. failed\n", s);
    3cf2:	85a6                	mv	a1,s1
    3cf4:	00003517          	auipc	a0,0x3
    3cf8:	ab450513          	addi	a0,a0,-1356 # 67a8 <malloc+0x1d96>
    3cfc:	00001097          	auipc	ra,0x1
    3d00:	c56080e7          	jalr	-938(ra) # 4952 <printf>
    exit(1);
    3d04:	4505                	li	a0,1
    3d06:	00000097          	auipc	ra,0x0
    3d0a:	7b6080e7          	jalr	1974(ra) # 44bc <exit>
    printf("%s: unlink dir0 failed\n", s);
    3d0e:	85a6                	mv	a1,s1
    3d10:	00003517          	auipc	a0,0x3
    3d14:	ab050513          	addi	a0,a0,-1360 # 67c0 <malloc+0x1dae>
    3d18:	00001097          	auipc	ra,0x1
    3d1c:	c3a080e7          	jalr	-966(ra) # 4952 <printf>
    exit(1);
    3d20:	4505                	li	a0,1
    3d22:	00000097          	auipc	ra,0x0
    3d26:	79a080e7          	jalr	1946(ra) # 44bc <exit>

0000000000003d2a <fsfull>:
{
    3d2a:	7171                	addi	sp,sp,-176
    3d2c:	f506                	sd	ra,168(sp)
    3d2e:	f122                	sd	s0,160(sp)
    3d30:	ed26                	sd	s1,152(sp)
    3d32:	e94a                	sd	s2,144(sp)
    3d34:	e54e                	sd	s3,136(sp)
    3d36:	e152                	sd	s4,128(sp)
    3d38:	fcd6                	sd	s5,120(sp)
    3d3a:	f8da                	sd	s6,112(sp)
    3d3c:	f4de                	sd	s7,104(sp)
    3d3e:	f0e2                	sd	s8,96(sp)
    3d40:	ece6                	sd	s9,88(sp)
    3d42:	e8ea                	sd	s10,80(sp)
    3d44:	e4ee                	sd	s11,72(sp)
    3d46:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    3d48:	00003517          	auipc	a0,0x3
    3d4c:	aa850513          	addi	a0,a0,-1368 # 67f0 <malloc+0x1dde>
    3d50:	00001097          	auipc	ra,0x1
    3d54:	c02080e7          	jalr	-1022(ra) # 4952 <printf>
  for(nfiles = 0; ; nfiles++){
    3d58:	4481                	li	s1,0
    name[0] = 'f';
    3d5a:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    3d5e:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    3d62:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    3d66:	4b29                	li	s6,10
    printf("%s: writing %s\n", name);
    3d68:	00003c97          	auipc	s9,0x3
    3d6c:	a98c8c93          	addi	s9,s9,-1384 # 6800 <malloc+0x1dee>
    int total = 0;
    3d70:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    3d72:	00005a17          	auipc	s4,0x5
    3d76:	66ea0a13          	addi	s4,s4,1646 # 93e0 <buf>
    name[0] = 'f';
    3d7a:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    3d7e:	0384c7bb          	divw	a5,s1,s8
    3d82:	0307879b          	addiw	a5,a5,48
    3d86:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3d8a:	0384e7bb          	remw	a5,s1,s8
    3d8e:	0377c7bb          	divw	a5,a5,s7
    3d92:	0307879b          	addiw	a5,a5,48
    3d96:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3d9a:	0374e7bb          	remw	a5,s1,s7
    3d9e:	0367c7bb          	divw	a5,a5,s6
    3da2:	0307879b          	addiw	a5,a5,48
    3da6:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    3daa:	0364e7bb          	remw	a5,s1,s6
    3dae:	0307879b          	addiw	a5,a5,48
    3db2:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    3db6:	f4040aa3          	sb	zero,-171(s0)
    printf("%s: writing %s\n", name);
    3dba:	f5040593          	addi	a1,s0,-176
    3dbe:	8566                	mv	a0,s9
    3dc0:	00001097          	auipc	ra,0x1
    3dc4:	b92080e7          	jalr	-1134(ra) # 4952 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3dc8:	20200593          	li	a1,514
    3dcc:	f5040513          	addi	a0,s0,-176
    3dd0:	00000097          	auipc	ra,0x0
    3dd4:	72c080e7          	jalr	1836(ra) # 44fc <open>
    3dd8:	89aa                	mv	s3,a0
    if(fd < 0){
    3dda:	0a055663          	bgez	a0,3e86 <fsfull+0x15c>
      printf("%s: open %s failed\n", name);
    3dde:	f5040593          	addi	a1,s0,-176
    3de2:	00003517          	auipc	a0,0x3
    3de6:	a2e50513          	addi	a0,a0,-1490 # 6810 <malloc+0x1dfe>
    3dea:	00001097          	auipc	ra,0x1
    3dee:	b68080e7          	jalr	-1176(ra) # 4952 <printf>
  while(nfiles >= 0){
    3df2:	0604c363          	bltz	s1,3e58 <fsfull+0x12e>
    name[0] = 'f';
    3df6:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    3dfa:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    3dfe:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    3e02:	4929                	li	s2,10
  while(nfiles >= 0){
    3e04:	5afd                	li	s5,-1
    name[0] = 'f';
    3e06:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    3e0a:	0344c7bb          	divw	a5,s1,s4
    3e0e:	0307879b          	addiw	a5,a5,48
    3e12:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    3e16:	0344e7bb          	remw	a5,s1,s4
    3e1a:	0337c7bb          	divw	a5,a5,s3
    3e1e:	0307879b          	addiw	a5,a5,48
    3e22:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    3e26:	0334e7bb          	remw	a5,s1,s3
    3e2a:	0327c7bb          	divw	a5,a5,s2
    3e2e:	0307879b          	addiw	a5,a5,48
    3e32:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    3e36:	0324e7bb          	remw	a5,s1,s2
    3e3a:	0307879b          	addiw	a5,a5,48
    3e3e:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    3e42:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    3e46:	f5040513          	addi	a0,s0,-176
    3e4a:	00000097          	auipc	ra,0x0
    3e4e:	6c2080e7          	jalr	1730(ra) # 450c <unlink>
    nfiles--;
    3e52:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    3e54:	fb5499e3          	bne	s1,s5,3e06 <fsfull+0xdc>
  printf("fsfull test finished\n");
    3e58:	00003517          	auipc	a0,0x3
    3e5c:	9e850513          	addi	a0,a0,-1560 # 6840 <malloc+0x1e2e>
    3e60:	00001097          	auipc	ra,0x1
    3e64:	af2080e7          	jalr	-1294(ra) # 4952 <printf>
}
    3e68:	70aa                	ld	ra,168(sp)
    3e6a:	740a                	ld	s0,160(sp)
    3e6c:	64ea                	ld	s1,152(sp)
    3e6e:	694a                	ld	s2,144(sp)
    3e70:	69aa                	ld	s3,136(sp)
    3e72:	6a0a                	ld	s4,128(sp)
    3e74:	7ae6                	ld	s5,120(sp)
    3e76:	7b46                	ld	s6,112(sp)
    3e78:	7ba6                	ld	s7,104(sp)
    3e7a:	7c06                	ld	s8,96(sp)
    3e7c:	6ce6                	ld	s9,88(sp)
    3e7e:	6d46                	ld	s10,80(sp)
    3e80:	6da6                	ld	s11,72(sp)
    3e82:	614d                	addi	sp,sp,176
    3e84:	8082                	ret
    int total = 0;
    3e86:	896e                	mv	s2,s11
      if(cc < BSIZE)
    3e88:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    3e8c:	40000613          	li	a2,1024
    3e90:	85d2                	mv	a1,s4
    3e92:	854e                	mv	a0,s3
    3e94:	00000097          	auipc	ra,0x0
    3e98:	648080e7          	jalr	1608(ra) # 44dc <write>
      if(cc < BSIZE)
    3e9c:	00aad563          	ble	a0,s5,3ea6 <fsfull+0x17c>
      total += cc;
    3ea0:	00a9093b          	addw	s2,s2,a0
    while(1){
    3ea4:	b7e5                	j	3e8c <fsfull+0x162>
    printf("%s: wrote %d bytes\n", total);
    3ea6:	85ca                	mv	a1,s2
    3ea8:	00003517          	auipc	a0,0x3
    3eac:	98050513          	addi	a0,a0,-1664 # 6828 <malloc+0x1e16>
    3eb0:	00001097          	auipc	ra,0x1
    3eb4:	aa2080e7          	jalr	-1374(ra) # 4952 <printf>
    close(fd);
    3eb8:	854e                	mv	a0,s3
    3eba:	00000097          	auipc	ra,0x0
    3ebe:	566080e7          	jalr	1382(ra) # 4420 <close>
    if(total == 0)
    3ec2:	f20908e3          	beqz	s2,3df2 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    3ec6:	2485                	addiw	s1,s1,1
    3ec8:	bd4d                	j	3d7a <fsfull+0x50>

0000000000003eca <rand>:
{
    3eca:	1141                	addi	sp,sp,-16
    3ecc:	e422                	sd	s0,8(sp)
    3ece:	0800                	addi	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    3ed0:	00003717          	auipc	a4,0x3
    3ed4:	ce870713          	addi	a4,a4,-792 # 6bb8 <randstate>
    3ed8:	6308                	ld	a0,0(a4)
    3eda:	001967b7          	lui	a5,0x196
    3ede:	60d78793          	addi	a5,a5,1549 # 19660d <_end+0x189d6d>
    3ee2:	02f50533          	mul	a0,a0,a5
    3ee6:	3c6ef7b7          	lui	a5,0x3c6ef
    3eea:	35f78793          	addi	a5,a5,863 # 3c6ef35f <_end+0x3c6e2abf>
    3eee:	953e                	add	a0,a0,a5
    3ef0:	e308                	sd	a0,0(a4)
}
    3ef2:	2501                	sext.w	a0,a0
    3ef4:	6422                	ld	s0,8(sp)
    3ef6:	0141                	addi	sp,sp,16
    3ef8:	8082                	ret

0000000000003efa <badwrite>:
{
    3efa:	7179                	addi	sp,sp,-48
    3efc:	f406                	sd	ra,40(sp)
    3efe:	f022                	sd	s0,32(sp)
    3f00:	ec26                	sd	s1,24(sp)
    3f02:	e84a                	sd	s2,16(sp)
    3f04:	e44e                	sd	s3,8(sp)
    3f06:	e052                	sd	s4,0(sp)
    3f08:	1800                	addi	s0,sp,48
  unlink("junk");
    3f0a:	00003517          	auipc	a0,0x3
    3f0e:	94e50513          	addi	a0,a0,-1714 # 6858 <malloc+0x1e46>
    3f12:	00000097          	auipc	ra,0x0
    3f16:	5fa080e7          	jalr	1530(ra) # 450c <unlink>
    3f1a:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    3f1e:	00003997          	auipc	s3,0x3
    3f22:	93a98993          	addi	s3,s3,-1734 # 6858 <malloc+0x1e46>
    write(fd, (char*)0xffffffffffL, 1);
    3f26:	5a7d                	li	s4,-1
    3f28:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    3f2c:	20100593          	li	a1,513
    3f30:	854e                	mv	a0,s3
    3f32:	00000097          	auipc	ra,0x0
    3f36:	5ca080e7          	jalr	1482(ra) # 44fc <open>
    3f3a:	84aa                	mv	s1,a0
    if(fd < 0){
    3f3c:	06054b63          	bltz	a0,3fb2 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    3f40:	4605                	li	a2,1
    3f42:	85d2                	mv	a1,s4
    3f44:	00000097          	auipc	ra,0x0
    3f48:	598080e7          	jalr	1432(ra) # 44dc <write>
    close(fd);
    3f4c:	8526                	mv	a0,s1
    3f4e:	00000097          	auipc	ra,0x0
    3f52:	4d2080e7          	jalr	1234(ra) # 4420 <close>
    unlink("junk");
    3f56:	854e                	mv	a0,s3
    3f58:	00000097          	auipc	ra,0x0
    3f5c:	5b4080e7          	jalr	1460(ra) # 450c <unlink>
  for(int i = 0; i < assumed_free; i++){
    3f60:	397d                	addiw	s2,s2,-1
    3f62:	fc0915e3          	bnez	s2,3f2c <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    3f66:	20100593          	li	a1,513
    3f6a:	00003517          	auipc	a0,0x3
    3f6e:	8ee50513          	addi	a0,a0,-1810 # 6858 <malloc+0x1e46>
    3f72:	00000097          	auipc	ra,0x0
    3f76:	58a080e7          	jalr	1418(ra) # 44fc <open>
    3f7a:	84aa                	mv	s1,a0
  if(fd < 0){
    3f7c:	04054863          	bltz	a0,3fcc <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    3f80:	4605                	li	a2,1
    3f82:	00002597          	auipc	a1,0x2
    3f86:	9c658593          	addi	a1,a1,-1594 # 5948 <malloc+0xf36>
    3f8a:	00000097          	auipc	ra,0x0
    3f8e:	552080e7          	jalr	1362(ra) # 44dc <write>
    3f92:	4785                	li	a5,1
    3f94:	04f50963          	beq	a0,a5,3fe6 <badwrite+0xec>
    printf("write failed\n");
    3f98:	00003517          	auipc	a0,0x3
    3f9c:	8e050513          	addi	a0,a0,-1824 # 6878 <malloc+0x1e66>
    3fa0:	00001097          	auipc	ra,0x1
    3fa4:	9b2080e7          	jalr	-1614(ra) # 4952 <printf>
    exit(1);
    3fa8:	4505                	li	a0,1
    3faa:	00000097          	auipc	ra,0x0
    3fae:	512080e7          	jalr	1298(ra) # 44bc <exit>
      printf("open junk failed\n");
    3fb2:	00003517          	auipc	a0,0x3
    3fb6:	8ae50513          	addi	a0,a0,-1874 # 6860 <malloc+0x1e4e>
    3fba:	00001097          	auipc	ra,0x1
    3fbe:	998080e7          	jalr	-1640(ra) # 4952 <printf>
      exit(1);
    3fc2:	4505                	li	a0,1
    3fc4:	00000097          	auipc	ra,0x0
    3fc8:	4f8080e7          	jalr	1272(ra) # 44bc <exit>
    printf("open junk failed\n");
    3fcc:	00003517          	auipc	a0,0x3
    3fd0:	89450513          	addi	a0,a0,-1900 # 6860 <malloc+0x1e4e>
    3fd4:	00001097          	auipc	ra,0x1
    3fd8:	97e080e7          	jalr	-1666(ra) # 4952 <printf>
    exit(1);
    3fdc:	4505                	li	a0,1
    3fde:	00000097          	auipc	ra,0x0
    3fe2:	4de080e7          	jalr	1246(ra) # 44bc <exit>
  close(fd);
    3fe6:	8526                	mv	a0,s1
    3fe8:	00000097          	auipc	ra,0x0
    3fec:	438080e7          	jalr	1080(ra) # 4420 <close>
  unlink("junk");
    3ff0:	00003517          	auipc	a0,0x3
    3ff4:	86850513          	addi	a0,a0,-1944 # 6858 <malloc+0x1e46>
    3ff8:	00000097          	auipc	ra,0x0
    3ffc:	514080e7          	jalr	1300(ra) # 450c <unlink>
  exit(0);
    4000:	4501                	li	a0,0
    4002:	00000097          	auipc	ra,0x0
    4006:	4ba080e7          	jalr	1210(ra) # 44bc <exit>

000000000000400a <run>:
}

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    400a:	7179                	addi	sp,sp,-48
    400c:	f406                	sd	ra,40(sp)
    400e:	f022                	sd	s0,32(sp)
    4010:	ec26                	sd	s1,24(sp)
    4012:	e84a                	sd	s2,16(sp)
    4014:	1800                	addi	s0,sp,48
    4016:	892a                	mv	s2,a0
    4018:	84ae                	mv	s1,a1
  int pid;
  int xstatus;
  
  printf("test %s: ", s);
    401a:	00003517          	auipc	a0,0x3
    401e:	86e50513          	addi	a0,a0,-1938 # 6888 <malloc+0x1e76>
    4022:	00001097          	auipc	ra,0x1
    4026:	930080e7          	jalr	-1744(ra) # 4952 <printf>
  if((pid = fork()) < 0) {
    402a:	00000097          	auipc	ra,0x0
    402e:	48a080e7          	jalr	1162(ra) # 44b4 <fork>
    4032:	02054f63          	bltz	a0,4070 <run+0x66>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4036:	c931                	beqz	a0,408a <run+0x80>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4038:	fdc40513          	addi	a0,s0,-36
    403c:	00000097          	auipc	ra,0x0
    4040:	488080e7          	jalr	1160(ra) # 44c4 <wait>
    if(xstatus != 0) 
    4044:	fdc42783          	lw	a5,-36(s0)
    4048:	cba1                	beqz	a5,4098 <run+0x8e>
      printf("FAILED\n", s);
    404a:	85a6                	mv	a1,s1
    404c:	00003517          	auipc	a0,0x3
    4050:	86450513          	addi	a0,a0,-1948 # 68b0 <malloc+0x1e9e>
    4054:	00001097          	auipc	ra,0x1
    4058:	8fe080e7          	jalr	-1794(ra) # 4952 <printf>
    else
      printf("OK\n", s);
    return xstatus == 0;
    405c:	fdc42503          	lw	a0,-36(s0)
  }
}
    4060:	00153513          	seqz	a0,a0
    4064:	70a2                	ld	ra,40(sp)
    4066:	7402                	ld	s0,32(sp)
    4068:	64e2                	ld	s1,24(sp)
    406a:	6942                	ld	s2,16(sp)
    406c:	6145                	addi	sp,sp,48
    406e:	8082                	ret
    printf("runtest: fork error\n");
    4070:	00003517          	auipc	a0,0x3
    4074:	82850513          	addi	a0,a0,-2008 # 6898 <malloc+0x1e86>
    4078:	00001097          	auipc	ra,0x1
    407c:	8da080e7          	jalr	-1830(ra) # 4952 <printf>
    exit(1);
    4080:	4505                	li	a0,1
    4082:	00000097          	auipc	ra,0x0
    4086:	43a080e7          	jalr	1082(ra) # 44bc <exit>
    f(s);
    408a:	8526                	mv	a0,s1
    408c:	9902                	jalr	s2
    exit(0);
    408e:	4501                	li	a0,0
    4090:	00000097          	auipc	ra,0x0
    4094:	42c080e7          	jalr	1068(ra) # 44bc <exit>
      printf("OK\n", s);
    4098:	85a6                	mv	a1,s1
    409a:	00003517          	auipc	a0,0x3
    409e:	81e50513          	addi	a0,a0,-2018 # 68b8 <malloc+0x1ea6>
    40a2:	00001097          	auipc	ra,0x1
    40a6:	8b0080e7          	jalr	-1872(ra) # 4952 <printf>
    40aa:	bf4d                	j	405c <run+0x52>

00000000000040ac <main>:

int
main(int argc, char *argv[])
{
    40ac:	cd010113          	addi	sp,sp,-816
    40b0:	32113423          	sd	ra,808(sp)
    40b4:	32813023          	sd	s0,800(sp)
    40b8:	30913c23          	sd	s1,792(sp)
    40bc:	31213823          	sd	s2,784(sp)
    40c0:	31313423          	sd	s3,776(sp)
    40c4:	31413023          	sd	s4,768(sp)
    40c8:	2f513c23          	sd	s5,760(sp)
    40cc:	1e00                	addi	s0,sp,816
  char *n = 0;
  if(argc > 1) {
    40ce:	4785                	li	a5,1
  char *n = 0;
    40d0:	4981                	li	s3,0
  if(argc > 1) {
    40d2:	00a7d463          	ble	a0,a5,40da <main+0x2e>
    n = argv[1];
    40d6:	0085b983          	ld	s3,8(a1)
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    40da:	00001797          	auipc	a5,0x1
    40de:	a1e78793          	addi	a5,a5,-1506 # 4af8 <malloc+0xe6>
    40e2:	cd040713          	addi	a4,s0,-816
    40e6:	00001817          	auipc	a6,0x1
    40ea:	cf280813          	addi	a6,a6,-782 # 4dd8 <malloc+0x3c6>
    40ee:	6388                	ld	a0,0(a5)
    40f0:	678c                	ld	a1,8(a5)
    40f2:	6b90                	ld	a2,16(a5)
    40f4:	6f94                	ld	a3,24(a5)
    40f6:	e308                	sd	a0,0(a4)
    40f8:	e70c                	sd	a1,8(a4)
    40fa:	eb10                	sd	a2,16(a4)
    40fc:	ef14                	sd	a3,24(a4)
    40fe:	02078793          	addi	a5,a5,32
    4102:	02070713          	addi	a4,a4,32
    4106:	ff0794e3          	bne	a5,a6,40ee <main+0x42>
    410a:	6394                	ld	a3,0(a5)
    410c:	679c                	ld	a5,8(a5)
    410e:	e314                	sd	a3,0(a4)
    4110:	e71c                	sd	a5,8(a4)
    {forktest, "forktest"},
    {bigdir, "bigdir"}, // slow
    { 0, 0},
  };
    
  printf("usertests starting\n");
    4112:	00002517          	auipc	a0,0x2
    4116:	7ae50513          	addi	a0,a0,1966 # 68c0 <malloc+0x1eae>
    411a:	00001097          	auipc	ra,0x1
    411e:	838080e7          	jalr	-1992(ra) # 4952 <printf>

  if(open("usertests.ran", 0) >= 0){
    4122:	4581                	li	a1,0
    4124:	00002517          	auipc	a0,0x2
    4128:	7b450513          	addi	a0,a0,1972 # 68d8 <malloc+0x1ec6>
    412c:	00000097          	auipc	ra,0x0
    4130:	3d0080e7          	jalr	976(ra) # 44fc <open>
    4134:	00054f63          	bltz	a0,4152 <main+0xa6>
    printf("already ran user tests -- rebuild fs.img (rm fs.img; make fs.img)\n");
    4138:	00002517          	auipc	a0,0x2
    413c:	7b050513          	addi	a0,a0,1968 # 68e8 <malloc+0x1ed6>
    4140:	00001097          	auipc	ra,0x1
    4144:	812080e7          	jalr	-2030(ra) # 4952 <printf>
    exit(1);
    4148:	4505                	li	a0,1
    414a:	00000097          	auipc	ra,0x0
    414e:	372080e7          	jalr	882(ra) # 44bc <exit>
  }
  close(open("usertests.ran", O_CREATE));
    4152:	20000593          	li	a1,512
    4156:	00002517          	auipc	a0,0x2
    415a:	78250513          	addi	a0,a0,1922 # 68d8 <malloc+0x1ec6>
    415e:	00000097          	auipc	ra,0x0
    4162:	39e080e7          	jalr	926(ra) # 44fc <open>
    4166:	00000097          	auipc	ra,0x0
    416a:	2ba080e7          	jalr	698(ra) # 4420 <close>

  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    416e:	cd843903          	ld	s2,-808(s0)
    4172:	04090963          	beqz	s2,41c4 <main+0x118>
    4176:	cd040493          	addi	s1,s0,-816
  int fail = 0;
    417a:	4a01                	li	s4,0
    if((n == 0) || strcmp(t->s, n) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    417c:	4a85                	li	s5,1
    417e:	a031                	j	418a <main+0xde>
  for (struct test *t = tests; t->s != 0; t++) {
    4180:	04c1                	addi	s1,s1,16
    4182:	0084b903          	ld	s2,8(s1)
    4186:	02090463          	beqz	s2,41ae <main+0x102>
    if((n == 0) || strcmp(t->s, n) == 0) {
    418a:	00098963          	beqz	s3,419c <main+0xf0>
    418e:	85ce                	mv	a1,s3
    4190:	854a                	mv	a0,s2
    4192:	00000097          	auipc	ra,0x0
    4196:	068080e7          	jalr	104(ra) # 41fa <strcmp>
    419a:	f17d                	bnez	a0,4180 <main+0xd4>
      if(!run(t->f, t->s))
    419c:	85ca                	mv	a1,s2
    419e:	6088                	ld	a0,0(s1)
    41a0:	00000097          	auipc	ra,0x0
    41a4:	e6a080e7          	jalr	-406(ra) # 400a <run>
    41a8:	fd61                	bnez	a0,4180 <main+0xd4>
        fail = 1;
    41aa:	8a56                	mv	s4,s5
    41ac:	bfd1                	j	4180 <main+0xd4>
    }
  }
  if(!fail)
    41ae:	000a0b63          	beqz	s4,41c4 <main+0x118>
    printf("ALL TESTS PASSED\n");
  else
    printf("SOME TESTS FAILED\n");
    41b2:	00002517          	auipc	a0,0x2
    41b6:	79650513          	addi	a0,a0,1942 # 6948 <malloc+0x1f36>
    41ba:	00000097          	auipc	ra,0x0
    41be:	798080e7          	jalr	1944(ra) # 4952 <printf>
    41c2:	a809                	j	41d4 <main+0x128>
    printf("ALL TESTS PASSED\n");
    41c4:	00002517          	auipc	a0,0x2
    41c8:	76c50513          	addi	a0,a0,1900 # 6930 <malloc+0x1f1e>
    41cc:	00000097          	auipc	ra,0x0
    41d0:	786080e7          	jalr	1926(ra) # 4952 <printf>
  exit(1);   // not reached.
    41d4:	4505                	li	a0,1
    41d6:	00000097          	auipc	ra,0x0
    41da:	2e6080e7          	jalr	742(ra) # 44bc <exit>

00000000000041de <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    41de:	1141                	addi	sp,sp,-16
    41e0:	e422                	sd	s0,8(sp)
    41e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    41e4:	87aa                	mv	a5,a0
    41e6:	0585                	addi	a1,a1,1
    41e8:	0785                	addi	a5,a5,1
    41ea:	fff5c703          	lbu	a4,-1(a1)
    41ee:	fee78fa3          	sb	a4,-1(a5)
    41f2:	fb75                	bnez	a4,41e6 <strcpy+0x8>
    ;
  return os;
}
    41f4:	6422                	ld	s0,8(sp)
    41f6:	0141                	addi	sp,sp,16
    41f8:	8082                	ret

00000000000041fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    41fa:	1141                	addi	sp,sp,-16
    41fc:	e422                	sd	s0,8(sp)
    41fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    4200:	00054783          	lbu	a5,0(a0)
    4204:	cf91                	beqz	a5,4220 <strcmp+0x26>
    4206:	0005c703          	lbu	a4,0(a1)
    420a:	00f71b63          	bne	a4,a5,4220 <strcmp+0x26>
    p++, q++;
    420e:	0505                	addi	a0,a0,1
    4210:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    4212:	00054783          	lbu	a5,0(a0)
    4216:	c789                	beqz	a5,4220 <strcmp+0x26>
    4218:	0005c703          	lbu	a4,0(a1)
    421c:	fef709e3          	beq	a4,a5,420e <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
    4220:	0005c503          	lbu	a0,0(a1)
}
    4224:	40a7853b          	subw	a0,a5,a0
    4228:	6422                	ld	s0,8(sp)
    422a:	0141                	addi	sp,sp,16
    422c:	8082                	ret

000000000000422e <strlen>:

uint
strlen(const char *s)
{
    422e:	1141                	addi	sp,sp,-16
    4230:	e422                	sd	s0,8(sp)
    4232:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4234:	00054783          	lbu	a5,0(a0)
    4238:	cf91                	beqz	a5,4254 <strlen+0x26>
    423a:	0505                	addi	a0,a0,1
    423c:	87aa                	mv	a5,a0
    423e:	4685                	li	a3,1
    4240:	9e89                	subw	a3,a3,a0
    4242:	00f6853b          	addw	a0,a3,a5
    4246:	0785                	addi	a5,a5,1
    4248:	fff7c703          	lbu	a4,-1(a5)
    424c:	fb7d                	bnez	a4,4242 <strlen+0x14>
    ;
  return n;
}
    424e:	6422                	ld	s0,8(sp)
    4250:	0141                	addi	sp,sp,16
    4252:	8082                	ret
  for(n = 0; s[n]; n++)
    4254:	4501                	li	a0,0
    4256:	bfe5                	j	424e <strlen+0x20>

0000000000004258 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4258:	1141                	addi	sp,sp,-16
    425a:	e422                	sd	s0,8(sp)
    425c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    425e:	ce09                	beqz	a2,4278 <memset+0x20>
    4260:	87aa                	mv	a5,a0
    4262:	fff6071b          	addiw	a4,a2,-1
    4266:	1702                	slli	a4,a4,0x20
    4268:	9301                	srli	a4,a4,0x20
    426a:	0705                	addi	a4,a4,1
    426c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    426e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4272:	0785                	addi	a5,a5,1
    4274:	fee79de3          	bne	a5,a4,426e <memset+0x16>
  }
  return dst;
}
    4278:	6422                	ld	s0,8(sp)
    427a:	0141                	addi	sp,sp,16
    427c:	8082                	ret

000000000000427e <strchr>:

char*
strchr(const char *s, char c)
{
    427e:	1141                	addi	sp,sp,-16
    4280:	e422                	sd	s0,8(sp)
    4282:	0800                	addi	s0,sp,16
  for(; *s; s++)
    4284:	00054783          	lbu	a5,0(a0)
    4288:	cf91                	beqz	a5,42a4 <strchr+0x26>
    if(*s == c)
    428a:	00f58a63          	beq	a1,a5,429e <strchr+0x20>
  for(; *s; s++)
    428e:	0505                	addi	a0,a0,1
    4290:	00054783          	lbu	a5,0(a0)
    4294:	c781                	beqz	a5,429c <strchr+0x1e>
    if(*s == c)
    4296:	feb79ce3          	bne	a5,a1,428e <strchr+0x10>
    429a:	a011                	j	429e <strchr+0x20>
      return (char*)s;
  return 0;
    429c:	4501                	li	a0,0
}
    429e:	6422                	ld	s0,8(sp)
    42a0:	0141                	addi	sp,sp,16
    42a2:	8082                	ret
  return 0;
    42a4:	4501                	li	a0,0
    42a6:	bfe5                	j	429e <strchr+0x20>

00000000000042a8 <gets>:

char*
gets(char *buf, int max)
{
    42a8:	711d                	addi	sp,sp,-96
    42aa:	ec86                	sd	ra,88(sp)
    42ac:	e8a2                	sd	s0,80(sp)
    42ae:	e4a6                	sd	s1,72(sp)
    42b0:	e0ca                	sd	s2,64(sp)
    42b2:	fc4e                	sd	s3,56(sp)
    42b4:	f852                	sd	s4,48(sp)
    42b6:	f456                	sd	s5,40(sp)
    42b8:	f05a                	sd	s6,32(sp)
    42ba:	ec5e                	sd	s7,24(sp)
    42bc:	1080                	addi	s0,sp,96
    42be:	8baa                	mv	s7,a0
    42c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    42c2:	892a                	mv	s2,a0
    42c4:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    42c6:	4aa9                	li	s5,10
    42c8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    42ca:	0019849b          	addiw	s1,s3,1
    42ce:	0344d863          	ble	s4,s1,42fe <gets+0x56>
    cc = read(0, &c, 1);
    42d2:	4605                	li	a2,1
    42d4:	faf40593          	addi	a1,s0,-81
    42d8:	4501                	li	a0,0
    42da:	00000097          	auipc	ra,0x0
    42de:	1fa080e7          	jalr	506(ra) # 44d4 <read>
    if(cc < 1)
    42e2:	00a05e63          	blez	a0,42fe <gets+0x56>
    buf[i++] = c;
    42e6:	faf44783          	lbu	a5,-81(s0)
    42ea:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    42ee:	01578763          	beq	a5,s5,42fc <gets+0x54>
    42f2:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
    42f4:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
    42f6:	fd679ae3          	bne	a5,s6,42ca <gets+0x22>
    42fa:	a011                	j	42fe <gets+0x56>
  for(i=0; i+1 < max; ){
    42fc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    42fe:	99de                	add	s3,s3,s7
    4300:	00098023          	sb	zero,0(s3)
  return buf;
}
    4304:	855e                	mv	a0,s7
    4306:	60e6                	ld	ra,88(sp)
    4308:	6446                	ld	s0,80(sp)
    430a:	64a6                	ld	s1,72(sp)
    430c:	6906                	ld	s2,64(sp)
    430e:	79e2                	ld	s3,56(sp)
    4310:	7a42                	ld	s4,48(sp)
    4312:	7aa2                	ld	s5,40(sp)
    4314:	7b02                	ld	s6,32(sp)
    4316:	6be2                	ld	s7,24(sp)
    4318:	6125                	addi	sp,sp,96
    431a:	8082                	ret

000000000000431c <atoi>:
  return r;
}

int
atoi(const char *s)
{
    431c:	1141                	addi	sp,sp,-16
    431e:	e422                	sd	s0,8(sp)
    4320:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4322:	00054683          	lbu	a3,0(a0)
    4326:	fd06879b          	addiw	a5,a3,-48
    432a:	0ff7f793          	andi	a5,a5,255
    432e:	4725                	li	a4,9
    4330:	02f76963          	bltu	a4,a5,4362 <atoi+0x46>
    4334:	862a                	mv	a2,a0
  n = 0;
    4336:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    4338:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    433a:	0605                	addi	a2,a2,1
    433c:	0025179b          	slliw	a5,a0,0x2
    4340:	9fa9                	addw	a5,a5,a0
    4342:	0017979b          	slliw	a5,a5,0x1
    4346:	9fb5                	addw	a5,a5,a3
    4348:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    434c:	00064683          	lbu	a3,0(a2) # 1000 <writetest+0xb6>
    4350:	fd06871b          	addiw	a4,a3,-48
    4354:	0ff77713          	andi	a4,a4,255
    4358:	fee5f1e3          	bleu	a4,a1,433a <atoi+0x1e>
  return n;
}
    435c:	6422                	ld	s0,8(sp)
    435e:	0141                	addi	sp,sp,16
    4360:	8082                	ret
  n = 0;
    4362:	4501                	li	a0,0
    4364:	bfe5                	j	435c <atoi+0x40>

0000000000004366 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4366:	1141                	addi	sp,sp,-16
    4368:	e422                	sd	s0,8(sp)
    436a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    436c:	02b57663          	bleu	a1,a0,4398 <memmove+0x32>
    while(n-- > 0)
    4370:	02c05163          	blez	a2,4392 <memmove+0x2c>
    4374:	fff6079b          	addiw	a5,a2,-1
    4378:	1782                	slli	a5,a5,0x20
    437a:	9381                	srli	a5,a5,0x20
    437c:	0785                	addi	a5,a5,1
    437e:	97aa                	add	a5,a5,a0
  dst = vdst;
    4380:	872a                	mv	a4,a0
      *dst++ = *src++;
    4382:	0585                	addi	a1,a1,1
    4384:	0705                	addi	a4,a4,1
    4386:	fff5c683          	lbu	a3,-1(a1)
    438a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    438e:	fee79ae3          	bne	a5,a4,4382 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4392:	6422                	ld	s0,8(sp)
    4394:	0141                	addi	sp,sp,16
    4396:	8082                	ret
    dst += n;
    4398:	00c50733          	add	a4,a0,a2
    src += n;
    439c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    439e:	fec05ae3          	blez	a2,4392 <memmove+0x2c>
    43a2:	fff6079b          	addiw	a5,a2,-1
    43a6:	1782                	slli	a5,a5,0x20
    43a8:	9381                	srli	a5,a5,0x20
    43aa:	fff7c793          	not	a5,a5
    43ae:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    43b0:	15fd                	addi	a1,a1,-1
    43b2:	177d                	addi	a4,a4,-1
    43b4:	0005c683          	lbu	a3,0(a1)
    43b8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    43bc:	fef71ae3          	bne	a4,a5,43b0 <memmove+0x4a>
    43c0:	bfc9                	j	4392 <memmove+0x2c>

00000000000043c2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    43c2:	1141                	addi	sp,sp,-16
    43c4:	e422                	sd	s0,8(sp)
    43c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    43c8:	ce15                	beqz	a2,4404 <memcmp+0x42>
    43ca:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
    43ce:	00054783          	lbu	a5,0(a0)
    43d2:	0005c703          	lbu	a4,0(a1)
    43d6:	02e79063          	bne	a5,a4,43f6 <memcmp+0x34>
    43da:	1682                	slli	a3,a3,0x20
    43dc:	9281                	srli	a3,a3,0x20
    43de:	0685                	addi	a3,a3,1
    43e0:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
    43e2:	0505                	addi	a0,a0,1
    p2++;
    43e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    43e6:	00d50d63          	beq	a0,a3,4400 <memcmp+0x3e>
    if (*p1 != *p2) {
    43ea:	00054783          	lbu	a5,0(a0)
    43ee:	0005c703          	lbu	a4,0(a1)
    43f2:	fee788e3          	beq	a5,a4,43e2 <memcmp+0x20>
      return *p1 - *p2;
    43f6:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
    43fa:	6422                	ld	s0,8(sp)
    43fc:	0141                	addi	sp,sp,16
    43fe:	8082                	ret
  return 0;
    4400:	4501                	li	a0,0
    4402:	bfe5                	j	43fa <memcmp+0x38>
    4404:	4501                	li	a0,0
    4406:	bfd5                	j	43fa <memcmp+0x38>

0000000000004408 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4408:	1141                	addi	sp,sp,-16
    440a:	e406                	sd	ra,8(sp)
    440c:	e022                	sd	s0,0(sp)
    440e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    4410:	00000097          	auipc	ra,0x0
    4414:	f56080e7          	jalr	-170(ra) # 4366 <memmove>
}
    4418:	60a2                	ld	ra,8(sp)
    441a:	6402                	ld	s0,0(sp)
    441c:	0141                	addi	sp,sp,16
    441e:	8082                	ret

0000000000004420 <close>:

int close(int fd){
    4420:	1101                	addi	sp,sp,-32
    4422:	ec06                	sd	ra,24(sp)
    4424:	e822                	sd	s0,16(sp)
    4426:	e426                	sd	s1,8(sp)
    4428:	1000                	addi	s0,sp,32
    442a:	84aa                	mv	s1,a0
  fflush(fd);
    442c:	00000097          	auipc	ra,0x0
    4430:	2da080e7          	jalr	730(ra) # 4706 <fflush>
  char* buf = get_putc_buf(fd);
    4434:	8526                	mv	a0,s1
    4436:	00000097          	auipc	ra,0x0
    443a:	14e080e7          	jalr	334(ra) # 4584 <get_putc_buf>
  if(buf){
    443e:	cd11                	beqz	a0,445a <close+0x3a>
    free(buf);
    4440:	00000097          	auipc	ra,0x0
    4444:	548080e7          	jalr	1352(ra) # 4988 <free>
    putc_buf[fd] = 0;
    4448:	00349713          	slli	a4,s1,0x3
    444c:	00008797          	auipc	a5,0x8
    4450:	f9478793          	addi	a5,a5,-108 # c3e0 <putc_buf>
    4454:	97ba                	add	a5,a5,a4
    4456:	0007b023          	sd	zero,0(a5)
  }
  return sclose(fd);
    445a:	8526                	mv	a0,s1
    445c:	00000097          	auipc	ra,0x0
    4460:	088080e7          	jalr	136(ra) # 44e4 <sclose>
}
    4464:	60e2                	ld	ra,24(sp)
    4466:	6442                	ld	s0,16(sp)
    4468:	64a2                	ld	s1,8(sp)
    446a:	6105                	addi	sp,sp,32
    446c:	8082                	ret

000000000000446e <stat>:
{
    446e:	1101                	addi	sp,sp,-32
    4470:	ec06                	sd	ra,24(sp)
    4472:	e822                	sd	s0,16(sp)
    4474:	e426                	sd	s1,8(sp)
    4476:	e04a                	sd	s2,0(sp)
    4478:	1000                	addi	s0,sp,32
    447a:	892e                	mv	s2,a1
  fd = open(n, O_RDONLY);
    447c:	4581                	li	a1,0
    447e:	00000097          	auipc	ra,0x0
    4482:	07e080e7          	jalr	126(ra) # 44fc <open>
  if(fd < 0)
    4486:	02054563          	bltz	a0,44b0 <stat+0x42>
    448a:	84aa                	mv	s1,a0
  r = fstat(fd, st);
    448c:	85ca                	mv	a1,s2
    448e:	00000097          	auipc	ra,0x0
    4492:	086080e7          	jalr	134(ra) # 4514 <fstat>
    4496:	892a                	mv	s2,a0
  close(fd);
    4498:	8526                	mv	a0,s1
    449a:	00000097          	auipc	ra,0x0
    449e:	f86080e7          	jalr	-122(ra) # 4420 <close>
}
    44a2:	854a                	mv	a0,s2
    44a4:	60e2                	ld	ra,24(sp)
    44a6:	6442                	ld	s0,16(sp)
    44a8:	64a2                	ld	s1,8(sp)
    44aa:	6902                	ld	s2,0(sp)
    44ac:	6105                	addi	sp,sp,32
    44ae:	8082                	ret
    return -1;
    44b0:	597d                	li	s2,-1
    44b2:	bfc5                	j	44a2 <stat+0x34>

00000000000044b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    44b4:	4885                	li	a7,1
 ecall
    44b6:	00000073          	ecall
 ret
    44ba:	8082                	ret

00000000000044bc <exit>:
.global exit
exit:
 li a7, SYS_exit
    44bc:	4889                	li	a7,2
 ecall
    44be:	00000073          	ecall
 ret
    44c2:	8082                	ret

00000000000044c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
    44c4:	488d                	li	a7,3
 ecall
    44c6:	00000073          	ecall
 ret
    44ca:	8082                	ret

00000000000044cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    44cc:	4891                	li	a7,4
 ecall
    44ce:	00000073          	ecall
 ret
    44d2:	8082                	ret

00000000000044d4 <read>:
.global read
read:
 li a7, SYS_read
    44d4:	4895                	li	a7,5
 ecall
    44d6:	00000073          	ecall
 ret
    44da:	8082                	ret

00000000000044dc <write>:
.global write
write:
 li a7, SYS_write
    44dc:	48c1                	li	a7,16
 ecall
    44de:	00000073          	ecall
 ret
    44e2:	8082                	ret

00000000000044e4 <sclose>:
.global sclose
sclose:
 li a7, SYS_close
    44e4:	48d5                	li	a7,21
 ecall
    44e6:	00000073          	ecall
 ret
    44ea:	8082                	ret

00000000000044ec <kill>:
.global kill
kill:
 li a7, SYS_kill
    44ec:	4899                	li	a7,6
 ecall
    44ee:	00000073          	ecall
 ret
    44f2:	8082                	ret

00000000000044f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
    44f4:	489d                	li	a7,7
 ecall
    44f6:	00000073          	ecall
 ret
    44fa:	8082                	ret

00000000000044fc <open>:
.global open
open:
 li a7, SYS_open
    44fc:	48bd                	li	a7,15
 ecall
    44fe:	00000073          	ecall
 ret
    4502:	8082                	ret

0000000000004504 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4504:	48c5                	li	a7,17
 ecall
    4506:	00000073          	ecall
 ret
    450a:	8082                	ret

000000000000450c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    450c:	48c9                	li	a7,18
 ecall
    450e:	00000073          	ecall
 ret
    4512:	8082                	ret

0000000000004514 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4514:	48a1                	li	a7,8
 ecall
    4516:	00000073          	ecall
 ret
    451a:	8082                	ret

000000000000451c <link>:
.global link
link:
 li a7, SYS_link
    451c:	48cd                	li	a7,19
 ecall
    451e:	00000073          	ecall
 ret
    4522:	8082                	ret

0000000000004524 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4524:	48d1                	li	a7,20
 ecall
    4526:	00000073          	ecall
 ret
    452a:	8082                	ret

000000000000452c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    452c:	48a5                	li	a7,9
 ecall
    452e:	00000073          	ecall
 ret
    4532:	8082                	ret

0000000000004534 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4534:	48a9                	li	a7,10
 ecall
    4536:	00000073          	ecall
 ret
    453a:	8082                	ret

000000000000453c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    453c:	48ad                	li	a7,11
 ecall
    453e:	00000073          	ecall
 ret
    4542:	8082                	ret

0000000000004544 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    4544:	48b1                	li	a7,12
 ecall
    4546:	00000073          	ecall
 ret
    454a:	8082                	ret

000000000000454c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    454c:	48b5                	li	a7,13
 ecall
    454e:	00000073          	ecall
 ret
    4552:	8082                	ret

0000000000004554 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4554:	48b9                	li	a7,14
 ecall
    4556:	00000073          	ecall
 ret
    455a:	8082                	ret

000000000000455c <ntas>:
.global ntas
ntas:
 li a7, SYS_ntas
    455c:	48d9                	li	a7,22
 ecall
    455e:	00000073          	ecall
 ret
    4562:	8082                	ret

0000000000004564 <nice>:
.global nice
nice:
 li a7, SYS_nice
    4564:	48dd                	li	a7,23
 ecall
    4566:	00000073          	ecall
 ret
    456a:	8082                	ret

000000000000456c <create_mutex>:
.global create_mutex
create_mutex:
 li a7, SYS_create_mutex
    456c:	48e1                	li	a7,24
 ecall
    456e:	00000073          	ecall
 ret
    4572:	8082                	ret

0000000000004574 <acquire_mutex>:
.global acquire_mutex
acquire_mutex:
 li a7, SYS_acquire_mutex
    4574:	48e5                	li	a7,25
 ecall
    4576:	00000073          	ecall
 ret
    457a:	8082                	ret

000000000000457c <release_mutex>:
.global release_mutex
release_mutex:
 li a7, SYS_release_mutex
    457c:	48e9                	li	a7,26
 ecall
    457e:	00000073          	ecall
 ret
    4582:	8082                	ret

0000000000004584 <get_putc_buf>:
static char digits[] = "0123456789ABCDEF";

char* putc_buf[NFILE];
int putc_index[NFILE];

char* get_putc_buf(int fd){
    4584:	1101                	addi	sp,sp,-32
    4586:	ec06                	sd	ra,24(sp)
    4588:	e822                	sd	s0,16(sp)
    458a:	e426                	sd	s1,8(sp)
    458c:	1000                	addi	s0,sp,32
    458e:	84aa                	mv	s1,a0
  char* buf = putc_buf[fd];
    4590:	00351693          	slli	a3,a0,0x3
    4594:	00008797          	auipc	a5,0x8
    4598:	e4c78793          	addi	a5,a5,-436 # c3e0 <putc_buf>
    459c:	97b6                	add	a5,a5,a3
    459e:	6388                	ld	a0,0(a5)
  if(buf) {
    45a0:	c511                	beqz	a0,45ac <get_putc_buf+0x28>
  }
  buf = malloc(PUTC_BUF_LEN);
  putc_buf[fd] = buf;
  putc_index[fd] = 0;
  return buf;
}
    45a2:	60e2                	ld	ra,24(sp)
    45a4:	6442                	ld	s0,16(sp)
    45a6:	64a2                	ld	s1,8(sp)
    45a8:	6105                	addi	sp,sp,32
    45aa:	8082                	ret
  buf = malloc(PUTC_BUF_LEN);
    45ac:	6505                	lui	a0,0x1
    45ae:	00000097          	auipc	ra,0x0
    45b2:	464080e7          	jalr	1124(ra) # 4a12 <malloc>
  putc_buf[fd] = buf;
    45b6:	00008797          	auipc	a5,0x8
    45ba:	e2a78793          	addi	a5,a5,-470 # c3e0 <putc_buf>
    45be:	00349713          	slli	a4,s1,0x3
    45c2:	973e                	add	a4,a4,a5
    45c4:	e308                	sd	a0,0(a4)
  putc_index[fd] = 0;
    45c6:	00249713          	slli	a4,s1,0x2
    45ca:	973e                	add	a4,a4,a5
    45cc:	32072023          	sw	zero,800(a4)
  return buf;
    45d0:	bfc9                	j	45a2 <get_putc_buf+0x1e>

00000000000045d2 <putc>:

static void
putc(int fd, char c)
{
    45d2:	1101                	addi	sp,sp,-32
    45d4:	ec06                	sd	ra,24(sp)
    45d6:	e822                	sd	s0,16(sp)
    45d8:	e426                	sd	s1,8(sp)
    45da:	e04a                	sd	s2,0(sp)
    45dc:	1000                	addi	s0,sp,32
    45de:	84aa                	mv	s1,a0
    45e0:	892e                	mv	s2,a1
  char* buf = get_putc_buf(fd);
    45e2:	00000097          	auipc	ra,0x0
    45e6:	fa2080e7          	jalr	-94(ra) # 4584 <get_putc_buf>
  buf[putc_index[fd]++] = c;
    45ea:	00249793          	slli	a5,s1,0x2
    45ee:	00008717          	auipc	a4,0x8
    45f2:	df270713          	addi	a4,a4,-526 # c3e0 <putc_buf>
    45f6:	973e                	add	a4,a4,a5
    45f8:	32072783          	lw	a5,800(a4)
    45fc:	0017869b          	addiw	a3,a5,1
    4600:	32d72023          	sw	a3,800(a4)
    4604:	97aa                	add	a5,a5,a0
    4606:	01278023          	sb	s2,0(a5)
  if(c == '\n' || putc_index[fd] == PUTC_BUF_LEN){
    460a:	47a9                	li	a5,10
    460c:	02f90463          	beq	s2,a5,4634 <putc+0x62>
    4610:	00249713          	slli	a4,s1,0x2
    4614:	00008797          	auipc	a5,0x8
    4618:	dcc78793          	addi	a5,a5,-564 # c3e0 <putc_buf>
    461c:	97ba                	add	a5,a5,a4
    461e:	3207a703          	lw	a4,800(a5)
    4622:	6785                	lui	a5,0x1
    4624:	00f70863          	beq	a4,a5,4634 <putc+0x62>
    write(fd, buf, putc_index[fd]);
    putc_index[fd] = 0;
  }
  //write(fd, &c, 1);
}
    4628:	60e2                	ld	ra,24(sp)
    462a:	6442                	ld	s0,16(sp)
    462c:	64a2                	ld	s1,8(sp)
    462e:	6902                	ld	s2,0(sp)
    4630:	6105                	addi	sp,sp,32
    4632:	8082                	ret
    write(fd, buf, putc_index[fd]);
    4634:	00249793          	slli	a5,s1,0x2
    4638:	00008917          	auipc	s2,0x8
    463c:	da890913          	addi	s2,s2,-600 # c3e0 <putc_buf>
    4640:	993e                	add	s2,s2,a5
    4642:	32092603          	lw	a2,800(s2)
    4646:	85aa                	mv	a1,a0
    4648:	8526                	mv	a0,s1
    464a:	00000097          	auipc	ra,0x0
    464e:	e92080e7          	jalr	-366(ra) # 44dc <write>
    putc_index[fd] = 0;
    4652:	32092023          	sw	zero,800(s2)
}
    4656:	bfc9                	j	4628 <putc+0x56>

0000000000004658 <printint>:
  putc_index[fd] = 0;
}

static void
printint(int fd, int xx, int base, int sgn)
{
    4658:	7139                	addi	sp,sp,-64
    465a:	fc06                	sd	ra,56(sp)
    465c:	f822                	sd	s0,48(sp)
    465e:	f426                	sd	s1,40(sp)
    4660:	f04a                	sd	s2,32(sp)
    4662:	ec4e                	sd	s3,24(sp)
    4664:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4666:	c299                	beqz	a3,466c <printint+0x14>
    4668:	0005cd63          	bltz	a1,4682 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    466c:	2581                	sext.w	a1,a1
  neg = 0;
    466e:	4301                	li	t1,0
    4670:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
    4674:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
    4676:	2601                	sext.w	a2,a2
    4678:	00002897          	auipc	a7,0x2
    467c:	51888893          	addi	a7,a7,1304 # 6b90 <digits>
    4680:	a801                	j	4690 <printint+0x38>
    x = -xx;
    4682:	40b005bb          	negw	a1,a1
    4686:	2581                	sext.w	a1,a1
    neg = 1;
    4688:	4305                	li	t1,1
    x = -xx;
    468a:	b7dd                	j	4670 <printint+0x18>
  }while((x /= base) != 0);
    468c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
    468e:	8836                	mv	a6,a3
    4690:	0018069b          	addiw	a3,a6,1
    4694:	02c5f7bb          	remuw	a5,a1,a2
    4698:	1782                	slli	a5,a5,0x20
    469a:	9381                	srli	a5,a5,0x20
    469c:	97c6                	add	a5,a5,a7
    469e:	0007c783          	lbu	a5,0(a5) # 1000 <writetest+0xb6>
    46a2:	00f70023          	sb	a5,0(a4)
  }while((x /= base) != 0);
    46a6:	0705                	addi	a4,a4,1
    46a8:	02c5d7bb          	divuw	a5,a1,a2
    46ac:	fec5f0e3          	bleu	a2,a1,468c <printint+0x34>
  if(neg)
    46b0:	00030b63          	beqz	t1,46c6 <printint+0x6e>
    buf[i++] = '-';
    46b4:	fd040793          	addi	a5,s0,-48
    46b8:	96be                	add	a3,a3,a5
    46ba:	02d00793          	li	a5,45
    46be:	fef68823          	sb	a5,-16(a3) # ff0 <writetest+0xa6>
    46c2:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
    46c6:	02d05963          	blez	a3,46f8 <printint+0xa0>
    46ca:	89aa                	mv	s3,a0
    46cc:	fc040793          	addi	a5,s0,-64
    46d0:	00d784b3          	add	s1,a5,a3
    46d4:	fff78913          	addi	s2,a5,-1
    46d8:	9936                	add	s2,s2,a3
    46da:	36fd                	addiw	a3,a3,-1
    46dc:	1682                	slli	a3,a3,0x20
    46de:	9281                	srli	a3,a3,0x20
    46e0:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
    46e4:	fff4c583          	lbu	a1,-1(s1)
    46e8:	854e                	mv	a0,s3
    46ea:	00000097          	auipc	ra,0x0
    46ee:	ee8080e7          	jalr	-280(ra) # 45d2 <putc>
  while(--i >= 0)
    46f2:	14fd                	addi	s1,s1,-1
    46f4:	ff2498e3          	bne	s1,s2,46e4 <printint+0x8c>
}
    46f8:	70e2                	ld	ra,56(sp)
    46fa:	7442                	ld	s0,48(sp)
    46fc:	74a2                	ld	s1,40(sp)
    46fe:	7902                	ld	s2,32(sp)
    4700:	69e2                	ld	s3,24(sp)
    4702:	6121                	addi	sp,sp,64
    4704:	8082                	ret

0000000000004706 <fflush>:
void fflush(int fd){
    4706:	1101                	addi	sp,sp,-32
    4708:	ec06                	sd	ra,24(sp)
    470a:	e822                	sd	s0,16(sp)
    470c:	e426                	sd	s1,8(sp)
    470e:	e04a                	sd	s2,0(sp)
    4710:	1000                	addi	s0,sp,32
    4712:	892a                	mv	s2,a0
  char* buf = get_putc_buf(fd);
    4714:	00000097          	auipc	ra,0x0
    4718:	e70080e7          	jalr	-400(ra) # 4584 <get_putc_buf>
  write(fd, buf, putc_index[fd]);
    471c:	00291793          	slli	a5,s2,0x2
    4720:	00008497          	auipc	s1,0x8
    4724:	cc048493          	addi	s1,s1,-832 # c3e0 <putc_buf>
    4728:	94be                	add	s1,s1,a5
    472a:	3204a603          	lw	a2,800(s1)
    472e:	85aa                	mv	a1,a0
    4730:	854a                	mv	a0,s2
    4732:	00000097          	auipc	ra,0x0
    4736:	daa080e7          	jalr	-598(ra) # 44dc <write>
  putc_index[fd] = 0;
    473a:	3204a023          	sw	zero,800(s1)
}
    473e:	60e2                	ld	ra,24(sp)
    4740:	6442                	ld	s0,16(sp)
    4742:	64a2                	ld	s1,8(sp)
    4744:	6902                	ld	s2,0(sp)
    4746:	6105                	addi	sp,sp,32
    4748:	8082                	ret

000000000000474a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    474a:	7119                	addi	sp,sp,-128
    474c:	fc86                	sd	ra,120(sp)
    474e:	f8a2                	sd	s0,112(sp)
    4750:	f4a6                	sd	s1,104(sp)
    4752:	f0ca                	sd	s2,96(sp)
    4754:	ecce                	sd	s3,88(sp)
    4756:	e8d2                	sd	s4,80(sp)
    4758:	e4d6                	sd	s5,72(sp)
    475a:	e0da                	sd	s6,64(sp)
    475c:	fc5e                	sd	s7,56(sp)
    475e:	f862                	sd	s8,48(sp)
    4760:	f466                	sd	s9,40(sp)
    4762:	f06a                	sd	s10,32(sp)
    4764:	ec6e                	sd	s11,24(sp)
    4766:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4768:	0005c483          	lbu	s1,0(a1)
    476c:	18048d63          	beqz	s1,4906 <vprintf+0x1bc>
    4770:	8aaa                	mv	s5,a0
    4772:	8b32                	mv	s6,a2
    4774:	00158913          	addi	s2,a1,1
  state = 0;
    4778:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    477a:	02500a13          	li	s4,37
      if(c == 'd'){
    477e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    4782:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    4786:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    478a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    478e:	00002b97          	auipc	s7,0x2
    4792:	402b8b93          	addi	s7,s7,1026 # 6b90 <digits>
    4796:	a839                	j	47b4 <vprintf+0x6a>
        putc(fd, c);
    4798:	85a6                	mv	a1,s1
    479a:	8556                	mv	a0,s5
    479c:	00000097          	auipc	ra,0x0
    47a0:	e36080e7          	jalr	-458(ra) # 45d2 <putc>
    47a4:	a019                	j	47aa <vprintf+0x60>
    } else if(state == '%'){
    47a6:	01498f63          	beq	s3,s4,47c4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    47aa:	0905                	addi	s2,s2,1
    47ac:	fff94483          	lbu	s1,-1(s2)
    47b0:	14048b63          	beqz	s1,4906 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    47b4:	0004879b          	sext.w	a5,s1
    if(state == 0){
    47b8:	fe0997e3          	bnez	s3,47a6 <vprintf+0x5c>
      if(c == '%'){
    47bc:	fd479ee3          	bne	a5,s4,4798 <vprintf+0x4e>
        state = '%';
    47c0:	89be                	mv	s3,a5
    47c2:	b7e5                	j	47aa <vprintf+0x60>
      if(c == 'd'){
    47c4:	05878063          	beq	a5,s8,4804 <vprintf+0xba>
      } else if(c == 'l') {
    47c8:	05978c63          	beq	a5,s9,4820 <vprintf+0xd6>
      } else if(c == 'x') {
    47cc:	07a78863          	beq	a5,s10,483c <vprintf+0xf2>
      } else if(c == 'p') {
    47d0:	09b78463          	beq	a5,s11,4858 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    47d4:	07300713          	li	a4,115
    47d8:	0ce78563          	beq	a5,a4,48a2 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    47dc:	06300713          	li	a4,99
    47e0:	0ee78c63          	beq	a5,a4,48d8 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    47e4:	11478663          	beq	a5,s4,48f0 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    47e8:	85d2                	mv	a1,s4
    47ea:	8556                	mv	a0,s5
    47ec:	00000097          	auipc	ra,0x0
    47f0:	de6080e7          	jalr	-538(ra) # 45d2 <putc>
        putc(fd, c);
    47f4:	85a6                	mv	a1,s1
    47f6:	8556                	mv	a0,s5
    47f8:	00000097          	auipc	ra,0x0
    47fc:	dda080e7          	jalr	-550(ra) # 45d2 <putc>
      }
      state = 0;
    4800:	4981                	li	s3,0
    4802:	b765                	j	47aa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    4804:	008b0493          	addi	s1,s6,8
    4808:	4685                	li	a3,1
    480a:	4629                	li	a2,10
    480c:	000b2583          	lw	a1,0(s6)
    4810:	8556                	mv	a0,s5
    4812:	00000097          	auipc	ra,0x0
    4816:	e46080e7          	jalr	-442(ra) # 4658 <printint>
    481a:	8b26                	mv	s6,s1
      state = 0;
    481c:	4981                	li	s3,0
    481e:	b771                	j	47aa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4820:	008b0493          	addi	s1,s6,8
    4824:	4681                	li	a3,0
    4826:	4629                	li	a2,10
    4828:	000b2583          	lw	a1,0(s6)
    482c:	8556                	mv	a0,s5
    482e:	00000097          	auipc	ra,0x0
    4832:	e2a080e7          	jalr	-470(ra) # 4658 <printint>
    4836:	8b26                	mv	s6,s1
      state = 0;
    4838:	4981                	li	s3,0
    483a:	bf85                	j	47aa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    483c:	008b0493          	addi	s1,s6,8
    4840:	4681                	li	a3,0
    4842:	4641                	li	a2,16
    4844:	000b2583          	lw	a1,0(s6)
    4848:	8556                	mv	a0,s5
    484a:	00000097          	auipc	ra,0x0
    484e:	e0e080e7          	jalr	-498(ra) # 4658 <printint>
    4852:	8b26                	mv	s6,s1
      state = 0;
    4854:	4981                	li	s3,0
    4856:	bf91                	j	47aa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    4858:	008b0793          	addi	a5,s6,8
    485c:	f8f43423          	sd	a5,-120(s0)
    4860:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    4864:	03000593          	li	a1,48
    4868:	8556                	mv	a0,s5
    486a:	00000097          	auipc	ra,0x0
    486e:	d68080e7          	jalr	-664(ra) # 45d2 <putc>
  putc(fd, 'x');
    4872:	85ea                	mv	a1,s10
    4874:	8556                	mv	a0,s5
    4876:	00000097          	auipc	ra,0x0
    487a:	d5c080e7          	jalr	-676(ra) # 45d2 <putc>
    487e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4880:	03c9d793          	srli	a5,s3,0x3c
    4884:	97de                	add	a5,a5,s7
    4886:	0007c583          	lbu	a1,0(a5)
    488a:	8556                	mv	a0,s5
    488c:	00000097          	auipc	ra,0x0
    4890:	d46080e7          	jalr	-698(ra) # 45d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    4894:	0992                	slli	s3,s3,0x4
    4896:	34fd                	addiw	s1,s1,-1
    4898:	f4e5                	bnez	s1,4880 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    489a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    489e:	4981                	li	s3,0
    48a0:	b729                	j	47aa <vprintf+0x60>
        s = va_arg(ap, char*);
    48a2:	008b0993          	addi	s3,s6,8
    48a6:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    48aa:	c085                	beqz	s1,48ca <vprintf+0x180>
        while(*s != 0){
    48ac:	0004c583          	lbu	a1,0(s1)
    48b0:	c9a1                	beqz	a1,4900 <vprintf+0x1b6>
          putc(fd, *s);
    48b2:	8556                	mv	a0,s5
    48b4:	00000097          	auipc	ra,0x0
    48b8:	d1e080e7          	jalr	-738(ra) # 45d2 <putc>
          s++;
    48bc:	0485                	addi	s1,s1,1
        while(*s != 0){
    48be:	0004c583          	lbu	a1,0(s1)
    48c2:	f9e5                	bnez	a1,48b2 <vprintf+0x168>
        s = va_arg(ap, char*);
    48c4:	8b4e                	mv	s6,s3
      state = 0;
    48c6:	4981                	li	s3,0
    48c8:	b5cd                	j	47aa <vprintf+0x60>
          s = "(null)";
    48ca:	00002497          	auipc	s1,0x2
    48ce:	2de48493          	addi	s1,s1,734 # 6ba8 <digits+0x18>
        while(*s != 0){
    48d2:	02800593          	li	a1,40
    48d6:	bff1                	j	48b2 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    48d8:	008b0493          	addi	s1,s6,8
    48dc:	000b4583          	lbu	a1,0(s6)
    48e0:	8556                	mv	a0,s5
    48e2:	00000097          	auipc	ra,0x0
    48e6:	cf0080e7          	jalr	-784(ra) # 45d2 <putc>
    48ea:	8b26                	mv	s6,s1
      state = 0;
    48ec:	4981                	li	s3,0
    48ee:	bd75                	j	47aa <vprintf+0x60>
        putc(fd, c);
    48f0:	85d2                	mv	a1,s4
    48f2:	8556                	mv	a0,s5
    48f4:	00000097          	auipc	ra,0x0
    48f8:	cde080e7          	jalr	-802(ra) # 45d2 <putc>
      state = 0;
    48fc:	4981                	li	s3,0
    48fe:	b575                	j	47aa <vprintf+0x60>
        s = va_arg(ap, char*);
    4900:	8b4e                	mv	s6,s3
      state = 0;
    4902:	4981                	li	s3,0
    4904:	b55d                	j	47aa <vprintf+0x60>
    }
  }
}
    4906:	70e6                	ld	ra,120(sp)
    4908:	7446                	ld	s0,112(sp)
    490a:	74a6                	ld	s1,104(sp)
    490c:	7906                	ld	s2,96(sp)
    490e:	69e6                	ld	s3,88(sp)
    4910:	6a46                	ld	s4,80(sp)
    4912:	6aa6                	ld	s5,72(sp)
    4914:	6b06                	ld	s6,64(sp)
    4916:	7be2                	ld	s7,56(sp)
    4918:	7c42                	ld	s8,48(sp)
    491a:	7ca2                	ld	s9,40(sp)
    491c:	7d02                	ld	s10,32(sp)
    491e:	6de2                	ld	s11,24(sp)
    4920:	6109                	addi	sp,sp,128
    4922:	8082                	ret

0000000000004924 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    4924:	715d                	addi	sp,sp,-80
    4926:	ec06                	sd	ra,24(sp)
    4928:	e822                	sd	s0,16(sp)
    492a:	1000                	addi	s0,sp,32
    492c:	e010                	sd	a2,0(s0)
    492e:	e414                	sd	a3,8(s0)
    4930:	e818                	sd	a4,16(s0)
    4932:	ec1c                	sd	a5,24(s0)
    4934:	03043023          	sd	a6,32(s0)
    4938:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    493c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    4940:	8622                	mv	a2,s0
    4942:	00000097          	auipc	ra,0x0
    4946:	e08080e7          	jalr	-504(ra) # 474a <vprintf>
}
    494a:	60e2                	ld	ra,24(sp)
    494c:	6442                	ld	s0,16(sp)
    494e:	6161                	addi	sp,sp,80
    4950:	8082                	ret

0000000000004952 <printf>:

void
printf(const char *fmt, ...)
{
    4952:	711d                	addi	sp,sp,-96
    4954:	ec06                	sd	ra,24(sp)
    4956:	e822                	sd	s0,16(sp)
    4958:	1000                	addi	s0,sp,32
    495a:	e40c                	sd	a1,8(s0)
    495c:	e810                	sd	a2,16(s0)
    495e:	ec14                	sd	a3,24(s0)
    4960:	f018                	sd	a4,32(s0)
    4962:	f41c                	sd	a5,40(s0)
    4964:	03043823          	sd	a6,48(s0)
    4968:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    496c:	00840613          	addi	a2,s0,8
    4970:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    4974:	85aa                	mv	a1,a0
    4976:	4505                	li	a0,1
    4978:	00000097          	auipc	ra,0x0
    497c:	dd2080e7          	jalr	-558(ra) # 474a <vprintf>
}
    4980:	60e2                	ld	ra,24(sp)
    4982:	6442                	ld	s0,16(sp)
    4984:	6125                	addi	sp,sp,96
    4986:	8082                	ret

0000000000004988 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4988:	1141                	addi	sp,sp,-16
    498a:	e422                	sd	s0,8(sp)
    498c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    498e:	ff050693          	addi	a3,a0,-16 # ff0 <writetest+0xa6>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4992:	00002797          	auipc	a5,0x2
    4996:	23678793          	addi	a5,a5,566 # 6bc8 <freep>
    499a:	639c                	ld	a5,0(a5)
    499c:	a805                	j	49cc <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    499e:	4618                	lw	a4,8(a2)
    49a0:	9db9                	addw	a1,a1,a4
    49a2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    49a6:	6398                	ld	a4,0(a5)
    49a8:	6318                	ld	a4,0(a4)
    49aa:	fee53823          	sd	a4,-16(a0)
    49ae:	a091                	j	49f2 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    49b0:	ff852703          	lw	a4,-8(a0)
    49b4:	9e39                	addw	a2,a2,a4
    49b6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    49b8:	ff053703          	ld	a4,-16(a0)
    49bc:	e398                	sd	a4,0(a5)
    49be:	a099                	j	4a04 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    49c0:	6398                	ld	a4,0(a5)
    49c2:	00e7e463          	bltu	a5,a4,49ca <free+0x42>
    49c6:	00e6ea63          	bltu	a3,a4,49da <free+0x52>
{
    49ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    49cc:	fed7fae3          	bleu	a3,a5,49c0 <free+0x38>
    49d0:	6398                	ld	a4,0(a5)
    49d2:	00e6e463          	bltu	a3,a4,49da <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    49d6:	fee7eae3          	bltu	a5,a4,49ca <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    49da:	ff852583          	lw	a1,-8(a0)
    49de:	6390                	ld	a2,0(a5)
    49e0:	02059713          	slli	a4,a1,0x20
    49e4:	9301                	srli	a4,a4,0x20
    49e6:	0712                	slli	a4,a4,0x4
    49e8:	9736                	add	a4,a4,a3
    49ea:	fae60ae3          	beq	a2,a4,499e <free+0x16>
    bp->s.ptr = p->s.ptr;
    49ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    49f2:	4790                	lw	a2,8(a5)
    49f4:	02061713          	slli	a4,a2,0x20
    49f8:	9301                	srli	a4,a4,0x20
    49fa:	0712                	slli	a4,a4,0x4
    49fc:	973e                	add	a4,a4,a5
    49fe:	fae689e3          	beq	a3,a4,49b0 <free+0x28>
  } else
    p->s.ptr = bp;
    4a02:	e394                	sd	a3,0(a5)
  freep = p;
    4a04:	00002717          	auipc	a4,0x2
    4a08:	1cf73223          	sd	a5,452(a4) # 6bc8 <freep>
}
    4a0c:	6422                	ld	s0,8(sp)
    4a0e:	0141                	addi	sp,sp,16
    4a10:	8082                	ret

0000000000004a12 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4a12:	7139                	addi	sp,sp,-64
    4a14:	fc06                	sd	ra,56(sp)
    4a16:	f822                	sd	s0,48(sp)
    4a18:	f426                	sd	s1,40(sp)
    4a1a:	f04a                	sd	s2,32(sp)
    4a1c:	ec4e                	sd	s3,24(sp)
    4a1e:	e852                	sd	s4,16(sp)
    4a20:	e456                	sd	s5,8(sp)
    4a22:	e05a                	sd	s6,0(sp)
    4a24:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4a26:	02051993          	slli	s3,a0,0x20
    4a2a:	0209d993          	srli	s3,s3,0x20
    4a2e:	09bd                	addi	s3,s3,15
    4a30:	0049d993          	srli	s3,s3,0x4
    4a34:	2985                	addiw	s3,s3,1
    4a36:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    4a3a:	00002797          	auipc	a5,0x2
    4a3e:	18e78793          	addi	a5,a5,398 # 6bc8 <freep>
    4a42:	6388                	ld	a0,0(a5)
    4a44:	c515                	beqz	a0,4a70 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4a46:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4a48:	4798                	lw	a4,8(a5)
    4a4a:	03277f63          	bleu	s2,a4,4a88 <malloc+0x76>
    4a4e:	8a4e                	mv	s4,s3
    4a50:	0009871b          	sext.w	a4,s3
    4a54:	6685                	lui	a3,0x1
    4a56:	00d77363          	bleu	a3,a4,4a5c <malloc+0x4a>
    4a5a:	6a05                	lui	s4,0x1
    4a5c:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    4a60:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4a64:	00002497          	auipc	s1,0x2
    4a68:	16448493          	addi	s1,s1,356 # 6bc8 <freep>
  if(p == (char*)-1)
    4a6c:	5b7d                	li	s6,-1
    4a6e:	a885                	j	4ade <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    4a70:	00008797          	auipc	a5,0x8
    4a74:	e2078793          	addi	a5,a5,-480 # c890 <base>
    4a78:	00002717          	auipc	a4,0x2
    4a7c:	14f73823          	sd	a5,336(a4) # 6bc8 <freep>
    4a80:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    4a82:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    4a86:	b7e1                	j	4a4e <malloc+0x3c>
      if(p->s.size == nunits)
    4a88:	02e90b63          	beq	s2,a4,4abe <malloc+0xac>
        p->s.size -= nunits;
    4a8c:	4137073b          	subw	a4,a4,s3
    4a90:	c798                	sw	a4,8(a5)
        p += p->s.size;
    4a92:	1702                	slli	a4,a4,0x20
    4a94:	9301                	srli	a4,a4,0x20
    4a96:	0712                	slli	a4,a4,0x4
    4a98:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    4a9a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    4a9e:	00002717          	auipc	a4,0x2
    4aa2:	12a73523          	sd	a0,298(a4) # 6bc8 <freep>
      return (void*)(p + 1);
    4aa6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    4aaa:	70e2                	ld	ra,56(sp)
    4aac:	7442                	ld	s0,48(sp)
    4aae:	74a2                	ld	s1,40(sp)
    4ab0:	7902                	ld	s2,32(sp)
    4ab2:	69e2                	ld	s3,24(sp)
    4ab4:	6a42                	ld	s4,16(sp)
    4ab6:	6aa2                	ld	s5,8(sp)
    4ab8:	6b02                	ld	s6,0(sp)
    4aba:	6121                	addi	sp,sp,64
    4abc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    4abe:	6398                	ld	a4,0(a5)
    4ac0:	e118                	sd	a4,0(a0)
    4ac2:	bff1                	j	4a9e <malloc+0x8c>
  hp->s.size = nu;
    4ac4:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    4ac8:	0541                	addi	a0,a0,16
    4aca:	00000097          	auipc	ra,0x0
    4ace:	ebe080e7          	jalr	-322(ra) # 4988 <free>
  return freep;
    4ad2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    4ad4:	d979                	beqz	a0,4aaa <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4ad6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4ad8:	4798                	lw	a4,8(a5)
    4ada:	fb2777e3          	bleu	s2,a4,4a88 <malloc+0x76>
    if(p == freep)
    4ade:	6098                	ld	a4,0(s1)
    4ae0:	853e                	mv	a0,a5
    4ae2:	fef71ae3          	bne	a4,a5,4ad6 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    4ae6:	8552                	mv	a0,s4
    4ae8:	00000097          	auipc	ra,0x0
    4aec:	a5c080e7          	jalr	-1444(ra) # 4544 <sbrk>
  if(p == (char*)-1)
    4af0:	fd651ae3          	bne	a0,s6,4ac4 <malloc+0xb2>
        return 0;
    4af4:	4501                	li	a0,0
    4af6:	bf55                	j	4aaa <malloc+0x98>
