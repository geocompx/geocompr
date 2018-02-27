## rev I

- I would split chapter 6 into input versus output (visualization). The former, I would add to chapter 2, while the latter could be a little expanded by some of the material taught at Use R! conferences. Yes, I see that there is chapter 9 but data output is not limited to map making. Chapter 2 should then be split into two. 2a would be just about vector and raster data, and 2b about coordinate reference systems, units, data input.
- Unfortunately, the same (lucid and easy to read) cannot be said about the examples in part II. For example, the osmdata::getbb command on page 155 specifies an output format that is not known to the osmdata package, which in its latest version (as of Feb 2018) allows only for data.frame, matrix, string, or polygon.
- After two Human geography examples, I am missing some physical geography in Part II. Please touch base with Edzer Pebesma and his group to see whether they would share an example or two.
- I would leave these sections (5.2) where they are. The topic is important in and by itself and easier to find (even for lookup purposes if the book is used as a reference) if we leave it in section 5.2.
- (chapter 2) No, please leave it as is. Similar to ASDAR, I believe that it is pedagogically much easier to explain how GIS data is structured by looking at the code. Which is why I have been using ASDAR and would now use your book even in an Intro to GIS class.
- Transportation and raster don't really go together. Plus, there is the point you raise about length. I rather you add a physical geography chapter in section II and have that one focus on raster operations. I am, for example, working on greenhouse gas emissions and if one used that example, plus Pebesma's temporal extensions (spacetime, st, stars), one could have a very rich chapter.
- In general, I am concerned that you are trying to do too much. The book would already be good if you ended with chapter 9 (which would be 10 if you followed by advice of splitting chapter 2 into two). The bridges to GIS software are but kind of 'sugar on top'. Yes, I very much agree that a big data chapter would be more valuable than the raster/vector interactions. Chapters 11-15 are too much. I fear that this will cost you a lot of time and by then you will have to rewrite parts of the other chapters again because the R world is spinning so fast. The stars package, for example will open a whole new world of n-dimensionality and working with non-local BIG data. Leave writing a GeoComp Applications book to others and get this one out fast! Then prepare for a second edition in 2019. ;)
- In the thank-you note to Josh O'Brien on page 101, the URL to the discussion on stackoverflow is missing.
- Please insert a code snippet that results in the table 5.2 - it is a bit tedious to look this up interactively. 
- I love section 5.3 on clipping; here you do exactly what I am missing in part II of the book: you are providing the code that shows how to create the figures in each chapter.
- Chapter 7. It would be nice if the code for generating figures would be inserted immediately before those figures show up in the text. I know, you promise to show how to do this in chapter 9 but this is really frustrating. So, please insert the code here and add a note that the detailed instructions will be expanded on in chapter 9.
- The rail example on page 166 is not very convincing: lots of effort for very little outcome. 
- The use of SpatialLinesNetwork on page 168 is incorrect; the code does not work as indicated.
- Chapter 8. Location analysis and geomarketing are not the same! I like the comparison between (landscape) ecological analysis and location analysis though. 
- After we download and show the contents of the file on page 175, it would be good if you translated the terms displayed as they are in German.
- As in chapter 7t would be nice to have the code describing how the figures are created in inserted here.
- At the end of the reversed geocoding on page 182, I would add a View(coords) command to see the coordinates derived. 
- The translation into metro names does not work as depicted. I don't get Leipzig nor Velbert.
- Quite frankly, this section 8.5 is not convincing - even if it were working, it is a lot of effort for little outcome. Plus, it does not add to the purpose of this particular chapter (location analysis). I recommend to just drop section 8.5.
- Do you realize that you make readers download some 2 GBytes of data in this little script on page 183?! That is not fair! - And then, why are you translating the resulting list into a raster object? To use a field representation makes no sense here; besides, it is very wasteful, creating a large raster with lots of N/As (whitespace). This might make sense in a parallel landscape ecological application but does not fit an audience interested in location/allocation analysis.

# TO DO IN THE FUTURE 

# CANNOT FIND IT

# UNCLEAR

- Last (command) line on page 104: please add a line to plot(world_laea2). The result is much prettier than what is printed in the book. 
- Besides: when I do (str(con_raster_ea)), then I get different results. [JN: I CANNOT CONFIRM THIS.]
- The last line on page 111 ends with a colon but there is nothing to follow on the next page. [JN: I WAS UNABLE TO LOCATE IT.]
- The two code lines on top of page 162 require the lwgeom package. In chapter 5, this was properly noted but here in chapter 7, it is missing. [JN: I AM UNABLE TO LOCATE USE OF LWGEOM IN CH7.]

# FIXED

- not an error but an inconsistency is the switch from the assignment operator <- to the equal sign from section 2.3 onward
