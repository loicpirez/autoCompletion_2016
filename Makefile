##
## Makefile for autoCompletion in /home/loic/RubymineProjects/autoCompletion_2016
## 
## Made by Loïc Pirez
## Login   <loic.pirez@epitech.eu>
## 
## Started on  Mon Jul 10 09:24:38 2017 Loïc Pirez
## Last update Mon Jul 10 09:29:46 2017 Loïc Pirez
##

NAME		=	autoCompletion

SRC		=	$(SRC_DIR)autoComplete.rb

all		:	$(NAME)

$(NAME)		:	
			cp $(SRC) $(NAME)

clean		:
			rm -f $(NAME)

fclean		:	clean

re		:	fclean all
