# Cross::Track::Distance
Uber simple gem to calculate the cross track distance (aka cross track error).

Suppose you are proceeding on a great circle route from `start_segment_pt` to `end_segment_pt` but you are at `point`, You can calculate the shortest distance to the segment that conforms the route

```
  start_segment_pt  * ------+------------------ * end_segment
                            |
                            |
                            * point
```
If `start_segment_pt`, `end_segment_pt` and  `point` are given in __latitude and longitude__ (WGS84), and the radius of the great circle is the Earth, you can use this gem to calculate the shortest distance from point to the segment line also called cross track distance or cross track error.

You have more info abou the theory behind the formula in these links:

* This gem is based on http://www.movable-type.co.uk/scripts/latlong.html
* You also have more information on http://williams.best.vwh.net/avform.htm#XTE


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cross-track-distance'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cross-track-distance

## Usage

```ruby
require 'cross/track/distance'

segment_start = {lat: 53.3206, lon: -1.7297}
segment_end = {lat: 53.1887, lon: 0.1334}
point = {lat: 53.2611, lon: -0.7972}

puts Cross::Track::Distance.cross_track_distance(segment_start,segment_end,point)
# => -307.549570418756
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/merlos/cross-track-distance.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
