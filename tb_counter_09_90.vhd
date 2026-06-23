library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_09_90 is
-- Testbench 不需要外部腳位
end tb_counter_09_90;

architecture Behavior of tb_counter_09_90 is 

    -- 宣告要測試的元件
    component counter_09_90
    port(
         clk       : in  std_logic;
         rst       : in  std_logic;
         up_down   : in  std_logic;
         count_out : out std_logic_vector(3 downto 0)
        );
    end component;
    
    -- 內部訊號
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '0';
    signal up_down   : std_logic := '1';
    signal count_out : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- 例項化連接
    uut: counter_09_90 port map (
          clk       => clk,
          rst       => rst,
          up_down   => up_down,
          count_out => count_out
        );

    -- 產生時脈
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
 
    -- 測試激勵流程
    stim_proc: process
    begin		
        -- 1. 系統重置
        rst <= '1';
        wait for 30 ns;	
        rst <= '0';
        wait for 10 ns;

        -- ? 2. 設定計數方向：改這裡就好！
        -- ======================================
        up_down <= '1';  -- ? 改成 '1' 就是全程上數，改成 '0' 就是全程下數
        -- ======================================
        
        -- 3. 讓它一直跑直到模擬結束 (例如 1000 ns)
        wait for 1000 ns;

        -- 結束模擬
        wait;
    end process;

end Behavior;