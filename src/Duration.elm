module Duration exposing
    ( Duration
    , Seconds
    , days
    , from
    , hours
    , inDays
    , inHours
    , inJulianYears
    , inMilliseconds
    , inMinutes
    , inSeconds
    , inWeeks
    , julianYears
    , milliseconds
    , minutes
    , seconds
    , weeks
    )

import Quantity exposing (Quantity(..))
import Time


{-| The standard unit of time is seconds.
-}
type Seconds
    = Seconds


{-| A `Duration` refers to an elapsed time, as opposed to a specific instant in
time (which would generally be represented by a `Posix` value).
-}
type alias Duration =
    Quantity Float Seconds


{-| Find the elapsed time from a start time to an end time. For example,
assuming that `nineAM` and `fivePM` are two `Time.Posix` values on the same day:

    Duration.from nineAM fivePM
    --> Duration.hours 8

-}
from : Time.Posix -> Time.Posix -> Duration
from startTime endTime =
    let
        numMilliseconds =
            Time.posixToMillis endTime - Time.posixToMillis startTime
    in
    milliseconds (toFloat numMilliseconds)


{-| Construct a `Duration` from a given number of seconds.
-}
seconds : Float -> Duration
seconds numSeconds =
    Quantity numSeconds


{-| Convert a `Duration` to a value in seconds.

    Duration.milliseconds 10 |> Duration.inSeconds
    --> 0.01

-}
inSeconds : Duration -> Float
inSeconds (Quantity numSeconds) =
    numSeconds


{-| Construct a `Duration` from a given number of milliseconds.

    Duration.milliseconds 5000
    --> Duration.seconds 5

-}
milliseconds : Float -> Duration
milliseconds numMilliseconds =
    seconds (0.001 * numMilliseconds)


{-| Convert a `Duration` to a value in milliseconds.

    Duration.seconds 0.5 |> Duration.inMilliseconds
    --> 500

-}
inMilliseconds : Duration -> Float
inMilliseconds duration =
    inSeconds duration * 1000


{-| Construct a `Duration` from a given number of minutes.

    Duration.minutes 3
    --> Duration.seconds 180

-}
minutes : Float -> Duration
minutes numMinutes =
    seconds (60 * numMinutes)


{-| Convert a `Duration` to a value in minutes.

    Duration.seconds 90 |> Duration.inMinutes
    --> 1.5

-}
inMinutes : Duration -> Float
inMinutes duration =
    inSeconds duration / 60


{-| Construct a `Duration` from a given number of hours.

    Duration.hours 1
    --> Duration.seconds 3600

-}
hours : Float -> Duration
hours numHours =
    seconds (3600 * numHours)


{-| Convert a `Duration` to a value in hours.

    Duration.minutes 120 |> Duration.inHours
    --> 2

-}
inHours : Duration -> Float
inHours duration =
    inSeconds duration / 3600


{-| Construct a `Duration` from a given number of days. A day is defined as
exactly 24 hours or 86400 seconds. Therefore, it is only equal to the length of
a given calendar day if that calendar day does not include either a leap second
or any added/removed daylight savings hours.

    Duration.days 1
    --> Duration.hours 24

-}
days : Float -> Duration
days numDays =
    seconds (86400 * numDays)


{-| Convert a `Duration` to a value in days.

    Duration.hours 72 |> Duration.inDays
    --> 3

-}
inDays : Duration -> Float
inDays duration =
    inSeconds duration / 86400


{-| Construct a `Duration` from a given number of weeks.

    Duration.weeks 1
    --> Duration.days 7

-}
weeks : Float -> Duration
weeks numWeeks =
    seconds (604800 * numWeeks)


{-| Convert a `Duration` to a value in weeks.

    Duration.days 28 |> Duration.inWeeks
    --> 4

-}
inWeeks : Duration -> Float
inWeeks duration =
    inSeconds duration / 604800


{-| Construct a `Duration` from a given number of [Julian years](https://en.wikipedia.org/wiki/Julian_year_(astronomy)).
A Julian year is defined as exactly 365.25 days, the average length of a year in
the historical Julian calendar. This is 10 minutes and 48 seconds longer than
a Gregorian year (365.2425 days), which is the average length of a year in the
modern Gregorian calendar, but the Julian year is a bit easier to remember and
reason about and has the virtue of being the 'year' value used in the definition
of a light year.
    Duration.julianYears 1
    --> Duration.days 365.25


-}
julianYears : Float -> Duration
julianYears numJulianYears =
    seconds (31557600 * numJulianYears)


{-| Convert a `Duration` to a value in Julian years.

    Duration.hours 10000 |> Duration.inJulianYears
    --> 1.1407711613050422

-}
inJulianYears : Duration -> Float
inJulianYears duration =
    inSeconds duration / 31557600
