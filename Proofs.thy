theory Proofs
imports Main
begin
(*Template from Textbook Website, modified as needed*)

(*2.1*)
value "1 + (2::nat)"
value "1 + (2::int)"
value "1 - (2::nat)"
value "1 - (2::int)"
value "[a,b] @ [c,d]"

(*
2.2:
Start from the definition of add given in text.
Prove that add is associative and commutative.
Define a recursive function double :: nat ⇒ nat and prove double m = add m m.
*)
fun add :: "nat => nat => nat" where
"add 0 n = n" |
"add (Suc m) n = Suc(add m n)"

(*
NOTE:
This proof does NOT require any others lemmas  as it can stand alone.
The rational is that we don't need to solve, anything, just show that
the terms can be arranged.
*)
lemma add_assoc: "add x (add y z) = add (add x y) z"
  apply(induction x)
  apply(auto)
  done

lemma add_zero [simp]: "add x 0 = x"
  apply(induction x)
  apply(auto)
  done

lemma add_suc [simp]: "add x (Suc y) = Suc(add x y)"
  apply(induction x)
  apply(auto)
  done

(*
add_communative requires add_zero and add_suc.

add_zero is necessary because it is the base case for this inductive proof.

add_suc is necessary because the inductive step requires assuming an inductive
hypothesis, and then proving it is true for the n+1 step.
*)
lemma add_communative: "add x y = add y x"
  apply(induction x)
  apply(auto)
  done

fun double :: "nat => nat" where
 "double 0 = 0" |
 "double x = add x x"

lemma double_add: "double x = add x x"
    apply(induction x)
    apply(auto)
    done

(*
2.3:
Define a function count :: ′a ⇒ ′a list ⇒ nat that counts the number of occurrences of an element in a list.
Prove count x xs <= length xs.

*)
fun count :: "'a => 'a list => nat" where
  "count y Nil= 0" |
  "count y (x # xs)= (if x = y then Suc(count y xs) else count y xs)"

lemma count_less_length: "count x xs \<le> length xs"
  apply(induction xs)
  apply(auto)
  done

(*2.4:
Define a recursive function snoc :: ′a list ⇒ ′a ⇒ ′a list that appends an element to the end of a list.
With the help of snoc define a recursive function reverse :: ′a list ⇒ ′a list that reverses a list.
Prove reverse (reverse xs) = xs.
*)

(* 2.4 *)
fun snoc :: "'a list => 'a => 'a list" where
"snoc Nil y = y # Nil" |
"snoc (x # xs) y = x # (snoc xs y)"

(* modified definition from textbook *)
fun rev :: "'a list ⇒ 'a list" where
"rev Nil = Nil" |
"rev (x # xs) = (rev xs) @ (x # Nil)"

(* actually usuing snoc i defined*)
fun reverse :: "'a list => 'a list" where
"reverse Nil = Nil" |
"reverse (x # xs) = snoc (reverse xs) x"

(*
Without this lemma, "reverse (x # xs) = snoc(reverse x) x"
remains unproven, which is the inductive step
*)
lemma reverse_snoc [simp]: "reverse (snoc xs y) = y # reverse xs"
  apply(induction xs)
  apply(auto)
  done


lemma reverse: "reverse (reverse xs) = xs"
  apply(induction xs)
  apply(auto)
  done

(*
2.5:
Define a recursive function sum_upto :: nat ⇒ nat such that sum_upto n = 0 + ... + n and prove sum_upto n = n ∗ (n + 1) div 2.
*)

(*2.5*)
fun sum_upto :: "nat => nat" where
  "sum_upto 0 = 0" |
  "sum_upto (Suc x) = (Suc x) + (sum_upto x)"

(*2.5*)
theorem summation: "sum_upto n =  (n * (n +1)) div 2"
  apply(induction n)
  apply(auto)
  done

(*
2.6
Starting from the type ′a tree defined in the text, define a function contents :: ′a tree ⇒ ′a list that collects all values in a tree in a list, in any order, without removing duplicates.
Then define a function sum_tree :: nat tree ⇒ nat that sums up all values in a tree of natural numbers and prove sum_tree t = sum_list (contents t )
*)
datatype 'a tree = Tip | Node "'a tree" 'a "'a tree"

(* defined in textbook *)
fun mirror :: "'a tree \<Rightarrow> 'a tree" where
 "mirror Tip = Tip" |
 "mirror (Node l a r ) = Node (mirror r ) a (mirror l)"

lemma mirror_identity: "mirror(mirror t) = t"
  apply(induction t)
  apply(auto)
  done

fun sum_tree :: "nat tree => nat" where
"sum_tree Tip = 0" |
"sum_tree (Node l a r) = a + (sum_tree l) + (sum_tree r)"

(* I called collect in_order since it was only tree traversal missing *)
fun in_order :: "'a tree => 'a list" where
"in_order Tip = []" |
"in_order (Node l a r) =((in_order l) @ [a]) @ (in_order r)"

theorem sum_tree_list: "sum_tree t = sum_list (in_order t)"
  apply(induction t)
  apply(auto)
  done

(*
Define a new type @{text "'a tree2"} of binary trees where values are also
stored in the leaves of the tree.  Also reformulate the
@{text mirror} function accordingly. Define two functions
*)

datatype 'a tree2 = Tip 'a | Node "'a tree2" 'a "'a tree2"

fun mirror2 :: "'a tree2 => 'a tree2" where
  "mirror2 (Tip x) = Tip x" |
  "mirror2 (Node l a r) = Node (mirror2 r) a (mirror2 l)"

fun pre_order :: "'a tree2 => 'a list" where
  "pre_order (Tip x) = x # Nil" |
  "pre_order (Node l a r) = (a # (pre_order l)) @ (pre_order r)"

fun post_order :: "'a tree2 => 'a list" where
  "post_order (Tip x) = x # Nil" |
  "post_order (Node l a r) = ((post_order l) @ (post_order r)) @ (a # Nil)"

lemma mirror2_identity: "mirror2(mirror2 t) = t"
  apply(induction t)
  apply(auto)
  done

end
