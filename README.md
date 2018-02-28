Gilded rose kata
------------

Maker's Academy practice kata to extend legacy code. Kata originally written by [Terry Hughes](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/), translated into Ruby (and many other languages) by [Emily Bache](https://github.com/emilybache/GildedRose-Refactoring-Kata).

## Specification

Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a SellIn value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- “Aged Brie” actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
- “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

- “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the UpdateQuality method and Items property static if you like, we’ll cover for you).

## Approach

1. Diagrammed original code
2. Wrote basic tests for the original update_quality method, including text-based approval test (see below)
4. Start refactoring code for readability, without changing structure
5. As the code became more clear, including how it diverges from the spec, wrote further tests, including for some edge cases
6. Once I was satisfied the code was fully covered, I started refactoring in small steps, checking the tests and text-based golden master each time.
7. Refactored original nest of if statements into one case...then statement, which calls a separate method for each special item
8. To ensure single responsibility, I extracted these into an ItemUpdater class and set of sub-classes to handle different special items

**Text-based approval testing**: I used the output of `texttest_fixture.rb` to produce 'golden master' - after all changes, I compared the output of `texttest_fixture.rb` to the golden master using the `diff` tool in bash. If they didn't match, the test failed, since all refactoring changes shouldn't change the output of the program.