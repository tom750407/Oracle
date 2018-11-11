--首先用alter system设置撤销保留阈值，然后指定retention guarantee保证性撤销保留
alter system set undo_retention=3600;
alter tablespace undotbs1 retention guarantee;
