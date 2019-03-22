nut_outer_diameter = 44;
nut_inner_diameter = 19;
nut_height = 23;

module nut(margin_outer=0, margin_inner=0) {
  r_outer = (nut_outer_diameter / 2) + margin_outer;
  r_inner = (nut_inner_diameter / 2) + margin_inner;
  h = nut_height + margin_outer;

  angles = [for (i=[0:5]) i * (360 / 6)];
  coords = [for (th=angles) [r_outer * cos(th), r_outer * sin(th)] ];

  difference() {
    translate([0, 0, -h/2])
    linear_extrude(height=h)
    polygon(coords);

    cylinder(r=r_inner, h=h+1, center=true);
  }
}

module nut_stack() {
  for(i=[-1,0,1]) {
    z_shift = i * (nut_height + 5);

    translate([0, 0, z_shift])
    nut();
  }
}

nut_stack();