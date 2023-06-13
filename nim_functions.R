# Hello person who decided to open this

random_setups_1 <- matrix(c(1,2,4,7,1,2,5,6,1,3,4,6,1,3,5,7,2,3,4,5,2,3,6,7,2,3,8,9,4,5,6,7,4,5,8,9),9,byrow=1)
bitwXorMult <- function(x) {
  sum <- 0
  for (i in 1:length(x)) {
    sum <- bitwXor(sum,x[i])
  }
  return(sum)
}
bestMove <- function(x) {
  nimSum <- bitwXorMult(x)
  y <- rep(0,length(x))
  for (i in 1:length(x)) {
    y[i] <- bitwXor(nimSum,x[i])
  }
  z <- rep(0,length(x))
  for (i in 1:length(x)) {
    z[i] <- (x[i]>y[i])
  }
  move <- which.max(z)
  return(c(move,x[move]-y[move]))
}
play_babybot_defunct <- function() {
  playing <- TRUE
  while(playing) {
    message("Starting game!")
    heaps <- (random_setups_1[sample(9,1),])[sample(4)]
    message(paste("The heaps are:",heaps[1],heaps[2],heaps[3],heaps[4]))
    in_progress <- TRUE
    while (in_progress) {
      p1_move <- readline(prompt = "Which heap would you like to remove stones from? --> ")
      verify_move <- TRUE
      while (verify_move) {
        if ((p1_move==1)|(p1_move==2)|(p1_move==3)|(p1_move==4)) {
          if (heaps[as.integer(p1_move)]!=0) {
            verify_move <- FALSE
          } else {
            p1_move <- readline(prompt="Heap has no stones. Enter another heap. --> ")
          }
        } else {
          p1_move <- readline(prompt="Invalid heap. Enter another heap. --> ")
        }
      }
      p1_num <- readline(prompt = "How many stones would you like to remove? --> ")
      verify_num <- TRUE
      while (verify_num) {
        if (sum((1:heaps[as.integer(p1_move)])==p1_num)==0) {
          p1_num <- readline(prompt="Invalid number. Choose another number to remove. --> ")
        } else {
          verify_num <- FALSE
        }
      }
      message(paste("Removing ",p1_num," stones from heap ",p1_move,".",sep=""))
      heaps[as.integer(p1_move)] <- heaps[as.integer(p1_move)]-as.integer(p1_num)
      message(paste("The heaps are:",heaps[1],heaps[2],heaps[3],heaps[4]))
      p2_move <- bestMove(heaps)
      message(paste("The bot removes ",p2_move[2],' stones from heap ',p2_move[1],".",sep=""))
      heaps[p2_move[1]] <- heaps[p2_move[1]]-p2_move[2]
      message(paste("The heaps are:",heaps[1],heaps[2],heaps[3],heaps[4]))
      if (sum(heaps)==0) {
        message("All heaps are zero and you cannot move. The bot wins!")
        in_progress <- FALSE
      }
    }
    newgame <- readline(prompt="New game? Y/N --> ")
    if (newgame=="N") {
      message("Thanks for playing!")
      playing <- FALSE
    } else if (newgame!="Y") {
      message("Quit fooling around.")
    } else {
      message("Resetting heaps...")
    }
  }
}
play_babybot <- function() {
  playing <- TRUE
  message("Starting game!")
  while (playing) {
    heaps <- (random_setups_1[sample(9,1),])[sample(4)]
    in_progress <- TRUE
    while (in_progress) {
      player <- 1
      heap_message(heaps)
      move <- player_move(heaps)
      if (sum(move=="BREAK")) {
        break
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_1)
        break
      }
      heaps <- remove_zero_heaps(heaps)
      player <- 0
      heap_message(heaps)
      move <- bestMove(heaps)
      if (move[2]==0) {
        temp_heap <- sample(1:length(heaps),1)
        move <- c(temp_heap,sample(1:heaps[temp_heap],1))
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_2)
        break
      }
      heaps <- remove_zero_heaps(heaps)
    }
    playing <- play_again()
    if (playing) {
      message("Resetting heaps...")
    }
  }
  message("Thanks for playing!")
}
play_childbot <- function() {
  playing <- TRUE
  message("Starting game!")
  while (playing) {
    heaps <- sample(1:9,1)
    in_progress <- TRUE
    while (in_progress) {
      player <- 1
      heap_message(heaps)
      move <- player_move(heaps)
      if (sum(move=="BREAK")) {
        break
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_1)
        break
      }
      heaps <- remove_zero_heaps(heaps)
      player <- 0
      heap_message(heaps)
      move <- bestMove(heaps)
      if (move[2]==0) {
        temp_heap <- sample(1:length(heaps),1)
        move <- c(temp_heap,sample(1:heaps[temp_heap],1))
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_2)
        break
      }
      heaps <- remove_zero_heaps(heaps)
    }
    playing <- play_again()
    if (playing) {
      message("Resetting heaps...")
    }
  }
  message("Thanks for playing!")
}
validate_stones <- function(s,i) {
  r <- i
  validating <- TRUE
  while(validating) {
    if (sum(1:s == r) == 1) {
      validating <- FALSE
    } else {
      r <- readline(prompt="Invalid number. Choose another number to remove. --> ")
    }
  }
  return(as.integer(r))
}
remove_message <- function(you,h,n) {
  if (you == 1) {
    startmsg <- "Removing "
  } else {
    startmsg <- "The bot removes "
  }
  message(paste(startmsg,n," stones from heap ",h,'.',sep=""))
}
heap_message <- function(h) {
  l <- "The heaps are:"
  for (i in 1:length(h)) {
    l <- paste(l, "\nHeap ",i,": ",h[i],sep="")
  }
  message(l)
}
win_message_1 <- "All heaps are zero and the bot cannot move. You win!"
win_message_2 <- "All heaps are zero and you cannot move. The bot wins!"
play_childbot_defunct <- function() {
  playing <- TRUE
  while(playing) {
    heap <- sample(1:9,1)
    heap_message(heap)
    move <- readline(prompt="How many stones would you like to remove? --> ")
    move <- validate_stones(heap,move)
    remove_message(1,move,1)
    heap <- heap - move
    heap_message(heap)
    if (heap == 0) {
      message(win_message_1)
    } else {
      remove_message(0,1,heap)
      heap_message(0)
      message(win_message_2)
    }
    again <- readline(prompt="New game? Y/N --> ")
    if (again == "N") {
      playing <- FALSE
    } else if (again == "Y") {
      message("Resetting heaps...")
    } else {
      message("I don't like having to program edge cases when people don't follow the rules. Resetting heaps...")
    }
  }
}

