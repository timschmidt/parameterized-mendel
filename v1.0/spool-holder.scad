module truncated_teardrop(height, radius)
{
	rotate([0, 90, 0])
	union()
	{
		cylinder(height, radius, radius);
	
		linear_extrude(height=height)
		polygon([
			[radius*cos(135), radius*sin(135)],
			[-radius*1.1,  radius*0.313],
			[-radius*1.1, -radius*0.313],
			[radius*cos(225), radius*sin(225)],
		]);
	}
}

module twelvegon(radius, z0, z1)
{
	translate([0, 0, z0])
	linear_extrude(height = z1 - z0)
	polygon([
		[radius*cos( 360*1/24),radius*sin( 360*1/24)],
		[radius*cos( 360*3/24),radius*sin( 360*3/24)],
		[radius*cos( 360*5/24),radius*sin( 360*5/24)],
		[radius*cos( 360*7/24),radius*sin( 360*7/24)],
		[radius*cos( 360*9/24),radius*sin( 360*9/24)],
		[radius*cos( 360*11/24),radius*sin( 360*11/24)],
		[radius*cos( 360*13/24),radius*sin( 360*13/24)],
		[radius*cos( 360*15/24),radius*sin( 360*15/24)],
		[radius*cos( 360*17/24),radius*sin( 360*17/24)],
		[radius*cos( 360*19/24),radius*sin( 360*19/24)],
		[radius*cos( 360*21/24),radius*sin( 360*21/24)],
		[radius*cos( 360*23/24),radius*sin( 360*23/24)],
	]);
}

module hub(radius, rod_diameter)
{
	c15 = cos(15);
	inner_corner = (radius*c15 - 10) / c15;
	inner_edge = inner_corner * c15;
	outer_edge = inner_edge + 10;
  cross = outer_edge - max(5, 4+rod_diameter/2);
	triangle = cross - (4+rod_diameter/2);

	difference()
	{
		union()
		{
			// Add material to support the bearing
			cylinder(11, 16, 16);

			// Add material for body
			difference()
			{
				twelvegon(radius, 0, 10);
				twelvegon(inner_corner, 5, 20);
			}

			for ( i = [0:5] )
			{
				// Add material to support the cross brace
				rotate([0,0,i*60])
				rotate([0, 0, 360/12])
				translate([cross, 0, 0])
				cylinder(10, 4+rod_diameter/2, 4+rod_diameter/2);

				// Add material to support the spoke
				rotate([0,0,i*60])
				translate([inner_edge, 0, 8])
				rotate([0, 90, 0])
				cylinder(10, 4+rod_diameter/2, 4+rod_diameter/2);
			}
		}

		// Axel
		translate([0,0,-5])
		cylinder (h = 25, r=9);

		// Bearing
		translate([0,0,3])
		cylinder (h = 25, r=11);

		for ( i = [0:5] )
		{
			// Spoke nut
			rotate([0,0,i*60])
			translate([0,0,-5])
			linear_extrude(height=15)
			polygon([
				[inner_edge, -7],
				[inner_edge, 7],
				[20, 7],
				[20, -7],
			]);
			
			// Triangle gap
			if (triangle > 30)
			{
				rotate([0,0,i*60])
				translate([0,0,-5])
				linear_extrude(height=15)
				polygon([
					[25 * cos(360*4/48), 25 * sin(360*4/48)],
					[triangle * cos(360*2/48), triangle * sin(360*2/48)],
					[triangle * cos(360*6/48), triangle * sin(360*6/48)],
				]);
			}			
	
			// Spoke
			rotate([0,0,i*60])
			translate([17, 0, max(5, 4+rod_diameter/2)])
			truncated_teardrop(radius, 0.2 + rod_diameter/2);
	
			// Cross Brace
			rotate([0,0,i*60])
			rotate([0, 0, 360/12])
			translate([cross, 0, -5])
			cylinder(30, 0.2 + rod_diameter/2, 0.2 + rod_diameter/2);
		}
	}
}

hub(radius=70, rod_diameter=8);
