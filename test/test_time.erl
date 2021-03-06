%%% Copyright 2012 Marcelo Gornstein <marcelog@gmail.com>
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.
-module(test_time).
-author("Marcelo Gornstein <marcelog@gmail.com>").
-github("https://github.com/marcelog").
-homepage("http://marcelog.github.com/").
-license("Apache License 2.0").

-include_lib("eunit/include/eunit.hrl").

start() ->
  [].

stop(_SetupData) ->
  ok.

can_detect_leap_year(_SetupData) ->
  [
    ?_assertEqual(true, ecal_time:is_leapyear(1600)),
    ?_assertEqual(true, ecal_time:is_leapyear(2000)),
    ?_assertEqual(true, ecal_time:is_leapyear(2400)),
    ?_assertEqual(true, ecal_time:is_leapyear(2800)),
    ?_assertEqual(false, ecal_time:is_leapyear(1700)),
    ?_assertEqual(false, ecal_time:is_leapyear(1800)),
    ?_assertEqual(false, ecal_time:is_leapyear(1900)),
    ?_assertEqual(false, ecal_time:is_leapyear(2100)),
    ?_assertEqual(false, ecal_time:is_leapyear(2200)),
    ?_assertEqual(false, ecal_time:is_leapyear(2300)),
    ?_assertEqual(false, ecal_time:is_leapyear(2500)),
    ?_assertEqual(false, ecal_time:is_leapyear(2600)),
    ?_assertEqual(false, ecal_time:is_leapyear(2700)),
    ?_assertEqual(false, ecal_time:is_leapyear(2900)),
    ?_assertEqual(false, ecal_time:is_leapyear(3000)),
    ?_assertEqual(false, ecal_time:is_leapyear(1601)),
    ?_assertEqual(false, ecal_time:is_leapyear(1602)),
    ?_assertEqual(false, ecal_time:is_leapyear(1603)),
    ?_assertEqual(true, ecal_time:is_leapyear(1604)),
    ?_assertEqual(true, ecal_time:is_leapyear(1784)),
    ?_assertEqual(true, ecal_time:is_leapyear(1788)),
    ?_assertEqual(true, ecal_time:is_leapyear(1792)),
    ?_assertEqual(true, ecal_time:is_leapyear(1796))
  ].

can_get_day_of_time(_SetupData) ->
  Year = 2012,
  Day = lists:foldl(
    fun(X, Acc) ->
      case ecal_time:is_leapyear(X) of
        true -> Acc + 366;
        false -> Acc + 365
      end
    end,
    0,
    lists:seq(1, Year)
  ),
  Dt1 = ecal_time:datetime_to_secs({{Year, 1, 1}, {1, 2, 3}}),
  [?_assertEqual(Day, ecal_time:day_of_time(Dt1))].

can_get_second_of_day(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {19, 30, 30}}),
  [?_assertEqual(70230, ecal_time:second_of_day(Dt1))].

can_get_minute_of_day(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {19, 30, 30}}),
  [?_assertEqual(1170, ecal_time:minute_of_day(Dt1))].

can_get_hour_of_day(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {19, 30, 30}}),
  [?_assertEqual(19, ecal_time:hour_of_day(Dt1))].

can_get_beginning_of_day(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {19, 30, 30}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  [?_assertEqual(Dt2, ecal_time:beginning_of_day(Dt1))].

can_get_end_of_day(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {19, 30, 30}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  [?_assertEqual(Dt2, ecal_time:end_of_day(Dt1))].

can_plus_and_minus_seconds(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 2}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_seconds(Dt1, 1)),
    ?_assertEqual(Dt1, ecal_time:minus_seconds(Dt2, 1))
  ].

can_plus_and_minus_minutes(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 2}, {0, 0, 59}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_minutes(Dt1, 1)),
    ?_assertEqual(Dt1, ecal_time:minus_minutes(Dt2, 1))
  ].

can_plus_and_minus_hours(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 2}, {0, 59, 59}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_hours(Dt1, 1)),
    ?_assertEqual(Dt1, ecal_time:minus_hours(Dt2, 1))
  ].

can_plus_and_minus_days(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 2}, {23, 59, 59}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_days(Dt1, 1)),
    ?_assertEqual(Dt1, ecal_time:minus_days(Dt2, 1))
  ].

