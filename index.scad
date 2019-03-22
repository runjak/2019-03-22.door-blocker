nut_outer_diameter = 44;
nut_inner_diameter = 19;
nut_height = 23;

layer_margin = 5;
layer_count = 3;
layers = [
  for(i=[0:(layer_count - 1)])
  i * (nut_height + layer_margin)
];

module nut(margin_outer=0, margin_inner=0) {
  r_outer = (nut_outer_diameter / 2) + margin_outer;
  r_inner = (nut_inner_diameter / 2) + margin_inner;
  h = nut_height + margin_outer;

  angles = [for (i=[0:5]) i * (360 / 6)];
  coords = [for (th=angles) [r_outer * cos(th), r_outer * sin(th)]];

  difference() {
    translate([0, 0, -h/2])
    linear_extrude(height=h)
    polygon(coords);

    cylinder(r=r_inner, h=h+1, center=true);
  }
}

module nut_stack(margin=0) {
  shift = nut_outer_diameter / 2;
  angles = [for (i=[0:(layer_count - 1)]) i*(360 / 6)];
  coords = [for (th=angles) [shift * cos(th), shift * sin(th)]];

  for(layer=layers) {
    translate([0, 0, layer])
    nut(margin, -nut_inner_diameter);
  }

  for(i=[0:(layer_count - 1)]) {
    c = coords[i];

    translate([c[0], c[1], layers[i]])
    nut(margin, -nut_inner_diameter);
  }
}

module fillet() {
  rotate([45,45,0])
  cube([layer_margin, layer_margin, layer_margin], center=true);
}

module door_blocker(margin=0) {
  minkowski() {
    nut(margin, -nut_inner_diameter);

    fillet();
  }
}

door_blocker();