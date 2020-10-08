import os
import pandas as pd
import datetime

def main():
    jtl_path = input('Please insert jtl path: ')

    data = pd.read_csv(jtl_path)
    print("%d rows included" % data['Latency'].count())

    print("*** Note: if you didn't provide number to demonstrate it will take all as default")
    sample_rows = int(input('Please insert number of rows to demonstrate: ') or "-1")

    print("*** Note: if you didn't provide number of offset it will take from head")
    offset = int(input('Which offset of rows would you like to take: ') or "0")

    if sample_rows > -1:
        # offset = 0 if offset < 0 else offset
        last = sample_rows + offset
        data = data.take(list(range(offset, last)))
        print('Take %d rows from %d to %d' % (data['Latency'].count(), offset, last-1))


    data['timeStamp'] = pd.to_datetime(data['timeStamp'])
    res = data.plot(x='timeStamp', y='Latency')
    res.set_xlabel('timeStamp')
    res.set_ylabel('Latency')
    res = res.get_figure()
    output_dir = os.path.join(os.path.dirname(jtl_path), 'plot_res')
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    res.savefig(os.path.join(output_dir, 'res'),dpi=300)
    data.agg({'Latency': ["mean", "max", "min", "average"]}).to_csv(os.path.join(output_dir, 'res_agg.csv'))

if __name__ == "__main__":
    main()


# C:\map_colonies\load-testing\Jmeter\google-xyz\res\xyz-res.jtl