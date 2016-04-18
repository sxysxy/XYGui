#include "ruby.h"

VALUE cXYWidget = 0;

void Init_xy_widget_ext()
{
	cXYWidget = rb_define_class("XYWidget", rb_cObject);
}