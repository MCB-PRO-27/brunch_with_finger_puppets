//
/*
 * Lifted with Pleasure from http://stackoverflow.com/questions/499126/jquery-set-cursor-position-in-text-area
 *
 * Set's a selection so you can set focus at a cursor position, also will select text if end>start, to use
 * as caret position helper just make sure start - end are the same
 * Used int comment-input-view for replyTo, to position cursor at end of the pre-puplated username
 */
$.fn.selectRange = function(start, end) {
    return this.each(function() {
        if (this.setSelectionRange) {
            this.focus();
            this.setSelectionRange(start, end);
        } else if (this.createTextRange) {
            var range = this.createTextRange();
            range.collapse(true);
            range.moveEnd('character', end);
            range.moveStart('character', start);
            range.select();
        }
    });
};