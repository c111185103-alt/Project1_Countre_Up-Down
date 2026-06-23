library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_09_90 is
    Port ( clk       : in  STD_LOGIC;
           rst       : in  STD_LOGIC;
           up_down   : in  STD_LOGIC;                    -- '1'0-9计'0'9-0计
           count_out : out STD_LOGIC_VECTOR (3 downto 0)  -- 4-bit 块
         );
end counter_09_90;

architecture Behavioral of counter_09_90 is
    signal cnt_reg : unsigned(3 downto 0) := (others => '0');
begin

    count_out <= std_logic_vector(cnt_reg);

    process(clk, rst)
    begin
        if rst = '1' then
            cnt_reg <= (others => '0');
        elsif rising_edge(clk) then
            if up_down = '1' then
                -- 0 -> 9 计碻吏
                if cnt_reg >= 9 then
                    cnt_reg <= "0000";
                else
                    cnt_reg <= cnt_reg + 1;
                end if;
            else
                -- 9 -> 0 计碻吏
                if cnt_reg <= 0 or cnt_reg > 9 then
                    cnt_reg <= "1001";
                else
                    cnt_reg <= cnt_reg - 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;