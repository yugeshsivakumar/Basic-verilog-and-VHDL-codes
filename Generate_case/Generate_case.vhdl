
-- Half Adder Module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ha is
    Port ( a    : in  STD_LOGIC;      -- Input A
           b    : in  STD_LOGIC;      -- Input B
           sum  : out STD_LOGIC;      -- Sum output
           cout : out STD_LOGIC       -- Carry output (or cout in this case)
         );
end ha;

architecture Behavioral of ha is
begin
    process(a, b)
    begin
        sum <= a xor b;               -- Sum calculation
        cout <= a and b;              -- Carry calculation
    end process;
    
    initial
        report "Half adder instantiation";
end Behavioral;


// Full Adder Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa is
    Port ( a    : in  STD_LOGIC;      -- Input A
           b    : in  STD_LOGIC;      -- Input B
           cin  : in  STD_LOGIC;      -- Carry input
           sum  : out STD_LOGIC;      -- Sum output
           cout : out STD_LOGIC       -- Carry output
         );
end fa;

architecture Behavioral of fa is
begin
    process(a, b, cin)
    begin
        sum <= a xor b xor cin;           -- Sum calculation
        cout <= (a and b) or (b and cin) or (cin and a); -- Carry calculation
    end process;
    
    initial
        report "Full adder instantiation";
end Behavioral;


// Generic Adder Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gen is
    generic (
        ADDER_TYPE : integer := 1    -- Default to Full Adder
    );
    Port ( a    : in  STD_LOGIC;      -- Input A
           b    : in  STD_LOGIC;      -- Input B
           cin  : in  STD_LOGIC;      -- Carry input
           sum  : out STD_LOGIC;      -- Sum output
           cout : out STD_LOGIC       -- Carry output
         );
end gen;

architecture Behavioral of gen is
begin
    gen_adder: process (a, b, cin)
    begin
        case ADDER_TYPE is
            when 0 =>
                -- Instantiate Half Adder
                ha_inst: entity work.ha port map (
                    a => a,
                    b => b,
                    sum => sum,
                    cout => cout
                );
            when 1 =>
                -- Instantiate Full Adder
                fa_inst: entity work.fa port map (
                    a => a,
                    b => b,
                    cin => cin,
                    sum => sum,
                    cout => cout
                );
            when others =>
                -- Default to Full Adder if ADDER_TYPE is invalid
                fa_inst: entity work.fa port map (
                    a => a,
                    b => b,
                    cin => cin,
                    sum => sum,
                    cout => cout
                );
        end case;
    end process;
end Behavioral;


-- testbench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b, cin : STD_LOGIC := '0';  -- Input signals
    signal sum, cout : STD_LOGIC;         -- Output signals

    -- Component declaration for the gen module
    component gen
        generic (
            ADDER_TYPE : integer := 1
        );
        Port ( a    : in  STD_LOGIC;
               b    : in  STD_LOGIC;
               cin  : in  STD_LOGIC;
               sum  : out STD_LOGIC;
               cout : out STD_LOGIC
             );
    end component;

begin

    -- Instantiate the gen module with ADDER_TYPE = 0 (Half Adder)
    u0: gen
        generic map (
            ADDER_TYPE => 0
        )
        port map (
            a => a,
            b => b,
            cin => cin,
            sum => sum,
            cout => cout
        );

    -- Stimulus process to generate test patterns
    stim_proc: process
    begin
        report "Starting stimulus generation";
        for i in 0 to 4 loop
            wait for 10 ns;
            a <= std_logic($random and '1');
            b <= std_logic($random and '1');
            cin <= std_logic($random and '1');
        end loop;
        report "Stimulus generation complete";
        wait;
    end process;

    -- Monitor process to display the signals
    monitor_proc: process
    begin
        wait for 1 ns;
        report "a = " & std_logic'image(a) & " b = " & std_logic'image(b) & " cin = " & std_logic'image(cin) & 
               " sum = " & std_logic'image(sum) & " cout = " & std_logic'image(cout);
        wait for 9 ns;
    end process;

end Behavioral;
