import sublime
import sublime_plugin

# Ripped off from https://github.com/mburrows/RecenterTopBottom/blob/master/recenter_top_bottom.py

class ScrollLineToTopCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.show_at_top()

    def row(self):
        caret = self.view.sel()[0].begin()
        return self.view.rowcol(caret)[0]

    def show_at_top(self):
        top, _ = self.screen_extents()
        offset = self.row() - top - 1
        self.view.run_command('scroll_lines', {'amount': -offset})

    def screen_extents(self):
        screenful = self.view.visible_region()
        top_row, _ = self.view.rowcol(screenful.begin())
        bottom_row, _ = self.view.rowcol(screenful.end())
        return (top_row, bottom_row)
