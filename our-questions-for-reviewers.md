## Questions - the second round of reviews

- We delayed submission of this review by a month to ensure that Parts I and II were cohesive and essentially finished. Are there any important foundational topics that we have missed in Part 1? And if we decided to add a third chapter to Part II, what would you suggest? We chose chapters 7 (transport) and 8 (location analysis) by thinking about topics already been covered in existing R-Spatial resources and the desire to make this as useful to as many people as possible.

- We have carefully proof-read the content in Part I and improved it iteratively and now think it is camera-ready: can you find any issues with the prose or formatting of text/figures/code?

- At present, 5.2 Reprojecting geographic data section contains four subsections including those showing how to specifically reproject vector and raster data.
Would it be better and more consistent if we moved sections 5.2.2 (Reprojecting vector geometries) and 5.2.4 (Reprojecting raster into the sections specifically dealing with geometry operations) on vector (5.3) and raster data (5.4), respectively?
    - An advantage of this is that we could provide general recommendations regarding reprojections which are applicable to both raster and vector data in the beginning (5.2), while showing the specifics how to do so in the corresponding geometric operation sections.
    - A disadvantage is the current structure keeps everything regarding reprojections in one place and that the raster/vector sections are already large. We would appreciate your feedback on how to order the sections - see https://geocompr.robinlovelace.net/transform.html#reproj-geo-data for this.

- There is a step change in content between chapter 1 and 2, with the latter containing much code output. Thinking of readers new to the subject is this 'throwing people in at the deep end' good for ensuring that it's focussed on the code, or should we try to reduce the amount of code output in Chapter 2?

- Chapter 7 currently contains no raster operations. One option would be to add a raster surface containing a transport-related variable (e.g. number of cycle parking places). Would that be wise from your perspective or is the chapter already sufficiently long?

- We have set-out a plan for Parts III and IV of the book here: https://github.com/Robinlovelace/geocompr/blob/master/our-chapters.md
    - Do the overall part names make sense?
    - Are there any recommendations for Part III we should include? 
    - For example, would the big data chapter be more important than the raster/vector chapter? 

## Questions - the first round of reviews

- How best to represent the sf class system so students benefit most from the diagram in section 2.1? See discussion in this commit for at least 3 options of the best way forward: https://github.com/Robinlovelace/geocompr/commit/46f50e4c556c2252e372b69b2df1ad9eff09c709
- Should we keep all the Exercises at the end of the chapters for consistency, or add additional Exercises before the end? (Latest thinking: have a main Excercises section at the end of each chapter but include some exercises mid-chapter where appropriate.)
- How should we handle units? At present we describe them briefly in the context of simple features in Section [2.4](http://robinlovelace.net/geocompr/spatial-class.html#units) and then again in exercises [3.7](http://robinlovelace.net/geocompr/attr.html#exercises-2) but we were wondering if a more systematic coverage of this potentially tricky topic is needed
- Likewise for CRSs - we introduce them in [2.3](http://robinlovelace.net/geocompr/spatial-class.html#crs-intro) but plan a larger section, going into more detail about how to select and modify them, in Chapter 6. Sound good?
- At present we have tried to keep vector and raster data relatively well-integrated. However, there has been discussion of splitting-out some of the raster stuff (see [github discussion](https://github.com/Robinlovelace/geocompr/pull/80#discussion_r135806844)) in the context of matrix algebra, which blurs the boundary between spatial and non-spatial operations. Any thoughts on this?
- We'd also appreciate feedback on the book's structure. Our thinking has evolved as we've written the first fie chapters and, as documented in [our_chapters.md](https://github.com/Robinlovelace/geocompr/blob/master/our_chapters.md), the latest plan is to have 4 parts of the basic format methods1 -> applications1 -> methods2 -> applications2. Whether these Parts are formal in the index (like in R for Data Science) or just used for our own benefit is an open question (we're not in any rush to formalise them) but any comments on the book's structure would be appreciated. The thinking is that 'getting stuck in' with practical examples asap after the foundations have been learned will be fun and conducive to learning, so readers don't get bored before the more advanced methods sections.
- We would like to know if you think that there is a need for a chapter on cloud computing/big data in a geocomputation context?
