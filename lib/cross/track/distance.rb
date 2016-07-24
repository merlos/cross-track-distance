require "cross/track/distance/version"
require "haversine"
# Based on http://www.movable-type.co.uk/scripts/latlong.html
#

# helper methods
class Float
 def to_rad
   self*Math::PI/180
  end
  def to_deg
   180*self/Math::PI
 end
end

module Cross
  module Track
    module Distance



        # Earth ratio in meters
        @@R = 6371000

        #
        # http://www.movable-type.co.uk/scripts/latlong.html

        def self.bearing(from, to)
          #  see http://mathforum.org/library/drmath/view/55417.html
          # phi_1 = from.lat to radians
          # phi_2 = to.lat to radians
          # delta_lambda = to.lon - from.lon to radians
          # y = sin(d_lambda) * cos(phi_2)
          # x = cos(phi_1) * sin(phi_2) - sin(phi_1)*cos(phi_2) * cos(delta_lambda)
          # thita = atan2(y, x)
          # (thita to_degrees  + 360) % 360)
          phi_1 = from[:lat].to_rad
          phi_2 = to[:lat].to_rad
          delta_lambda= (to[:lon] - from[:lon]).to_rad
          y = Math::sin(delta_lambda) * Math::cos(phi_2)
          x = Math::cos(phi_1) * Math::sin(phi_2) - Math::sin(phi_1) * Math::cos(phi_2) * Math::cos(delta_lambda)
          thita = Math::atan2(y,x)
          #puts from
          #puts to
          #puts phi_1
          #puts phi_2
          #puts delta_lambda
          #puts y
          #puts x
          #puts thita
          (thita.to_deg + 360) % 360
        end
        #
        #
        # Calculates the shortest distance from point to the segment line on a great circle.
        # segment_start_pt is point in which the segment starts. It's a hash with :lat and :lon
        # segment_end_pt is point in which the segment ends. It's a hash with :lat and :lon
        # point is the point to calculate the distance to the segment.
        #
        # Returns the distance in meters
        def self.cross_track_distance(segment_start_pt, segment_end_pt, point)
          #var δ13 = pathStart.distanceTo(this, radius)/radius;
          #var θ13 = pathStart.bearingTo(this).toRadians();
          #var θ12 = pathStart.bearingTo(pathEnd).toRadians();
          #var dxt = Math.asin( Math.sin(δ13) * Math.sin(θ13-θ12) ) * radius;

          #puts segment_start_pt
          #puts segment_end_pt
          #puts point

          delta_13 = Haversine.distance(segment_start_pt[:lat],segment_start_pt[:lon],point[:lat],point[:lon]).to_m / @@R
          thita_13 = Cross::Track::Distance::bearing(segment_start_pt, point).to_rad
          thita_12 = Cross::Track::Distance::bearing(segment_start_pt, segment_end_pt).to_rad

          #puts delta_13
          #puts thita_13
          #puts thita_12

          Math::asin(Math::sin(delta_13) * Math::sin(thita_13 - thita_12) ) * @@R

        end
      # Your code goes here...
    end
  end
end
