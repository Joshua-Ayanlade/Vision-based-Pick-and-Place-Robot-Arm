#!/usr/bin/env python
import os

for i in range(1,5):
    # To run terminal command to generate ar_marker 1,2 and 3
    os.system("rosrun ar_track_alvar createMarker {0}".format(i))
    # To change generated markers border color, size and save
    img = "MarkerData_{0}.png".format(i)
    os.system("convert {0} -bordercolor white -border 100x100 ar_tag_{1}.png".format(img,i))

    # To create the material file for the 3 marker
    with open("ar_maker.material",'a') as f:
        f.write("""material ar_tag/tag_%d {
    receive_shadows on
    technique {
        pass {
        ambient 1.0 1.0 1.0 1.0
        diffuse 1.0 1.0 1.0 1.0
        specular 0.5 0.5 0.5 1.0
        lighting on
        shading gouraud
        texture_unit { texture ar_tag_%d.png }
        }
    }
}
"""%(i,i))