can_get_beginning_of_minute(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 00}}),
  [?_assertEqual(Dt2, ecal_time:beginning_of_minute(Dt1))].

can_get_end_of_minute(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 55}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  [?_assertEqual(Dt2, ecal_time:end_of_minute(Dt1))].

can_get_beginning_of_hour(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 27, 13}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 00, 00}}),
  [?_assertEqual(Dt2, ecal_time:beginning_of_hour(Dt1))].

can_get_end_of_hour(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 19, 55}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 59, 59}}),
  [?_assertEqual(Dt2, ecal_time:end_of_hour(Dt1))].

can_get_tomorrow(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 27, 13}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 2}, {00, 00, 00}}),
  [?_assertEqual(Dt2, ecal_time:tomorrow(Dt1))].

can_get_yesterday(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 19, 55}}),
  Dt2 = ecal_time:datetime_to_secs({{2011, 12, 31}, {0, 0, 0}}),
  [?_assertEqual(Dt2, ecal_time:yesterday(Dt1))].

can_plus_and_minus_year(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2011, 1, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_year(Dt1)),
    ?_assertEqual(Dt1, ecal_time:minus_year(Dt2))
  ].

can_plus_and_minus_leap_year(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2000, 1, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{2001, 1, 1}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_leap_year(Dt1)),
    ?_assertEqual(Dt1, ecal_time:minus_leap_year(Dt2))
  ].

can_get_year_of_time(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2000, 12, 12}, {12, 12, 12}}),
  Dt2 = ecal_time:datetime_to_secs({{2000, 1, 1}, {0, 0, 0}}),
  Result = {Dt2, 2000},
  [?_assertEqual(Result, ecal_time:year_of_time(Dt1))].

can_get_timespec_for_year(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2000, 1, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{2001, 1, 1}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt1, ecal_time:timespec_for_year(2000)),
    ?_assertEqual(Dt2, ecal_time:timespec_for_year(2001))
  ].

can_get_beginning_of_year(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 5, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 12, 31}, {0, 0, 0}}),
  Dt3 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt3, ecal_time:beginning_of_year(Dt1)),
    ?_assertEqual(Dt3, ecal_time:beginning_of_year(Dt2)),
    ?_assertEqual(Dt3, ecal_time:beginning_of_year(Dt3))
  ].

can_get_end_of_year(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 19, 55}}),
  Dt2 = ecal_time:datetime_to_secs({{2012, 12, 31}, {23, 59, 59}}),
  [?_assertEqual(Dt2, ecal_time:end_of_year(Dt1))].

can_plus_and_minus_years(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{1600, 1, 1}, {23, 19, 55}}),
  Dt2 = ecal_time:datetime_to_secs({{1700, 1, 1}, {23, 19, 55}}),
  [
    ?_assertEqual(Dt2, ecal_time:plus_years(Dt1, 100)),
    ?_assertEqual(Dt1, ecal_time:minus_years(Dt2, 100))
  ].

can_get_month_of_time(_SetupData) ->
  Dt11 = ecal_time:datetime_to_secs({{2012, 1, 1}, {23, 19, 55}}),
  Dt12 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  Dt21 = ecal_time:datetime_to_secs({{2012, 12, 31}, {23, 19, 55}}),
  Dt22 = ecal_time:datetime_to_secs({{2012, 12, 1}, {0, 0, 0}}),
  Dt31 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  Dt32 = ecal_time:datetime_to_secs({{2012, 1, 1}, {0, 0, 0}}),
  Dt41 = ecal_time:datetime_to_secs({{1600, 5, 12}, {12, 12, 12}}),
  Dt42 = ecal_time:datetime_to_secs({{1600, 5, 1}, {0, 0, 0}}),
  [
    ?_assertEqual({Dt12, 0}, ecal_time:month_of_time(Dt11)),
    ?_assertEqual({Dt22, 11}, ecal_time:month_of_time(Dt21)),
    ?_assertEqual({Dt32, 0}, ecal_time:month_of_time(Dt31)),
    ?_assertEqual({Dt42, 4}, ecal_time:month_of_time(Dt41))
  ].

can_get_beginning_of_month(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{1600, 2, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{1600, 2, 28}, {23, 59, 59}}),
  [?_assertEqual(Dt1, ecal_time:beginning_of_month(Dt2))].

