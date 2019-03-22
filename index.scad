nut_outer_diameter = 44;
nut_inner_diameter = 19;
nut_height = 23;

module nut(margin_outer=0) {
  r = (nut_outer_diameter / 2) + margin_outer;
  h = nut_height + margin_outer;

  angles = [for (i=[0:5]) i * (360 / 6)];
  coords = [for (th=angles) [r * cos(th), r * sin(th)] ];

  translate([0, 0, -h/2])
  linear_extrude(height=h)
  polygon(coords);
}

nut();