player_move <- function(h) {
  move <- readline(prompt="Which heap would you like to remove stones from? --> ")
  while (sum(move==(1:length(h)))!=1) {
    if ((move=="Quit")|(move=="quit")) {
      return("BREAK")
    }
    move <- readline(prompt="Invalid heap. Enter another heap. --> ")
  }
  num <- readline(prompt="How many stones would you like to remove? --> ")
  while (sum(num==(1:h[as.integer(move)]))!=1) {
    if ((num=="Quit")|(num=="quit")) {
      return("BREAK")
    }
    num <- readline(prompt="Invalid number. Choose another number to remove. --> ")
  }
  return(c(as.integer(move),as.integer(num)))
}
check_win <- function(h) {
  return(sum(h)!=0)
}
remove_zero_heaps <- function(h) {
  z <- c()
  for (i in 1:length(h)) {
    if (h[i] != 0) {
      z <- c(z,h[i])
    }
  }
  return(z)
}
play_again <- function() {
  again <- readline(prompt="New game? Y/N --> ")
  while ((again!="Y")&(again!="N")&(again!="y")&(again!="n")&(again!="Yes")&(again!="No")&(again!="yes")&(again!="no")) {
    again <- readline(prompt="Enter Y or N --> ")
  }
  return(("Y"==again)|("y"==again)|("Yes"==again)|("yes"==again))
}
play_teenbot <- function() {
  playing <- TRUE
  message("Starting game!")
  while (playing) {
    heaps <- sample(9,2)
    in_progress <- TRUE
    while (in_progress) {
      player <- 1
      heap_message(heaps)
      move <- player_move(heaps)
      if (sum(move=="BREAK")) {
        break
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_1)
        break
      }
      heaps <- remove_zero_heaps(heaps)
      player <- 0
      heap_message(heaps)
      move <- bestMove(heaps)
      if (move[2]==0) {
        temp_heap <- sample(1:length(heaps),1)
        move <- c(temp_heap,sample(1:heaps[temp_heap],1))
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_2)
        break
      }
      heaps <- remove_zero_heaps(heaps)
    }
    playing <- play_again()
    if (playing) {
      message("Resetting heaps...")
    }
  }
  message("Thanks for playing!")
}
play_adultbot <- function() {
  playing <- TRUE
  message("Starting game!")
  while (playing) {
    num <- sample(5,1)
    heaps <- sample(c(1,2*num,2*num+1),3)
    added <- sample(3,1)
    heaps[added] <- heaps[added] + sample(7,1)
    in_progress <- TRUE
    while (in_progress) {
      player <- 1
      heap_message(heaps)
      move <- player_move(heaps)
      if (sum(move=="BREAK")) {
        break
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_1)
        break
      }
      heaps <- remove_zero_heaps(heaps)
      player <- 0
      heap_message(heaps)
      move <- bestMove(heaps)
      if (move[2]==0) {
        temp_heap <- sample(1:length(heaps),1)
        move <- c(temp_heap,sample(1:heaps[temp_heap],1))
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_2)
        break
      }
      heaps <- remove_zero_heaps(heaps)
    }
    playing <- play_again()
    if (playing) {
      message("Resetting heaps...")
    }
  }
  message("Thanks for playing!")
}
nim_sum <- function(...) {
  x <- c(...)
  return(bitwXorMult(c(x)))
}
message("Functions loaded!")
diffuculty_selection <- function(x) {
  if (x==1) {
    h <- sample(2:13,sample(2:3,1))
    while (nim_sum(h)==0) {
      h <- sample(2:13,sample(2:3,1))
    }
    return(h)
  }
  if (x==2) {
    h <- sample(4:15,sample(c(3,3,4),1))
    while (nim_sum(h)==0) {
      h <- sample(4:15,sample(c(3,3,4),1))
    }
    return(h)
  }
  if (x==3) {
    h <- sample(2:20,sample(c(4,4,5,5,6),1))
    while (nim_sum(h)==0) {
      h <- sample(2:20,sample(c(4,4,5,5,6),1))
    }
    return(h)
  }
  if (x==4) {
    h <- sample(5:32,sample(c(6,7,7),1))
    while (nim_sum(h)==0) {
      h <- sample(5:32,sample(c(6,7,7),1))
    }
    return(h)
  }
  if (x==5) {
    h <- sample(1:64,sample(c(15:21),1))
    while (nim_sum(h)==0) {
      h <- sample(1:64,sample(c(15:21),1))
    }
    return(h)
  }
}
play_grandmabot <- function() {
  playing <- TRUE
  message("Starting game!")
  while (playing) {
    message("1 = Easy (similar to Adult Bot)\n2 = Medium (a fair step up)\n3 = Hard (a challenge but doable)\n4 = Insane (an unforgiving test of skill)")
    dif <- readline(prompt="Select your difficulty --> ")
    while (sum(dif==1:4)==0) {
      if (dif==5) {
        dif <- readline(prompt="5 is not a difficulty. Select a valid difficulty --> ")
        if (dif==5) {
          dif <- readline(prompt="I told you 5 is not a difficulty. Select another difficulty --> ")
          if (dif==5) {
            dif <- readline(prompt="There is no fifth \"Ultra Insane Apocalypse Nim\" difficulty. Select another difficulty --> ")
            if (dif==5) {
              message("Fine. You asked for it...")
              break
            }
          }
        }
      }
      if (dif!=5) {
        if (sum(dif==1:4)==0) {
          dif <- readline(prompt="Invalid difficulty. Select another difficulty --> ")
        } else {
          break
        }
      }
    }
    heaps <- diffuculty_selection(dif)
    in_progress <- TRUE
    while (in_progress) {
      player <- 1
      heap_message(heaps)
      move <- player_move(heaps)
      if (sum(move=="BREAK")) {
        break
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_1)
        break
      }
      heaps <- remove_zero_heaps(heaps)
      player <- 0
      heap_message(heaps)
      move <- bestMove(heaps)
      if (move[2]==0) {
        temp_heap <- sample(1:length(heaps),1)
        move <- c(temp_heap,sample(1:heaps[temp_heap],1))
      }
      heaps[move[1]] <- heaps[move[1]] - move[2]
      remove_message(player,move[1],move[2])
      in_progress <- check_win(heaps)
      if (!in_progress) {
        message(win_message_2)
        break
      }
      heaps <- remove_zero_heaps(heaps)
    }
    playing <- play_again()
    if (playing) {
      message("Resetting heaps...")
    }
  }
  message("Thanks for playing!")
}