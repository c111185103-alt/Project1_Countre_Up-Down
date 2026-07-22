library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_09_90 is
    Port ( clk       : in  STD_LOGIC;                    -- 125 MHz 系統主時脈
           rst       : in  STD_LOGIC;                    -- 復位鍵 (高電平有效)
           up_down   : in  STD_LOGIC;                    -- '1'上數，'0'下數
           count_out : out STD_LOGIC_VECTOR (3 downto 0)  -- 4-bit LED 輸出
         );
end counter_09_90;

architecture Behavioral of counter_09_90 is
    signal cnt_reg     : unsigned(3 downto 0) := (others => '0');
    
    -- 125,000,000Hz / 1Hz = 125,000,000 個週期
    -- 計數範圍從 0 到 124,999,999
    signal clk_div_cnt : integer range 0 to 124999999 := 0;
    signal clk_en      : std_logic := '0'; -- 1Hz 啟用訊號 (Clock Enable)
begin

    count_out <= std_logic_vector(cnt_reg);

    -- [Process 1] 產生每秒僅觸發一個週期的 Enable 訊號
    process(clk, rst)
    begin
        if rst = '1' then
            clk_div_cnt <= 0;
            clk_en      <= '0';
        elsif rising_edge(clk) then
            if clk_div_cnt = 124999999 then
                clk_div_cnt <= 0;
                clk_en      <= '1'; -- 達到 1 秒，觸發 Enable
            else
                clk_div_cnt <= clk_div_cnt + 1;
                clk_en      <= '0'; -- 平時保持關閉
            end if;
        end if;
    end process;

    -- [Process 2] 計數器：完全在 125MHz 主時脈下運作，僅在 clk_en 為 '1' 時才累加/遞減
    process(clk, rst)
    begin
        if rst = '1' then
            cnt_reg <= (others => '0');
        elsif rising_edge(clk) then
            if clk_en = '1' then -- 只有在一秒時間到時才動作
                if up_down = '1' then
                    -- 上數循環
                    if cnt_reg >= 9 then
                        cnt_reg <= (others => '0');
                    else
                        cnt_reg <= cnt_reg + 1;
                    end if;
                else
                    -- 下數循環 (加入括號防止 VHDL 語法解析錯誤)
                    if (cnt_reg = 0) or (cnt_reg > 9) then
                        cnt_reg <= "1001"; -- 回到 9
                    else
                        cnt_reg <= cnt_reg - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;