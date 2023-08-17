# Learn to Nim

Welcome to the wild and wacky world of combinatorial game theory, starring the game of Nim! There are three similar but distinct ways of accessing the lesson, so choose the method that best suits you.

![image_choice](images/readme_drawing1.png)

The simplest way to access is through Binder ([here](https://mybinder.org/v2/gh/White-Lizard1/learn_to_nim/main?labpath=nim.ipynb)), which allows to you interact with the file in a brower, no setup needed. Downside: It might require some time to load, and occasionally the website experiences too much traffic and you can't access it.

If that doesn't work, but you have experience with a computer, using the IPNYB with Jupyter Notebook should be simple enough. If it's too complicated, try the third method. (note this is for Windows only, for Mac/Linux it's still possible but it might be a different process.) Download the file [nim.ipnyb](https://github.com/White-Lizard1/learn_to_nim/blob/main/nim.ipynb) (**i**nteractive **py**thon **n**ote**b**ook), download [Jupyter notebook](https://jupyter.org/install), download [R 4.3.0](https://cran.r-project.org/bin/windows/base/old/4.3.0/), open R, and type the following lines of code to install IRkernel (so R works in Jupyter):

install.packages("IRkernel")

IRkernel::installspec(user = FALSE)

Then open command prompt, type in "jupyter notebook filepath" but replace "filepath" with the nim.ipnyb filepath. When it opens the notebook in your browser, select "Kernel" and change the kernel to R. If I didn't write this incorrectly it should work. 

The third option: If all else fails, you can always use the [HTML version](https://white-lizard1.github.io/learn_to_nim/), which has the downside that you can't interact with the file (which means you can't play Nim, which slightly lowers the experience).

Unfortunately I could not find a way to make the file interactable, simple, and reliable at the same time. If you know a better option let me know.

FAQ down here for confused people:

(no one has been confused yet)
