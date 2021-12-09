-- BCD-7段显示译码器设计
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY BCD7 IS
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
END BCD7;
ARCHITECTURE behav OF BCD7 IS
    BEGIN
    PROCESS (tem1,tem2,btim,stim,gtim)
      BEGIN         
    case tem1(3 downto 0) is     -- BCD 7段译码表
      when "0000" => q1<="1111110";         when "0001" => q1<="0110000";
      when "0010" => q1<="1101101";         when "0011" => q1<="1111001";
      when "0100" => q1<="0110011";         when "0101" => q1<="1011011";
      when "0110" => q1<="1011111";         when "0111" => q1<="1110000";
      when "1000" => q1<="1111111";         when "1001" => q1<="1111011";
      when others => q1<="0000000";
     END case;
	   case tem2(3 downto 0) is     -- BCD 7段译码表
      when "0000" => q2<="1111110";         when "0001" => q2<="0110000";
      when "0010" => q2<="1101101";         when "0011" => q2<="1111001";
      when "0100" => q2<="0110011";         when "0101" => q2<="1011011";
      when "0110" => q2<="1011111";         when "0111" => q2<="1110000";
      when "1000" => q2<="1111111";         when "1001" => q2<="1111011";
      when others => q2<="0000000";
     END case;
	   case btim(3 downto 0) is     -- BCD 7段译码表
      when "0000" => q3<="1111110";         when "0001" => q3<="0110000";
      when "0010" => q3<="1101101";         when "0011" => q3<="1111001";
      when "0100" => q3<="0110011";         when "0101" => q3<="1011011";
      when "0110" => q3<="1011111";         when "0111" => q3<="1110000";
      when "1000" => q3<="1111111";         when "1001" => q3<="1111011";
      when others => q3<="0000000";
     END case;
	   case stim(3 downto 0) is     -- BCD 7段译码表
      when "0000" => q4<="1111110";         when "0001" => q4<="0110000";
      when "0010" => q4<="1101101";         when "0011" => q4<="1111001";
      when "0100" => q4<="0110011";         when "0101" => q4<="1011011";
      when "0110" => q4<="1011111";         when "0111" => q4<="1110000";
      when "1000" => q4<="1111111";         when "1001" => q4<="1111011";
      when others => q4<="0000000";
     END case;
	  case gtim(3 downto 0) is     -- BCD 7段译码表
      when "0000" => q5<="1111110";         when "0001" => q5<="0110000";
      when "0010" => q5<="1101101";         when "0011" => q5<="1111001";
      when "0100" => q5<="0110011";         when "0101" => q5<="1011011";
      when "0110" => q5<="1011111";         when "0111" => q5<="1110000";
      when "1000" => q5<="1111111";         when "1001" => q5<="1111011";
      when others => q5<="0000000";
     END case;
   END PROCESS;   
END behav;
