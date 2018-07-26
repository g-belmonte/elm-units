module Quantity
    exposing
        ( AccelerationUnits
        , AngleUnits
        , LengthUnits
        , Quantity(..)
        , ScreenSpace
        , SpeedUnits
        , TemperatureUnits
        , TimeUnits
        , WorldSpace
        , abs
        , acceleration
        , clamp
        , compare
        , distance
        , greaterThan
        , lessThan
        , max
        , maximum
        , min
        , minimum
        , minus
        , negate
        , plus
        , ratio
        , sort
        , speed
        , speedup
        , sum
        , times
        )


type TimeUnits
    = TimeUnits


type AngleUnits
    = AngleUnits


type WorldSpace
    = WorldSpace


type ScreenSpace
    = ScreenSpace


type LengthUnits space
    = LengthUnits


type SpeedUnits space
    = SpeedUnits


type AccelerationUnits space
    = AccelerationUnits


type TemperatureUnits
    = TemperatureUnits


type Quantity units
    = Quantity Float


value : Quantity units -> Float
value (Quantity x) =
    x



-- 'Infix' operators


negate : Quantity units -> Quantity units
negate (Quantity x) =
    Quantity -x


plus : Quantity units -> Quantity units -> Quantity units
plus (Quantity y) (Quantity x) =
    Quantity (x + y)


minus : Quantity units -> Quantity units -> Quantity units
minus (Quantity y) (Quantity x) =
    Quantity (x - y)


times : Float -> Quantity units -> Quantity units
times scale (Quantity x) =
    Quantity (scale * x)


lessThan : Quantity units -> Quantity units -> Bool
lessThan (Quantity y) (Quantity x) =
    x < y


greaterThan : Quantity units -> Quantity units -> Bool
greaterThan (Quantity y) (Quantity x) =
    x > y



-- Other arithmetic functions


compare : Quantity units -> Quantity units -> Order
compare (Quantity x) (Quantity y) =
    Basics.compare x y


max : Quantity units -> Quantity units -> Quantity units
max (Quantity x) (Quantity y) =
    Quantity (Basics.max x y)


min : Quantity units -> Quantity units -> Quantity units
min (Quantity x) (Quantity y) =
    Quantity (Basics.min x y)


abs : Quantity units -> Quantity units
abs (Quantity x) =
    Quantity (Basics.abs x)


clamp : Quantity units -> Quantity units -> Quantity units -> Quantity units
clamp (Quantity lower) (Quantity upper) (Quantity x) =
    Quantity (Basics.clamp lower upper x)


ratio : Quantity units -> Quantity units -> Float
ratio (Quantity x) (Quantity y) =
    x / y



-- List functions


sum : List (Quantity units) -> Quantity units
sum quantities =
    List.foldl plus (Quantity 0) quantities


minimum : List (Quantity units) -> Maybe (Quantity units)
minimum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl min first rest)


maximum : List (Quantity units) -> Maybe (Quantity units)
maximum quantities =
    case quantities of
        [] ->
            Nothing

        first :: rest ->
            Just (List.foldl max first rest)


sort : List (Quantity units) -> List (Quantity units)
sort quantities =
    List.sortBy value quantities



-- Basic constructors/conversions


speed : Quantity (LengthUnits space) -> Quantity TimeUnits -> Quantity (SpeedUnits space)
speed (Quantity d) (Quantity t) =
    Quantity (d / t)


distance : Quantity TimeUnits -> Quantity (SpeedUnits space) -> Quantity (LengthUnits space)
distance (Quantity t) (Quantity v) =
    Quantity (v * t)


speedup : Quantity TimeUnits -> Quantity (AccelerationUnits space) -> Quantity (SpeedUnits space)
speedup (Quantity t) (Quantity a) =
    Quantity (a * t)


acceleration : Quantity (SpeedUnits space) -> Quantity TimeUnits -> Quantity (AccelerationUnits space)
acceleration (Quantity v) (Quantity t) =
    Quantity (v / t)
