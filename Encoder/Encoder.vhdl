-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity enc is
    Port ( in  : in  STD_LOGIC_VECTOR (7 downto 0); -- 8-bit input
           en  : in  STD_LOGIC;                     -- Enable signal
           clk : in  STD_LOGIC;                     -- Clock signal
           out : out STD_LOGIC_VECTOR (2 downto 0)  -- 3-bit output
         );
end enc;

architecture Behavioral of enc is
begin
    process(clk)
    begin
        if rising_edge(clk) then
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
                    when others     => out <= "ZZZ";
                end case;
            else
                out <= "XXX";
            end if;
        end if;
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal in  : STD_LOGIC_VECTOR (7 downto 0) := "00000000"; -- 8-bit input signal
    signal en  : STD_LOGIC := '0';                           -- Enable signal
    signal clk : STD_LOGIC := '0';                           -- Clock signal
    signal out : STD_LOGIC_VECTOR (2 downto 0);              -- 3-bit output signal

    -- Component declaration for the enc module
    component enc
        Port ( in  : in  STD_LOGIC_VECTOR (7 downto 0);
               en  : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               out : out STD_LOGIC_VECTOR (2 downto 0)
             );
    end component;

begin

    -- Instantiate the enc module
    uut: enc port map (in => in, en => en, clk => clk, out => out);

    -- Clock generation process
    clk_process : process
    begin
        while now < 100 ns loop
            clk <= not clk;
            wait for 1 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process to generate test patterns
    stim_proc: process
    begin
        report "Time = " & integer'image(now) & "  En = " & std_logic'image(en) & "  IN = " & std_logic_vector'image(in) & "  Out = " & std_logic_vector'image(out);

        en <= '0';
        wait for 5 ns;
        en <= '1';

        wait for 5 ns;
        in <= "00000001"; wait for 5 ns;
        in <= "00000010"; wait for 5 ns;
        in <= "00000100"; wait for 5 ns;
        in <= "00001000"; wait for 5 ns;
        in <= "00010000"; wait for 5 ns;
        in <= "00100000"; wait for 5 ns;
        in <= "01000000"; wait for 5 ns;
        in <= "10000000"; wait for 5 ns;

        wait for 50 ns;
        report "Simulation finished.";
        wait;
    end process;

end Behavioral;