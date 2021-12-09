library ieee;
use ieee.std_logic_1164.all; 
ENTITY  chuanlian IS
   PORT ( 
			clk:in std_logic;
			key: in std_logic;  --输入开关信号
			key_jia: in std_logic;   --温度加按钮
			key_jian:in std_logic;    --温度减按钮
			key_djia: in std_logic;   --定时加按钮
			key_djian:in std_logic;    --定时减按钮
			key_jieneng1:in std_logic;  --节能按钮
			key_moshi: in std_logic;   --模式按钮
			cold: out std_logic;
			hot: out std_logic;
			wind: out std_logic;
			dry: out std_logic;
			key_fengsu: in std_logic;   --风速按钮
			ruo: out std_logic;
			wei: out std_logic;
			zhong: out std_logic;
			qiang: out std_logic;
			key_fengxiang: in std_logic_vector(1 downto 0);   --风向按钮
			sx: out std_logic;--上下扫风
			zy: out std_logic;--左右扫风
			key_dingshi:in std_logic;  --定时按钮
			tem1:out std_logic_vector(3 downto 0); --输出十位温度 
			tem2:out std_logic_vector(3 downto 0);  --输出个位温度
			cflag_down: out std_logic;
			xinhao:out std_logic;
			btim: out std_logic_vector(3 downto 0); --百位输出定时的时间   以半小时为单位最多3小时
			stim: out std_logic_vector(3 downto 0); --十位输出定时的时间   以半小时为单位最多3小时
			gtim: out std_logic_vector(3 downto 0); --个位输出定时的时间   以半小时为单位最多3小时
			q1 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出		十位温度
			q2 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出		个位温度
			q3 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出		百位时间
			q4 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出		十位时间
			q5 : OUT STD_LOGIC_VECTOR(0 TO 6)		--7段输出		个位时间
			);
END chuanlian;
ARCHITECTURE behave2 OF chuanlian IS

	component kongtiao
		port (
		key: in std_logic;  --输入开关信号
		flag_down:in std_logic;
		xinhao: out std_logic   --传输给其他模块的开关信号
		);
	end component kongtiao;
	
	component moshi
		port (
		xinhao: in std_logic;   --接收到的开关信号
		key_moshi: in std_logic;   --模式按钮
		cold: out std_logic;
		hot: out std_logic;
		wind: out std_logic;
		dry: out std_logic
		);
	end component moshi;
	
	component wendu
		port (
		clk:in std_logic;
		xinhao: in std_logic;   --接收到的开关信号
		key_jia: in std_logic;   --温度加按钮
		key_jian:in std_logic;    --温度减按钮
		key_jieneng:in std_logic;
		tem1:out std_logic_vector(3 downto 0); --输出十位温度 
		tem2:out std_logic_vector(3 downto 0)  --输出个位温度
		);
	end component wendu;
	
	component fengsu
		port (
		xinhao: in std_logic;   --接收到的开关信号
		key_fengsu: in std_logic;   --模式按钮
		key_jieneng:in std_logic;
		ruo: out std_logic;
		wei: out std_logic;
		zhong: out std_logic;
		qiang: out std_logic
		);
	end component fengsu;
	
	component fengxiang
		port (
		clk:in std_logic;
		xinhao: in std_logic;   --接收到的开关信号
		key_fengxiang: in std_logic_vector(1 downto 0);   --模式按钮
		key_jieneng:in std_logic;
		sx: out std_logic;--上下扫风
		zy: out std_logic--左右扫风
		);
	end component fengxiang;
	
	component shezhidingshi
		port (
		clk : in std_logic;              
		xinhao:in std_logic;
		key_dingshi:in std_logic;
		key_jia: in std_logic;   --温度加按钮
		key_jian:in std_logic;    --温度减按钮
		tim:out integer
		);
	end component shezhidingshi;
	
	component cnt10
		port (
		clk:in std_logic;
		fclk:out std_logic
		);
	end component cnt10;
	
	component dingshi 
		port (
		fclk : in std_logic;    --输入经过分频之后的时钟信号   暂且为十分频信号            
		xinhao:in std_logic;
		tim:in integer;
		key_dingshi:in std_logic;
		flag_down: out std_logic:='1';
		btim: out std_logic_vector(3 downto 0); --百位输出定时的时间   以半小时为单位最多3小时
		stim: out std_logic_vector(3 downto 0); --十位输出定时的时间   以半小时为单位最多3小时
		gtim: out std_logic_vector(3 downto 0) --个位输出定时的时间   以半小时为单位最多3小时
		);	
	end component dingshi;
	
	component BCD7 IS
		PORT( tem1: IN STD_LOGIC_VECTOR(3 DOWNTO 0);   --数据输入
			tem2: IN STD_LOGIC_VECTOR(3 DOWNTO 0);   --数据输入
			btim: IN STD_LOGIC_VECTOR(3 DOWNTO 0);   --数据输入
			stim: IN STD_LOGIC_VECTOR(3 DOWNTO 0);   --数据输入
			gtim: IN STD_LOGIC_VECTOR(3 DOWNTO 0);   --数据输入
			q1 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出
			q2 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出
			q3 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出
			q4 : OUT STD_LOGIC_VECTOR(0 TO 6);     --7段输出
			q5 : OUT STD_LOGIC_VECTOR(0 TO 6)		--7段输出
			);
	END component BCD7;
	
	component jieneng
		port (
		xinhao: in std_logic;   --接收到的开关信号
		key_jieneng1: in std_logic;   --模式按钮
		key_jieneng: out std_logic   --模式按钮
		);
	end component jieneng ;
	
	signal sflag_down,fclk:std_logic;
	signal sxinhao:std_logic;
	signal stem1,stem2,sbtim,sstim,sgtim:std_logic_vector(3 downto 0);
	signal sttim:integer;
	signal key_jieneng:std_logic;
BEGIN        
KT: kongtiao port map(key,sflag_down,sxinhao);
							xinhao<=sxinhao;
MS: moshi	 port map(sxinhao,key_moshi,cold,hot,wind,dry);
WD: wendu	 port map(clk,sxinhao,key_jia,key_jian,key_jieneng,stem1,stem2);
							tem1<=stem1;
							tem2<=stem2;
FS: fengsu   port map(sxinhao,key_fengsu,key_jieneng,ruo,wei,zhong,qiang);
FX: fengxiang port map(clk,sxinhao,key_fengxiang,key_jieneng,sx,zy);
SZDS: shezhidingshi port map(clk,sxinhao,key_dingshi,key_djia,key_djian,sttim);
CNT: cnt10	 port map(clk,fclk);
DS: dingshi  port map(fclk,sxinhao,sttim,key_dingshi,sflag_down,sbtim,sstim,sgtim);
							cflag_down<=sflag_down;
							btim<=sbtim;
							stim<=sstim;
							gtim<=sgtim;
BCD: BCD7	 port map(stem1,stem2,sbtim,sstim,sgtim,q1,q2,q3,q4,q5);
JN: jieneng  port map(sxinhao,key_jieneng1,key_jieneng);

END  behave2;
