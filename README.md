# GoldMiner-Remastered
## Problemstilling
Eftersom Adobe stopper support til Adobe Flash Player i slutningen af 2020, vil en masse gamle Flash spil stoppe med at virke. Dermed rekreere jeg spillet Gold Miner, så man stadig kan spille det i fremtiden.
## Pseudokode
Playerklasse, mineralklasse og en score klasse indlæses. Deriblandt sprites til bagground og objekter. Mineraler placeres udfra random funktion og bliver rettet af regen funktion, så der ikke er overlap. Gameloop begynder.

<dl>
  <dt>Gameloop</dt>
  <dd>Player position svinger frem og tilbage over jorden. Når spilleren trykker <i>s</i> stopper player position og player armen bliver længere i takt med varigheden af trykket. Hvis player postionen overlapper et mineral, bliver mineral.pos til player.pos og kan herefter trækkes tilbage af spilleren ved tryk på <i>w</i>. Når mineral kommer tilbage til player standard postion forsvinder mineral og score tæller point op baseret på vægt og værdi af mineral.</dd>
</dl>

Når der ikke er flere mineraler ryddes billedet og score bliver fremvist.

## Flowchart
![alt text](https://github.com/joha6351/GoldMiner/blob/master/Flowchart%20-%20Gold%20Miner.svg "Flowchart")
Alternativt findes [her](https://joha6351.github.io/)

#### Mangler
- Score klasse
- Fixe grab funktionen, så den ikke tager fat i alle.
- Lave endingscreen, sammenhøren med Score
