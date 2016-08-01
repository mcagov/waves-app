/**
 * Resize function without multiple trigger
 *
 * Usage:
 * $(window).smartresize(function(){
 *     // code here
 * });
 */
(function($,sr){
    // debouncing function from John Hann
    // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
    var debounce = function (func, threshold, execAsap) {
      var timeout;

        return function debounced () {
            var obj = this, args = arguments;
            function delayed () {
                if (!execAsap)
                    func.apply(obj, args);
                timeout = null;
            }

            if (timeout)
                clearTimeout(timeout);
            else if (execAsap)
                func.apply(obj, args);

            timeout = setTimeout(delayed, threshold || 100);
        };
    };

    // smartresize
    jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

})(jQuery,'smartresize');


var CURRENT_URL = window.location.href.split('?')[0],
    $BODY = $('body'),
    $MENU_TOGGLE = $('#menu_toggle'),
    $SIDEBAR_MENU = $('#sidebar-menu'),
    $SIDEBAR_FOOTER = $('.sidebar-footer'),
    $LEFT_COL = $('.left_col'),
    $RIGHT_COL = $('.right_col'),
    $NAV_MENU = $('.nav_menu'),
    $FOOTER = $('footer');

// Sidebar
$(document).ready(function() {

    var setContentHeight = function () {
        $RIGHT_COL.css('min-height', $(window).height());

        var bodyHeight = $BODY.outerHeight(),
            footerHeight = $BODY.hasClass('footer_fixed') ? 0 : $FOOTER.height(),
            leftColHeight = $LEFT_COL.eq(1).height() + $SIDEBAR_FOOTER.height(),
            contentHeight = bodyHeight < leftColHeight ? leftColHeight : bodyHeight;

        $RIGHT_COL.css('min-height', contentHeight);
    };

    $SIDEBAR_MENU.find('a').on('click', function(ev) {
        var $li = $(this).parent();

        if ($li.is('.active')) {
            $li.removeClass('active active-sm');
            $('ul:first', $li).slideUp(function() {
                setContentHeight();
            });
        } else {
            // prevent closing menu if we are on child menu
            if (!$li.parent().is('.child_menu')) {
                $SIDEBAR_MENU.find('li').removeClass('active active-sm');
                $SIDEBAR_MENU.find('li ul').slideUp();
            }

            $li.addClass('active');

            $('ul:first', $li).slideDown(function() {
                setContentHeight();
            });
        }
    });

    // toggle small or large menu
    $MENU_TOGGLE.on('click', function() {
        if ($BODY.hasClass('nav-md')) {
            $SIDEBAR_MENU.find('li.active ul').hide();
            $SIDEBAR_MENU.find('li.active').addClass('active-sm').removeClass('active');
        } else {
            $SIDEBAR_MENU.find('li.active-sm ul').show();
            $SIDEBAR_MENU.find('li.active-sm').addClass('active').removeClass('active-sm');
        }

        $BODY.toggleClass('nav-md nav-sm');

        setContentHeight();
    });

    // check active menu
    $SIDEBAR_MENU.find('a[href="' + CURRENT_URL + '"]').parent('li').addClass('current-page');

    $SIDEBAR_MENU.find('a').filter(function () {
        return this.href == CURRENT_URL;
    }).parent('li').addClass('current-page').parents('ul').slideDown(function() {
        setContentHeight();
    }).parent().addClass('active');

    // recompute content when resizing
    $(window).smartresize(function(){
        setContentHeight();
    });

    setContentHeight();

    // fixed sidebar
    if ($.fn.mCustomScrollbar) {
        $('.menu_fixed').mCustomScrollbar({
            autoHideScrollbar: true,
            theme: 'minimal',
            mouseWheel:{ preventDefault: true }
        });
    }
});

// Tooltip
$(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip({
        container: 'body'
    });
});

// select2
$(document).ready(function() {
    $(".select2_single").select2({
        allowClear: false
    });
    $(".select2_group").select2({});
    $(".select2_multiple").select2({
        maximumSelectionLength: 4,
        allowClear: true
    });
});

// daterangepicker
$(document).ready(function() {
  $('#daterange').daterangepicker({
    singleDatePicker: true,
    calender_style: "picker_4"
  });
});

// Table
$('table input').on('ifChecked', function () {
    checkState = '';
    $(this).parent().parent().parent().addClass('selected');
    countChecked();
});
$('table input').on('ifUnchecked', function () {
    checkState = '';
    $(this).parent().parent().parent().removeClass('selected');
    countChecked();
});

// Accordion
$(document).ready(function() {
    $(".expand").on("click", function () {
        $(this).next().slideToggle(200);
        $expand = $(this).find(">:first-child");

        if ($expand.text() == "+") {
            $expand.text("-");
        } else {
            $expand.text("+");
        }
    });
});

// NProgress
if (typeof NProgress != 'undefined') {
    $(document).ready(function () {
        NProgress.start();
    });

    $(window).load(function () {
        NProgress.done();
    });
}

$MENU_TOGGLE.on('click', function() {
  $(window).resize();
});


// Morris chart samples
// Morris.Bar({
//   element: 'graph_bar_group',
//   data: [
//     {"period": "2016-10-01", "licensed": 807, "sorned": 660},
//     {"period": "2016-09-30", "licensed": 1251, "sorned": 729},
//     {"period": "2016-09-29", "licensed": 1769, "sorned": 1018},
//     {"period": "2016-09-20", "licensed": 2246, "sorned": 1461},
//     {"period": "2016-09-19", "licensed": 2657, "sorned": 1967},
//     {"period": "2016-09-18", "licensed": 3148, "sorned": 2627},
//     {"period": "2016-09-17", "licensed": 3471, "sorned": 3740},
//     {"period": "2016-09-16", "licensed": 2871, "sorned": 2216},
//     {"period": "2016-09-15", "licensed": 2401, "sorned": 1656},
//     {"period": "2016-09-10", "licensed": 2115, "sorned": 1022}
//   ],
//   xkey: 'period',
//   barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
//   ykeys: ['licensed', 'sorned'],
//   labels: ['Licensed', 'SORN'],
//   hideHover: 'auto',
//   xLabelAngle: 60,
//   resize: true
// });

Morris.Bar({
  element: 'report_outstanding_work_graph_bar_group',
  data: [
    {"period": "2016-10-01", "received": 25, "outstanding": 7},
    {"period": "2016-09-30", "received": 12, "outstanding": 7},
    {"period": "2016-09-29", "received": 17, "outstanding": 10},
    {"period": "2016-09-20", "received": 22, "outstanding": 14},
    {"period": "2016-09-19", "received": 26, "outstanding": 19},
    {"period": "2016-09-18", "received": 31, "outstanding": 26},
    {"period": "2016-09-17", "received": 34, "outstanding": 31}
  ],
  xkey: 'period',
  barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
  ykeys: ['received', 'outstanding'],
  labels: ['Received', 'Outstanding'],
  hideHover: 'auto',
  xLabelAngle: 60,
  resize: true
});
