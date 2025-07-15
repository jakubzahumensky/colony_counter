## FIJI macro for automatic counting of colonies from a plate

# Motivation
The task of counting yeast/bacterial colonies on a plate is tedius and prone to errors. In general, Most of the colonies (if the growth is not too strong) can be clearly distinguished, meaning they can be segmented. Developing a macro frees experimenter time, increased throughput and reproducibility, while removing bias.

# Macro steps:
    1. Duplicate and process image – enhance local contrast, remove background etc. 
        ◦ prepare as much as possible for binarization
    2. Binarize (create mask), watershed into separate objects and adjust their shape a bit
    3. Summarize results, especially report the number
        ◦ the counting works analogously to working with the Burker chamber, specifically, only colonies touching the bottom and right-hand edges are counted, while the ones touching the top andleft-hand edge of the image are ignored
    4. Create overlay of the final segmentation mask with the original image for verification

# Macro usage:
    1. Open Fiji
    2. Load macro in Fiji (drag-and-drop/ file → open)
    3. Open image to be analyzed
    4. Run macro
    5. Results are written out in the form of a table on screen
	