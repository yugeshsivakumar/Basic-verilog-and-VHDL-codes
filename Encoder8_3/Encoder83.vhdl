
-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Encoder8_3 is
    Port ( en : in STD_LOGIC;
           in : in STD_LOGIC_VECTOR(7 downto 0);
           out : out STD_LOGIC_VECTOR(2 downto 0));
end Encoder8_3;

architecture Behavioral of Encoder8_3 is
begin
    process(en, in)
    begin
        if en = '1' then
            case in is
                when "00000001" => out <= "000";
                when "00000010" => out <= "001";
                when "00000100" => out <= "010";
                when "00001000" => out <= "011";
                when "00010000" => out <= "100";
                when "00100000" => out <= "101";
                when "01000000" => out <= "110";
                when "10000000" => out <= "111";
                when others => out <= "000";
            end case;
        else
            out <= "000";
        end if;
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Encoder8_3_tb is
end Encoder8_3_tb;

architecture Behavioral of Encoder8_3_tb is
    signal in_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal en_tb : STD_LOGIC;
    signal out_tb : STD_LOGIC_VECTOR(2 downto 0);

    -- Instantiate the Encoder8_3
    component Encoder8_3
        Port ( en : in STD_LOGIC;
               in : in STD_LOGIC_VECTOR(7 downto 0);
               out : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

begin
    -- DUT instantiation
    DUT: Encoder8_3 port map(
        en => en_tb,
        in => in_tb,
        out => out_tb
    );

    -- Test process
    process
        variable i : integer;
    begin
        en_tb <= '0';
        wait for 10 ns;

        -- Run test with en = 0 (disabled)
        for i in 0 to 7 loop
            in_tb <= std_logic_vector(to_unsigned(2**i, 8));
            wait for 10 ns;
        end loop;

        en_tb <= '1';
        wait for 10 ns;

        -- Run test with en = 1 (enabled)
        for i in 0 to 7 loop
            in_tb <= std_logic_vector(to_unsigned(2**i, 8));
            wait for 10 ns;
        end loop;

        wait;
    end process;

    -- Monitor process to display the output
    process
    begin
        wait for 1 ns;
        while true loop
            report "en=" & std_logic'image(en_tb) &
                   " in=" & integer'image(to_integer(unsigned(in_tb))) &
                   " out=" & integer'image(to_integer(unsigned(out_tb)));
            wait for 10 ns;
        end loop;
    end process;
end Behavioral;