can_get_end_of_month(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{1600, 2, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{1600, 2, 29}, {23, 59, 59}}),
  [?_assertEqual(Dt2, ecal_time:end_of_month(Dt1))].

can_get_day_of_month(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{1600, 2, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{1600, 2, 29}, {23, 59, 59}}),
  [
    ?_assertEqual(0, ecal_time:day_of_month(Dt1)),
    ?_assertEqual(28, ecal_time:day_of_month(Dt2))
  ].

can_get_day_of_week(_SetupData) ->
  Dt1 = ecal_time:datetime_to_secs({{1970, 1, 1}, {0, 0, 0}}),
  Dt2 = ecal_time:datetime_to_secs({{1970, 1, 2}, {0, 0, 0}}),
  Dt3 = ecal_time:datetime_to_secs({{1970, 1, 3}, {0, 0, 0}}),
  Dt4 = ecal_time:datetime_to_secs({{1970, 1, 4}, {0, 0, 0}}),
  Dt5 = ecal_time:datetime_to_secs({{1970, 1, 5}, {0, 0, 0}}),
  Dt6 = ecal_time:datetime_to_secs({{1970, 1, 6}, {0, 0, 0}}),
  Dt7 = ecal_time:datetime_to_secs({{1970, 1, 7}, {0, 0, 0}}),
  [
    ?_assertEqual(5, ecal_time:day_of_week(Dt1)),
    ?_assertEqual(6, ecal_time:day_of_week(Dt2)),
    ?_assertEqual(0, ecal_time:day_of_week(Dt3)),
    ?_assertEqual(1, ecal_time:day_of_week(Dt4)),
    ?_assertEqual(2, ecal_time:day_of_week(Dt5)),
    ?_assertEqual(3, ecal_time:day_of_week(Dt6)),
    ?_assertEqual(4, ecal_time:day_of_week(Dt7))
  ].

can_get_beginning_of_week(_SetupData) ->
  Dt11 = ecal_time:datetime_to_secs({{1970, 1, 3}, {0, 0, 0}}),
  Dt12 = ecal_time:datetime_to_secs({{1970, 1, 3}, {0, 0, 0}}),
  [
    ?_assertEqual(Dt12, ecal_time:beginning_of_week(Dt11)),
    ?_assertEqual(Dt12, ecal_time:beginning_of_week(Dt12))
  ].

can_get_end_of_week(_SetupData) ->
  Dt11 = ecal_time:datetime_to_secs({{1969, 12, 30}, {0, 0, 0}}),
  Dt12 = ecal_time:datetime_to_secs({{1970, 1, 2}, {23, 59, 59}}),
  [
    ?_assertEqual(Dt12, ecal_time:end_of_week(Dt11)),
    ?_assertEqual(Dt12, ecal_time:end_of_week(Dt12))
  ].

simple_test_() ->
  {setup,
    fun start/0,
    fun stop/1,
    fun(SetupData) ->
      {inparallel, [
        can_detect_leap_year(SetupData),
        can_get_day_of_time(SetupData),
        can_get_second_of_day(SetupData),
        can_get_minute_of_day(SetupData),
        can_get_hour_of_day(SetupData),
        can_get_beginning_of_day(SetupData),
        can_get_end_of_day(SetupData),
        can_plus_and_minus_seconds(SetupData),
        can_plus_and_minus_minutes(SetupData),
        can_plus_and_minus_hours(SetupData),
        can_plus_and_minus_days(SetupData),
        can_get_beginning_of_minute(SetupData),
        can_get_end_of_minute(SetupData),
        can_get_beginning_of_hour(SetupData),
        can_get_end_of_hour(SetupData),
        can_get_tomorrow(SetupData),
        can_get_yesterday(SetupData),
        can_plus_and_minus_year(SetupData),
        can_plus_and_minus_leap_year(SetupData),
        can_get_year_of_time(SetupData),
        can_get_beginning_of_year(SetupData),
        can_get_end_of_year(SetupData),
        can_get_timespec_for_year(SetupData),
        can_plus_and_minus_years(SetupData),
        can_get_month_of_time(SetupData),
        can_get_beginning_of_month(SetupData),
        can_get_end_of_month(SetupData),
        can_get_day_of_month(SetupData),
        can_get_day_of_week(SetupData),
        can_get_beginning_of_week(SetupData),
        can_get_end_of_week(SetupData)
      ]}
    end
  }.