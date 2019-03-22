nut_outer_diameter = 44;
nut_inner_diameter = 19;
nut_height = 23;

module nut() {
  r = nut_outer_diameter / 2;

  angles = [for (i=[0:5]) i * (360 / 6)];
  coords = [for (th=angles) [r * cos(th), r * sin(th)] ];

  translate([0, 0, -(nut_height/2)])
  linear_extrude(height=nut_height)
  polygon(coords);
}

nut();

