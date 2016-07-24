require 'test_helper'

class Cross::Track::DistanceTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cross::Track::Distance::VERSION
  end

  def test_haversine_works_as_expected
    # var p1 = new LatLon(52.205, 0.119);
    #     var p2 = new LatLon(48.857, 2.351);
    #     var d = p1.distanceTo(p2); // 404.3 km
    p1 = {lat: 52.205, lon: 0.119}
    p2 = {lat: 48.857, lon: 2.351}
    d = Haversine.distance(p1[:lat], p1[:lon], p2[:lat], p2[:lon]).to_m.to_int
    assert_equal 404279,d
    #puts d
  end

  def test_rad_to_deg
    r = Math::PI / 2
    assert_equal 90, r.to_deg.to_int
  end

  def test_deg_to_rad
    r = 180.0
    assert_equal Math::PI, r.to_rad
  end

  def test_bearing_calculation
    p1 = {lat: 52.205, lon: 0.119}
    p2 = {lat: 48.857, lon: 2.351}
    bearing = Cross::Track::Distance.bearing(p1, p2)
    assert_equal 156.2, bearing.round(1)
  end


  def test_cross_track_distance
    #   var p1 = new LatLon(53.3206, -1.7297);
    #   var p2 = new LatLon(53.1887,  0.1334);
    #   var pCurrent = new LatLon(53.2611, -0.7972);
    #   var d = pCurrent.crossTrackDistanceTo(p1, p2);  // -307.5 m
    segment_start = {lat: 53.3206, lon: -1.7297}
    segment_end = {lat: 53.1887, lon: 0.1334}
    point = {lat: 53.2611, lon: -0.7972}
    xtd = Cross::Track::Distance.cross_track_distance(segment_start, segment_end, point)
    assert_equal -307.5, xtd.round(1)
  end
end
