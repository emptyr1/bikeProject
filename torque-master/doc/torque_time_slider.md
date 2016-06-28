# Torque Time Slider

You can use the `time_slider` option to show an animated time slider with Torque layers. This option is enabled by default when creating visualizations with [cartodb.createVis](http://docs.cartodb.com/cartodb-platform/cartodb-js/api-methods/#cartodbcreatevis) and [createLayer](http://docs.cartodb.com/cartodb-platform/cartodb-js/api-methods/#cartodbcreatelayermap-layersource--options--callback). Both require a map_id DOM object.

**Enable / Disable the Torque Time Slider**

Description | The Torque time slider is enabled by default, for your visualization or layer.
Sample Torque.js Code | `{ time_slider: true });`
Default Value | `true`, enabled by default.
Available Values | See [boolean](http://docs.cartodb.com/cartodb-platform/cartocss/properties/#boolean).
Related Examples | To disable the time slider option, use `time_slider: false`. See [No Torque Time Slider - Example Code](http://bl.ocks.org/michellechandra/081ca7160a8c782266d2).<br/><br/>For a code example about how to use the `time_slider` option to modify a Torque map, see [Torque with a Custom Time Slider](http://bl.ocks.org/csobier/cebdd47242d7ca98ec5e).

**Note:** The `time_slider` option is specific for Torque.js only. All the other CartoDB.js options are also supported for Torque.js. For the complete list of arguments, options, and returns, see [CartoDB.js API Methods](http://docs.cartodb.com/cartodb-platform/cartodb-js/api-methods/#api-methods).


## Customize Animation for your Time Slider

You can customize the animation of your Torque time slider by editing the `-torque-frame-count` and `-torque-animation-duration` CartoCSS properties. (Optionally, you can create a [CartoDB.js](http://docs.cartodb.com/cartodb-platform/cartodb-js/api-methods/#api-methods) map to create a custom time slider). This section also describes how time interval data is aggregated, and describes the formula used to calculate time buckets.

- [`-torque-frame-count`](http://docs.cartodb.com/cartodb-platform/cartocss/properties-for-torque/#torque-frame-count-number) specifies the number of animation steps/frames in your torque animation. You can change the time slider timestamp by adjusting the number of steps.<br /><br />**Tip:** This is the _Steps_ option from the [Torque wizard](/cartodb-editor/maps/#torque) of the CartDB Editor.

- [`-torque-animation-duration`](http://docs.cartodb.com/cartodb-platform/cartocss/properties-for-torque/#torque-animation-duration-number) specifies the length of time for your animation, in seconds. You can adjust the duration of the animation as needed.<br /><br />**Tip:** This is the _Duration (secs)_ option from the [Torque wizard](/cartodb-editor/maps/#torque) of the CartoDB Editor.

### Aggregating Time Interval Data

Before customizing the time slider, you should understand how Torque time interval data is calculated. Torque aggregates time (rather than use an exact start time and end from your column fields). Torque calculates the time interval as follows:

- Reads the first date/time stamp from your dataset
- Reads the last date/time stamp to from your dataset
- Aggregates the time period based on the first and last date/time stamp (including seconds)
- Once the time interval is defined, it breaks the time period up in smaller "buckets"
- The number of buckets is based on the number of [Steps](http://docs.cartodb.com/cartodb-platform/cartocss/properties-for-torque/#torque-frame-count-number) you select for your Torque map
- Each bucket, or step, is one animation frame
  
Thus, the start and end time for each bucket depends on the number of divided steps (not a specific start time or end time that you entered). 

**Note:** If you are creating Torque maps with the CartoDB Editor, the date format of the Torque time slider is automatically calculated by CartoDB and cannot be edited. See [Calculating the Time Slider in the CartoDB Editor](#calculating-the-time-slider-in-the-cartodb-editor) for more details.

### Formula for Calculating Time Buckets

The following formula can help you calculate the number of steps for your Torque data.

`time = times.start + (times.end - times.start)*(step/total_steps);`

Where:

- `time` = time at each hop
- `times.start` = the earliest time in your date/time column
- `times.end` = the latest time in your date/time column

The Torque time slider displays these buckets of time, animating the entire sequence of your dataset, and divides the time according to the number of specified steps. You can alter the [duration](http://docs.cartodb.com/cartodb-platform/cartocss/properties-for-torque/#torque-animation-duration-number) of the animation, and adjust the time slider timestamp with the number of [Steps](http://docs.cartodb.com/cartodb-platform/cartocss/properties-for-torque/#torque-frame-count-number).

#### Calculating the Time Slider in the CartoDB Editor

When creating Torque maps with the CartoDB Editor, the date format of the Torque time slider is automatically calculated by CartoDB, depending on the range of time in your dataset. It cannot be edited. If your data contains the following range of time, the time slider displays as described:

- Time range is _less than one day_, the time slider displays the _time_
- Time range is _less than three days_, the time slider displays the _day and time_
- Time range is _more than three days, but less than a year_, the time slider displays the _month/day/year_
- Time range is _more than a year_, the time slider displays the _month/year_
