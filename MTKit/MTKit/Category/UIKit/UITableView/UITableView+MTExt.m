//
//  UITableView+MTExt.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UITableView+MTExt.h"

@implementation UITableView (MTExt)

/**
 Perform a series of method calls that insert, delete, or select rows and
 sections of the receiver.
 
 @discussion Perform a series of method calls that insert, delete, or select
 rows and sections of the table. Call this method if you want
 subsequent insertions, deletion, and selection operations (for
 example, cellForRowAtIndexPath: and indexPathsForVisibleRows)
 to be animated simultaneously.
 
 @discussion If you do not make the insertion, deletion, and selection calls
 inside this block, table attributes such as row count might become
 invalid. You should not call reloadData within the block; if you
 call this method within the group, you will need to perform any
 animations yourself.
 
 @param block  A block combine a series of method calls.
 */
- (void)mt_updateWithBlock:(void (^)(UITableView *tableView))block {
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

/**
 Scrolls the receiver until a row or section location on the screen.
 
 @discussion            Invoking this method does not cause the delegate to
 receive a scrollViewDidScroll: message, as is normal for
 programmatically-invoked user interface operations.
 
 @param row             Row index in section. NSNotFound is a valid value for
 scrolling to a section with zero rows.
 
 @param section         Section index in table.
 
 @param scrollPosition  A constant that identifies a relative position in the
 receiving table view (top, middle, bottom) for row when
 scrolling concludes.
 
 @param animated        YES if you want to animate the change in position,
 NO if it should be immediate.
 */
- (void)mt_scrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

/**
 Inserts a row in the receiver with an option to animate the insertion.
 
 @param row        Row index in section.
 
 @param section    Section index in table.
 
 @param animation  A constant that either specifies the kind of animation to
 perform when inserting the cell or requests no animation.
 */
- (void)mt_insertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *toInsert = [NSIndexPath indexPathForRow:row inSection:section];
    [self mt_insertRowAtIndexPath:toInsert withRowAnimation:animation];
}

/**
 Reloads the specified row using a certain animation effect.
 
 @param row        Row index in section.
 
 @param section    Section index in table.
 
 @param animation  A constant that indicates how the reloading is to be animated,
 for example, fade out or slide out from the bottom. The animation
 constant affects the direction in which both the old and the
 new rows slide. For example, if the animation constant is
 UITableViewRowAnimationRight, the old rows slide out to the
 right and the new cells slide in from the right.
 */
- (void)mt_reloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *toReload = [NSIndexPath indexPathForRow:row inSection:section];
    [self mt_reloadRowAtIndexPath:toReload withRowAnimation:animation];
}

/**
 Deletes the row with an option to animate the deletion.
 
 @param row        Row index in section.
 
 @param section    Section index in table.
 
 @param animation  A constant that indicates how the deletion is to be animated,
 for example, fade out or slide out from the bottom.
 */
- (void)mt_deleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *toDelete = [NSIndexPath indexPathForRow:row inSection:section];
    [self mt_deleteRowAtIndexPath:toDelete withRowAnimation:animation];
}

/**
 Inserts the row in the receiver at the locations identified by the indexPath,
 with an option to animate the insertion.
 
 @param indexPath  An NSIndexPath object representing a row index and section
 index that together identify a row in the table view.
 
 @param animation  A constant that either specifies the kind of animation to
 perform when inserting the cell or requests no animation.
 */
- (void)mt_insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

/**
 Reloads the specified row using a certain animation effect.
 
 @param indexPath  An NSIndexPath object representing a row index and section
 index that together identify a row in the table view.
 
 @param animation A constant that indicates how the reloading is to be animated,
 for example, fade out or slide out from the bottom. The animation
 constant affects the direction in which both the old and the
 new rows slide. For example, if the animation constant is
 UITableViewRowAnimationRight, the old rows slide out to the
 right and the new cells slide in from the right.
 */
- (void)mt_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

/**
 Deletes the row specified by an array of index paths,
 with an option to animate the deletion.
 
 @param indexPath  An NSIndexPath object representing a row index and section
 index that together identify a row in the table view.
 
 @param animation  A constant that indicates how the deletion is to be animated,
 for example, fade out or slide out from the bottom.
 */
- (void)mt_deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

/**
 Inserts a section in the receiver, with an option to animate the insertion.
 
 @param section    An index specifies the section to insert in the receiving
 table view. If a section already exists at the specified
 index location, it is moved down one index location.
 
 @param animation  A constant that indicates how the insertion is to be animated,
 for example, fade in or slide in from the left.
 */
- (void)mt_insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self insertSections:sections withRowAnimation:animation];
}

/**
 Deletes a section in the receiver, with an option to animate the deletion.
 
 @param section    An index that specifies the sections to delete from the
 receiving table view. If a section exists after the specified
 index location, it is moved up one index location.
 
 @param animation  A constant that either specifies the kind of animation to
 perform when deleting the section or requests no animation.
 */
- (void)mt_deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self deleteSections:sections withRowAnimation:animation];
}

/**
 Reloads the specified section using a given animation effect.
 
 @param section    An index identifying the section to reload.
 
 @param animation  A constant that indicates how the reloading is to be animated,
 for example, fade out or slide out from the bottom. The
 animation constant affects the direction in which both the
 old and the new section rows slide. For example, if the
 animation constant is UITableViewRowAnimationRight, the old
 rows slide out to the right and the new cells slide in from the right.
 */
- (void)mt_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:animation];
}

/**
 Unselect all rows in tableView.
 
 @param animated YES to animate the transition, NO to make the transition immediate.
 */
- (void)mt_clearSelectedRowsAnimated:(BOOL)animated {
    NSArray *indexs = [self indexPathsForSelectedRows];
    [indexs enumerateObjectsUsingBlock:^(NSIndexPath* path, NSUInteger idx, BOOL *stop) {
        [self deselectRowAtIndexPath:path animated:animated];
    }];
}

/**
 清除tableview多余的Cell
 */
- (void)mt_hidenBlankCell {
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

@end
