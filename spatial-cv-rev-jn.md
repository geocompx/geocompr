Random notes:

1. "(Semi-)Parametric regression techniques" - you use terms (e.g. semi-parametric) without any introduction/explanation. I suggest to replace it with "Statistical modeling techniques".
JM: Just deleted it.
2. "which is probably familiar to most readers" - I think we should not use statements like this one. I suggest to remove it.
JM: deleted
3. "CV determines a model’s ability to predict new data or differently put its ability to generalize." This sentence doesn't sound right...
JM: rewritten.
4. "CV achieves this by splitting the data randomly into test and training sets." Is it always true? CV can also splitting the data in a non-random fashion, e.g. stratified sample, etc.
JM: Ok, rewritten.
5. "To make the ratio between landslide and non-landslide points more balanced, we randomly sample 175 from the 1360 non-landslide points." Probably it is a good idea to add a set.seed here to be able to reproduce this...
JM: ok, another seed... (Note to myself: rerun the sampling with the seed)
6. Creation on the dem object is complex and probably unnecessary here. Maybe we could add this raster object to spDataLarge?
JM: Well, I think this is a great example how to create a raster object.
7. "`log_carea`: the decadic logarithm of the catchment area (log m^2^)". Is it log or log10)?
JM: it is log10
8. "Later on we will introduce the mlr package, an umbrella-package providing a unified interface to a plethora of modeling approaches." Should we use words like "plethora" in our book?
JM: What's the problem with "plethora"? But I can change to "many" or alike
9. Commented code `# the same as:
# fit = glm(lslpts ~ ., data = select(lsl, -x, -y))` - I think this code can be removed. It just add some confusion.
JM: ok, removed
10. "# loading among others ta, a raster stack containing the predictors" - is it a temporary solution? We should have this in our data packages or it should be calculated in the previous chunks...
JM: ok, we can put it into spData or spDataLarge. 
11. "There are three main directions:". I suggest rewriting those three points. The first two are very short and the other one is much longer. Moreover, the first point is written like a description ("The predictions (...) are ..."), the second one is an action ("Adding ..."), and the third one is a suggestion ("(...) there are").
JM: All of these are descriptions. I don't intend to suggest anything here. That the third point is longer than the other is unfortunate but can't really be fixed.
12. "the most beautiful prediction map " What does it mean? I think this sentence should be rewritten.
JM: rewritten but it means exactly what it means a prediction map is pretty much useless if the prediction is bad
13. "AUROC" - I am surprised by this abbreviation. Isn't usually "AUC"?
JM: yep, sometimes you find AUC but the proper abbreviation is AUROC.
14. "Figure 13.4" - Should we ask for the permission to use this figure? I would think that we should...
JM: I have asked for permission, and received back a positive answer.
15. "Secondly, a learner defines the specific model that models the task data or differently put learns a structure inherent in the provided data." I don't understand this sentence.
JM: rewritten
16. "library(mlr)" in the Spatial CV with mlr section looks unnecessary. We already have load this library at the beginning of the chapter.
JM: Yep, I know, this is just to show that we are needing mlr algorithms now.
17. "# run the following lines to find out from which package the
# learner is taken and how to access the corresponding help 
# file(s)
# getLearnerPackages(learner)
# helpLearner(learner)" - This chunk contains a lot of commented ideas. Maybe this could be added in the regular text?
JM: ok, changed as recommended.
18. "to run 169 learners (mlr package version: 2.13).". Maybe it is better to generalize this sentence, for example "to run more than 150 learners..".
JM: ok, changed
19. "also spatially, in an inner fold (see section 13.5.2)" I suggest removing the details (", in an inner fold").
JM: ok, changed
20. " Please note that package sperrorest initially implemented spatial cross-validation in R (A. Brenning 2012b). In the meantime, its functionality was integrated into the mlr package which is the reason why we are using mlr (Schratz et al. 2018).66" Is this information really important for this chapter?
JM: I am just paying respect to my boss here, since he implemented sperrorest. Maybe the information is not crucial but does not harm either.
21. "The caret package (...) so far it does not provide spatial CV which is why we refrain from using it for spatial data.". Maybe we could mention the CAST package in this footnote - https://cran.r-project.org/web/packages/CAST/index.html. 
JM: We could.
22. What was your reason to use SVM? (I my work this technique was never the one with the largest predictive quality..)
JM: The reason is simple. Tuning of SVM hyperparameters has definitely an impact on the model's performance whereas in the case of random forests, it is often the case that the tuning has only a marginal effect. This way I hope to avoid discussions with ml guys about the necessity of hyperparameter tuning. What is more, SVM and random forests and other ml techniques frequently are on the same ballpark with regard to predictive performance.
23. You state "It is beyond the scope of this book to explain exactly what a SVM is." and next there are several sentences explaining SVM. Maybe this one should be removed...
JM: Removed.
24. "Therefore, we will make sure to replace automated by spatial hyperparameter tuning in the following." I don't understand this sentence.
JM: Rewritten.
25. ". To find out which SVM functions are available we use again the listLearners() command." I suggest to replace this code output with a knitr table.
JM: Could do.
26. "We will use ksvm() from the kernlab package (???)." Citation is missing here.
JM: Thanks for spotting. Changed.
27. What is the reason for using ksvm() instead of the different implementation of SVM>
JM: ksvm() provides more kernel options. But you could use the other svms as well.
28. What is "outer resampling loop"? This term should be either avoided or explained.
JM: We definitely to use is, hence, I have to explain it better. Troughout the document I am now using performance estimation level (outer resampling loop) and hyperparameter tuning level (inner resampling loop). Patrick has suggested to do that. This is also what the figure is saying. So I hope this is better understandable. If not, let me know, please!
29. I am rather unsatisfied that the parallelization approach works only on Unix. Is it really impossible on Windows? For example, https://github.com/berndbischl/parallelMap states that the parallelMap package works on Windows, but only in the socket mode.
JM: Parallelization works also under Windows. The problem is that there is no or no easy mc.set.seed equivalent under Windows (afaik, Patrick wanted to have a deeper look). mc.set.seed lets you reproduced the randomly chosen hyperparameters when you rerun the code. So my suggestion would be to add a Windows code while stating that the advantage of mc.set.seed is to obtain the same result when rerunning the code which in the Windows version is not the case.
30. The **parallelMap** package is not loaded in this chapter. Therefore, the `parallelStart()` function does not work.
JM: Interesting, I thought parallelMap is a mlr dependency. Thanks for spotting.
31. "Probably we are not the only ones using the server, therefore we are friendly and will use only half of its cores which in our case corresponds to 24 (cpus parameter)." Is it necessary to inform reader what half of the cores means in out case?
JM: deleted here. Later on, it is necessary since we are saying how long the processing took.
32. "saveRDS(result, "svm_sp_sp_rbf_50it.rda")" - In this comment, you save the result object to the RDS format, but with RData extension...
JM: Now I am using .rds
33. "Running 125,000 models using 24 cores took more than 37 minutes." Maybe it is better to inform (warn) readers about the runtime before the actual run? 
JM: We could, but I think it is pretty much obvious from the text that parallelization is in order here and that we use it to reduce runtime.
34. "However, using 200 instead of 50 iterations in the random search would probably yield even better hyperparameter combinations resulting in a better AUROC (Schratz et al. 2018). On the other hand, this would increase the number of models to be fitted from 125,000 to 500,000.70" What is the role of this discussion? I am afraid that it could be confusing for the readers new to ML.
JM: rewritten, now just saying that more iterations in the random search will naturally increase runtime.
35. "Here, we just have a short glance at the optimal hyperparameters combination and the result which was obtained with them in the first iteration of the outer loop." I have (probably) never used **mlr** before and I am confused here. It this the best set of hyperparameters? Or is it the best set only for one repeat of CV? How can I find and extract the best model to use it in, for example, deployment?
JM: I know what you are asking for and you are not the first, I have wondered about the same thing as well. However, spatial cv is about performance estimation not about finding the optimal hyperparameters for a specific spatial prediction. We now have 500 "optimal" hyperparameter combinations. Which of them would you like to choose? All of them are based on different spatial partitions. The short answer is, you do not tune hyperparameters on a subset of the data for predictive mapping. For this, you would refrain from the hyperparameter tuning in the "inner" fold. I have updated the text accordingly while also saying that we will see an example how to tune hyperparameters for predictive mapping in the ecological chapter.
36. We should have acknowledgments in every (or some) chapters. There should be only one acknowledgments section for the whole book.
JM: Yep, you are right, I just wrote it here to not forget @pat-s's valuable comments on this chapter.
37. Some plots' captions in this chapter specify the CRS used. We haven't done this in the previous chapters, so it should be removed (in my opinion).
JM: Sorry, I disagree, but how should the reader know to which CRS the coordinates in the map are referring without the CRS?
38. The chapter title - I suggest simplifying it to "Spatial machine learning". I think this shorter title is perfect, because cross-validation is the only difference between non-spatial and spatial ML.
JM: Robin will read over the chapter and voice an opinion on that. Alex Brenning has suggested following title: Assessing the performance of machine-learning models in spatial prediction
