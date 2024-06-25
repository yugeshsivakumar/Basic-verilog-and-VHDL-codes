-- MUX1 Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           out : out  STD_LOGIC
         );
end mux1;

architecture Behavioral of mux1 is
begin
    initial
        report "MUX_1 is instantiated";
    
    process(sel)
    begin
        if sel = '1' then
            out <= b;
        else
            out <= a;
        end if;
    end process;
end Behavioral;


-- MUX2 Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           out : out  STD_LOGIC
         );
end mux2;

architecture Behavioral of mux2 is
begin
    initial
        report "MUX_2 is instantiated";
    
    process(sel)
    begin
        case sel is
            when '0' =>
                out <= a;
            when '1' =>
                out <= b;
            when others =>
                out <= 'X';  -- Handle undefined case
        end case;
    end process;
end Behavioral;


-- GEN Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gen is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           out : out  STD_LOGIC
         );
    generic (
        mode : integer := 0
    );
end gen;

architecture Behavioral of gen is
    -- Component declaration for the mux1 and mux2 modules
    component mux1 is
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               sel : in  STD_LOGIC;
               out : out  STD_LOGIC
             );
    end component;
    
    component mux2 is
        Port ( a : in  STD_LOGIC;
               b : in  STD_LOGIC;
               sel : in  STD_LOGIC;
               out : out  STD_LOGIC
             );
    end component;
    
    -- Signal declaration for mux outputs
    signal mux_out : STD_LOGIC;
begin
    -- Instantiate mux1 or mux2 based on mode
    gen_proc: process(a, b, sel)
    begin
        if mode = 0 then
            mux1_inst: mux1 port map (
                a => a,
                b => b,
                sel => sel,
                out => mux_out
            );
        else
            mux2_inst: mux2 port map (
                a => a,
                b => b,
                sel => sel,
                out => mux_out
            );
        end if;
    end process;
    
    -- Output assignment
    out <= mux_out;
end Behavioral;


-- Testbench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    -- Signals for testbench
    signal a, b, sel, out : STD_LOGIC;
    constant CLK_PERIOD : time := 10 ns;  -- Clock period for simulation
    
    -- Clock process for generating clock signal
    signal clk : STD_LOGIC := '0';
    constant HALF_CLK_PERIOD : time := CLK_PERIOD / 2;
begin

    -- Instantiate the gen module
    uut: gen
        generic map (
            mode => 0  -- Mode 0 selects mux1, Mode 1 selects mux2
        )
        port map (
            a => a,
            b => b,
            sel => sel,
            out => out
        );
    
    -- Stimulus process for generating test patterns
    stim_proc: process
    begin
        report "Starting testbench stimulus";
        for i in 0 to 4 loop
            wait for CLK_PERIOD;
            a <= std_logic(to_unsigned(integer(to_bitvector($random))), a'length);
            b <= std_logic(to_unsigned(integer(to_bitvector($random))), b'length);
            sel <= std_logic(to_unsigned(integer(to_bitvector($random(0 to 1)))), sel'length);
            report "i = " & integer'image(i) & ", a = " & std_logic'image(a) & ", b = " & std_logic'image(b) &
                   ", sel = " & std_logic'image(sel) & ", out = " & std_logic'image(out);
        end loop;
        report "Testbench stimulus complete";
        wait;
    end process;

    -- Clock generation process
    clk_proc: process
    begin
        wait for HALF_CLK_PERIOD;
        clk <= not clk;
    end process;

end Behavioral;
