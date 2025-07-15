/*
 * Macro for automatic counting of colonies on a plate.
 */

min_diameter = 0.25;
min_circularity = 0.5;
min_colony_area = PI*pow(min_diameter/2,2);

title = getTitle();
path = getDirectory("image");
Stack.setXUnit("mm");
run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.045 pixel_height=0.045 voxel_depth=0.045");

preprocess();
binarize();

run("Analyze Particles...", "size=min_colony_area-Infinity circularity=min_circularity-1.00 show=Masks display exclude clear summarize");
mask_title = getTitle();

selectImage(title);
run("8-bit");

run("Merge Channels...", "c1=[" + mask_title + "] c4=[" + title + "] create");


function preprocess(){
	run("Duplicate...", " ");
	run("Subtract Background...", "rolling=15 disable");
	run("Enhance Contrast", "saturated=0.01");
	run("Apply LUT");
	run("Enhance Local Contrast (CLAHE)", "blocksize=90 histogram=256 maximum=5 mask=*None*");
	run("Normalize Local Contrast", "block_radius_x=2 block_radius_y=2 standard_deviations=5 stretch");
}


function binarize(){
	run("Convert to Mask");
	run("Despeckle");
	run("Adjustable Watershed", "tolerance=0.001");
	run("Erode");
	run("Dilate");
	run("Set Measurements...", "shape redirect=None decimal=3");
	run("Translate...", "x=-1 y=-1 interpolation=None");
}
