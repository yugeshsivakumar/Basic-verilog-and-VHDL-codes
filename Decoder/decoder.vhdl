-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dec_3x8 is
    Port ( en  : in  STD_LOGIC;             -- Enable signal
           in  : in  STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input
           out : out STD_LOGIC_VECTOR (15 downto 0) -- 16-bit output
         );
end dec_3x8;

architecture Behavioral of dec_3x8 is
begin

process(en, in)
begin
    if en = '1' then
        out <= (others => '0');
        out(to_integer(unsigned(in))) <= '1'; -- Set the bit corresponding to the input value
    else
        out <= (others => '0'); -- Output all zeros if enable is not active
    end if;
end process;

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal en  : STD_LOGIC := '0';                    -- Enable signal
    signal in  : STD_LOGIC_VECTOR (3 downto 0) := "0000"; -- 4-bit input signal
    signal out : STD_LOGIC_VECTOR (15 downto 0);       -- 16-bit output signal
    signal i   : integer := 0;                        -- Loop index for simulation

    -- Component declaration for the dec_3x8 module
    component dec_3x8
        Port ( en  : in  STD_LOGIC;
               in  : in  STD_LOGIC_VECTOR (3 downto 0);
               out : out STD_LOGIC_VECTOR (15 downto 0)
             );
    end component;

begin

    -- Instantiate the dec_3x8 module
    uut: dec_3x8 port map (en => en, in => in, out => out);

    -- Stimulus process to generate test patterns
    stim_proc: process
    begin
        -- Display header for better readability of simulation results
        report "en = " & std_logic'image(en) & "  in = " & std_logic_vector'image(in) & "  out = " & std_logic_vector'image(out);
        
        for i in 0 to 31 loop
            en <= std_logic(i(4));
            in <= std_logic_vector(to_unsigned(i mod 16, 4));
            wait for 10 ns;
        end loop;
        
        report "Simulation finished.";
        wait;
    end process;

end Behavioral;
