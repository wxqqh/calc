CC=gcc

# 生成目录
GENDIR=./gen
DISTDIR=./dist
# 通过创建的目标文件的源文件名
# bison通过parser.y创建代码, flex通过lexer.y创建代码
# 这里配置的分别对应的名字
PARSER=parser
LEXER=lexer

# 生成最终目标
CFLAGS=-I$(GENDIR)
TARET=./app

# 因为这两个文件是通过创建出来的， make的时候还没有， 所以需要显式声明
GENFILE=$(GENDIR)/$(PARSER).c $(GENDIR)/$(LEXER).c

# 所有的源码文件
SRC=$(GENFILE) $(wildcard *.c)
#DIR=$(notdir $(SRC))
#OBJ=$(patsubst %.c,%.o,$(DIR))
# 所有的源码对应的obj(*.o)
OBJ=$(SRC:%.c=%.o)

# 构建所有， 生成app
all:$(TARET)
#@echo "build success!!"

$(TARET): $(OBJ)
	@echo " -> TARET " $<
	$(CC) $(CFLAGS) -o $(DISTDIR)/$(TARET) $(OBJ)

$(OBJ): %.o: %.c
	@echo " -> build " $<
	$(CC) -c $(CFLAGS) $< -o $@ 

# bison生成parser文件
$(GENDIR)/$(PARSER).c: $(PARSER).y
# bison -d --defines=${GENDIR}/$(PARSER).h -o ${GENDIR}/$(PARSER).cpp $(PARSER).y
	bison -d -o ${GENDIR}/$(PARSER).c $(PARSER).y
# flex生成lexer文件
$(GENDIR)/$(LEXER).c: $(LEXER).l
# flex -o ${GENDIR}/$(LEXER).c $(LEXER).l
	flex --header-file=${GENDIR}/$(LEXER).h -o ${GENDIR}/$(LEXER).c $(LEXER).l

# 生成parser和lexer文件
gen: $(GENFILE)

# 创建目录
dir:
	mkdir -p $(GENDIR) $(DISTDIR) 
# 生成检验demo
calc: $(GENFILE)
	$(CC) -D CALC_YY $(CFLAGS) $< -o $(DISTDIR)/$@ -lfl

clean:
	rm -f $(GENDIR)/*
	rm -f $(DISTDIR)/*
	rm -f $(OBJ)
	rm -f $(TARET)

.PHONY:clean gen dir calc
